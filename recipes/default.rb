#
# Cookbook:: metaphlan2
# Recipe:: default
#
# Copyright (c) 2016 Eagle Genomics Ltd, Apache License, Version 2.0.
##########################################################

apt_update

include_recipe 'python_setup'

pyenv_pip 'numpy' do
  version '1.11.1'
end

pyenv_pip 'biopython' do
  version '1.67'
end

# requirement for export2graphlan
pyenv_pip 'scipy' do
  version '0.18.0'
end

# requirement for export2graphlan
pyenv_pip 'pandas' do
  version '0.18.1'
end

# requirement for export2graphlan
# install required packages for matplotlib
package 'Install png libs' do
  case node['platform']
  when 'ubuntu', 'debian'
    package_name 'libpng-dev'
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
pyenv_pip 'matplotlib' do
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
