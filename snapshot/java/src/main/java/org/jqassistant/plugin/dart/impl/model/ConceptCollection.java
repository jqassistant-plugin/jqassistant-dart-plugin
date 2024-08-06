package org.jqassistant.plugin.dart.impl.model;

import com.fasterxml.jackson.annotation.JsonAlias;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.jqassistant.plugin.dart.impl.model.core.Class;
import org.jqassistant.plugin.dart.impl.model.core.Enum;
import org.jqassistant.plugin.dart.impl.model.core.*;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@ToString
public class ConceptCollection {

    @JsonAlias("library")
    private List<Library> libraries = new ArrayList<>();

    @JsonAlias("class")
    private List<Class> classes = new ArrayList<>();

    @JsonAlias("function")
    private List<Function> functions = new ArrayList<>();

    @JsonAlias("variable")
    private List<Variable> variables = new ArrayList<>();

    @JsonAlias("mixin")
    private List<Mixin> mixins = new ArrayList<>();

    @JsonAlias("enum")
    private List<Enum> enums = new ArrayList<>();

}
