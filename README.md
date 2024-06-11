# jQAssistant Dart Plugin

> NOTE: This plugin is in active development. Expect limited feature sets and (partially) incorrect behaviors.

This is the [Dart](https://dart.dev) Plugin of https://jqassistant.org[jQAssistant].
It provides a tool to extract language concepts from Dart code and a scanner for the resulting JSON files.

> For more info, refer to the **[Documentation](https://jqassistant-plugin.github.io/jqassistant-dart-plugin)**

## Installation & Basic Usage (WIP)

**Dart Tooling:**

1. Install Dart on your machine
2. Clone this repository
3. Run `dart pub global activate bin -s path` inside the `./dart` directory of the repository
    - NOTE: you may need to follow the instructions in the console output to add the executable to your `PATH` variable
4. Use `jqa_dart_lce` to run the tool

**Java Tooling:**

1. Run `mvn clean install` in the root directory of the repository
2. Add the following configuration to a `.jqassistant.yml` in the Dart package root directory:
    ```yaml
    jqassistant:
      plugins:
        # Includes the jQAssistant Dart plugin
        - group-id: org.jqassistant.plugin.dart
          artifact-id: jqassistant-dart-plugin
          version: 1.0.0-SNAPSHOT
      scan:
        include:
          files:
            - dart:package::.reports/jqa/dart-output.json
    ```
3. Run the [jQA CLI](https://mvnrepository.com/artifact/com.buschmais.jqassistant.cli/jqassistant-commandline-neo4jv5)
   in the project directory
    - e.g. `~/path/to/cli/bin/jqassistant.sh reset scan analyze`
