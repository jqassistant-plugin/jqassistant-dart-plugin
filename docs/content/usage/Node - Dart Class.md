---
aliases:
  - :Dart:Class
---
# `:Dart:Class` Node

-> represents a globally declared Dart class

## Properties

| Name                  | Description                                                                  |
|-----------------------|------------------------------------------------------------------------------|
| `fqn`                 | fully qualified name of the class (e.g. `package:my_package/a.dart:MyClass`) |
| `libraryPath`         | absolute path of the containing library                                      |
| `name`                | name of the class                                                            |
| `base` (boolean)      | indicates, if the class has a `base` modifier                                |
| `interface` (boolean) | indicates, if the class has a `interface` modifier                           |
| `final` (boolean)     | indicates, if the class has a `final` modifier                               |
| `sealed` (boolean)    | indicates, if the class has a `sealed` modifier                              |
| `abstract` (boolean)  | indicates, if the class has a `abstract` modifier                            |
| `mixin` (boolean)     | indicates, if the class has a `mixin` modifier                               |

## Relations

| Name         | Target Label(s)                                                          | Cardinality | Description                                                        |
| ------------ | ------------------------------------------------------------------------ | ----------- | ------------------------------------------------------------------ |
| `EXTENDS`    | [[Node - Dart Class\|:Dart:Class]]                                       | 0..1        | super class from which the class inherits via `extends` keyword    |
| `IMPLEMENTS` | [[Node - Dart Class\|:Dart:Class]]                                       | 0..*        | class interfaces which are implemented via `implements` keyword    |
| `USES_MIXIN` | [[Node - Dart Mixin\|:Dart:Mixin]]<br>[[Node - Dart Class\|:Dart:Class]] | 0..*        | mixins and mixin classes that are implemented using `with` keyword |


