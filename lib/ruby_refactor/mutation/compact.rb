class RubyRefactor
  class Mutation
    class Compact
      def initialize(tree)
        @tree = tree
      end

      def run(tree = @tree)
        if tree.type == :begin && children_for(tree).count == 1
          tree = children_for(tree).first
        end

        tree.reconstruct_with(
          type: tree.type,
          children: children_for(tree),
        )
      end

      def children_for(tree)
        if tree.type == :begin
          tree.children.reject(&:nil?)
        else
          tree.children
        end.map { |child| run(child) }
      end
    end
  end
end
