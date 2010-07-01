module Jekyll

  module TestTasks

    extend self

    caller.find { |f| f =~ %r{(.*)/Rakefile:\d+(?::|\z)} }

    # Where we're called from (the plugin location)
    CALLER = $1 || File.expand_path('../../..', __FILE__)

    # Patch to apply to Jekyll installation
    JEKYLL_PATCH = <<-JEKYLL_PATCH
diff --git a/lib/jekyll/site.rb b/lib/jekyll/site.rb
index 7570cb0..9fbe738 100644
--- a/lib/jekyll/site.rb
+++ b/lib/jekyll/site.rb
@@ -43,6 +43,9 @@ module Jekyll
       # If safe mode is off, load in any ruby files under the plugins
       # directory.
       unless self.safe
+        ENV['PLUGIN_PATH'].split(':').each { |f| $: << f } if ENV['PLUGIN_PATH']
+        ENV['PLUGIN'].split(':').each { |f| require f } if ENV['PLUGIN']
+
         Dir[File.join(self.plugins, "**/*.rb")].each do |f|
           require f
         end
    JEKYLL_PATCH

    # call-seq:
    #   setup_env
    #
    # Set environment variables for patched Jekyll to pick up.
    def setup_env
      ENV['PLUGIN_PATH'] = Dir[File.expand_path('../jekyll-*/lib', CALLER)].join(':')
      ENV['PLUGIN'] = File.basename(CALLER).sub('-', '/')
    end

    # call-seq:
    #   run_jekyll_task(task)
    #
    # Run Jekyll's original Rake task +task+ with this plugin loaded.
    def run_jekyll_task(task)
      abort 'Must set JEKYLL to point at patched Jekyll installation' unless ENV['JEKYLL']

      Dir.chdir(ENV['JEKYLL']) {
        unless %w[PLUGIN_PATH PLUGIN].all? { |k| system('grep', '-q', "'#{k}'", 'lib/jekyll/site.rb') }
          warn 'Jekyll must be patched in order to run with this plugin loaded'
          puts
          puts JEKYLL_PATCH

          abort
        end

        system('rake', task)
      }
    end

  end

end

# Install test tasks.
namespace :jekyll do

  %w[test features].each { |t|
    desc "Run Jekyll's original #{t} task with this plugin loaded"
    task t do
      Jekyll::TestTasks.setup_env
      Jekyll::TestTasks.run_jekyll_task t
    end
  }

end
