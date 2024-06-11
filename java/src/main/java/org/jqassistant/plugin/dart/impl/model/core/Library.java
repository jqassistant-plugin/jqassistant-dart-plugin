package org.jqassistant.plugin.dart.impl.model.core;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Library extends NamedConcept {
    private String path;
}
