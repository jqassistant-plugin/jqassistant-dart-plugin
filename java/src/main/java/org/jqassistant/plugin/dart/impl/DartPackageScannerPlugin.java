package org.jqassistant.plugin.dart.impl;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.core.scanner.api.ScannerPlugin;
import com.buschmais.jqassistant.core.scanner.api.Scope;
import com.buschmais.jqassistant.plugin.common.api.scanner.AbstractScannerPlugin;
import com.buschmais.jqassistant.plugin.common.api.scanner.filesystem.FileResource;
import com.buschmais.jqassistant.plugin.json.api.model.JSONFileDescriptor;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.jqassistant.plugin.dart.api.DartScope;
import org.jqassistant.plugin.dart.api.model.core.DartScanDescriptor;
import org.jqassistant.plugin.dart.impl.mapper.core.DartScanMapper;
import org.jqassistant.plugin.dart.impl.model.core.Package;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@ScannerPlugin.Requires(JSONFileDescriptor.class)
public class DartPackageScannerPlugin extends AbstractScannerPlugin<FileResource, DartScanDescriptor> {

    private ObjectMapper objectMapper;

    @Override
    public void initialize() {
        this.objectMapper = new ObjectMapper();
        this.objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    }

    @Override
    public boolean accepts(FileResource fileResource, String path, Scope scope) {
        return DartScope.PACKAGE.equals(scope) && path.endsWith(".json");
    }

    @Override
    public DartScanDescriptor scan(FileResource fileResource, String path, Scope scope, Scanner scanner) throws IOException {
        var reader = objectMapper.readerFor(Package.class);
        var parser = reader.createParser(fileResource.createStream());
        List<Package> packages = Arrays.asList(reader.readValue(parser, Package[].class));
        return DartScanMapper.INSTANCE.map(packages, scanner);
    }
}
