require "spec_helper"
require "ruby_refactor/tree"
require "ruby_refactor/mutation"

RSpec.describe RubyRefactor::Mutation::Compact do
  let(:nil_child) do
    node(type: :begin, children: [RubyRefactor::Tree::NilNode.new]) 
  end

  let(:single_child_begin) do
    node(type: :begin, children: [node(type: :send, children: [])]) 
  end

  it { expect(compact(nil_child).children).to be_empty }
  it { expect(compact(single_child_begin)).to eq(single_child_begin.child) }

  def compact(tree)
    RubyRefactor::Mutation::Compact.new(tree).run
  end
end
