package org.jqassistant.plugin.dart.core.basics;

import com.buschmais.jqassistant.core.store.api.model.Descriptor;
import com.buschmais.jqassistant.core.test.plugin.AbstractPluginIT;
import org.jqassistant.plugin.dart.TestUtils;
import org.jqassistant.plugin.dart.api.DartScope;
import org.jqassistant.plugin.dart.api.model.core.PackageDescriptor;
import org.jqassistant.plugin.dart.core.basics.assertions.DeclarationAssertions;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Basic integration test for the basic features of the core part of the jQA Dart Plugin.
 * This only checks that basic graph structures are generated. It is not exhaustive for all potential scan results.
 */
class DartScannerCoreBasicsIT extends AbstractPluginIT {

    Descriptor scannedDescriptor;

    @Test
    void testScanner() {
        TestUtils utils = new TestUtils();
        File file = utils.getReportJson("java-it-core-basics-sample-dart-output");
        scannedDescriptor = getScanner().scan(file, file.getAbsolutePath(), DartScope.PACKAGE);
        store.beginTransaction();

        TestResult testResult = query("MATCH (package:Dart:Package) RETURN package");
        assertThat(testResult.getColumns())
            .as("package is present in the graph")
            .containsKey("package");
        List<PackageDescriptor> packageDescriptors = testResult.getColumn("package");
        assertThat(packageDescriptors)
            .as("there's only one scanned package")
            .hasSize(1);

        PackageDescriptor packageDescriptor = packageDescriptors.get(0);

        // normally, the following path would be absolute
        // when regenerating the json, please crop the extracted path accordingly
        assertThat(packageDescriptor.getRootDirectory().getAbsoluteFileName())
            .as("package has correct path")
            .isEqualTo(utils.resolvePath("/java/src/test/resources/java-it-core-basics-sample-package"));
        assertThat(packageDescriptor)
            .as("package has correct identifiers")
            .hasFieldOrPropertyWithValue("name", "test_package")
            .hasFieldOrPropertyWithValue("fqn", "package:test_package");

        assertThat(packageDescriptor.getConfigFile().getAbsoluteFileName())
            .as("package has correct config file")
            .isEqualTo(utils.resolvePath("/java/src/test/resources/java-it-core-basics-sample-package/pubspec.yaml"));

        assertThat(packageDescriptor.getLibraries())
            .as("package has two expected empty libraries under lib/")
            .anySatisfy(lib -> assertThat(lib.getFqn()).isEqualTo("package:test_package/a.dart"))
            .anySatisfy(lib -> assertThat(lib.getFqn()).isEqualTo("package:test_package/b.dart"));

        new DeclarationAssertions(packageDescriptor, utils)
            .assertLibraryPresence()
            .assertClassPresence()
            .assertFunctionPresence()
            .assertVariablePresence()
            .assertMixinPresence()
            .assertEnumPresence();

        store.commitTransaction();
    }
}
