package org.jqassistant.plugin.dart.impl.model.core;

import com.fasterxml.jackson.annotation.JsonAlias;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Variable extends NamedConcept {

    private String libraryPath;
    private String name;
    private String type;

    @JsonAlias("late")
    private Boolean lateModifier;

    @JsonAlias("final")
    private Boolean finalModifier;

    @JsonAlias("const")
    private Boolean constModifier;
}
