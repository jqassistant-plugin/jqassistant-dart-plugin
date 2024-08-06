package org.jqassistant.plugin.dart.impl.model.core;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.jqassistant.plugin.dart.impl.model.ConceptCollection;

@Getter
@Setter
@ToString
public class Package extends NamedConcept {

    private String name;

    private String packagePath;

    private ConceptCollection concepts;

}
