require "spec_helper"
require "code_folder"
require "ruby_refactor/file"

RSpec.describe "formatting" do
  let!(:folder) { CodeFolder.new }

  pending { expect("'some'").to retain_formatting }

  RSpec::Matchers.define :retain_formatting do
    match do |code|
      expect(cycled(code)).to eq(code)
    end

    failure_message do |code|
      "Expected #{code} to retain formatting, was #{cycled(code)}"
    end
  end

  def cycled(code)
    path = folder.create_lib(code).path
    file = RubyRefactor::File.new(path)
    require "byebug";byebug
    file.write(file.parse)
    File.read(path)
  end
end
