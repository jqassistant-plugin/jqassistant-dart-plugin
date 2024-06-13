package org.jqassistant.plugin.dart.api.model.core;

import com.buschmais.xo.neo4j.api.annotation.Label;
import com.buschmais.xo.neo4j.api.annotation.Relation;

import java.util.List;

@Label("Library")
public interface LibraryDescriptor extends DartDescriptor, FqnDescriptor {

    @Relation("DECLARES")
    List<ClassDescriptor> getClasses();

}
