# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jekyll-testtasks}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jens Wille"]
  s.date = %q{2010-07-02}
  s.description = %q{Test your Jekyll plugins with ease.}
  s.email = %q{jens.wille@gmail.com}
  s.extra_rdoc_files = ["COPYING", "ChangeLog", "README"]
  s.files = ["lib/jekyll/testtasks/version.rb", "lib/jekyll/testtasks/rake.rb", "lib/jekyll/testtasks.rb", "README", "ChangeLog", "Rakefile", "COPYING"]
  s.rdoc_options = ["--title", "jekyll-testtasks Application documentation", "--main", "README", "--line-numbers", "--inline-source", "--charset", "UTF-8", "--all"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Test your Jekyll plugins with ease.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
