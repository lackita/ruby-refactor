require "parser/current"
require "unparser"
require "ruby_refactor/tree"

class RubyRefactor
  class File
    def initialize(file_name)
      @file_name = file_name
    end
    
    def parse
      Tree.node(Parser::CurrentRuby.parse(::File.read(@file_name)))
    end

    def write(tree)
      ::File.write(@file_name, Unparser.unparse(tree.ast))
    end
  end
end
