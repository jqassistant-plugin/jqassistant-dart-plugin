package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.model.FileDescriptor;
import com.buschmais.jqassistant.plugin.common.api.scanner.FileResolver;
import lombok.extern.slf4j.Slf4j;
import org.jqassistant.plugin.dart.api.model.core.ClassDescriptor;
import org.jqassistant.plugin.dart.api.model.core.LibraryDescriptor;
import org.jqassistant.plugin.dart.impl.model.ConceptCollection;
import org.jqassistant.plugin.dart.impl.model.core.Library;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
public class LibraryMapper {

    public static final LibraryMapper INSTANCE = new LibraryMapper();

    public List<LibraryDescriptor> map(ConceptCollection conceptCollection, Scanner scanner) {
        FileResolver fileResolver = scanner.getContext().peek(FileResolver.class);
        List<LibraryDescriptor> result = new ArrayList<>();

        Map<String, List<ClassDescriptor>> classes = new HashMap<>();
        ClassMapper.INSTANCE.mapList(conceptCollection.getClasses(), scanner)
            .forEach(classDescriptor -> classes.merge(classDescriptor.getLibraryPath(), new ArrayList<>(List.of(classDescriptor)), (o, n) -> {
                o.addAll(n);
                return o;
            }));

        for (Library library : conceptCollection.getLibraries()) {
            FileDescriptor fileDescriptor = fileResolver.require(library.getPath(), FileDescriptor.class, scanner.getContext());
            if (fileDescriptor != null) { // only represent libraries in the graph that were previously scanned in the file system
                LibraryDescriptor libraryDescriptor = scanner.getContext().getStore().addDescriptorType(fileDescriptor, LibraryDescriptor.class);
                libraryDescriptor.setFqn(library.getFqn());

                libraryDescriptor.getClasses().addAll(classes.getOrDefault(library.getPath(), new ArrayList<>()));

                result.add(libraryDescriptor);
            }
        }

        return result;
    }

}
