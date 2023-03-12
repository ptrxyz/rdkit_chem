# frozen_string_literal: true

require 'fileutils'
require 'rbconfig'
require 'mkmf'

main_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
rdkit_dir = File.join(main_dir, 'rdkit')
install_dir = File.join(main_dir, 'rdkit_chem')
src_dir = rdkit_dir
build_dir = File.join(src_dir, 'build')

begin
  nr_processors = `getconf _NPROCESSORS_ONLN`.to_i # should be POSIX compatible
rescue StandardError
  nr_processors = 1
end

FileUtils.mkdir_p rdkit_dir
Dir.chdir main_dir do
  FileUtils.rm_rf src_dir
  puts 'Downloading RDKit sources'
  git = 'git clone https://github.com/rdkit/rdkit.git'
  system git
end

Dir.chdir(src_dir) do
  checkout = 'git checkout 39bcee635e0ee8bc5da6798318fdcd4602c4baa6'
  system checkout
end

FileUtils.cp_r(
  File.join(main_dir, 'Code'),
  File.join(rdkit_dir),
  remove_destination: true
)

FileUtils.cp_r(
  File.join(main_dir, 'CMakeLists.txt'),
  File.join(rdkit_dir),
  remove_destination: true
)

env_boost_root = ENV['BOOST_ROOT'] || ''
boost_root = env_boost_root.empty? ? '/usr/include' : env_boost_root

host_os = RbConfig::CONFIG['host_os']
is_linux = host_os =~ /linux/
is_mac = host_os =~ /darwin/
ld_path = ''

if is_linux || is_mac
  ld_string = is_linux ? 'LD_LIBRARY_PATH' : 'DYLD_LIBRARY_PATH'
  ld_path = "#{ld_string}=#{install_dir}/lib"
  env_ld = ENV[ld_string] || ''

  ld_path += ":#{env_ld}" unless env_ld.empty?
end

FileUtils.mkdir_p build_dir
Dir.chdir build_dir do
  puts 'Configuring RDKit'

  cmake = "#{ld_path} cmake #{src_dir} -DRDK_INSTALL_INTREE=OFF " \
          "-DCMAKE_INSTALL_PREFIX=#{install_dir} " \
          '-DCMAKE_BUILD_TYPE=Release -DRDK_BUILD_CPP_TESTS=OFF -DRDK_BUILD_PYTHON_WRAPPERS=OFF ' \
          '-DRDK_BUILD_SWIG_WRAPPERS=ON -DRDK_BUILD_INCHI_SUPPORT=OFF ' \
          '-DBoost_NO_BOOST_CMAKE=ON'
  system cmake
end

# local installation in gem directory
Dir.chdir build_dir do
  puts 'Compiling RDKit sources.'
  system "#{ld_path} make -j#{nr_processors}"
  system "#{ld_path} make install"
end

# Remove compiled file, free spaces
FileUtils.remove_dir(rdkit_dir)

# create a fake Makefile
File.open(File.join(File.dirname(__FILE__), 'Makefile'), 'w+') do |makefile|
  makefile.puts "all:\n\ttrue\n\ninstall:\n\ttrue\n"
end

$makefile_created = true
