class RubyRefactor
  class Tree
    module Searchable
      def search(range)
        if !@lines
          tree
        elsif !overlaps?(range)
          Tree::NilNode.new
        elsif partially_within?(range)
          reconstruct_for_partial_search_result(range)
        else
          self
        end
      end

      def overlaps?(line_range)
        @lines && line_range.overlaps?(@lines)
      end

      def partially_within?(range)
        overlaps?(range) && !within?(range)
      end

      def within?(range)
        @lines && range.cover?(@lines)
      end

      def reconstruct_for_partial_search_result(range)
        if type == :def
          reconstruct_with(
            type: :begin,
            children: covered_children(range),
            value: nil,
          )
        else
          reconstruct_with(children: covered_children(range))
        end
      end

      def covered_children(range)
        children.map { |c| c.search(range) }.reject(&:nil?)
      end
    end
  end
end
