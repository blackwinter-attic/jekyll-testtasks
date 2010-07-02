require 'jekyll/testtasks'

# Install test tasks for Rake.
namespace :jekyll do

  task :setup_env do
    Jekyll::TestTasks.setup_env
  end

  Jekyll::TestTasks::TASKS.each { |t|
    desc "Run Jekyll's original #{t} task with this plugin loaded"
    task t => :setup_env do
      Jekyll::TestTasks.run_jekyll_task(t)
    end
  }
end

desc "Run Jekyll's test tasks (#{Jekyll::TestTasks::TASKS.join(', ')})"
task :jekyll => Jekyll::TestTasks::TASKS.map { |t| "jekyll:#{t}" }
