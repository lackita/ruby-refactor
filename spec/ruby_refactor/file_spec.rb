require "spec_helper"
require "code_folder"
require "ruby_refactor/file"
require "ruby_refactor/tree"

RSpec.describe RubyRefactor::File do
  let!(:folder) { CodeFolder.new }
  after(:each) { folder.teardown }

  let(:code) { "2 + 2 # foo" }
  let(:path) { folder.create_file(code).path }
  let(:file) { RubyRefactor::File.new(path) }

  it { expect(file.parse).to eq(ast(code)) }
  it { expect(file.parse.comments.map(&:text)).to eq(["# foo"]) }
  it { file.write(file.parse); expect(File.read(path)).to eq(code) }
end
