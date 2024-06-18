import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/extractor.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'test_utils.dart';

void main() {
  group("Classes Test", () {
    final String packagePath = "integration_test/samples/classes";
    late ConceptMap concepts;

    setUpAll(() async {
      final scanResult = await processPackages(packagePath);
      concepts = scanResult[0].concepts;
    });

    test("library exists", () {
      expect(concepts["library"], isNotNull);
      final libraries = concepts["library"]!;
      expect(
          libraries,
          contains(matchesLibrary("package:test_package/empty.dart",
              normPath(packagePath, "./lib/empty.dart"))));
    });

    test("empty classes", () {
      List<LCEConcept> classes = concepts["class"]!;
      final libPath = normPath(packagePath, "./lib/empty.dart");
      expect(
          classes,
          contains(matchesClass("package:test_package/empty.dart:BasicClass",
              libPath, "BasicClass")));
      expect(
          classes,
          contains(matchesClass(
              "package:test_package/empty.dart:BaseClass", libPath, "BaseClass",
              baseModifier: true)));
      expect(
          classes,
          contains(matchesClass(
              "package:test_package/empty.dart:InterfaceClass",
              libPath, "InterfaceClass",
              interfaceModifier: true)));
      expect(
          classes,
          contains(matchesClass("package:test_package/empty.dart:FinalClass",
              libPath, "FinalClass",
              finalModifier: true)));
      expect(
          classes,
          contains(matchesClass("package:test_package/empty.dart:SealedClass",
              libPath, "SealedClass",
              sealedModifier: true)));
      expect(
          classes,
          contains(matchesClass("package:test_package/empty.dart:AbstractClass",
              libPath, "AbstractClass",
              abstractModifier: true)));
      expect(
          classes,
          contains(matchesClass(
              "package:test_package/empty.dart:AbstractInterfaceClass",
              libPath,
              "AbstractInterfaceClass",
              abstractModifier: true,
              interfaceModifier: true)));
      expect(
          classes,
          contains(matchesClass(
              "package:test_package/empty.dart:AbstractFinalClass",
              libPath,
              "AbstractFinalClass",
              abstractModifier: true,
              finalModifier: true)));
      expect(
          classes,
          contains(matchesClass("package:test_package/empty.dart:MixinClass",
              libPath, "MixinClass",
              mixinModifier: true)));
      expect(
          classes,
          contains(matchesClass(
              "package:test_package/empty.dart:BaseMixinClass",
              libPath, "BaseMixinClass",
              baseModifier: true, mixinModifier: true)));
      expect(
          classes,
          contains(matchesClass(
              "package:test_package/empty.dart:AbstractMixinClass",
              libPath,
              "AbstractMixinClass",
              abstractModifier: true,
              mixinModifier: true)));
      expect(
          classes,
          contains(matchesClass(
              "package:test_package/empty.dart:AbstractBaseMixinClass",
              libPath,
              "AbstractBaseMixinClass",
              abstractModifier: true,
              baseModifier: true,
              mixinModifier: true)));
    });
  });
}
