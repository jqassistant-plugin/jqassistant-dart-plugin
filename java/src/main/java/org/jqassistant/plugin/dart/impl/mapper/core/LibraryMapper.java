package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.model.FileDescriptor;
import com.buschmais.jqassistant.plugin.common.api.scanner.FileResolver;
import lombok.extern.slf4j.Slf4j;
import org.jqassistant.plugin.dart.api.model.core.*;
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

        Map<String, List<FunctionDescriptor>> functions = new HashMap<>();
        FunctionMapper.INSTANCE.mapList(conceptCollection.getFunctions(), scanner)
            .forEach(functionDescriptor -> functions.merge(functionDescriptor.getLibraryPath(), new ArrayList<>(List.of(functionDescriptor)), (o, n) -> {
                o.addAll(n);
                return o;
            }));

        Map<String, List<VariableDescriptor>> variables = new HashMap<>();
        VariableMapper.INSTANCE.mapList(conceptCollection.getVariables(), scanner)
            .forEach(variableDescriptor -> variables.merge(variableDescriptor.getLibraryPath(), new ArrayList<>(List.of(variableDescriptor)), (o, n) -> {
                o.addAll(n);
                return o;
            }));

        Map<String, List<MixinDescriptor>> mixins = new HashMap<>();
        MixinMapper.INSTANCE.mapList(conceptCollection.getMixins(), scanner)
            .forEach(mixinDescriptor -> mixins.merge(mixinDescriptor.getLibraryPath(), new ArrayList<>(List.of(mixinDescriptor)), (o, n) -> {
                o.addAll(n);
                return o;
            }));

        Map<String, List<EnumDescriptor>> enums = new HashMap<>();
        EnumMapper.INSTANCE.mapList(conceptCollection.getEnums(), scanner)
            .forEach(enumDescriptor -> enums.merge(enumDescriptor.getLibraryPath(), new ArrayList<>(List.of(enumDescriptor)), (o, n) -> {
                o.addAll(n);
                return o;
            }));

        for (Library library : conceptCollection.getLibraries()) {
            FileDescriptor fileDescriptor = fileResolver.require(library.getPath(), FileDescriptor.class, scanner.getContext());
            if (fileDescriptor != null) { // only represent libraries in the graph that were previously scanned in the file system
                LibraryDescriptor libraryDescriptor = scanner.getContext().getStore().addDescriptorType(fileDescriptor, LibraryDescriptor.class);
                libraryDescriptor.setFqn(library.getFqn());

                libraryDescriptor.getClasses().addAll(classes.getOrDefault(library.getPath(), new ArrayList<>()));
                libraryDescriptor.getFunctions().addAll(functions.getOrDefault(library.getPath(), new ArrayList<>()));
                libraryDescriptor.getVariables().addAll(variables.getOrDefault(library.getPath(), new ArrayList<>()));
                libraryDescriptor.getMixins().addAll(mixins.getOrDefault(library.getPath(), new ArrayList<>()));
                libraryDescriptor.getEnums().addAll(enums.getOrDefault(library.getPath(), new ArrayList<>()));

                result.add(libraryDescriptor);
            }
        }

        return result;
    }

}
