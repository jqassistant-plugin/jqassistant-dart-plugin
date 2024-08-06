import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/variable_concept.dart';
import 'package:jqassistant_dart_lce/src/core/extractor.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'test_utils.dart';

void main() {
  group("Variables Test", () {
    final String packagePath = "integration_test/samples/variables";
    final String libPath = normPath(packagePath, "./lib/variables.dart");
    Map<String, LCEVariable> variables = {};
    late ConceptMap concepts;

    setUpAll(() async {
      final scanResult = await processPackages(packagePath);
      concepts = scanResult[0].concepts;

      expect(concepts["library"], isNotNull);
      final libraries = concepts["library"]!;
      expect(
          libraries,
          contains(matchesLibrary("package:test_package/variables.dart",
              normPath(packagePath, "./lib/variables.dart"))));

      expect(concepts.containsKey(LCEVariable.CONCEPT_ID), isTrue);

      concepts[LCEVariable.CONCEPT_ID]
          ?.map((fun) => fun as LCEVariable)
          .forEach((v) {
        variables[v.name] = v;
      });
    });

    test("variable keyword combinations", () {
      expect(variables.containsKey("vVar"), isTrue);
      expect(
          variables["vVar"]!,
          matchesVariable("package:test_package/variables.dart:vVar", libPath,
              "vVar", "int"));
      expect(
          variables["vLate"]!,
          matchesVariable("package:test_package/variables.dart:vLate", libPath,
              "vLate", "dynamic",
              lateModifier: true));
      expect(
          variables["vFinal"]!,
          matchesVariable("package:test_package/variables.dart:vFinal", libPath,
              "vFinal", "int",
              finalModifier: true));
      expect(
          variables["vLateFinal"]!,
          matchesVariable("package:test_package/variables.dart:vLateFinal",
              libPath, "vLateFinal", "int",
              lateModifier: true, finalModifier: true));
      expect(
          variables["vConst"]!,
          matchesVariable("package:test_package/variables.dart:vConst", libPath,
              "vConst", "int",
              constModifier: true));
      expect(
          variables["vFinal1"]!,
          matchesVariable("package:test_package/variables.dart:vFinal1",
              libPath, "vFinal1", "int",
              finalModifier: true));
      expect(
          variables["vFinal2"]!,
          matchesVariable("package:test_package/variables.dart:vFinal2",
              libPath, "vFinal2", "String",
              finalModifier: true));
      expect(
          variables["vString"]!,
          matchesVariable("package:test_package/variables.dart:vString",
              libPath, "vString", "String"));
      expect(
          variables["vRefInternal"]!,
          matchesVariable("package:test_package/variables.dart:vRefInternal",
              libPath, "vRefInternal", "InternalClass"));
      expect(
          variables["vRefExternal"]!,
          matchesVariable("package:test_package/variables.dart:vRefExternal",
              libPath, "vRefExternal", "ExternalClass"));
    });
  });
}
