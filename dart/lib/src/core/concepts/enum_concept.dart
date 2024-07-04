import 'package:jqassistant_dart_lce/src/core/concept.dart';

final class LCEEnum extends LCEConcept {
  static const CONCEPT_ID = "enum";

  @override
  String get conceptId => CONCEPT_ID;

  String fqn;
  String libraryPath;
  String name;

  LCEEnum(this.fqn, this.libraryPath, this.name);

  @override
  Map<String, Object?> toJSON() {
    return {"fqn": fqn, "libraryPath": libraryPath, "name": name};
  }
}
