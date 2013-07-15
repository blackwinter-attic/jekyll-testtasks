# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "jekyll-testtasks"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jens Wille"]
  s.date = "2013-07-15"
  s.description = "Test your Jekyll plugins with ease."
  s.email = "jens.wille@gmail.com"
  s.extra_rdoc_files = ["README", "COPYING", "ChangeLog"]
  s.files = ["lib/jekyll/testtasks.rb", "lib/jekyll/testtasks/rake.rb", "lib/jekyll/testtasks/version.rb", "COPYING", "ChangeLog", "README", "Rakefile"]
  s.homepage = "http://github.com/blackwinter/jekyll-testtasks"
  s.licenses = ["AGPL"]
  s.rdoc_options = ["--charset", "UTF-8", "--line-numbers", "--all", "--title", "jekyll-testtasks Application documentation (v0.0.2)", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.5"
  s.summary = "Test your Jekyll plugins with ease."
end
