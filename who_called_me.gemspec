# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name      = 'who_called_me'
  s.version   = "0.1.0"
  s.date      = Time.now.utc.strftime("%Y-%m-%d")
  s.homepage  = %q{http://github.com/alainravet/who_called_me}

  s.summary     = %q{track and list the code lines that exercise a line}
  s.description = %q{track and list the code lines that exercise a line}

  s.authors   = ["Alain Ravet"]
  s.email     = %q{alain.ravet+git@gmail.com}
  s.extra_rdoc_files = %w(LICENSE README.markdown)
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  %w().each do |gem|
    s.add_dependency gem
  end
  %w(rspec).each do |gem|
    s.add_development_dependency gem
  end
end

