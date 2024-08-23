import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/enum_concept.dart';
import 'package:jqassistant_dart_lce/src/core/extractor.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'test_utils.dart';

void main() {
  group("Enums Test", () {
    final String packagePath = "integration_test/samples/enums";
    late ConceptMap concepts;

    setUpAll(() async {
      final scanResult =
          await processPackages(packagePath, new ExtractorOptions());
      concepts = scanResult[0].concepts;
    });

    test("library exists", () {
      expect(concepts["library"], isNotNull);
      final libraries = concepts["library"]!;
      expect(
          libraries,
          contains(matchesLibrary("package:test_package/enums.dart",
              normPath(packagePath, "./lib/enums.dart"))));
    });

    test("empty mixins", () {
      List<LCEConcept> enums = concepts[LCEEnum.CONCEPT_ID]!;
      final libPath = normPath(packagePath, "./lib/enums.dart");
      expect(
          enums,
          contains(matchesEnum("package:test_package/enums.dart:BasicEnum",
              libPath, "BasicEnum")));
    });
  });
}
