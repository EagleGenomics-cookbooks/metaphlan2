#
# Cookbook Name:: metaphlan2
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'metaphlan2::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'includes the `poise-python` recipe' do
    expect(chef_run).to include_recipe('poise-python')
  end

  it 'install python' do
    expect(chef_run).to install_python_runtime('2')
  end

  it 'install mercurial' do
    expect(chef_run).to upgrade_package('mercurial')
  end

  it 'sets metaphlan2 version to 2.6.0' do
    expect(chef_run.node['metaphlan2']['version']).to eq('2.6.0')
  end

  it 'includes the `mercurial` recipe' do
    expect(chef_run).to include_recipe('mercurial')
  end

  it 'adds metaphlan path to PATH' do
    expect(chef_run).to add_magic_shell_environment('PATH')
  end

  it 'sets METAPHLAN2_VERSION variable' do
    expect(chef_run).to add_magic_shell_environment('METAPHLAN2_VERSION')
  end

  it 'install biopython' do
    expect(chef_run).to install_python_package('biopython')
  end

  it 'install numpy' do
    expect(chef_run).to install_python_package('numpy')
  end

  it 'install scipy' do
    expect(chef_run).to install_python_package('scipy')
  end

  it 'install pandas' do
    expect(chef_run).to install_python_package('pandas')
  end

  it 'install png libs' do
    expect(chef_run).to install_package('Install png libs')
  end

  it 'install Install freetype libs' do
    expect(chef_run).to install_package('Install freetype libs')
  end

  it 'install pkg config' do
    expect(chef_run).to install_package('Install pkg config')
  end

  it 'install g++' do
    expect(chef_run).to install_package('Install g++')
  end

  it 'install matplotlib' do
    expect(chef_run).to install_python_package('matplotlib')
  end
end
