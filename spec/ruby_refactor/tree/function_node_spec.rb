require "spec_helper"
require "ruby_refactor/tree"
require "parser/current"
require "ast/sexp"

class RubyRefactor::Tree
  RSpec.describe FunctionNode do
    let(:function) { FunctionNode.new(ast: nil, value: function_name, children: [body]) }
    let(:function_name) { :foo }
    let(:body) { ast("1 + 1") }

    it { expect(function.value).to eq(function_name) }
    it { expect(function.children).to eq([body]) }
    it { expect(function.ast).to eq(ast(function_code("1 + 1")).ast) }

    it { expect(ast(function_code("2 + 2")).reconstruct_with(children: [body])).
           to eq(ast(function_code("1 + 1"))) }

    def function_code(body)
      <<-code
        def #{function_name}
          #{body}
        end
      code
    end
  end
end
