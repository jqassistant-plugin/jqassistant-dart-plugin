import 'package:jqassistant_dart_lce/src/core/post_processor.dart';
import 'package:jqassistant_dart_lce/src/core/processor.dart';
import 'package:jqassistant_dart_lce/src/core/processors/class_processor.dart';
import 'package:jqassistant_dart_lce/src/core/processors/library_processor.dart';
import 'package:jqassistant_dart_lce/src/core/utils/ast_utils.dart';

/**
 * Mapping of [AstNodeType]s to all available core [Processor]s
 */
final Map<AstNodeType, List<Processor>> _processors = {
  AstNodeType.compilationUnit: [LibraryProcessor()],
  AstNodeType.classDeclaration: [ClassProcessor()],
};

/**
 * Retrieves all [Processor]s for a given [AstNodeType]
 */
List<Processor> getProcessors(AstNodeType nodeType) {
  return _processors[nodeType] ?? [];
}

/**
 * Adds a new [Processor] for the given [AstNodeType].
 * This function can be used by extensions to provide additional processing capabilities.
 */
void addProcessor(AstNodeType nodeType, Processor processor) {
  if (_processors.containsKey(nodeType)) {
    _processors[nodeType]!.add(processor);
  } else {
    _processors[nodeType] = [processor];
  }
}

/**
 * List of all available [PostProcessors].
 * This list can be expanded by extensions.
 */
final List<PostProcessor> POST_PROCESSORS = [];
