class RubyRefactor
  class Tree
    class NumberNode < Node
      def self.from_ast(node)
        new(value: node.children.first)
      end

      def ast
        Parser::AST::Node.new(:int, [value])
      end
    end
  end
end
