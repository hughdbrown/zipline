# -----------------------------------------------------
# Test tasks.
# -----------------------------------------------------
namespace "test" do
  def nosetests(dir=nil)
    cmd = "nosetests #{TEST_DIR}"
    notice(cmd)
    sh(cmd)
  end

  desc "Run the unit tests"
  task :unit do
    nosetests()
    $stderr.puts("INFO: unit test disabled")
  end
end

desc "Run all tests"
task :test => ["test:unit"]
