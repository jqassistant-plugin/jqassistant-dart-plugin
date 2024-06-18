import 'package:analyzer/dart/ast/ast.dart';
import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/function_concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/parameter_concept.dart';
import 'package:jqassistant_dart_lce/src/core/context.dart';
import 'package:jqassistant_dart_lce/src/core/execution_condition.dart';
import 'package:jqassistant_dart_lce/src/core/processor.dart';
import 'package:jqassistant_dart_lce/src/core/utils/ast_utils.dart';

import '../utils/path_utils.dart';

final class FunctionDeclarationProcessor extends Processor {
  /**
   * Local Context identifier to pre-register an [LCEFunction] object to be used by Processors further down the tree
   */
  static const FUNCTION_DECLARATION_CONTEXT = "function-declaration";

  @override
  ExecutionCondition get executionCondition => ExecutionCondition(
      [AstNodeType.functionDeclaration],
      (processingContext) =>
          processingContext.astNode.parent is CompilationUnit);

  @override
  void preChildrenProcessing(ProcessingContext processingContext) {
    FunctionDeclaration node = processingContext.astNode as FunctionDeclaration;
    String name = node.name.toString();
    String fqn = convertLibraryPathToFQN(
            processingContext.globalContext.packageInfo,
            processingContext.globalContext.sourceFilePathAbsolute) +
        ":${name}";
    String returnType = node.returnType?.toString() ?? "(not identified)";
    processingContext.localContexts
            .currentContexts()[FUNCTION_DECLARATION_CONTEXT] =
        LCEFunction(fqn, processingContext.globalContext.sourceFilePathAbsolute,
            name, returnType);
  }

  @override
  ConceptMap postChildrenProcessing(
      ProcessingContext processingContext, ConceptMap childConcepts) {
    final function = processingContext.localContexts
        .currentContexts()[FUNCTION_DECLARATION_CONTEXT]! as LCEFunction;
    function.parameters =
        extractAndDeleteChildConcepts(childConcepts, LCEParameter.CONCEPT_ID);
    return singleEntryConceptMap(function);
  }
}

final class FunctionExpressionProcessor extends Processor {
  @override
  ExecutionCondition get executionCondition => ExecutionCondition(
      [AstNodeType.functionExpression],
      (processingContext) =>
          processingContext.localContexts.parentContexts()?.containsKey(
              FunctionDeclarationProcessor.FUNCTION_DECLARATION_CONTEXT) ??
          false);

  @override
  ConceptMap postChildrenProcessing(
      ProcessingContext processingContext, ConceptMap childConcepts) {
    FunctionExpression node = processingContext.astNode as FunctionExpression;

    List<LCEParameter> parameters = [];
    for (final (index, param)
        in node.parameters?.parameters.indexed ?? <(int, FormalParameter)>[]) {
      parameters.add(LCEParameter(param.name.toString(), index,
          param.declaredElement?.type.toString() ?? "(not identified)"));
    }

    return parameters.length == 0 ? {} : {LCEParameter.CONCEPT_ID: parameters};
  }
}
