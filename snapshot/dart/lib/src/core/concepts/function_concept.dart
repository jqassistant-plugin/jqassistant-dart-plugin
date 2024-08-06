import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/parameter_concept.dart';

final class LCEFunction extends LCEConcept {
  static const CONCEPT_ID = "function";

  @override
  String get conceptId => CONCEPT_ID;

  String fqn;
  String libraryPath;
  String name;
  String returnType;
  List<LCEParameter> parameters = [];

  LCEFunction(this.fqn, this.libraryPath, this.name, this.returnType);

  @override
  Map<String, Object?> toJSON() {
    return {
      "fqn": fqn,
      "libraryPath": libraryPath,
      "name": name,
      "returnType": returnType,
      "parameters": parameters.map((p) => p.toJSON()).toList()
    };
  }
}
