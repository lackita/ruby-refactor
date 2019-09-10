require "spec_helper"
require "parser/current"
require "ast/sexp"
require "ruby_refactor/mutation"
require "ruby_refactor/tree"
require "ruby_refactor/parser"

RSpec.describe RubyRefactor::Mutation::Replace do
  include AST::Sexp

  it { expect(replace("1 + 1\n2 + 2", 1..0)).to eq("1 + 1\n2 + 2") }
  it { expect(replace("1 + 1", 1..1)).to eq("something") }
  it { expect(replace("1 + 1\n2 + 2", 1..1)).to eq("something\n2 + 2") }
  it { expect(replace("1 + 1\n2 + 2\n3 + 3", 2..2)).to eq("1 + 1\nsomething\n3 + 3") }
  it { expect(replace("def foo\n1 + 1\nend", 2..2)).to eq("def foo\nsomething\nend") }
  it { expect(replace("1 + 1\n2 + 2\n3 + 3", 2..3)).to eq("1 + 1\nsomething") }

  def replace(code, range)
    RubyRefactor::Mutation.chain(
      RubyRefactor::Parser.new(code),
      [:replace, range, with: "something"],
    )
  end

  def ast(code)
    RubyRefactor::Tree.node(Parser::CurrentRuby.parse(code))
  end
end
