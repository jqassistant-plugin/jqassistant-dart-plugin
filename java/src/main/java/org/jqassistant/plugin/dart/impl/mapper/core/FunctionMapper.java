package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.mapper.DescriptorMapper;
import org.jqassistant.plugin.dart.api.model.core.FunctionDescriptor;
import org.jqassistant.plugin.dart.impl.model.core.Function;
import org.mapstruct.Context;
import org.mapstruct.Mapper;

import java.util.List;

import static org.mapstruct.factory.Mappers.getMapper;

@Mapper(uses = {ParameterMapper.class})
public interface FunctionMapper extends DescriptorMapper<Function, FunctionDescriptor> {

    FunctionMapper INSTANCE = getMapper(FunctionMapper.class);

    List<FunctionDescriptor> mapList(List<Function> value, @Context Scanner scanner);
}
