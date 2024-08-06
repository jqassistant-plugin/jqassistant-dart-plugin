package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.mapper.DescriptorMapper;
import org.jqassistant.plugin.dart.api.model.core.ParameterDescriptor;
import org.jqassistant.plugin.dart.impl.model.core.Parameter;
import org.mapstruct.Context;
import org.mapstruct.Mapper;

import java.util.List;

import static org.mapstruct.factory.Mappers.getMapper;

@Mapper
public interface ParameterMapper extends DescriptorMapper<Parameter, ParameterDescriptor> {

    ParameterMapper INSTANCE = getMapper(ParameterMapper.class);

    List<ParameterDescriptor> mapList(List<Parameter> value, @Context Scanner scanner);
}
