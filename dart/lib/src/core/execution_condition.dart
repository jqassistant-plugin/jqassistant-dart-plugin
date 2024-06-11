import 'package:jqassistant_dart_lce/src/core/context.dart';
import 'package:jqassistant_dart_lce/src/core/utils/ast_utils.dart';

/**
 * Represents the condition under which a [Processor] is executed.
 */
final class ExecutionCondition {
  /** Condition that never returns true */
  static final ExecutionCondition NEVER = ExecutionCondition([], (_) => false);

  List<AstNodeType> currentNodeTypes;
  bool Function(ProcessingContext processingContext) check;

  /**
   * Creates new [ExecutionCondition]
   *
   * [currentNodeTypes]: 1. Check: types of the current node on which the condition shall be checked
   *
   * [check]: 2. Check: function to perform advanced checks on the global and local contexts, and on the node involving parent/sibling nodes, etc.
   */
  ExecutionCondition(this.currentNodeTypes, this.check);
}
