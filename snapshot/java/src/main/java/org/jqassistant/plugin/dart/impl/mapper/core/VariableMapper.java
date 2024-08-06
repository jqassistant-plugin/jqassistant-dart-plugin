package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.mapper.DescriptorMapper;
import org.jqassistant.plugin.dart.api.model.core.VariableDescriptor;
import org.jqassistant.plugin.dart.impl.model.core.Variable;
import org.mapstruct.*;

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

    @AfterMapping
    default void after(Variable value, @MappingTarget VariableDescriptor target, @Context Scanner scanner) {
        scanner.getContext().peek(FqnResolver.class).registerFqn(target.getFqn(), target);
    }

    List<VariableDescriptor> mapList(List<Variable> value, @Context Scanner scanner);
}
