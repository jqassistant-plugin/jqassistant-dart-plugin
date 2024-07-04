package org.jqassistant.plugin.dart.impl.model.core;

import com.fasterxml.jackson.annotation.JsonAlias;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Mixin extends NamedConcept {

    private String libraryPath;
    private String name;

    @JsonAlias("base")
    private Boolean baseModifier;

    @JsonAlias("on")
    private String constraintFqn;
}
