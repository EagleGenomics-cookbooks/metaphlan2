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

# check out the GraPhlAn sources
mercurial node['metaphlan2']['install_dir'] do
  repository 'https://bitbucket.org/biobakery/metaphlan2'
  reference node['metaphlan2']['version']
  action :clone
end

magic_shell_environment 'METAPHLAN2_VERSION' do
  value node['metaphlan2']['version']
end

# NOTE: the 'filename' feature is only available in a pull request version of magic_shell,
#       NOT the Chef Supermarket version. Hence a custom Berksfile entry is required.
magic_shell_environment 'PATH' do
  filename 'metaphlan2'
  value "$PATH:#{node['metaphlan2']['install_dir']}"
end
