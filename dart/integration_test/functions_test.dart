import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/function_concept.dart';
import 'package:jqassistant_dart_lce/src/core/extractor.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'test_utils.dart';

void main() {
  group("Functions Test", () {
    final String packagePath = "integration_test/samples/functions";
    final String libPath = normPath(packagePath, "./lib/functions.dart");
    Map<String, LCEFunction> functions = {};
    late ConceptMap concepts;

    setUpAll(() async {
      final scanResult =
          await processPackages(packagePath, new ExtractorOptions());
      concepts = scanResult[0].concepts;

      expect(concepts["library"], isNotNull);
      final libraries = concepts["library"]!;
      expect(
          libraries,
          contains(matchesLibrary("package:test_package/functions.dart",
              normPath(packagePath, "./lib/functions.dart"))));

      expect(concepts.containsKey(LCEFunction.CONCEPT_ID), isTrue);

      concepts[LCEFunction.CONCEPT_ID]
          ?.map((fun) => fun as LCEFunction)
          .forEach((fun) {
        functions[fun.name] = fun;
      });
    });

    test("void function", () {
      expect(functions.containsKey("voidFunction"), isTrue);
      LCEFunction function = functions["voidFunction"]!;
      expect(
          function,
          matchesFunction("package:test_package/functions.dart:voidFunction",
              libPath, "voidFunction", "void"));
      expect(function.parameters, isEmpty);
    });

    test("int function", () {
      expect(functions.containsKey("intFunction"), isTrue);
      LCEFunction function = functions["intFunction"]!;
      expect(
          function,
          matchesFunction("package:test_package/functions.dart:intFunction",
              libPath, "intFunction", "int"));
      expect(function.parameters, isEmpty);
    });

    test("function with internal class return type", () {
      expect(functions.containsKey("internalRefFunction"), isTrue);
      LCEFunction function = functions["internalRefFunction"]!;
      expect(
          function,
          matchesFunction(
              "package:test_package/functions.dart:internalRefFunction",
              libPath,
              "internalRefFunction",
              "InternalClass"));
      expect(function, hasParameter("c", 0, "InternalClass?"));
    });

    test("function with external class return type", () {
      expect(functions.containsKey("externalRefFunction"), isTrue);
      LCEFunction function = functions["externalRefFunction"]!;
      expect(
          function,
          matchesFunction(
              "package:test_package/functions.dart:externalRefFunction",
              libPath,
              "externalRefFunction",
              "ExternalClass"));
      expect(function, hasParameter("c", 0, "ExternalClass?"));
    });

    test("nested function", () {
      expect(functions.containsKey("outerNestedFunction"), isTrue);
      LCEFunction function = functions["outerNestedFunction"]!;
      expect(
          function,
          matchesFunction(
              "package:test_package/functions.dart:outerNestedFunction",
              libPath,
              "outerNestedFunction",
              "void"));
      expect(function.parameters, isEmpty);

      expect(functions.containsKey("innerNestedFunction"), isFalse);
    });
  });
}
