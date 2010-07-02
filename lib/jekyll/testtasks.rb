module Jekyll

  module TestTasks

    extend self

    # Jekyll's test tasks to install for the plugin
    TASKS = %w[test features].freeze

    caller.find { |f| f =~ %r{(.*)/Rakefile:\d+(?::|\z)} }

    # Where we're called from (the plugin location)
    CALLER = $1 || File.expand_path('../../..', __FILE__)

    # Patch to apply to the Jekyll installation
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
    # Sets environment variables for the patched Jekyll to pick up.
    def setup_env
      ENV['PLUGIN_PATH'] = Dir[File.expand_path('../jekyll-*/lib', CALLER)].join(':')
      ENV['PLUGIN'] = File.basename(CALLER).sub('-', '/')
    end

    # call-seq:
    #   ensure_jekyll_patch
    #
    # Ensures that the specified Jekyll installation seems
    # to be patched appropriately.
    def ensure_jekyll_patch
      file = File.read('lib/jekyll/site.rb')
      raise UnpatchedError.new(Dir.pwd) unless %w[PLUGIN_PATH PLUGIN].all? { |k| file =~ /'#{k}'/  }
    end

    # call-seq:
    #   jekyll_dir => aString
    #
    # Returns the Jekyll installation directory as specified through
    # the +JEKYLL+ environment variable or the <tt>.jekyll</tt> file
    # in your plugin's project directory.
    def jekyll_dir
      jekyll = ENV['JEKYLL'] || begin
        dot_jekyll = File.join(CALLER, '.jekyll')
        File.read(dot_jekyll).strip if File.readable?(dot_jekyll)
      end

      raise NotSetError unless jekyll
      raise NotFoundError.new(jekyll) unless File.directory?(jekyll)

      jekyll
    end

    # call-seq:
    #   in_jekyll_dir { ... }
    #
    # Runs the block inside the Jekyll installation directory.
    def in_jekyll_dir
      Dir.chdir(jekyll_dir) { ensure_jekyll_patch; yield }
    end

    # call-seq:
    #   run_jekyll_task(task)
    #
    # Runs Jekyll's original Rake task +task+.
    def run_jekyll_task(task)
      in_jekyll_dir { system('rake', task) }
    rescue TestTasksError => err
      warn err.to_s
      puts err.payload if err.payload

      exit 1
    end

    # call-seq:
    #   install_tasks
    #
    # Installs the relevant tasks.
    def install_tasks
      require 'jekyll/testtasks/rake'
    end

    class TestTasksError < RuntimeError
      attr_reader :dir, :payload

      def initialize(dir = nil); @dir = dir; end
    end

    class NotSetError < TestTasksError
      def to_s; 'Must set JEKYLL to point at patched Jekyll installation'; end
    end

    class NotFoundError < TestTasksError
      def to_s; "Jekyll installation not found at `#{dir}'"; end
    end

    class UnpatchedError < TestTasksError
      def payload; "\n" + JEKYLL_PATCH; end
      def to_s; "Jekyll must be patched in order to run with this plugin loaded\n[Found Jekyll at `#{dir}']"; end
    end

  end

end
