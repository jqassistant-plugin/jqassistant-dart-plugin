import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/mixin_concept.dart';
import 'package:jqassistant_dart_lce/src/core/extractor.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'test_utils.dart';

void main() {
  group("Mixins Test", () {
    final String packagePath = "integration_test/samples/mixins";
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

    test("empty mixins", () {
      List<LCEConcept> mixins = concepts[LCEMixin.CONCEPT_ID]!;
      final libPath = normPath(packagePath, "./lib/empty.dart");
      expect(
          mixins,
          contains(matchesMixin("package:test_package/empty.dart:BasicMixin",
              libPath, "BasicMixin")));
      expect(
          mixins,
          contains(matchesMixin(
              "package:test_package/empty.dart:BaseMixin", libPath, "BaseMixin",
              baseModifier: true)));
    });

    test("empty mixins", () {
      List<LCEConcept> mixins = concepts[LCEMixin.CONCEPT_ID]!;
      final libPath = normPath(packagePath, "./lib/empty.dart");
      expect(
          mixins,
          contains(matchesMixin("package:test_package/empty.dart:BasicMixin",
              libPath, "BasicMixin")));
      expect(
          mixins,
          contains(matchesMixin(
              "package:test_package/empty.dart:BaseMixin", libPath, "BaseMixin",
              baseModifier: true)));
    });

    test("constrained mixins", () {
      List<LCEConcept> mixins = concepts[LCEMixin.CONCEPT_ID]!;
      final libPath = normPath(packagePath, "./lib/constrained.dart");
      expect(
          mixins,
          contains(matchesMixin(
              "package:test_package/constrained.dart:onInternal",
              libPath,
              "onInternal")));
      LCEMixin m = mixins.firstWhere((x) =>
              x is LCEMixin &&
              x.fqn == "package:test_package/constrained.dart:onInternal")
          as LCEMixin;
      expect(m.onClass,
          equals("package:test_package/constrained.dart:InternalClass"));

      expect(
          mixins,
          contains(matchesMixin(
              "package:test_package/constrained.dart:onExternal",
              libPath,
              "onExternal")));
      m = mixins.firstWhere((x) =>
              x is LCEMixin &&
              x.fqn == "package:test_package/constrained.dart:onExternal")
          as LCEMixin;
      expect(m.onClass,
          equals("package:test_package/external.dart:ExternalClass"));
    });
  });
}
