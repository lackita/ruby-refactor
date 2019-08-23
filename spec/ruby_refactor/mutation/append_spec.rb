require "spec_helper"
require "ruby_refactor/tree"
require "ruby_refactor/mutation/append"

RSpec.describe RubyRefactor::Mutation::Append do
  it { expect(append(node, node(type: :foo)).children.last).to eq(node(type: :foo)) }
  it { expect(append(ast("1 + 1"), ast("2 + 2"))).to eq(ast("1 + 1\n2 + 2")) }
  it { expect(append(ast("1 + 1 # foo"), ast("2 + 2")).comments.map(&:text)).to eq(["# foo"]) }

  def append(tree, node)
    RubyRefactor::Mutation::Append.new(tree).run(node)
  end
end
