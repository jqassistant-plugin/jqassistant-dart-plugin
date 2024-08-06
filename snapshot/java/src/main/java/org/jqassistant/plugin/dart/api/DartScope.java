package org.jqassistant.plugin.dart.api;

import com.buschmais.jqassistant.core.scanner.api.Scope;

import static com.google.common.base.CaseFormat.LOWER_HYPHEN;
import static com.google.common.base.CaseFormat.UPPER_UNDERSCORE;

public enum DartScope implements Scope {

    PACKAGE;

    @Override
    public String getPrefix() {
        return "dart";
    }

    @Override
    public String getName() {
        return UPPER_UNDERSCORE.to(LOWER_HYPHEN, name());
    }
}
