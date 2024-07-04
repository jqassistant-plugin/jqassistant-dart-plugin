import 'package:analyzer/dart/element/element.dart';

/**
 * Specifies the different AstNode types.
 *
 * As the analyzer API doesn't provide a straightforward way to identify AstNode types, this enum was created as a helper.
 */
enum AstNodeType {
  classDeclaration,
  compilationUnit,
  enumDeclaration,
  formalParameterList,
  functionDeclaration,
  functionExpression,
  mixinDeclaration,
  topLevelVariableDeclaration,
}

/**
 * Returns the FQN of a given element
 */
String? getFQNFromElement(Element? element, {bool returnNullOnObject = false}) {
  if (element?.location?.components != null) {
    List<String> components = List.from(element!.location!.components);
    if (components.length == 1) {
      return components[0];
    }
    components.removeAt(
        0); // remove package identifier as it is always included in the second component
    String fqn = components.reduce((value, element) => value + ":" + element);
    if (returnNullOnObject && fqn == "dart:core/object.dart:Object") {
      return null;
    }
    return fqn;
  } else {
    return null;
  }
}
