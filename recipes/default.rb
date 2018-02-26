#
# Cookbook Name:: metaphlan2
# Recipe:: default
#
# Copyright (c) 2016 Eagle Genomics Ltd, Apache License, Version 2.0.
##########################################################

include_recipe 'apt' if node['platform_family'] == 'debian'
include_recipe 'poise-python'
include_recipe 'mercurial'

# install the Python runtime
python_runtime '2' do
  version '2.7'
  pip_version '8.1.2'
end

python_package 'biopython' do
  version '1.67'
end

python_package 'numpy' do
  version '1.11.1'
end

# requirement for export2graphlan
python_package 'scipy' do
  version '0.18.0'
end

# requirement for export2graphlan
python_package 'pandas' do
  version '0.18.1'
end

# requirement for export2graphlan
# install required packages for matplotlib
package 'Install png libs' do
  case node['platform']
  when 'ubuntu', 'debian'
    package_name 'libpng12-dev'
  end
end
package 'Install freetype libs' do
  case node['platform']
  when 'ubuntu', 'debian'
    package_name 'libfreetype6-dev'
  end
end
package 'Install pkg config' do
  case node['platform']
  when 'ubuntu', 'debian'
    package_name 'pkg-config'
  end
end
package 'Install g++' do
  case node['platform']
  when 'ubuntu', 'debian'
    package_name 'g++'
  end
end
python_package 'matplotlib' do
  version '1.5.1'
end

# leaving this in so it can be re-enabled when (if)
# the biobakery people sort out the bitbucket installation
# check out the MetaPhlAn2 sources
# mercurial node['metaphlan2']['install_dir'] do
#   repository 'https://bitbucket.org/biobakery/metaphlan2'
#   reference node['metaphlan2']['version']
#   action :clone
# end

bash 'Download zip file' do
  code <<-EOH
    cd #{node['metaphlan2']['zipfile']['local_dir']}
    wget -nv #{node['metaphlan2']['zipfile']['remote_url']}
    EOH
end

zipfile 'Extract metaphlan 2 zip file' do
  from node['metaphlan2']['zipfile']['local_file']
  into node['metaphlan2']['zipfile']['local_dir']
end

magic_shell_environment 'METAPHLAN2_VERSION' do
  value node['metaphlan2']['version']
end

# NOTE: the 'filename' feature is only available in a pull request version of magic_shell,
#       NOT the Chef Supermarket version. Hence a custom Berksfile entry is required.
magic_shell_environment 'PATH' do
  filename 'metaphlan2_path'
  value "$PATH:#{node['metaphlan2']['install_dir']}"
end
# put the metaphlan2 utils on the path
magic_shell_environment 'PATH' do
  filename 'metaphlan2_utils_path'
  value "$PATH:#{node['metaphlan2']['install_dir']}/utils"
end
# put the export2graphlan tool on the path
magic_shell_environment 'PATH' do
  filename 'metaphlan2_export_path'
  value "$PATH:#{node['metaphlan2']['install_dir']}/utils/export2graphlan"
end
