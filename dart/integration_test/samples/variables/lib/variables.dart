import 'package:test_package/external.dart';

class InternalClass {}

var vVar = 1;
late var vLate;
final vFinal = 2;
late final vLateFinal = 3;
const vConst = 4;

final vFinal1 = 1, vFinal2 = "2";

String vString = "";
InternalClass vRefInternal = InternalClass();
ExternalClass vRefExternal = ExternalClass();
