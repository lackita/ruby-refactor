require "spec_helper"
require "code_folder"
require "ruby_refactor/file"
require "ruby_refactor/tree"

RSpec.describe RubyRefactor::File do
  let!(:folder) { CodeFolder.new }
  after(:each) { folder.teardown }

  it "parses file" do
    code = "2 + 2"
    file = folder.create_file(code)
    expect(RubyRefactor::File.new(file.path).parse).
      to eq(RubyRefactor::Tree.node(Parser::CurrentRuby.parse(code)))
  end

  it "restores file" do
    code = "2 + 2"
    file = folder.create_file("")
    RubyRefactor::File.new(file.path).write(RubyRefactor::Tree.node(Parser::CurrentRuby.parse(code)))
    expect(File.read(file.path)).to eq(code)
  end
end
