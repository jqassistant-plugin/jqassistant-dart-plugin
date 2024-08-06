package org.jqassistant.plugin.dart.api.model.core;

import com.buschmais.jqassistant.plugin.common.api.model.FileDescriptor;
import com.buschmais.xo.neo4j.api.annotation.Label;
import com.buschmais.xo.neo4j.api.annotation.Relation;

import java.util.List;

@Label("Scan")
public interface DartScanDescriptor extends DartDescriptor, FileDescriptor {

    @Relation("CONTAINS_PACKAGE")
    List<PackageDescriptor> getPackages();

}
