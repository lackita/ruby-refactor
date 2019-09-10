class RubyRefactor
  class Tree
    class FunctionNode < Node
      def self.from_ast(ast, comments: [])
        new(
          ast: ast,
          type: :def,
          value: ast.children[0],
          children: ast.children[2..-1],
          comments: comments,
        )
      end

      def ast
        ::Parser::AST::Node.new(:def, [value, ::Parser::AST::Node.new(:args),
                                     *children.map(&:ast)])
      end
    end
  end
end
