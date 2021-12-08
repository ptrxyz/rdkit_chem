# -*- encoding: utf-8 -*-
# stub: rdkit_chem 2020.04.30.1 ruby lib
# stub: ext/rdkit_chem/extconf.rb

Gem::Specification.new do |s|
  s.name = "rdkit_chem".freeze
  s.version = "2020.04.30.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["An Nguyen".freeze]
  s.date = "2019-07-15"
  s.description = "RDKit as a GEM".freeze
  s.email = ["annguyen@kit.edu".freeze]
  s.extensions = ["ext/rdkit_chem/extconf.rb".freeze]
  s.files = ["Rakefile".freeze, "ext/rdkit_chem/extconf.rb".freeze, "lib/rdkit_chem.rb".freeze, "lib/rdkit_chem/version.rb".freeze, "test/test_rdkit_chem.rb".freeze]
  s.homepage = "https://github.com/CamAnNguyen/rdkit-chem".freeze
  s.licenses = ["BSD".freeze]
  s.rubygems_version = "2.7.11".freeze
  s.summary = "Ruby gem for RDKit !".freeze
  s.test_files = ["test/test_rdkit_chem.rb".freeze]

  s.installed_by_version = "2.7.11" if s.respond_to? :installed_by_version
end
