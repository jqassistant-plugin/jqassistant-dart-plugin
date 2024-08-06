import 'package:analyzer/dart/ast/ast.dart';
import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/variable_concept.dart';
import 'package:jqassistant_dart_lce/src/core/context.dart';
import 'package:jqassistant_dart_lce/src/core/execution_condition.dart';
import 'package:jqassistant_dart_lce/src/core/processor.dart';
import 'package:jqassistant_dart_lce/src/core/utils/ast_utils.dart';

import '../utils/path_utils.dart';

final class VariableProcessor extends Processor {
  @override
  ExecutionCondition get executionCondition => ExecutionCondition(
      [AstNodeType.topLevelVariableDeclaration], (processingContext) => true);

  @override
  ConceptMap postChildrenProcessing(
      ProcessingContext processingContext, ConceptMap childConcepts) {
    TopLevelVariableDeclaration node =
        processingContext.astNode as TopLevelVariableDeclaration;
    VariableDeclarationList declListNode = node.variables;

    List<LCEVariable> result = [];
    for (final varNode in declListNode.variables) {
      String name = varNode.name.toString();
      String fqn = convertLibraryPathToFQN(
              processingContext.globalContext.packageInfo,
              processingContext.globalContext.sourceFilePathAbsolute) +
          ":${name}";
      result.add(LCEVariable(
          fqn,
          processingContext.globalContext.sourceFilePathAbsolute,
          name,
          varNode.declaredElement?.type.toString() ?? "(not identified)",
          declListNode.isLate,
          declListNode.isFinal,
          declListNode.isConst));
    }

    return result.length == 0 ? {} : {LCEVariable.CONCEPT_ID: result};
  }
}
