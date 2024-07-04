---
aliases:
  - :Dart:Mixin
---
# `:Dart:Mixin` Node

-> represents a globally declared Dart mixin

## Properties

| Name             | Description                                                                  |
| ---------------- | ---------------------------------------------------------------------------- |
| `fqn`            | fully qualified name of the mixin (e.g. `package:my_package/a.dart:MyMixin`) |
| `libraryPath`    | absolute path of the containing library                                      |
| `name`           | name of the mixin                                                            |
| `base` (boolean) | indicates, if the mixin has a `base` modifier                                |

## Relations

| Name             | Target Label(s)                    | Cardinality | Description                                                     |
| ---------------- | ---------------------------------- | ----------- | --------------------------------------------------------------- |
| `CONSTRAINED_TO` | [[Node - Dart Class\|:Dart:Class]] | 0..1        | class to which the mixin is constrained to via the `on` keyword |
