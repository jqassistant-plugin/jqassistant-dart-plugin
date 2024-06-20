package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.mapper.DescriptorMapper;
import org.jqassistant.plugin.dart.api.model.core.VariableDescriptor;
import org.jqassistant.plugin.dart.impl.model.core.Variable;
import org.mapstruct.Context;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

import static org.mapstruct.factory.Mappers.getMapper;

@Mapper
public interface VariableMapper extends DescriptorMapper<Variable, VariableDescriptor> {

    VariableMapper INSTANCE = getMapper(VariableMapper.class);

    @Override
    @Mapping(source = "lateModifier", target = "late")
    @Mapping(source = "finalModifier", target = "final")
    @Mapping(source = "constModifier", target = "const")
    VariableDescriptor toDescriptor(Variable type, @Context Scanner scanner);

    List<VariableDescriptor> mapList(List<Variable> value, @Context Scanner scanner);
}
