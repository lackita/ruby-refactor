require "spec_helper"
require "code_folder"
require "ruby_refactor"

RSpec.describe "extract method" do
  let!(:folder) { CodeFolder.new }
  after(:each) { folder.teardown }
  
  it "extracts lines with no variables" do
    file = folder.create_lib("
      def say_some_stuff
        puts 'some'
        puts 'stuff'
        puts 'to'
        puts 'say'
      end
    ")
    original_output = folder.run_output("say_some_stuff")

    RubyRefactor.extract_method(file.path, name: "say_something", lines: 4..5)

    expect(File.read(file.path)).to eq(<<-code.strip)
def say_some_stuff
  puts("some")
  say_something
  puts("say")
end
def say_something
  puts("stuff")
  puts("to")
end
code

    expect(folder.run_output("say_some_stuff")).to eq(original_output)
    expect(folder.run_output("say_something")).to eq(folder.lines("stuff", "to"))
  end
end
