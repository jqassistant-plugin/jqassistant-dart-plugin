import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:jqassistant_dart_lce/src/core/concept.dart';
import 'package:jqassistant_dart_lce/src/core/context.dart';
import 'package:jqassistant_dart_lce/src/core/features.dart';
import 'package:jqassistant_dart_lce/src/core/package.dart';
import 'package:jqassistant_dart_lce/src/core/traverser.dart';
import 'package:jqassistant_dart_lce/src/core/utils/package_utils.dart';
import 'package:path/path.dart';

final class ExtractorOptions {
  bool prettyPrint = false;
}

Future<void> processPackagesAndOutputResult(
    String scanRoot, ExtractorOptions options) async {
  List<LCEPackage> packages = await processPackages(scanRoot);

  JsonEncoder encoder;
  if (options.prettyPrint) {
    encoder = JsonEncoder.withIndent('  ');
  } else {
    encoder = JsonEncoder();
  }

  final jsonString = encoder.convert(packages);
  final directory = Directory(join(scanRoot, ".reports", "jqa"));
  directory.createSync(recursive: true);
  final file = File(join(directory.absolute.path, "dart-output.json"));
  file.writeAsString(jsonString);
}

Future<List<LCEPackage>> processPackages(String scanRoot) async {
  final List<LCEPackage> result = [];

  final packagePaths = await determinePackagePaths(scanRoot);
  for (final packagePath in packagePaths) {
    LCEPackageInfo packageInfo = LCEPackageInfo(
        packagePath.replaceAll("\\", "/"), determinePackageName(packagePath));
    ConceptMap concepts = {};

    // Processing
    final libraryPaths = await determineLibraryPaths(packagePath);
    AnalysisContextCollection analysisContextCollection =
        AnalysisContextCollection(includedPaths: [packagePath]);
    AnalysisContext context = analysisContextCollection.contextFor(packagePath);
    AnalysisSession session = context.currentSession;
    for (final libraryPath in libraryPaths) {
      print("Scanning " + libraryPath);
      final result = await session.getResolvedUnit(libraryPath);
      if (result is ResolvedUnitResult) {
        CompilationUnit unit = result.unit;
        ConceptMap? extractedConcepts = unit.accept(Traverser(GlobalContext(
            packageInfo, libraryPath.replaceAll("\\", "/"), session)));
        if (extractedConcepts != null) {
          mergeConceptMaps([concepts, extractedConcepts]);
        }
      } else {
        print("Error: Could not resolve AST for : ${libraryPath}");
      }
    }

    LCEPackage package = LCEPackage(packageInfo)..concepts = concepts;

    result.add(package);
  }

  // Post-Processing
  for (var postProcessor in POST_PROCESSORS) {
    postProcessor.postProcess(result);
  }

  return result;
}
