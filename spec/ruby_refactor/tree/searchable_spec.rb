require "spec_helper"
require "ruby_refactor/tree"

class RubyRefactor::Tree
  RSpec.describe RubyRefactor::Tree::Searchable do
    let(:one_line_code) { "1 + 1" }
    let(:one_line) { ast(one_line_code) }
    let(:two_lines) { ast("1 + 1\n2 + 2") }
    let(:three_lines_code) { "1 + 1\n2 + 2\n3 + 3" }
    let(:three_lines) { ast(three_lines_code) }

    it { expect(Node.new(lines: 2..3)).to be_overlap(2..3) }
    it { expect(Node.new(lines: 1..2)).to_not be_overlap(3..4) }
    it { expect(Node.new(lines: 1..2)).to_not be_overlap(3..4) }

    it { expect(one_line.search(1..1)).to eq(one_line) }
    it { expect(two_lines.search(1..0)).to eq(ast("")) }
    it { expect(two_lines.search(1..1)).to eq(wrap_begin(one_line)) }
    it { expect(three_lines.search(1..2)).to eq(two_lines) }
    it { expect(three_lines.search(2..2)).to eq(wrap_begin(ast("2 + 2"))) }
    it { expect(function_code(one_line_code).search(2..2)).to eq(wrap_begin(one_line)) }
    it { expect(function_code(three_lines_code).search(3..3)).to eq(wrap_begin(wrap_begin(ast("2 + 2")))) }
    it { expect(three_lines.search(2..3).children.first).to be(three_lines.children[1]) }

    def wrap_begin(child)
      Node.new(type: :begin, children: [child])
    end

    def function_code(body)
      ast(<<-code)
        def foo
          #{body}
        end
      code
    end
  end
end
