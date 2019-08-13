class RubyRefactor
  class Mutation
    class Replace
      def initialize(tree)
        @tree = tree
        @replaced = false
      end

      def run(range, with:, tree: @tree)
        if !tree.overlaps?(range)
          tree
        elsif tree.partially_within?(range)
          tree.reconstruct_with(children: replace_children(range, with, tree))
        elsif @replaced
          Tree::NilNode.new
        else
          @replaced = true
          with
        end
      end

      def replace_children(range, with, tree)
        tree.children.flat_map { |c| run(range, with: with, tree: c) }
      end
    end
  end
end
