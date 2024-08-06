---
aliases:
  - :Dart:Package
---
# `:Dart:Package` Node

-> represents a [Dart Package](https://dart.dev/tools/pub/glossary#package)

## Properties

| Name   | Description                                            |
|--------|--------------------------------------------------------|
| `name` | name of the package as specified in the `pubspec.yaml` |
| `fqn`  | identifier in the form `package:<package_name>`        |

## Relations

| Name         | Target Label(s)                        | Cardinality | Description                                                              |
|--------------|----------------------------------------|-------------|--------------------------------------------------------------------------|
| `HAS_ROOT`   | `:Local:File:Directory`                | 1           | root directory of the package                                            |
| `HAS_CONFIG` | `:Local:File`                          | 1           | `pubspec.yaml` file of the package                                       |
| `CONTAINS`   | [[Node - Dart Library\|:Dart:Library]] | 0...*       | the individual libraries contained within the package's `/lib` directory |
