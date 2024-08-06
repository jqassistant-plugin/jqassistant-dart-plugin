package org.jqassistant.plugin.dart.api.model.core;

import com.buschmais.xo.neo4j.api.annotation.Label;
import com.buschmais.xo.neo4j.api.annotation.Relation;

import java.util.List;

@Label("Package")
public interface PackageDescriptor extends DartDescriptor {

    String getName();

    void setName(String name);

    String getFqn();

    void setFqn(String fqn);

    @Relation("HAS_ROOT")
    LocalFileDescriptor getRootDirectory();

    void setRootDirectory(LocalFileDescriptor rootDirectory);

    @Relation("HAS_CONFIG")
    LocalFileDescriptor getConfigFile();

    void setConfigFile(LocalFileDescriptor configFile);

    @Relation("CONTAINS")
    List<LibraryDescriptor> getLibraries();

}
