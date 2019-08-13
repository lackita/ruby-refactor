require "ruby_refactor/tree"

class RubyRefactor
  class Mutation
    class Append
      def initialize(tree)
        @tree = tree
      end

      def run(node)
        Tree::Node.new(
          type: :begin,
          children: [@tree, node],
          lines: @tree.lines,
        )
      end
    end
  end
end
