package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.mapper.DescriptorMapper;
import org.jqassistant.plugin.dart.api.model.core.EnumDescriptor;
import org.jqassistant.plugin.dart.impl.model.core.Enum;
import org.mapstruct.AfterMapping;
import org.mapstruct.Context;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

import java.util.List;

import static org.mapstruct.factory.Mappers.getMapper;

@Mapper
public interface EnumMapper extends DescriptorMapper<Enum, EnumDescriptor> {

    EnumMapper INSTANCE = getMapper(EnumMapper.class);

    @AfterMapping
    default void after(Enum value, @MappingTarget EnumDescriptor target, @Context Scanner scanner) {
        scanner.getContext().peek(FqnResolver.class).registerFqn(target.getFqn(), target);
    }

    List<EnumDescriptor> mapList(List<Enum> value, @Context Scanner scanner);
}
