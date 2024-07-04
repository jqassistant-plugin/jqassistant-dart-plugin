import 'package:test_package/external.dart';

class InternalClass {}

class InternalClass2 {}

mixin InternalMixin {}

mixin InternalMixin2 {}

mixin class InternalMixinClass {}

class InternalExtends extends InternalClass {}

class ExternalExtends extends ExternalClass {}

class InternalImplements implements InternalClass, InternalClass2 {}

class ExternalImplements implements ExternalClass, ExternalClass2 {}

class InternalMixins with InternalMixin, InternalMixin2, InternalMixinClass {}

class ExternalMixins with ExternalMixin, ExternalMixin2 {}
