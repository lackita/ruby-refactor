require "spec_helper"
require "ast/sexp"
require "ruby_refactor/tree"

RSpec.describe RubyRefactor::Tree::StringNode do
  include AST::Sexp

  let(:node) { RubyRefactor::Tree::StringNode.from_ast(s(:str, "foo")) }

  it { expect(node.value).to eq("foo") }
  it { expect(node.ast).to eq(s(:str, "foo")) }
end
