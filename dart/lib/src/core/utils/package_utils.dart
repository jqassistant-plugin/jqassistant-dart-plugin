import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

/**
 * Scans recursively for packages inside a given directory.
 * A package is identified as a directory containing a pubspec.yaml.
 * Returns a list of absolute paths to the detected packages
 */
Future<List<String>> determinePackagePaths(String scanRoot) async {
  List<String> result = [];

  Future<void> scanDirectory(Directory dir) async {
    bool containsPubspec = false;

    await for (var entity in dir.list()) {
      if (entity is File && entity.uri.pathSegments.last == 'pubspec.yaml') {
        containsPubspec = true;
        break;
      }
    }

    if (containsPubspec) {
      result.add(Directory(dir.absolute.path).resolveSymbolicLinksSync());
    } else {
      await for (var entity in dir.list()) {
        if (entity is Directory) {
          await scanDirectory(entity);
        }
      }
    }
  }

  await scanDirectory(Directory(scanRoot));
  return result;
}

/**
 * Scans recursively for libraries inside a given package.
 * Only script files inside the lib/ directory are considered.
 * Returns a list of absolute paths to the detected libraries
 */
Future<List<String>> determineLibraryPaths(String packagePath) async {
  List<String> result = [];

  Future<void> scanDirectory(Directory dir) async {
    await for (var entity in dir.list()) {
      if (entity is File && entity.path.endsWith('.dart')) {
        result.add(entity.absolute.path);
      } else if (entity is Directory) {
        await scanDirectory(entity);
      }
    }
  }

  await scanDirectory(Directory(join(packagePath, "lib")));
  return result;
}

/**
 * Reads pubspec.yaml of a given package and extracts the name property from it
 */
String determinePackageName(String packagePath) {
  File pubspecFile = File(join(packagePath, "pubspec.yaml"));
  final yamlMap = loadYaml(pubspecFile.readAsStringSync());
  return yamlMap["name"];
}
