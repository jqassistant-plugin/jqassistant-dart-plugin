package org.jqassistant.plugin.dart.core.basics.assertions;

import org.jqassistant.plugin.dart.TestUtils;
import org.jqassistant.plugin.dart.api.model.core.*;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

public class DeclarationAssertions {

    TestUtils utils;
    PackageDescriptor packageDescriptor;
    LibraryDescriptor classesLibDescriptor;
    LibraryDescriptor functionsLibDescriptor;
    LibraryDescriptor variablesLibDescriptor;
    LibraryDescriptor mixinsLibDescriptor;
    LibraryDescriptor enumsLibDescriptor;

    public DeclarationAssertions(PackageDescriptor packageDescriptor, TestUtils utils) {
        this.packageDescriptor = packageDescriptor;
        this.utils = utils;
    }

    public DeclarationAssertions assertLibraryPresence() {
        classesLibDescriptor = checkForLibrary("classes");
        functionsLibDescriptor = checkForLibrary("functions");
        variablesLibDescriptor = checkForLibrary("variables");
        mixinsLibDescriptor = checkForLibrary("mixins");
        enumsLibDescriptor = checkForLibrary("enums");
        return this;
    }

    private LibraryDescriptor checkForLibrary(String name) {
        Optional<LibraryDescriptor> classesLibDescriptorOptional = packageDescriptor.getLibraries().stream()
            .filter(mod -> mod.getFqn().equals("package:test_package/" + name + ".dart"))
            .findFirst();
        assertThat(classesLibDescriptorOptional)
            .as(name + " library is present")
            .isPresent();
        return classesLibDescriptorOptional.get();
    }

    public DeclarationAssertions assertClassPresence() {
        assertThat(classesLibDescriptor.getClasses())
            .as("classes library has two class declarations")
            .hasSize(2);

        Optional<ClassDescriptor> emptyClassDescriptorOpt = classesLibDescriptor.getClasses().stream().filter(c -> c.getFqn().equals("package:test_package/classes.dart:EmptyClass")).findFirst();
        assertThat(emptyClassDescriptorOpt)
            .as("empty class is present")
            .isPresent();
        ClassDescriptor emptyClassDescriptor = emptyClassDescriptorOpt.get();
        assertThat(emptyClassDescriptor)
            .as("empty class has all properties set correctly")
            .hasFieldOrPropertyWithValue("name", "EmptyClass")
            .hasFieldOrPropertyWithValue("libraryPath", utils.resolvePath("/java/src/test/resources/java-it-core-basics-sample-package/lib/classes.dart"))
            .hasFieldOrPropertyWithValue("base", false)
            .hasFieldOrPropertyWithValue("interface", false)
            .hasFieldOrPropertyWithValue("final", false)
            .hasFieldOrPropertyWithValue("sealed", false)
            .hasFieldOrPropertyWithValue("abstract", false)
            .hasFieldOrPropertyWithValue("mixin", false);

        Optional<ClassDescriptor> abstractMixinClassDescriptorOpt = classesLibDescriptor.getClasses().stream().filter(c -> c.getFqn().equals("package:test_package/classes.dart:EmptyAbstractMixinClass")).findFirst();
        assertThat(abstractMixinClassDescriptorOpt)
            .as("empty abstract mixin class is present")
            .isPresent();
        ClassDescriptor abstractMixinClassDescriptor = abstractMixinClassDescriptorOpt.get();
        assertThat(abstractMixinClassDescriptor)
            .as("empty abstract mixin class has all properties set correctly")
            .hasFieldOrPropertyWithValue("name", "EmptyAbstractMixinClass")
            .hasFieldOrPropertyWithValue("libraryPath", utils.resolvePath("/java/src/test/resources/java-it-core-basics-sample-package/lib/classes.dart"))
            .hasFieldOrPropertyWithValue("base", false)
            .hasFieldOrPropertyWithValue("interface", false)
            .hasFieldOrPropertyWithValue("final", false)
            .hasFieldOrPropertyWithValue("sealed", false)
            .hasFieldOrPropertyWithValue("abstract", true)
            .hasFieldOrPropertyWithValue("mixin", true);

        return this;
    }

