/**
 * Base class for all language concepts
 */
abstract base class LCEConcept {
  /**
   * Returns an unique identifier for a concept class.
   */
  String get conceptId;

  /**
   * Contains metadata that may be used by Processors further up the AST, or by Post-Processors.
   * NOTE: metadata should not be used in the toJSON method, as Concept classes should not contain any processing logic.
   */
  Map<String, Object> metadata = Map();

  /**
   * Returns a JSON object that contains all the information that should be present in the JSON report that is used for graph generation.
   * NOTE: This method should not contain any processing logic!
   *
   * Returns all fields, except metadata by default. Also calls toJSON for all fields that are concepts, or concept arrays.
   */
  Map<String, Object> toJSON();

  @override
  String toString() {
    return "${this.runtimeType.toString()}${toJSON().toString()}";
  }
}

/**
 * Represents a set of language concepts identified by their concept id representing their type.
 *
 * Key Structure: conceptMap.get(parentPropName).get(conceptId)
 */
typedef ConceptMap = Map<String, List<LCEConcept>>;

/**
 * Merges the given ConceptMaps. Array values of the same keys are concatenated.
 */
ConceptMap mergeConceptMaps(List<ConceptMap> maps) {
  if (maps.length == 0) {
    return {};
  } else if (maps.length == 1) {
    return maps[0];
  }

  final result = maps[0];

  for (var i = 1; i < maps.length; i++) {
    final mapToMerge = maps[i];
    for (final entry in mapToMerge.entries) {
      if (result.containsKey(entry.key)) {
        result[entry.key]?.addAll(entry.value);
      } else {
        result[entry.key] = entry.value;
      }
    }
  }

  return result;
}

/**
 * creates a ConceptMap containing a single concept
 */
ConceptMap singleEntryConceptMap(LCEConcept concept) {
  return {
    concept.conceptId: [concept]
  };
}

/**
 * Takes a [ConceptMap] with containing already processed child concepts, removes all concepts of the given concept ID and returns them.
 */
List<T> extractAndDeleteChildConcepts<T extends LCEConcept>(
    ConceptMap childConcepts, String conceptId) {
  return childConcepts.remove(conceptId)?.map((elem) => elem as T).toList() ??
      [];
}
