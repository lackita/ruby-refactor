require "parser/source/buffer"

class RubyRefactor
  class Parser
    def initialize(code)
      @code = code
    end

    def remove_trailing_comments(range)
      parse.comments.each do |comment|
        if comment.inline? && range.cover?(comment.location.line)
          rewriter.replace(comment.location.expression, "")
        end
      end
    end

    def replace(range, with:)
      rewriter.replace(search(range), with)
    end

    def search(range)
      parse.search(range).location.expression
    end

    def parse
      unless @parsed
        ast, comments = ::Parser::CurrentRuby.parse_with_comments(@code)
        @parsed = Tree.node(ast, comments: comments)
      end
      @parsed
    end

    def append_to_end(code)
      rewriter.insert_after(full_range, code)
    end

    def rewriter
      @rewriter ||= ::Parser::Source::TreeRewriter.new(buffer)
    end

    def full_range
      ::Parser::Source::Range.new(@buffer, 0, buffer.source.length)
    end

    def buffer
      @buffer ||= parse.location.expression.source_buffer
    end

    def lines_at(range)
      lines[(range.first - 1)..(range.last - 1)]
    end

    def indentation
      /^ */.match(
        lines.select do |l|
          l =~ /[^ ]/ 
        end.last,
      )[0]
    end

    def lines
      buffer.source_lines
    end

    def generate_function(name, body)
      "#{indentation}def #{name}\n#{body.join("\n")}\n      end\n"
    end
  end
end
