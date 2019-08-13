require "tempfile"
require "open3"

class CodeFolder
  def initialize
    @requires = []
    @files = []
  end
  
  def create_lib(contents)
    f = create_file(contents)
    @requires << f.path
    f
  end

  def create_file(contents)
    f = Tempfile.new(["", ".rb"])
    @files << f
    f.write(contents)
    f.flush
    f.close
    f
  end  

  def run_output(contents)
    f = create_file(
      lines(*@requires.map { |r| "require '#{r}'" }) +
      contents
    )

    stdout, stderr, status = Open3.capture3("ruby #{f.path}")

    if status != 0
      raise StandardError.new(stderr)
    end

    stdout
  end

  def lines(*lines)
    lines.map { |line| line + "\n" }.join("")
  end

  def teardown
    @files.each(&:close)
  end
end
