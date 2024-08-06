package org.jqassistant.plugin.dart.impl.mapper.core;

import lombok.Getter;
import org.jqassistant.plugin.dart.api.model.core.ClassDescriptor;
import org.jqassistant.plugin.dart.api.model.core.DartDescriptor;
import org.jqassistant.plugin.dart.api.model.core.MixinDescriptor;

import java.util.*;
import java.util.function.BiConsumer;
import java.util.stream.Collectors;


public class FqnResolver {

    private final Map<String, DartDescriptor> namedConcepts = new HashMap<>();

    private final Map<ResolutionType, List<ResolutionTask>> resolutionTasks = new EnumMap<>(ResolutionType.class);

    public enum ResolutionType {
        CLASS_EXTENDS,
        CLASS_IMPLEMENTS,
        CLASS_MIXIN_USAGE,
        MIXIN_CONSTRAINT
    }

    public void resolveAll() {
        resolutionTasks.forEach((resolutionType, rTs) -> {
            if (resolutionType == ResolutionType.CLASS_EXTENDS) {
                rTs.forEach(resolutionTask -> resolutionTask.resolve((ClassDescriptor d, String fqn) -> d.setExtends(getNamedConcept(fqn))));
            } else if (resolutionType == ResolutionType.CLASS_IMPLEMENTS) {
                rTs.forEach(resolutionTask -> resolutionTask.resolveList((ClassDescriptor d, List<String> fqns) -> d.getImplements().addAll(getNamedConcepts(fqns))));
            } else if (resolutionType == ResolutionType.CLASS_MIXIN_USAGE) {
                rTs.forEach(resolutionTask -> resolutionTask.resolveList((ClassDescriptor d, List<String> fqns) -> d.getUsesMixin().addAll(getNamedConcepts(fqns))));
            } else if (resolutionType == ResolutionType.MIXIN_CONSTRAINT) {
                rTs.forEach(resolutionTask -> resolutionTask.resolve((MixinDescriptor d, String fqn) -> d.setConstrainedTo(getNamedConcept(fqn))));
            }
        });
    }

    public void registerFqn(String fqn, DartDescriptor dartDescriptor) {
        namedConcepts.put(fqn, dartDescriptor);
    }

    public void registerResolution(ResolutionType resolutionType, ResolutionTask resolutionTask) {
        if (resolutionTasks.containsKey(resolutionType)) {
            resolutionTasks.get(resolutionType).add(resolutionTask);
        } else {
            resolutionTasks.put(resolutionType, new ArrayList<>(List.of(resolutionTask)));
        }
    }

    @SuppressWarnings("unchecked")
    private <T extends DartDescriptor> T getNamedConcept(String fqn) {
        if (!namedConcepts.containsKey(fqn)) {
            return null;
        }
        return (T) namedConcepts.get(fqn);
    }

    private <T extends DartDescriptor> List<T> getNamedConcepts(List<String> fqns) {
        return fqns.stream().<T>map(this::getNamedConcept).filter(Objects::nonNull).collect(Collectors.toList());
    }

    @Getter
    public static class ResolutionTask {

        private final DartDescriptor descriptor;
        private final List<String> fqns = new ArrayList<>();

        public ResolutionTask(DartDescriptor descriptor, List<String> fqns) {
            this.descriptor = descriptor;
            this.fqns.addAll(fqns);
        }

        public ResolutionTask(DartDescriptor descriptor, String fqn) {
            this.descriptor = descriptor;
            this.fqns.add(fqn);
        }

        String getFqn() {
            return fqns.get(0);
        }

        public <T extends DartDescriptor> void resolve(BiConsumer<T, String> resolver) {
            resolver.accept((T) descriptor, getFqn());
        }

        public <T extends DartDescriptor> void resolveList(BiConsumer<T, List<String>> resolver) {
            resolver.accept((T) descriptor, getFqns());
        }
    }
}
