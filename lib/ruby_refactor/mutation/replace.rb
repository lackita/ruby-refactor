class RubyRefactor
  class Mutation
    class Replace
      def initialize(parser)
        @parser = parser
      end

      def run(range, with:)
        if range.first <= range.last
          @parser.remove_trailing_comments(range)
          @parser.replace(range, with: with)
        end
      end
    end
  end
end
