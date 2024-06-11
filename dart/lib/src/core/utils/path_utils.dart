import 'package:jqassistant_dart_lce/src/core/package.dart';
import 'package:path/path.dart';

/**
 * converts an absolute path to a valid Dart FQN with a "package:..." prefix
 */
String convertLibraryPathToFQN(
    LCEPackageInfo packageInfo, String libraryPathAbsolute) {
  return libraryPathAbsolute.replaceFirst(join(packageInfo.packagePath, "lib"),
      "package:" + packageInfo.packageName);
}
