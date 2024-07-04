import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/class_concept.dart';
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
      List<LCEConcept> classes = concepts[LCEClass.CONCEPT_ID]!;
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

    test("class inheritance", () {
      List<LCEConcept> classes = concepts[LCEClass.CONCEPT_ID]!;
      final libPath = normPath(packagePath, "./lib/inheritance.dart");
      expect(
          classes,
          contains(matchesClass(
              "package:test_package/inheritance.dart:InternalExtends",
              libPath,
              "InternalExtends")));
      LCEClass c = classes.firstWhere((x) =>
              x is LCEClass &&
              x.fqn == "package:test_package/inheritance.dart:InternalExtends")
          as LCEClass;
      expect(c.extendsType,
          equals("package:test_package/inheritance.dart:InternalClass"));
      expect(c.implementsTypes, isEmpty);
      expect(c.withTypes, isEmpty);

      expect(
          classes,
          contains(matchesClass(
              "package:test_package/inheritance.dart:ExternalExtends",
              libPath,
              "ExternalExtends")));
      c = classes.firstWhere((x) =>
              x is LCEClass &&
              x.fqn == "package:test_package/inheritance.dart:ExternalExtends")
          as LCEClass;
      expect(c.extendsType,
          equals("package:test_package/external.dart:ExternalClass"));
      expect(c.implementsTypes, isEmpty);
      expect(c.withTypes, isEmpty);

      expect(
          classes,
          contains(matchesClass(
              "package:test_package/inheritance.dart:InternalImplements",
              libPath,
              "InternalImplements")));
      c = classes.firstWhere((x) =>
              x is LCEClass &&
              x.fqn ==
                  "package:test_package/inheritance.dart:InternalImplements")
          as LCEClass;
      expect(c.extendsType, isNull);
      expect(c.implementsTypes,
          contains("package:test_package/inheritance.dart:InternalClass"));
      expect(c.implementsTypes,
          contains("package:test_package/inheritance.dart:InternalClass2"));
      expect(c.withTypes, isEmpty);

      expect(
          classes,
          contains(matchesClass(
              "package:test_package/inheritance.dart:ExternalImplements",
              libPath,
              "ExternalImplements")));
      c = classes.firstWhere((x) =>
              x is LCEClass &&
              x.fqn ==
                  "package:test_package/inheritance.dart:ExternalImplements")
          as LCEClass;
      expect(c.extendsType, isNull);
      expect(c.implementsTypes,
          contains("package:test_package/external.dart:ExternalClass"));
      expect(c.implementsTypes,
          contains("package:test_package/external.dart:ExternalClass2"));
      expect(c.withTypes, isEmpty);

      expect(
          classes,
          contains(matchesClass(
              "package:test_package/inheritance.dart:InternalMixins",
              libPath,
              "InternalMixins")));
      c = classes.firstWhere((x) =>
              x is LCEClass &&
              x.fqn == "package:test_package/inheritance.dart:InternalMixins")
          as LCEClass;
      expect(c.extendsType, isNull);
      expect(c.implementsTypes, isEmpty);
      expect(c.withTypes,
          contains("package:test_package/inheritance.dart:InternalMixin"));
      expect(c.withTypes,
          contains("package:test_package/inheritance.dart:InternalMixin2"));
      expect(c.withTypes,
          contains("package:test_package/inheritance.dart:InternalMixinClass"));

      expect(
          classes,
          contains(matchesClass(
              "package:test_package/inheritance.dart:ExternalMixins",
              libPath,
              "ExternalMixins")));
      c = classes.firstWhere((x) =>
              x is LCEClass &&
              x.fqn == "package:test_package/inheritance.dart:ExternalMixins")
          as LCEClass;
      expect(c.extendsType, isNull);
      expect(c.implementsTypes, isEmpty);
      expect(c.withTypes,
          contains("package:test_package/external.dart:ExternalMixin"));
      expect(c.withTypes,
          contains("package:test_package/external.dart:ExternalMixin2"));
    });
  });
}
