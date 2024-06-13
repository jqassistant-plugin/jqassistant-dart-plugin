import '../concept.dart';

final class LCEClass extends LCEConcept {
  @override
  String get conceptId => "class";

  String fqn;
  String libraryPath;
  String name;
  bool baseModifier;
  bool interfaceModifier;
  bool finalModifier;
  bool sealedModifier;
  bool abstractModifier;
  bool mixinModifier;

  LCEClass(
      this.fqn,
      this.libraryPath,
      this.name,
      this.baseModifier,
      this.interfaceModifier,
      this.finalModifier,
      this.sealedModifier,
      this.abstractModifier,
      this.mixinModifier);

  @override
  Map<String, Object> toJSON() {
    return {
      "fqn": fqn,
      "libraryPath": libraryPath,
      "name": name,
      "base": baseModifier,
      "interface": interfaceModifier,
      "final": finalModifier,
      "sealed": sealedModifier,
      "abstract": abstractModifier,
      "mixin": mixinModifier
    };
  }
}
