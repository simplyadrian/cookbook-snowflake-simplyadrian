# Maven version
default['maven']['version'] = "3"
# Add maven to system path
default['maven']['setup_bin'] = true
# Maven cookbook installs the openjdk that ships with the cookbook.
default['maven']['install_java'] = false