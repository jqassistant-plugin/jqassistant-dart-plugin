import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/package.dart';

final class ProcessingContext {
  AstNode astNode;
  GlobalContext globalContext;
  LocalContexts localContexts;
  List<MetadataAssignmentRule> metadataAssignments;

  ProcessingContext(this.astNode, this.globalContext, this.localContexts,
      this.metadataAssignments);
}

/**
 * describes basic data structures provided to all Processors on a file level
 */
final class GlobalContext {
  LCEPackageInfo packageInfo;
  String sourceFilePathAbsolute;
  AnalysisSession analysisSession;

  GlobalContext(
      this.packageInfo, this.sourceFilePathAbsolute, this.analysisSession);
}

/**
 * represents the local contexts currently available at a given node inside the AST
 */
final class LocalContexts {
  List<Map<String, Object>> contexts = [];

  Map<String, Object> currentContexts() {
    if (contexts.length == 0) {
      return {};
    } else {
      return contexts[contexts.length - 1];
    }
  }

  Map<String, Object>? parentContexts() {
    if (contexts.length < 2) {
      return null;
    } else {
      return contexts[contexts.length - 2];
    }
  }

  /**
   * [name]: name of the context type to searched for
   *
   * Returns: closest context with given name to the current contexts, along with its position inside the stack, or
   * `null` if no context with the given name exists
   */
  (Object, int)? getNextContext(String name) {
    for (var i = contexts.length - 1; i >= 0; i--) {
      final context = contexts[i][name];
      if (context != null) {
        return (context, i - contexts.length);
      }
    }
    return null;
  }

  void pushContexts() {
    contexts.add({});
  }

  Map<String, Object>? popContexts() {
    if (contexts.isEmpty) {
      return null;
    }
    return contexts.removeLast();
  }
}

/**
 * Represents a rule for attaching certain metadata to concepts created during the post-children-processing phase.
 * The condition has to resolve to true in order for the metadata to be attached to a concept.
 *
 * A rule is propagated up the AST until it can be applied to at least one concept after the post-children-processing phase.
 */
final class MetadataAssignmentRule {
  bool Function(LCEConcept concept) condition;
  Map<String, Object> metadata;

  MetadataAssignmentRule(this.condition, this.metadata);

  /**
   * Checks if the condition is met for a given concept and if it is, applies the specified metadata to it.
   *
   * [concept] Concept to which the metadata should be attached to
   *
   * Returns: whether the metadata was applied
   */
  bool apply(LCEConcept concept) {
    final result = condition(concept);
    if (result) {
      metadata.forEach((key, value) {
        concept.metadata[key] = value;
      });
    }
    return result;
  }
}
