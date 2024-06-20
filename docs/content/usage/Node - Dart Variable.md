---
aliases:
  - :Dart:Variable
---
# `:Dart:Variable` Node

-> represents a globally declared variable or constant

## Properties

| Name          | Description                                                                       |
| ------------- | --------------------------------------------------------------------------------- |
| `fqn`         | fully qualified name of the variable (e.g. `package:my_package/a.dart:myVariable) |
| `libraryPath` | absolute path of the containing library                                           |
| `name`        | name of the variable                                                              |
| `type`        | name of the type of the variable (*to be replaced with type node system*)         |
| `late`        | indicates, if the variable has a `late` modifier                                  |
| `final`       | indicates, if the variable has a `final` modifier                                 |
| `const`       | indicates, if the variable has a `const` modifier                                 |

%%
## Relations

| Name | Target Label(s) | Cardinality | Description |
|------|-----------------|-------------|-------------|
|      |                 |             |             |
%%