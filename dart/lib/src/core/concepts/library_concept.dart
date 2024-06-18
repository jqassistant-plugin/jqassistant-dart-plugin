import 'package:jqassistant_dart_lce/src/core/concept.dart';

final class LCELibrary extends LCEConcept {
  static const CONCEPT_ID = "library";

  @override
  String get conceptId => CONCEPT_ID;

  String fqn;
  String path;

  LCELibrary(this.fqn, this.path);

  @override
  Map<String, Object> toJSON() {
    return {
      "fqn": fqn,
      "path": path,
    };
  }
}
