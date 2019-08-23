require "parser/current"
require "unparser"
require "ruby_refactor/tree"

class RubyRefactor
  class File
    def initialize(file_name)
      @file_name = file_name
    end
    
    def parse
      ast, comments = Parser::CurrentRuby.parse_with_comments(::File.read(@file_name))
      Tree.node(ast, comments: comments)
    end

    def write(tree)
      ::File.write(@file_name, Unparser.unparse(tree.ast, tree.comments || []))
    end
  end
end
