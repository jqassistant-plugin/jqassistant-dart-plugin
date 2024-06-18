---
aliases:
  - :Dart:Function
---
# `:Dart:Function` Node

-> represents a globally declared Dart function
- nested functions are not included in the graph

## Properties

| Name          | Description                                                                        |
|---------------|------------------------------------------------------------------------------------|
| `fqn`         | fully qualified name of the function (e.g. `package:my_package/a.dart:myFunction`) |
| `libraryPath` | absolute path of the containing library                                            |
| `name`        | name of the function                                                               |
| `returnType`  | name of the return type (*to be replaced with type node system*)                   |

## Relations

| Name            | Target Label(s)                            | Cardinality | Description                |
|-----------------|--------------------------------------------|-------------|----------------------------|
| `HAS_PARAMETER` | [[Node - Dart Parameter\|:Dart:Parameter]] | 0..*        | parameters of the function |