    public DeclarationAssertions assertFunctionPresence() {
        assertThat(functionsLibDescriptor.getFunctions())
            .as("functions library has one function")
            .hasSize(1);

        Optional<FunctionDescriptor> functionDescriptorOpt = functionsLibDescriptor.getFunctions().stream().filter(c -> c.getFqn().equals("package:test_package/functions.dart:myFunction")).findFirst();
        assertThat(functionDescriptorOpt)
            .as("function is present")
            .isPresent();
        FunctionDescriptor functionDescriptor = functionDescriptorOpt.get();
        assertThat(functionDescriptor)
            .as("function has all properties set correctly")
            .hasFieldOrPropertyWithValue("name", "myFunction")
            .hasFieldOrPropertyWithValue("libraryPath", utils.resolvePath("/java/src/test/resources/java-it-core-basics-sample-package/lib/functions.dart"))
            .hasFieldOrPropertyWithValue("returnType", "String");
        assertThat(functionDescriptor.getParameters())
            .as("function has parameters set correctly")
            .hasSize(2)
            .anySatisfy(p -> {
                assertThat(p.getName()).isEqualTo("a");
                assertThat(p.getIndex()).isZero();
                assertThat(p.getType()).isEqualTo("int");
            })
            .anySatisfy(p -> {
                assertThat(p.getName()).isEqualTo("b");
                assertThat(p.getIndex()).isEqualTo(1);
                assertThat(p.getType()).isEqualTo("String");
            });

        return this;
    }

    public DeclarationAssertions assertVariablePresence() {
        assertThat(variablesLibDescriptor.getVariables())
            .as("variables library has two variables")
            .hasSize(2);

        Optional<VariableDescriptor> stringVarDescriptorOpt = variablesLibDescriptor.getVariables().stream().filter(c -> c.getFqn().equals("package:test_package/variables.dart:vString")).findFirst();
        assertThat(stringVarDescriptorOpt)
            .as("String variable is present")
            .isPresent();
        VariableDescriptor stringVarDescriptor = stringVarDescriptorOpt.get();
        assertThat(stringVarDescriptor)
            .as("function has all properties set correctly")
            .hasFieldOrPropertyWithValue("name", "vString")
            .hasFieldOrPropertyWithValue("libraryPath", utils.resolvePath("/java/src/test/resources/java-it-core-basics-sample-package/lib/variables.dart"))
            .hasFieldOrPropertyWithValue("type", "String")
            .hasFieldOrPropertyWithValue("late", false)
            .hasFieldOrPropertyWithValue("final", false)
            .hasFieldOrPropertyWithValue("const", false);

        Optional<VariableDescriptor> lateFinalVarDescriptorOpt = variablesLibDescriptor.getVariables().stream().filter(c -> c.getFqn().equals("package:test_package/variables.dart:vLateFinal")).findFirst();
        assertThat(lateFinalVarDescriptorOpt)
            .as("String variable is present")
            .isPresent();
        VariableDescriptor lateFinalVarDescriptor = lateFinalVarDescriptorOpt.get();
        assertThat(lateFinalVarDescriptor)
            .as("function has all properties set correctly")
            .hasFieldOrPropertyWithValue("name", "vLateFinal")
            .hasFieldOrPropertyWithValue("libraryPath", utils.resolvePath("/java/src/test/resources/java-it-core-basics-sample-package/lib/variables.dart"))
            .hasFieldOrPropertyWithValue("type", "int")
            .hasFieldOrPropertyWithValue("late", true)
            .hasFieldOrPropertyWithValue("final", true)
            .hasFieldOrPropertyWithValue("const", false);

        return this;
    }

    public DeclarationAssertions assertMixinPresence() {
        assertThat(mixinsLibDescriptor.getMixins())
            .as("mixins library has one mixin declaration")
            .hasSize(1);

        Optional<MixinDescriptor> baseMixinOpt = mixinsLibDescriptor.getMixins().stream().filter(m -> m.getFqn().equals("package:test_package/mixins.dart:BaseMixin")).findFirst();
        assertThat(baseMixinOpt)
            .as("empty base mixin is present")
            .isPresent();
        MixinDescriptor baseMixinDescriptor = baseMixinOpt.get();
        assertThat(baseMixinDescriptor)
            .as("empty base mixin has all properties set correctly")
            .hasFieldOrPropertyWithValue("name", "BaseMixin")
            .hasFieldOrPropertyWithValue("libraryPath", utils.resolvePath("/java/src/test/resources/java-it-core-basics-sample-package/lib/mixins.dart"))
            .hasFieldOrPropertyWithValue("base", true);

        return this;
    }

    public DeclarationAssertions assertEnumPresence() {
        assertThat(enumsLibDescriptor.getEnums())
            .as("enums library has one enum declaration")
            .hasSize(1);

        Optional<EnumDescriptor> enumOpt = enumsLibDescriptor.getEnums().stream().filter(e -> e.getFqn().equals("package:test_package/enums.dart:BasicEnum")).findFirst();
        assertThat(enumOpt)
            .as("basic enum is present")
            .isPresent();
        EnumDescriptor enumDescriptor = enumOpt.get();
        assertThat(enumDescriptor)
            .as("basic enum has all properties set correctly")
            .hasFieldOrPropertyWithValue("name", "BasicEnum")
            .hasFieldOrPropertyWithValue("libraryPath", utils.resolvePath("/java/src/test/resources/java-it-core-basics-sample-package/lib/enums.dart"));

        return this;
    }

}
