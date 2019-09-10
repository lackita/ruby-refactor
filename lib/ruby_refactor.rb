require "ruby_refactor/tree"
require "ruby_refactor/mutation"
require "ruby_refactor/parser"

class RubyRefactor
  def self.extract_method(file_name, name:, lines:)
    parser = RubyRefactor::Parser.new(File.read(file_name))
    File.write(
      file_name,
      Mutation.chain(
        parser,
        [:append, parser.generate_function(name, parser.lines_at(lines))],
        [:replace, lines, with: name],
      ),
    )
  end
end
