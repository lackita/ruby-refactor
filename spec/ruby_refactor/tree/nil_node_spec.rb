require "spec_helper"
require "ruby_refactor/tree"

RSpec.describe RubyRefactor::Tree::NilNode do
  def node
    RubyRefactor::Tree::NilNode.new
  end

  it { expect(node).to be_nil }
  it { expect(node.children).to eq([]) }
  it { expect(node).to eq(node) }
  it { expect(node.ast).to eq(nil) }
end
