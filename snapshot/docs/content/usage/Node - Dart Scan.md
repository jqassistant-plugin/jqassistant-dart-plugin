---
aliases:
  - :Dart:Scan
---
# `:DartScan` Node

-> represents the results for scanning a directory for Dart packages
- is realized as additional labels on a `:File:Json` node

## Relations

| Name               | Target Label(s)                        | Cardinality | Description                                                                       |
|--------------------|----------------------------------------|-------------|-----------------------------------------------------------------------------------|
| `CONTAINS_PACKAGE` | [[Node - Dart Package\|:Dart:Package]] | 0..*        | all Dart packages that were found in the scanning directory or its subdirectories |
