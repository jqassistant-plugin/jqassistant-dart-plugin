import '../concept.dart';

final class LCELibrary extends LCEConcept {
  @override
  String get conceptId => "library";

  String fqn;
  String path;

  LCELibrary(this.fqn, this.path);

  @override
  Object toJSON() {
    return {
      "fqn": fqn,
      "path": path,
    };
  }
}
