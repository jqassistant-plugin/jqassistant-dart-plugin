package org.jqassistant.plugin.dart.api.model.core;

import com.buschmais.xo.neo4j.api.annotation.Label;
import com.buschmais.xo.neo4j.api.annotation.Relation;

import java.util.List;

@Label("Function")
public interface FunctionDescriptor extends DartDescriptor, FqnDescriptor {

    String getLibraryPath();

    void setLibraryPath(String libraryPath);

    String getName();

    void setName(String name);

    String getReturnType();

    void setReturnType(String returnType);

    @Relation("HAS_PARAMETER")
    List<ParameterDescriptor> getParameters();

}
