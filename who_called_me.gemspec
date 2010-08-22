# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{who_called_me}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alain Ravet"]
  s.date = %q{2010-08-23}
  s.description = %q{track and list the code lines that exercise a line}
  s.email = %q{alain.ravet+git@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/who_called_me.rb",
     "lib/who_called_me/array_utils.rb",
     "lib/who_called_me/string_utils.rb",
     "lib/who_called_me/trace_utils.rb",
     "lib/who_called_me/who_called_me.rb",
     "spec/fixtures/foo.rb",
     "spec/fixtures/foo_foo.rb",
     "spec/fixtures/foo_foo_caller.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/who_called_me_spec.rb"
  ]
  s.homepage = %q{http://github.com/alainravet/who_called_me}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{track and list the code lines that exercise a line}
  s.test_files = [
    "spec/fixtures/foo.rb",
     "spec/fixtures/foo_foo.rb",
     "spec/fixtures/foo_foo_caller.rb",
     "spec/spec_helper.rb",
     "spec/who_called_me_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end
