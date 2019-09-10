require "ruby_refactor/tree"
require "parser/source/tree_rewriter"

class RubyRefactor
  class Mutation
    class Append
      def initialize(parser)
        @parser = parser
      end

      def run(appended_code)
        @parser.append_to_end(ensure_new_line(appended_code))
      end

      def ensure_new_line(code)
        if @parser.buffer.source.end_with?("\n")
          code
        else
          "\n" + code
        end
      end
    end
  end
end
