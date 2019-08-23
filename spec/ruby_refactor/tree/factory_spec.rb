require "spec_helper"
require "parser/current"
require "ast/sexp"
require "ruby_refactor/tree"

class RubyRefactor
  class Tree
    RSpec.describe Factory do
      include AST::Sexp

      it "retains already constructed node" do
        node = RubyRefactor::Tree::Node.new
        expect(RubyRefactor::Tree.node(node)).to eq(node)
      end

      it { expect(Tree.node(nil)).to be_a(NilNode) }
      it { expect(Tree.node(:x)).to be_a(SymbolNode) }
      it { expect(Tree.node(s(:int, 1))).to be_a(NumberNode) }
      it { expect(Tree.node(s(:int, 1.1))).to be_a(NumberNode) }
      it { expect(Tree.node(s(:str, "foo"))).to be_a(StringNode) }
      it { expect { Tree.node(BadClass.new) }.to raise_exception(StandardError) }

      it { expect(Tree.node(s(:send), comments: "foo").comments).to eq("foo") }
      it { expect(Tree.node(s(:def), comments: "foo").comments).to eq("foo") }

      class BadClass < Exception; end
    end
  end
end
