$:.unshift File.expand_path('../lib', __FILE__)

require 'rdkit_chem/version'

Gem::Specification.new do |s|
  s.name               = 'rdkit_chem'
  s.version            = RDKitChem::GEMVERSION

  s.authors = ['An Nguyen']
  s.date = '2019-07-15'
  s.description = 'RDKit as a GEM'
  s.email = ['annguyen@kit.edu']
  s.homepage = 'https://github.com/CamAnNguyen/rdkit-chem'
  s.require_paths = ['lib']
  s.rubygems_version = '0.0.1'
  s.summary = 'Ruby gem for RDKit !'
  s.license = 'BSD'
  s.test_files = ['test/test_rdkit_chem.rb']

  s.files = %w[Rakefile lib/rdkit_chem.rb lib/rdkit_chem/version.rb]
  s.extensions = ['ext/rdkit_chem/extconf.rb']
end
