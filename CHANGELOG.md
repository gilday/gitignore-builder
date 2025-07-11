## 0.1.2 (TBD)

Compatibility:

  - Add Ruby 3.x compatibility by replacing deprecated `Dir.exists?` and `File.exists?` methods
  - Update GLI gem from 2.13.3 to 2.21.5 to fix ERB deprecation warnings
  - Fix deprecated `Rake::RDocTask`, now uses `RDoc::Task`
  - Add Ruby version requirement (>= 2.5.0) to gemspec

Security:

  - Fix potential shell command injection vulnerability by using `system()` instead of backticks

Features:

  - Update OS gitignore name from 'OSX' to 'macOS' to match current GitHub repository structure

Development:

  - Update RSpec stubbing syntax to modern `allow().to receive()` pattern
  - Add proper error handling for git operations with custom exception classes

## 0.0.3 (2015-05-25)

Features:

  - more details in usage
  - "update" command as an easy way to simply update the gitignores directory

