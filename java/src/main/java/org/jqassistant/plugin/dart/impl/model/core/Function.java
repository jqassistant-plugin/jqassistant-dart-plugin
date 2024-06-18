package org.jqassistant.plugin.dart.impl.model.core;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@ToString
public class Function extends NamedConcept {

    private String libraryPath;
    private String name;
    private String returnType;
    private List<Parameter> parameters = new ArrayList<>();
}
