default['metaphlan2']['install_dir'] = '/usr/local/metaphlan2'

# NOTE: the metaphlan2 versioning is not consistent in the bitbucket repository
#       the version tagged 2.5.0 is still showing 2.2.0 as version with 'metaphlan2.py -v'
default['metaphlan2']['version'] = '2.6.0'

# In order to get metaphlan 2 to work with Humann2, we need to get version 2.6.0 with the
# taxonomy database installed.
# However, the taxonomy database has been completely removed from bitbucket repo, and the only way
# (so far) we have found to get 2.6.0 with the taxonomy database installed is to use a zipfile they
# put on dropbox!
default['metaphlan2']['zipfile']['name'] = 'metaphlan2.zip'
default['metaphlan2']['zipfile']['remote_url'] = 'https://www.dropbox.com/s/ztqr8qgbo727zpn/' + default['metaphlan2']['zipfile']['name']
default['metaphlan2']['zipfile']['local_dir'] = '/usr/local/'
default['metaphlan2']['zipfile']['local_file'] = default['metaphlan2']['zipfile']['local_dir'] + default['metaphlan2']['zipfile']['name']
default['python']['version'] = '2.7.17'
