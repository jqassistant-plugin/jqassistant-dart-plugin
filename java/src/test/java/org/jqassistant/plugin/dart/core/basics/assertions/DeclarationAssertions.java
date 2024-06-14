package org.jqassistant.plugin.dart.core.basics.assertions;

import org.jqassistant.plugin.dart.TestUtils;
import org.jqassistant.plugin.dart.api.model.core.ClassDescriptor;
import org.jqassistant.plugin.dart.api.model.core.LibraryDescriptor;
import org.jqassistant.plugin.dart.api.model.core.PackageDescriptor;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

public class DeclarationAssertions {

    TestUtils utils;
    PackageDescriptor packageDescriptor;
    LibraryDescriptor classesLibDescriptor;

    public DeclarationAssertions(PackageDescriptor packageDescriptor, TestUtils utils) {
        this.packageDescriptor = packageDescriptor;
        this.utils = utils;
    }

    public DeclarationAssertions assertLibraryPresence() {

        Optional<LibraryDescriptor> classesLibDescriptorOptional = packageDescriptor.getLibraries().stream()
            .filter(mod -> mod.getFqn().equals("package:test_package/classes.dart"))
            .findFirst();

        assertThat(classesLibDescriptorOptional)
            .as("classes library is present")
            .isPresent();

        classesLibDescriptorOptional.ifPresent(moduleDescriptor -> this.classesLibDescriptor = moduleDescriptor);

        return this;
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
            .as("Empty class has all properties set correctly")
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
            .as("empty class is present")
            .isPresent();
        ClassDescriptor abstractMixinClassDescriptor = abstractMixinClassDescriptorOpt.get();
        assertThat(abstractMixinClassDescriptor)
            .as("Empty class has all properties set correctly")
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

}
