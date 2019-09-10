require "spec_helper"
require "ruby_refactor/tree"
require "ruby_refactor/mutation"
require "ruby_refactor/parser"

RSpec.describe RubyRefactor::Mutation::Append do
  it { expect(append("1 + 1", "2 + 2")).to eq("1 + 1\n2 + 2") }
  it { expect(append("1 + 1\n", "2 + 2")).to eq("1 + 1\n2 + 2") }
  it { expect(append("1 + 1 # foo", "2 + 2")).to eq("1 + 1 # foo\n2 + 2") }

  def append(code, appended)
    RubyRefactor::Mutation.chain(
      RubyRefactor::Parser.new(code),
      [:append, appended],
    )
  end
end
