class RubyRefactor
  class Tree
    class SymbolNode < Node
      def self.from_ast(value)
        new(
          type: :symbol,
          value: value,
        )
      end

      def ast
        value
      end
    end
  end
end
