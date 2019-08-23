require "spec_helper"
require "ruby_refactor/tree"

class RubyRefactor::Tree
  RSpec.describe RubyRefactor::Tree::Node do
    def node(opts = {})
      RubyRefactor::Tree::Node.new(opts)
    end

    it { expect(Node.new.children).to be_empty }

    it { expect(Node.new(lines: 1..3).within?(1..3)).to be_truthy }
    it { expect(Node.new(lines: 2..2).within?(3..5)).to be_falsey }

    it { expect(Node.new).to eq(Node.new) }
    it { expect(Node.new).to_not eq(Node.new(type: :bar)) }
    it { expect(Node.new).to_not eq(Node.new(type: :foo, children: [node])) }
    it { expect(Node.new(type: :foo)).to_not eq(NilNode.new) }
    it { expect(SymbolNode.from_ast(:x)).to_not eq(NilNode.new) }
    it { expect(NumberNode.new(value: 1)).to_not eq(NilNode.new) }

    it { expect(Node.new(comments: "foo").comments).to eq("foo") }
    it { expect(Node.new(comments: "foo").reconstruct_with.comments).to eq("foo") }

    it { expect(ast("1 + 1").type).to eq(:send) }
    it { expect(ast("1 + 1").lines).to eq(1..1) }
    it { expect(ast("1 + 1").children).to_not be_empty }
  end
end
