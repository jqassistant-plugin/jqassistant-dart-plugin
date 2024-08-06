package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.mapper.DescriptorMapper;
import org.jqassistant.plugin.dart.api.model.core.MixinDescriptor;
import org.jqassistant.plugin.dart.impl.model.core.Mixin;
import org.mapstruct.*;

import java.util.List;

import static org.mapstruct.factory.Mappers.getMapper;

@Mapper(unmappedSourcePolicy = ReportingPolicy.IGNORE)
public interface MixinMapper extends DescriptorMapper<Mixin, MixinDescriptor> {

    MixinMapper INSTANCE = getMapper(MixinMapper.class);

    @Override
    @Mapping(source = "baseModifier", target = "base")
    @Mapping(target = "constrainedTo", ignore = true)
    MixinDescriptor toDescriptor(Mixin type, @Context Scanner scanner);

    @AfterMapping
    default void after(Mixin value, @MappingTarget MixinDescriptor target, @Context Scanner scanner) {
        FqnResolver fqnResolver = scanner.getContext().peek(FqnResolver.class);
        fqnResolver.registerFqn(target.getFqn(), target);
        fqnResolver.registerResolution(FqnResolver.ResolutionType.MIXIN_CONSTRAINT, new FqnResolver.ResolutionTask(target, value.getConstraintFqn()));
    }

    List<MixinDescriptor> mapList(List<Mixin> value, @Context Scanner scanner);
}
