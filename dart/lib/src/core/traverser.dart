import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/context.dart';
import 'package:jqassistant_dart_lce/src/core/features.dart';
import 'package:jqassistant_dart_lce/src/core/processor.dart';
import 'package:jqassistant_dart_lce/src/core/utils/ast_utils.dart';

/**
 * Used for traversing an AST.
 * Provides context for and executes processors for the current node.
 */
final class Traverser extends UnifyingAstVisitor<ConceptMap> {
  GlobalContext globalContext;
  LocalContexts localContexts = LocalContexts();
  List<MetadataAssignmentRule> metadataAssignments = [];

  /**
   * stack of ConceptMap lists to keep track of all the processing results on the individual AST levels
   */
  List<List<ConceptMap>> childConceptStack = [[]];

  Traverser(this.globalContext);

  /**
   * General traversal method that's common to all AST node types
   *
   * [traverseChildren] set to true if child nodes should be traversed
   */
  ConceptMap traverse(AstNodeType nodeType, AstNode node,
      {bool traverseChildren = false}) {
    ProcessingContext processingContext = ProcessingContext(
        node, globalContext, localContexts, metadataAssignments);

    // push new local context
    localContexts.pushContexts();

    // find matching processors for current context
    final processorCandidates = getProcessors(nodeType);
    final List<Processor> validProcessors = processorCandidates
        .where((p) => p.executionCondition.check(processingContext))
        .toList();

    // pre-processing
    for (var processor in validProcessors) {
      processor.preChildrenProcessing(processingContext);
    }

    // process children
    ConceptMap childConcepts = {};
    if (traverseChildren) {
      childConceptStack.add([]);
      visitNode(node);
      childConcepts = mergeConceptMaps(childConceptStack.last);
      childConceptStack.removeLast();
    }

    // post-processing
    final List<ConceptMap> concepts = [];
    for (var processor in validProcessors) {
      concepts.add(
          processor.postChildrenProcessing(processingContext, childConcepts));
    }

    // pop local context
    localContexts.popContexts();

    // apply metadata assignment rules
    for (var i = metadataAssignments.length - 1; i >= 0; i--) {
      final rule = metadataAssignments[i];
      var applied = false;
      for (var conceptMap in concepts) {
        conceptMap.forEach((key, cs) {
          cs.forEach((c) {
            applied = applied || rule.apply(c);
          });
        });
      }

      // remove rule, if it was applied at least once
      if (applied) {
        metadataAssignments.removeAt(i);
      }
    }

    final result = mergeConceptMaps([childConcepts, ...concepts]);
    childConceptStack.last.add(result);
    return result;
  }

  @override
  ConceptMap? visitCompilationUnit(CompilationUnit node) {
    return traverse(AstNodeType.compilationUnit, node, traverseChildren: true);
  }

  @override
  ConceptMap? visitClassDeclaration(ClassDeclaration node) {
    return traverse(AstNodeType.classDeclaration, node);
  }
}
