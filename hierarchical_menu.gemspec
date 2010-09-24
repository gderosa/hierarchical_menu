# -*- encoding: utf-8 -*-

$LOAD_PATH.unshift File.join File.dirname(__FILE__), 'lib'

require 'date'
require 'hmenu/constants'

Gem::Specification.new do |s|
  s.name = %q{hierarchical_menu}
  s.version = HMenu::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Guido De Rosa"]
  s.date = Date.today.to_s
  s.description = %q{Ruby Tree based hierarchical menus with HTML output and JavaScript show/hide}
  s.email = %q{guido.derosa@vemarsas.it}
  s.files = [
    "README.rdoc",
    "Changelog",
    "css/hmenu.css",
    "js/hmenu.js",
    "lib/hmenu.rb",
    "lib/hmenu/extensions/tree.rb",
    "lib/hmenu/constants.rb",
    "lib/hmenu/css.rb",
    "lib/hmenu/js.rb",
    "lib/hmenu/node.rb"
  ]
  s.homepage = %q{http://github.com/gderosa/hierarchical_menu}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.require_paths = ["lib"]
  s.summary = %q{Hierarchical menus with html output}
  s.add_dependency 'rubytree'
end
