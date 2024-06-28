package org.jqassistant.plugin.dart.api.model.core;

import com.buschmais.xo.neo4j.api.annotation.Label;

@Label("Mixin")
public interface MixinDescriptor extends DartDescriptor, FqnDescriptor {

    String getLibraryPath();

    void setLibraryPath(String libraryPath);

    String getName();

    void setName(String name);

    Boolean getBase();

    void setBase(Boolean base);

}
