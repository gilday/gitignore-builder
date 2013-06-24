require 'methadone'
require_relative '../lib/gitignores'
require_relative '../lib/gitignores/fetcher'
require_relative '../lib/gitignores/builder'
require_relative '../lib/gitignores/exceptions'

IGNORES_DIR = 'tmp/gitignores'
FAKE_IGNORES = 'spec/fake_ignores'