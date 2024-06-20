import 'dart:io';

import 'package:jqassistant_dart_lce/src/core/concepts/class_concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/function_concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/library_concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/parameter_concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/variable_concept.dart';
import 'package:path/path.dart';
import 'package:test/expect.dart';

String normPath(String packagePath, String path) {
  return Directory(Directory.current.absolute.path +
          separator +
          packagePath +
          separator +
          path)
      .resolveSymbolicLinksSync()
      .replaceAll("\\", "/");
}

Matcher matchesLibrary(String fqn, String path) => predicate((LCELibrary v) {
      return v.fqn == fqn && v.path == path;
    }, "LCELibrary with fqn: ${fqn} and path: ${path}");

Matcher matchesClass(String fqn, String libraryPath, String name,
        {bool baseModifier = false,
        bool interfaceModifier = false,
        bool finalModifier = false,
        bool sealedModifier = false,
        bool abstractModifier = false,
        bool mixinModifier = false}) =>
    predicate((LCEClass v) {
      return v.fqn == fqn &&
          v.libraryPath == libraryPath &&
          v.name == name &&
          v.baseModifier == baseModifier &&
          v.interfaceModifier == interfaceModifier &&
          v.finalModifier == finalModifier &&
          v.sealedModifier == sealedModifier &&
          v.abstractModifier == abstractModifier &&
          v.mixinModifier == mixinModifier;
    },
        LCEClass(fqn, libraryPath, name, baseModifier, interfaceModifier,
                finalModifier, sealedModifier, abstractModifier, mixinModifier)
            .toString());

Matcher matchesFunction(
        String fqn, String libraryPath, String name, String returnType) =>
    predicate((LCEFunction f) {
      return f.fqn == fqn &&
          f.libraryPath == libraryPath &&
          f.name == name &&
          f.returnType == returnType;
    }, LCEFunction(fqn, libraryPath, name, returnType).toString());

Matcher hasParameter(String name, int index, String type) =>
    predicate((LCEFunction f) {
      return f.parameters.any((p) {
        return p.name == name && p.index == index && p.type == type;
      });
    }, LCEParameter(name, index, type).toString());

Matcher matchesVariable(
        String fqn, String libraryPath, String name, String type,
        {bool lateModifier = false,
        bool finalModifier = false,
        bool constModifier = false}) =>
    predicate((LCEVariable v) {
      return v.fqn == fqn &&
          v.libraryPath == libraryPath &&
          v.name == name &&
          v.type == type &&
          v.lateModifier == lateModifier &&
          v.finalModifier == finalModifier &&
          v.constModifier == constModifier;
    },
        LCEVariable(fqn, libraryPath, name, type, lateModifier, finalModifier,
                constModifier)
            .toString());
