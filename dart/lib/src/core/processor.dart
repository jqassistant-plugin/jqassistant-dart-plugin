import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/context.dart';
import 'package:jqassistant_dart_lce/src/core/execution_condition.dart';

/**
 * Extracts language concepts from a given node of an AST and its children.
 */
abstract base class Processor {
  /**
   * defines on what nodes and in which context the processor is executed
   */
  abstract final ExecutionCondition executionCondition;

  /**
   * Function that is executed before the children of the current AST node are processed.
   * Use to set up the local context.
   */
  void preChildrenProcessing(ProcessingContext processingContext) {}

  /**
   * Function that is executed after the children of the current AST node have been processed.
   * Use to integrate concepts generated for child nodes.
   *
   * NOTE: Remove child concepts from the Map, if they are no longer needed further up the tree!
   *
   * Returns: new concept(s) created for the current node
   */
  ConceptMap postChildrenProcessing(
      ProcessingContext processingContext, ConceptMap childConcepts) {
    return {};
  }
}
