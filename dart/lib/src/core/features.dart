import 'package:jqassistant_dart_lce/src/core/post_processor.dart';
import 'package:jqassistant_dart_lce/src/core/processor.dart';
import 'package:jqassistant_dart_lce/src/core/processors/class_processor.dart';
import 'package:jqassistant_dart_lce/src/core/processors/enum_processor.dart';
import 'package:jqassistant_dart_lce/src/core/processors/function_processor.dart';
import 'package:jqassistant_dart_lce/src/core/processors/library_processor.dart';
import 'package:jqassistant_dart_lce/src/core/processors/mixin_processor.dart';
import 'package:jqassistant_dart_lce/src/core/processors/variable_processor.dart';
import 'package:jqassistant_dart_lce/src/core/utils/ast_utils.dart';

/**
 * Mapping of [AstNodeType]s to all available core [Processor]s
 */
final List<Processor> _processors = [
  LibraryProcessor(),
  ClassProcessor(),
  EnumProcessor(),
  FunctionDeclarationProcessor(),
  FunctionExpressionProcessor(),
  MixinProcessor(),
  VariableProcessor(),
];

/**
 * Retrieves all [Processor]s for a given [AstNodeType]
 */
List<Processor> getProcessors(AstNodeType nodeType) {
  return _processors
      .where((p) => p.executionCondition.currentNodeTypes.contains(nodeType))
      .toList();
}

/**
 * Adds a new [Processor] for the given [AstNodeType].
 * This function can be used by extensions to provide additional processing capabilities.
 */
void addProcessor(Processor processor) {
  _processors.add(processor);
}

/**
 * List of all available [PostProcessors].
 * This list can be expanded by extensions.
 */
final List<PostProcessor> POST_PROCESSORS = [];
