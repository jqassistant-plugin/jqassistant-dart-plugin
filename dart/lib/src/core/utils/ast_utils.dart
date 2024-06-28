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
