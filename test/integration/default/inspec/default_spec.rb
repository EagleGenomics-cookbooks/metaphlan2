# Tests to check if the infrastructure we expect is available

describe file('/usr/local/metaphlan2') do
  it { should be_directory }
end

describe file('/usr/local/metaphlan2/utils') do
  it { should be_directory }
end

describe file('/usr/local/metaphlan2/utils/export2graphlan') do
  it { should be_directory }
end

describe file('/usr/local/metaphlan2/metaphlan2.py') do
  it { should be_file }
end

describe file('/usr/local/metaphlan2/utils/export2graphlan/export2graphlan.py') do
  it { should be_file }
end

describe command('which metaphlan2.py') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match %r{/metaphlan2/metaphlan2.py} }
end

describe command('metaphlan2.py -v') do
  its('exit_status') { should eq 0 }
  its('stderr') { should match(/2.6.0/) }
  # TODO: read versio number from node attributes
  # TODO: may need to include version adjustment, as tool versioning not consistent
end

describe command('which export2graphlan.py') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match %r{/utils/export2graphlan/export2graphlan.py} }
end

describe command('which python') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match %r{/python} }
end

describe command('python --version') do
  its('exit_status') { should eq 0 }
  its('stderr') { should match(/2.7/) }
end

describe command('echo $PATH') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/metaphlan2/) }
  its('stdout') { should match(/export2graphlan/) }
end
