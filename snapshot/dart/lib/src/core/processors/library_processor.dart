import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/library_concept.dart';
import 'package:jqassistant_dart_lce/src/core/context.dart';
import 'package:jqassistant_dart_lce/src/core/execution_condition.dart';
import 'package:jqassistant_dart_lce/src/core/processor.dart';
import 'package:jqassistant_dart_lce/src/core/utils/ast_utils.dart';
import 'package:jqassistant_dart_lce/src/core/utils/path_utils.dart';

final class LibraryProcessor extends Processor {
  @override
  ExecutionCondition get executionCondition => ExecutionCondition(
      [AstNodeType.compilationUnit], (processingContext) => true);

  @override
  ConceptMap postChildrenProcessing(
      ProcessingContext processingContext, ConceptMap childConcepts) {
    return singleEntryConceptMap(LCELibrary(
        convertLibraryPathToFQN(processingContext.globalContext.packageInfo,
            processingContext.globalContext.sourceFilePathAbsolute),
        processingContext.globalContext.sourceFilePathAbsolute));
  }
}
