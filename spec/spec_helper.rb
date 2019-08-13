require "bundler/setup"
require "parser/current"
require "ruby_refactor/tree"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def node(opts = {})
  RubyRefactor::Tree::Node.new(opts)
end

def ast(code)
  RubyRefactor::Tree.node(Parser::CurrentRuby.parse(code))
end
