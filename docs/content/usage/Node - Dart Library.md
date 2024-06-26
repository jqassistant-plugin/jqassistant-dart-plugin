---
aliases:
  - :Dart:Library
---
# `:Dart:Library` Node

-> represents a [Dart library](https://dart.dev/tools/pub/glossary#library)
- represents a single Dart file located in the `./lib` directory of the containing package
    - *libraries that are spread over multiple files using the `part of` directive are currently not supported*
- is realized as an extension of the matching `:File:Local` node

## Properties

| Name  | Description                                                                                                                                                                            |
|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `fqn` | Fully qualified name of the library. Uses the [[Node - Dart Package\|package FQN]] and a path relative to the `./lib` directory of the package (e.g. `package:my_package/my_lib.dart`) |

## Relations

| Name       | Target Label(s)                          | Cardinality | Description                                          |
| ---------- | ---------------------------------------- | ----------- | ---------------------------------------------------- |
| `DECLARES` | [[Node - Dart Class\|:Dart:Class]]       | 0..*        | globally declared classes of the library             |
| `DECLARES` | [[Node - Dart Function\|:Dart:Function]] | 0..*        | globally declared functions of the library           |
| `DECLARES` | [[Node - Dart Variable\|:Dart:Variable]] | 0..*        | globally declared variables/constants of the library |
| `DECLARES` | [[Node - Dart Mixin\|:Dart:Mixin]]       | 0..*        | globally declared mixins of the library              |
| `DECLARES` | [[Node - Dart Enum\|:Dart:Enum]]         | 0..*        | globally declared enums of the library               |
