import 'dart:io';

import 'package:jqassistant_dart_lce/src/core/concepts/library_concept.dart';
import 'package:path/path.dart';
import 'package:test/expect.dart';

String normPath(String packagePath, String path) {
  return Directory(Directory.current.absolute.path +
          separator +
          packagePath +
          separator +
          path)
      .resolveSymbolicLinksSync();
}

Matcher expectLibary(String fqn, String path) => predicate((LCELibrary v) {
      return v.fqn == fqn && v.path == path;
    }, "LCELibrary with fqn: ${fqn} and path: ${path}");
