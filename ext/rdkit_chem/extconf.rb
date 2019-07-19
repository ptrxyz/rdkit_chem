require 'fileutils'
require 'rbconfig'
require 'mkmf'

main_dir = File.expand_path(File.join(File.dirname(__FILE__),"..",".."))

rdkit_dir = File.join main_dir, 'rdkit'
src_dir = rdkit_dir

build_dir = File.join src_dir, 'build'
install_dir = rdkit_dir

begin
  nr_processors = `getconf _NPROCESSORS_ONLN`.to_i # should be POSIX compatible
rescue StandardError
  nr_processors = 1
end

FileUtils.mkdir_p rdkit_dir
Dir.chdir main_dir do
  FileUtils.rm_rf src_dir
  puts 'Downloading RDKit sources'
  git = "git clone https://github.com/CamAnNguyen/rdkit.git \
          --branch 'ruby-binding'"
  system git
end

env_boost_root = ENV['PKG_CONFIG_PATH']
boost_root = env_boost_root.empty? ? '/usr/include' : env_boost_root

FileUtils.mkdir_p build_dir
FileUtils.mkdir_p install_dir
Dir.chdir build_dir do
  puts 'Configuring RDKit'

  cmake = "cmake #{src_dir} -DCMAKE_INSTALL_PREFIX=#{install_dir} " \
          '-DCMAKE_BUILD_TYPE=Release -DRDK_BUILD_PYTHON_WRAPPERS=OFF ' \
          '-DRDK_BUILD_SWIG_WRAPPERS=ON -DRDK_BUILD_INCHI_SUPPORT=ON ' \
          "-DBOOST_ROOT=#{boost_root}"
  system cmake
end

# local installation in gem directory
Dir.chdir build_dir do
  puts 'Compiling RDKit sources.'
  system "make -j#{nr_processors}"
  system 'make install'
end

# create a fake Makefile
File.open(File.join(File.dirname(__FILE__), 'Makefile'), "w+") do |makefile|
  makefile.puts "all:\n\ttrue\n\ninstall:\n\ttrue\n"
end

$makefile_created = true
