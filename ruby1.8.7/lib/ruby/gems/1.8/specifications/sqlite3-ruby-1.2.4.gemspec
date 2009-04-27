# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sqlite3-ruby}
  s.version = "1.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jamis Buck"]
  s.date = %q{2008-08-27}
  s.email = %q{jamis@37signals.com}
  s.extensions = ["ext/sqlite3_api/extconf.rb"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["doc/faq", "doc/faq/faq.html", "doc/faq/faq.rb", "doc/faq/faq.yml", "ext/sqlite3_api", "ext/sqlite3_api/extconf.rb", "ext/sqlite3_api/Makefile", "ext/sqlite3_api/MANIFEST", "ext/sqlite3_api/mkmf.log", "ext/sqlite3_api/sqlite3_api.i", "ext/sqlite3_api/sqlite3_api_wrap.c", "ext/sqlite3_api/win32", "ext/sqlite3_api/win32/build.bat", "lib/sqlite3", "lib/sqlite3/constants.rb", "lib/sqlite3/database.rb", "lib/sqlite3/driver", "lib/sqlite3/driver/dl", "lib/sqlite3/driver/dl/api.rb", "lib/sqlite3/driver/dl/driver.rb", "lib/sqlite3/driver/native", "lib/sqlite3/driver/native/driver.rb", "lib/sqlite3/errors.rb", "lib/sqlite3/pragmas.rb", "lib/sqlite3/resultset.rb", "lib/sqlite3/statement.rb", "lib/sqlite3/translator.rb", "lib/sqlite3/value.rb", "lib/sqlite3/version.rb", "lib/sqlite3.rb", "test/bm.rb", "test/driver", "test/driver/dl", "test/driver/dl/tc_driver.rb", "test/mocks.rb", "test/native-vs-dl.rb", "test/tc_database.rb", "test/tc_errors.rb", "test/tc_integration.rb", "test/tests.rb", "README.rdoc"]
  s.has_rdoc = true
  s.homepage = %q{http://sqlite-ruby.rubyforge.org/sqlite3}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.0")
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{SQLite3/Ruby is a module to allow Ruby scripts to interface with a SQLite3 database.}
  s.test_files = ["test/tests.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
