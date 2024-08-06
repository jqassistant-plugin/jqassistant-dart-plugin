import 'package:jqassistant_dart_lce/src/core/concept.dart';

final class LCEParameter extends LCEConcept {
  static const CONCEPT_ID = "parameter";

  @override
  String get conceptId => CONCEPT_ID;

  String name;
  int index;
  String type;

  LCEParameter(this.name, this.index, this.type);

  @override
  Map<String, Object?> toJSON() {
    return {"name": name, "index": index, "type": type};
  }
}
