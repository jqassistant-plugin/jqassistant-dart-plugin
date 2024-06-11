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
      scanResult =
          await processPackages("integration_test/samples/basic-package");
    });

    test("package exists", () {
      expect(scanResult, hasLength(1));

      final package = scanResult[0];
      expect(package.packageInfo.packageName, "test-package");
    });

    test("libraries exist", () {
      final package = scanResult[0];
      expect(package.concepts["library"], isNotNull);
      final libraries = package.concepts["library"]!;
      expect(
          libraries,
          contains(expectLibary("package:test-package/a.dart",
              normPath(packagePath, "./lib/a.dart"))));
      expect(
          libraries,
          contains(expectLibary("package:test-package/b.dart",
              normPath(packagePath, "./lib/b.dart"))));
    });
  });
}
