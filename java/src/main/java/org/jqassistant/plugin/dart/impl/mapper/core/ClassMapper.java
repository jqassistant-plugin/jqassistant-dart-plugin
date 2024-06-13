package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.mapper.DescriptorMapper;
import org.jqassistant.plugin.dart.api.model.core.ClassDescriptor;
import org.jqassistant.plugin.dart.impl.model.core.Class;
import org.mapstruct.Context;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

import static org.mapstruct.factory.Mappers.getMapper;

@Mapper
public interface ClassMapper extends DescriptorMapper<Class, ClassDescriptor> {

    ClassMapper INSTANCE = getMapper(ClassMapper.class);

    @Override
    @Mapping(source = "baseModifier", target = "base")
    @Mapping(source = "interfaceModifier", target = "interface")
    @Mapping(source = "finalModifier", target = "final")
    @Mapping(source = "sealedModifier", target = "sealed")
    @Mapping(source = "abstractModifier", target = "abstract")
    @Mapping(source = "mixinModifier", target = "mixin")
    ClassDescriptor toDescriptor(Class type, @Context Scanner scanner);

    List<ClassDescriptor> mapList(List<Class> value, @Context Scanner scanner);
}
