class RubyRefactor
  class Tree
    class StringNode < Node
      def self.from_ast(node)
        new(
          type: :str,
          value: node.children.first
        )
      end

      def ast
        Parser::AST::Node.new(:str, [value])
      end
    end
  end
end
