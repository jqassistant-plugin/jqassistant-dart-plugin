package org.jqassistant.plugin.dart.api.model.core;

import com.buschmais.xo.neo4j.api.annotation.Label;

@Label("Parameter")
public interface ParameterDescriptor extends DartDescriptor, FqnDescriptor {

    String getName();

    void setName(String name);

    Integer getIndex();

    void setIndex(Integer index);

    String getType();

    void setType(String type);

}
