package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.mapper.DescriptorMapper;
import org.jqassistant.plugin.dart.api.model.core.ClassDescriptor;
import org.jqassistant.plugin.dart.impl.model.core.Class;
import org.mapstruct.*;

import java.util.List;

import static org.mapstruct.factory.Mappers.getMapper;

@Mapper(unmappedSourcePolicy = ReportingPolicy.IGNORE)
public interface ClassMapper extends DescriptorMapper<Class, ClassDescriptor> {

    ClassMapper INSTANCE = getMapper(ClassMapper.class);

    @Override
    @Mapping(source = "baseModifier", target = "base")
    @Mapping(source = "interfaceModifier", target = "interface")
    @Mapping(source = "finalModifier", target = "final")
    @Mapping(source = "sealedModifier", target = "sealed")
    @Mapping(source = "abstractModifier", target = "abstract")
    @Mapping(source = "mixinModifier", target = "mixin")
    @Mapping(target = "extends", ignore = true)
    @Mapping(target = "implements", ignore = true)
    @Mapping(target = "usesMixin", ignore = true)
    ClassDescriptor toDescriptor(Class type, @Context Scanner scanner);

    @AfterMapping
    default void after(Class value, @MappingTarget ClassDescriptor target, @Context Scanner scanner) {
        FqnResolver fqnResolver = scanner.getContext().peek(FqnResolver.class);
        fqnResolver.registerFqn(target.getFqn(), target);
        fqnResolver.registerResolution(FqnResolver.ResolutionType.CLASS_EXTENDS, new FqnResolver.ResolutionTask(target, value.getExtendsFqn()));
        fqnResolver.registerResolution(FqnResolver.ResolutionType.CLASS_IMPLEMENTS, new FqnResolver.ResolutionTask(target, value.getImplementsFqns()));
        fqnResolver.registerResolution(FqnResolver.ResolutionType.CLASS_MIXIN_USAGE, new FqnResolver.ResolutionTask(target, value.getUsedMixinFqns()));
    }

    List<ClassDescriptor> mapList(List<Class> value, @Context Scanner scanner);
}
