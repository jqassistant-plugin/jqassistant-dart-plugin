package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.mapper.DescriptorMapper;
import org.jqassistant.plugin.dart.api.model.core.FunctionDescriptor;
import org.jqassistant.plugin.dart.impl.model.core.Function;
import org.mapstruct.AfterMapping;
import org.mapstruct.Context;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

import java.util.List;

import static org.mapstruct.factory.Mappers.getMapper;

@Mapper(uses = {ParameterMapper.class})
public interface FunctionMapper extends DescriptorMapper<Function, FunctionDescriptor> {

    FunctionMapper INSTANCE = getMapper(FunctionMapper.class);

    @AfterMapping
    default void after(Function value, @MappingTarget FunctionDescriptor target, @Context Scanner scanner) {
        scanner.getContext().peek(FqnResolver.class).registerFqn(target.getFqn(), target);
    }

    List<FunctionDescriptor> mapList(List<Function> value, @Context Scanner scanner);
}
