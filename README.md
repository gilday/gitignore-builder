# Gitignores

Tool for building a .gitignore from community templates at [github/gitignore](https://github.com/github/gitignore)

## Installation

    $ gem install gitignores

## Usage

**add** append a list of .gitignores to the `.gitignore` in the current directory. Example:

    gitignores add Java IntelliJ Eclipse

Adds gitignores for Java, IntelliJ, Eclipse to CURRENT_DIR/.gitignore

**show** prints a concatenation of .gitignores to std_out

    gitignores show Java IntelliJ Eclipse

Prints gitignores for Java, IntelliJ, Eclipse to standard out
