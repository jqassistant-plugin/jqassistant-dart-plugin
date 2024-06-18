package org.jqassistant.plugin.dart.impl.model.core;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Parameter extends NamedConcept {

    private String name;
    private Integer index;
    private String type;

}
