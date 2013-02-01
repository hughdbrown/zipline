# -----------------------------------------------------
# Lint tasks.
# -----------------------------------------------------
namespace "lint" do
  LINT_DIR="tasks/lint"

  desc "Run the pylint analysis tool."
  task :pylint => ["setup:lint"] do
    sh("pylint --rcfile=#{LINT_DIR}/pylintrc #{CODE_DIR} #{TEST_DIR}")
    notice("PyLint passed")
  end

  desc "Run the pep8 analysis tool."
  task :pep8 => ["setup:lint"] do
    check_env_var(["WORKSPACE"])

    exclude = "ez_setup.py,environment.py,middleware.py,app_globals.py,error.py"
    sh("pep8 --repeat --count --exclude=#{exclude} --ignore=E501 #{CODE_DIR} #{TEST_DIR} | tee #{ENV['WORKSPACE']}/pep8.txt")
    notice("pep8 passed")
  end

  desc "Run coverage"
  task :pycoverage => ["setup:lint"] do
    check_env_var(["WORKSPACE"])

    FileUtils.cd(SERVER_DIR) do
      sh("python setup.py nosetests -v --with-xunit --xunit-file=#{ENV['WORKSPACE']}/nosetests.xml")
      sh("coverage xml")
      notice("coverage passed")
    end
  end

  desc "Run pyflakes"
  task :pyflakes => ["setup:lint"] do
    sh("pyflakes #{CODE_DIR} #{TEST_DIR}")
    notice("pyflakes passed")
  end
end

desc "Run all code analysis tools."
task :lint => [
    "lint:pep8", 
    "lint:pylint", 
    #"lint:pyflakes", 
    "lint:pycoverage"
]
