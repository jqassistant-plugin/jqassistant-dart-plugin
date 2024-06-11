import 'package:jqassistant_dart_lce/src/core/concept.dart';

/**
 * Represents basic information about a Dart package and its source files
 */
final class LCEPackageInfo {
  String packageName;

  /**
   * The absolute path to the directory containing the pubspec.yaml
   * This path is unique for every package.
   */
  String packagePath;

  /**
   * List of absolute paths to all .dart source files contained in the package.
   */
  List<String> sourceFilePaths = [];

  LCEPackageInfo(this.packagePath, this.packageName);
}

/**
 * Represents a Dart package along with all concepts contained within it.
 */
final class LCEPackage {
  LCEPackageInfo packageInfo;
  Map<String, List<LCEConcept>> concepts = new Map();

  LCEPackage(this.packageInfo);

  Object toJson() {
    return {
      "name": packageInfo.packageName,
      "fqn": "package:" + packageInfo.packageName,
      "packagePath": packageInfo.packagePath,
      "concepts":
          concepts.map((k, v) => MapEntry(k, v.map((c) => c.toJSON()).toList()))
    };
  }
}
