# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mysql}
  s.version = "2.7"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.autorequire = %q{mysql}
  s.bindir = nil
  s.cert_chain = nil
  s.date = %q{2005-10-10}
  s.email = %q{tommy@tmtm.org}
  s.extensions = ["extconf.rb"]
  s.files = ["COPYING", "COPYING.ja", "README.html", "README_ja.html", "extconf.rb", "mysql.c.in", "test.rb", "tommy.css", "mysql.gemspec"]
  s.homepage = %q{http://www.tmtm.org/en/mysql/ruby/}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{MySQL/Ruby provides the same functions for Ruby programs that the MySQL C API provides for C programs.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
