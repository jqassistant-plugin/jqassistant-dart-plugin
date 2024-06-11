package org.jqassistant.plugin.dart.impl.model;

import com.fasterxml.jackson.annotation.JsonAlias;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.jqassistant.plugin.dart.impl.model.core.Library;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@ToString
public class ConceptCollection {

    @JsonAlias("library")
    private List<Library> libraries = new ArrayList<>();

}
