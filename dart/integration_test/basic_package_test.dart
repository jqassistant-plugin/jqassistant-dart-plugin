import 'package:jqassistant_dart_lce/src/core/extractor.dart';
import 'package:jqassistant_dart_lce/src/core/package.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'test_utils.dart';

void main() {
  group("Basic Package Test", () {
    final String packagePath = "integration_test/samples/basic-package";
    late List<LCEPackage> scanResult;

    setUpAll(() async {
      scanResult = await processPackages(packagePath, new ExtractorOptions());
    });

    test("package exists", () {
      expect(scanResult, hasLength(1));

      final package = scanResult[0];
      expect(package.packageInfo.packageName, "test_package");
    });

    test("libraries exist", () {
      final package = scanResult[0];
      expect(package.concepts["library"], isNotNull);
      final libraries = package.concepts["library"]!;
      expect(
          libraries,
          contains(matchesLibrary("package:test_package/a.dart",
              normPath(packagePath, "./lib/a.dart"))));
      expect(
          libraries,
          contains(matchesLibrary("package:test_package/b.dart",
              normPath(packagePath, "./lib/b.dart"))));
    });
  });
}
