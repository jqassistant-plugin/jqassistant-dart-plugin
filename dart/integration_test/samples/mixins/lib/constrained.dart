import 'package:test_package/external.dart';

class InternalClass {}

mixin onInternal on InternalClass {}

mixin onExternal on ExternalClass {}
