class InternalClass {}

class InternalClass2 {}

class InternalClass3 {}
mixin InternalMixin {}
mixin InternalMixin2 {}

class EmptyClass {}

abstract mixin class EmptyAbstractMixinClass {}

class Inheritance extends InternalClass
    with InternalMixin, InternalMixin2
    implements InternalClass2, InternalClass3 {}
