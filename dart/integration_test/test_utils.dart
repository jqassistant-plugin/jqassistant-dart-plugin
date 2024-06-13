import 'dart:io';

import 'package:jqassistant_dart_lce/src/core/concepts/class_concept.dart';
import 'package:jqassistant_dart_lce/src/core/concepts/library_concept.dart';
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

Matcher expectLibary(String fqn, String path) => predicate((LCELibrary v) {
      return v.fqn == fqn && v.path == path;
    }, "LCELibrary with fqn: ${fqn} and path: ${path}");

Matcher expectClass(String fqn, String libraryPath, String name,
        {bool baseModifier = false,
        bool interfaceModifier = false,
        bool finalModifier = false,
        bool sealedModifier = false,
        bool abstractModifier = false,
        bool mixinModifier = false}) =>
    predicate((LCEClass v) {
      return v.fqn == fqn &&
          v.libraryPath == libraryPath &&
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
