package org.jqassistant.plugin.dart.impl.model.core;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Enum extends NamedConcept {

    private String libraryPath;
    private String name;

}
