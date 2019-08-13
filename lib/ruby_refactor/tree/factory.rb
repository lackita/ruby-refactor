class RubyRefactor
  class Tree
    class Factory
      def self.create_node(value)
        if value.is_a?(Node)
          value
        elsif value.nil?
          NilNode.from_ast
        elsif value.is_a?(Symbol)
          SymbolNode.from_ast(value)
        elsif value.type == :str
          StringNode.from_ast(value)
        elsif value.type == :int
          NumberNode.from_ast(value)
        elsif value.type == :def
          FunctionNode.from_ast(value)
        elsif value.is_a?(AST::Node)
          Node.new(ast: value)
        else
          raise StandardError.new("Unknown node: #{value}")
        end
      end
    end
  end
end
