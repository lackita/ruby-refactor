require "ruby_refactor/tree/factory"
require "ruby_refactor/tree/node"
require "ruby_refactor/tree/nil_node"
require "ruby_refactor/tree/symbol_node"
require "ruby_refactor/tree/number_node"
require "ruby_refactor/tree/function_node"
require "ruby_refactor/tree/string_node"

class RubyRefactor
  class Tree
    def self.node(value, options = {})
      Factory.create_node(value, options)
    end
  end
end
