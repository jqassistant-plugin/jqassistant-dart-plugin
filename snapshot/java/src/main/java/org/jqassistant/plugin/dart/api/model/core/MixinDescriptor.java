package org.jqassistant.plugin.dart.api.model.core;

import com.buschmais.xo.neo4j.api.annotation.Label;
import com.buschmais.xo.neo4j.api.annotation.Relation;

@Label("Mixin")
public interface MixinDescriptor extends DartDescriptor, FqnDescriptor {

    String getLibraryPath();

    void setLibraryPath(String libraryPath);

    String getName();

    void setName(String name);

    Boolean getBase();

    void setBase(Boolean base);

    @Relation("CONSTRAINED_TO")
    ClassDescriptor getConstrainedTo();

    void setConstrainedTo(ClassDescriptor constrainedTo);
}
