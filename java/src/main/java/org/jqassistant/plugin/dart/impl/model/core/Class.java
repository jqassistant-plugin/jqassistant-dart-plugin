package org.jqassistant.plugin.dart.impl.model.core;

import com.fasterxml.jackson.annotation.JsonAlias;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
public class Class extends NamedConcept {

    private String libraryPath;
    private String name;

    @JsonAlias("base")
    private Boolean baseModifier;

    @JsonAlias("interface")
    private Boolean interfaceModifier;

    @JsonAlias("final")
    private Boolean finalModifier;

    @JsonAlias("sealed")
    private Boolean sealedModifier;

    @JsonAlias("abstract")
    private Boolean abstractModifier;

    @JsonAlias("mixin")
    private Boolean mixinModifier;

    @JsonAlias("extends")
    private String extendsFqn;

    @JsonAlias("implements")
    private List<String> implementsFqns;

    @JsonAlias("usedMixins")
    private List<String> usedMixinFqns;
}
