package org.jqassistant.plugin.dart.api.model.core;

import com.buschmais.xo.neo4j.api.annotation.Label;

@Label("Variable")
public interface VariableDescriptor extends DartDescriptor, FqnDescriptor {

    String getLibraryPath();

    void setLibraryPath(String libraryPath);

    String getName();

    void setName(String name);

    String getType();

    void setType(String type);

    Boolean getLate();

    void setLate(Boolean late);

    Boolean getFinal();

    void setFinal(Boolean finals);

    Boolean getConst();

    void setConst(Boolean consts);
}
