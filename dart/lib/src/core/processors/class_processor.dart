import 'package:analyzer/dart/ast/ast.dart';
import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/context.dart';
import 'package:jqassistant_dart_lce/src/core/execution_condition.dart';
import 'package:jqassistant_dart_lce/src/core/processor.dart';
import 'package:jqassistant_dart_lce/src/core/utils/ast_utils.dart';

import '../concepts/class_concept.dart';
import '../utils/path_utils.dart';

final class ClassProcessor extends Processor {
  @override
  ExecutionCondition get executionCondition => ExecutionCondition(
      [AstNodeType.classDeclaration], (processingContext) => true);

  @override
  ConceptMap postChildrenProcessing(
      ProcessingContext processingContext, ConceptMap childConcepts) {
    ClassDeclaration node = processingContext.astNode as ClassDeclaration;
    String name = node.name.toString();
    String fqn = convertLibraryPathToFQN(
            processingContext.globalContext.packageInfo,
            processingContext.globalContext.sourceFilePathAbsolute) +
        ":${name}";

    String? superClass = getFQNFromElement(
        node.declaredElement?.supertype?.element,
        returnNullOnObject: true);

    List<String> implementsClasses = (node.declaredElement?.interfaces ?? [])
        .map((iType) => getFQNFromElement(iType.element))
        .nonNulls
        .toList();
    List<String> usesMixins = (node.declaredElement?.mixins ?? [])
        .map((iType) => getFQNFromElement(iType.element))
        .nonNulls
        .toList();

    return singleEntryConceptMap(LCEClass(
      fqn,
      processingContext.globalContext.sourceFilePathAbsolute,
      name,
      node.baseKeyword != null,
      node.interfaceKeyword != null,
      node.finalKeyword != null,
      node.sealedKeyword != null,
      node.abstractKeyword != null,
      node.mixinKeyword != null,
      superClass,
      implementsClasses,
      usesMixins,
    ));
  }
}
