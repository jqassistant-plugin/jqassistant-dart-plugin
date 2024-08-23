import 'dart:io';

import 'package:args/args.dart';
import 'package:jqassistant_dart_lce/src/core/extractor.dart';

void main(List<String> arguments) async {
  print("jQAssistant Dart Language Concept Extractor");

  final parser = ArgParser()
    ..addFlag("pretty-print",
        abbr: "p",
        defaultsTo: false,
        help: "if set, the output JSON file will use pretty print")
    ..addOption("sdk-path",
        abbr: "S",
        defaultsTo: null,
        help:
            "can be used to explicitly set the path of the Dart SDK that should be used by the tool");
  ArgResults argResults = parser.parse(arguments);

  if (argResults.rest.length > 1) {
    print("Please specify only one path to be scanned for Dart packages.");
    exit(1);
  }
  final scanRoot = argResults.rest.length == 0 ? "./" : argResults.rest[0];

  final options = ExtractorOptions();
  options.prettyPrint = argResults.flag("pretty-print");
  options.sdkPath = argResults.option("sdk-path");

  await processPackagesAndOutputResult(scanRoot, options);
}
