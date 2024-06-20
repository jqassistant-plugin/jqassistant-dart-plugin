import 'package:jqassistant_dart_lce/src/core/concept.dart';

final class LCEVariable extends LCEConcept {
  static const CONCEPT_ID = "variable";

  @override
  String get conceptId => CONCEPT_ID;

  String fqn;
  String libraryPath;
  String name;
  String type;
  bool lateModifier;
  bool finalModifier;
  bool constModifier;

  LCEVariable(this.fqn, this.libraryPath, this.name, this.type,
      this.lateModifier, this.finalModifier, this.constModifier);

  @override
  Map<String, Object> toJSON() {
    return {
      "fqn": fqn,
      "libraryPath": libraryPath,
      "name": name,
      "type": type,
      "late": lateModifier,
      "final": finalModifier,
      "const": constModifier,
    };
  }
}
