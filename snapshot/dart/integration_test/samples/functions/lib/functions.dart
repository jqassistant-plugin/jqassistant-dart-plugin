import 'package:test_package/external.dart';

class InternalClass {}

void voidFunction() {}

int intFunction() {
  return 1;
}

void paramFunction(int a, String b) {}

InternalClass internalRefFunction(InternalClass? c) {
  return InternalClass();
}

ExternalClass externalRefFunction(ExternalClass? c) {
  return ExternalClass();
}

void outerNestedFunction() {
  void innerNestedFunction() {}
}
