require File.expand_path(%q{../lib/jekyll/testtasks/version}, __FILE__)

begin
  require 'hen'

  Hen.lay! {{
    :gem => {
      :name         => %q{jekyll-testtasks},
      :version      => Jekyll::TestTasks::VERSION,
      :summary      => %q{Test your Jekyll plugins with ease.},
      :author       => %q{Jens Wille},
      :email        => %q{jens.wille@gmail.com},
      :license      => %q{AGPL},
      :homepage     => :blackwinter,
      :dependencies => %w[]
    }
  }}
rescue LoadError => err
  warn "Please install the `hen' gem. (#{err})"
end
