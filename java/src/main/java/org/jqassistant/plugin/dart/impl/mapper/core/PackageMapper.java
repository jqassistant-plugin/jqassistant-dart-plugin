package org.jqassistant.plugin.dart.impl.mapper.core;

import com.buschmais.jqassistant.core.scanner.api.Scanner;
import com.buschmais.jqassistant.plugin.common.api.scanner.FileResolver;
import org.jqassistant.plugin.dart.api.model.core.LocalFileDescriptor;
import org.jqassistant.plugin.dart.api.model.core.PackageDescriptor;
import org.jqassistant.plugin.dart.impl.filesystem.LocalFileResolver;
import org.jqassistant.plugin.dart.impl.model.core.Package;

import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class PackageMapper {

    public static final PackageMapper INSTANCE = new PackageMapper();

    public List<PackageDescriptor> map(List<Package> packages, Scanner scanner) {
        List<PackageDescriptor> result = new ArrayList<>();

        for (var aPackage : packages) {
            FileResolver fileResolver = new LocalFileResolver(Paths.get(aPackage.getPackagePath()));
            scanner.getContext().push(FileResolver.class, fileResolver);

            PackageDescriptor packageDescriptor = scanner.getContext().getStore().create(PackageDescriptor.class);

            packageDescriptor.setName(aPackage.getName());
            packageDescriptor.setFqn(aPackage.getFqn());

            LocalFileDescriptor rootDirDescriptor = fileResolver.require(aPackage.getPackagePath(), LocalFileDescriptor.class, scanner.getContext());
            packageDescriptor.setRootDirectory(rootDirDescriptor);

            LocalFileDescriptor configFileDescriptor = fileResolver.require(aPackage.getPackagePath() + "/pubspec.yaml", LocalFileDescriptor.class, scanner.getContext());
            packageDescriptor.setConfigFile(configFileDescriptor);

            packageDescriptor.getLibraries().addAll(
                LibraryMapper.INSTANCE.map(aPackage.getConcepts(), scanner)
            );

            result.add(packageDescriptor);
            scanner.getContext().pop(FileResolver.class);
        }

        return result;
    }

}
