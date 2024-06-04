# jQAssistant Plugin Template
Template repository to be used for creating new jQAssistant plugins.

# Template Usage

## Code
- place a `pom.xml` in the root directory that manages the build of the Maven Java artifact
- if there are only java sources place them `src/main/java` and `src/test/java` respectively
- if there are multiple tools (e.g. for language-native scanners) the sources may be placed in separate subdirectories
  - e.g. `java` and `typescript` for the Java artifact and a language-native TypeScript scanner

## Documentation
- use [Obsdian.md](https://obsidian.md) to open the `docs/content` directory as a new vault
  - alternatively you can directly edit the Markdown files with any IDE/text editor
  - the `index.md` file contains further instructions and hints
- update the content and links in the `jqa.quartz.config.json` to match the new plugin info
