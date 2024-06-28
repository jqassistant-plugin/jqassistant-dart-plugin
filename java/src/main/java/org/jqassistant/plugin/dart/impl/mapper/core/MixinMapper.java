package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.mapper.DescriptorMapper;
import org.jqassistant.plugin.dart.api.model.core.MixinDescriptor;
import org.jqassistant.plugin.dart.impl.model.core.Mixin;
import org.mapstruct.Context;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

import static org.mapstruct.factory.Mappers.getMapper;

@Mapper
public interface MixinMapper extends DescriptorMapper<Mixin, MixinDescriptor> {

    MixinMapper INSTANCE = getMapper(MixinMapper.class);

    @Override
    @Mapping(source = "baseModifier", target = "base")
    MixinDescriptor toDescriptor(Mixin type, @Context Scanner scanner);

    List<MixinDescriptor> mapList(List<Mixin> value, @Context Scanner scanner);
}
