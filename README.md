# Gitignores

Tool for building a .gitignore from community templates at [github/gitignore](https://github.com/github/gitignore)

## Installation

    gem install gitignores

## Usage

**add** append a list of .gitignores to the `.gitignore` in the current directory. Example:

    gitignores add Java JetBrains Eclipse

Adds gitignores for Java, JetBrains, Eclipse to `CURRENT_DIR/.gitignore`

**show** prints a concatenation of .gitignores to standard out

    gitignores show Java JetBrains Eclipse

Prints gitignores for Java, JetBrains, Eclipse to standard out

**list** prints a list of available gitignores

    gitignores list

**update** updates the github/gitignore cache (by default `$HOME/.gitignores`)

    gitignores update
