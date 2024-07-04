import 'package:jqassistant_dart_lce/src/core/concept.dart';

final class LCEMixin extends LCEConcept {
  static const CONCEPT_ID = "mixin";

  @override
  String get conceptId => CONCEPT_ID;

  String fqn;
  String libraryPath;
  String name;
  bool baseModifier;

  String? onClass;

  LCEMixin(
      this.fqn, this.libraryPath, this.name, this.baseModifier, this.onClass);

  @override
  Map<String, Object?> toJSON() {
    return {
      "fqn": fqn,
      "libraryPath": libraryPath,
      "name": name,
      "base": baseModifier,
      "on": onClass
    };
  }
}
