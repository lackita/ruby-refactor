class RubyRefactor
  class Tree
    class NilNode < Node
      def self.from_ast
        new(type: nil)
      end
      
      def nil?
        true
      end

      def ast
        nil
      end
    end
  end
end
