require "spec_helper"
require "ruby_refactor/tree"

RSpec.describe RubyRefactor::Tree::SymbolNode do
  def node(x)
    RubyRefactor::Tree::SymbolNode.from_ast(x)
  end

  it { expect(node(:foo)).to eq(node(:foo)) }
  it { expect(node(:foo)).to_not eq(node(:bar)) }
  it { expect(node(:foo).children).to eq([]) }
end
