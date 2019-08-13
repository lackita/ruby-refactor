require "ruby_refactor/file"
require "ruby_refactor/tree"
require "ruby_refactor/mutation"

class RubyRefactor
  def self.extract_method(file_name, name:, lines:)
    file = File.new(file_name)
    tree = file.parse

    file.write(Mutation.chain(file.parse,
      [:append, Tree::FunctionNode.new(
         value: name.to_sym,
         children: [tree.search(lines)],
       )],
      [:replace, lines, with: Tree::Node.new(
         type: :send,
         children: [nil, name.to_sym],
       )],
      [:compact],
    ))
  end
end
