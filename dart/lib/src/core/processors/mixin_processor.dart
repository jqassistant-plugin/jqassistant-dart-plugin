import 'package:analyzer/dart/ast/ast.dart';
import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/mixin_concept.dart';
import 'package:jqassistant_dart_lce/src/core/context.dart';
import 'package:jqassistant_dart_lce/src/core/execution_condition.dart';
import 'package:jqassistant_dart_lce/src/core/processor.dart';
import 'package:jqassistant_dart_lce/src/core/utils/ast_utils.dart';

import '../utils/path_utils.dart';

final class MixinProcessor extends Processor {
  @override
  ExecutionCondition get executionCondition => ExecutionCondition(
      [AstNodeType.mixinDeclaration], (processingContext) => true);

  @override
  ConceptMap postChildrenProcessing(
      ProcessingContext processingContext, ConceptMap childConcepts) {
    MixinDeclaration node = processingContext.astNode as MixinDeclaration;
    String name = node.name.toString();
    String fqn = convertLibraryPathToFQN(
            processingContext.globalContext.packageInfo,
            processingContext.globalContext.sourceFilePathAbsolute) +
        ":${name}";

    return singleEntryConceptMap(LCEMixin(
        fqn,
        processingContext.globalContext.sourceFilePathAbsolute,
        name,
        node.baseKeyword != null));
  }
}
