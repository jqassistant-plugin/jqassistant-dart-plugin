package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.model.FileDescriptor;
import org.jqassistant.plugin.dart.api.model.core.DartScanDescriptor;
import org.jqassistant.plugin.dart.impl.model.core.Package;

import java.util.List;

public class DartScanMapper {

    public static final DartScanMapper INSTANCE = new DartScanMapper();

    public DartScanDescriptor map(List<Package> packages, Scanner scanner) {
        FileDescriptor fileDescriptor = scanner.getContext().getCurrentDescriptor();
        DartScanDescriptor result = scanner.getContext().getStore().addDescriptorType(fileDescriptor, DartScanDescriptor.class);
        result.getPackages().addAll(PackageMapper.INSTANCE.map(packages, scanner));
        return result;
    }

}
