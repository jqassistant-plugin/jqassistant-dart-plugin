package org.jqassistant.plugin.dart.api.model.core;

import com.buschmais.xo.neo4j.api.annotation.Label;
import com.buschmais.xo.neo4j.api.annotation.Relation;

import java.util.List;

@Label("Class")
public interface ClassDescriptor extends DartDescriptor, FqnDescriptor {

    String getLibraryPath();

    void setLibraryPath(String libraryPath);

    String getName();

    void setName(String name);

    Boolean getBase();

    void setBase(Boolean base);

    Boolean getInterface();

    void setInterface(Boolean interfaces);

    Boolean getFinal();

    void setFinal(Boolean finals);

    Boolean getSealed();

    void setSealed(Boolean sealed);

    Boolean getAbstract();

    void setAbstract(Boolean abstracts);

    Boolean getMixin();

    void setMixin(Boolean mixin);

    @Relation("EXTENDS")
    ClassDescriptor getExtends();

    void setExtends(ClassDescriptor extendss);

    @Relation("IMPLEMENTS")
    List<ClassDescriptor> getImplements();

    @Relation("USES_MIXIN")
    List<DartDescriptor> getUsesMixin();
}
