require "spec_helper"
require "ruby_refactor/tree"

RSpec.describe RubyRefactor::Tree::NumberNode do
  def node(x)
    RubyRefactor::Tree::NumberNode.new(value: x)
  end

  it { expect(node(1)).to eq(node(1)) }
  it { expect(node(1)).to_not eq(node(2)) }
end
