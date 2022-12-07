#
# Cookbook:: chef_archive_bugs
# Recipe:: make_testdir
#
# Copyright:: 2022, The Authors, All Rights Reserved.
#

tmpdir = node['tmpdir']
testdir = node['testdir_name']

# destination directory is a subdirectory of the tmp dir
destination = File.join(tmpdir, testdir)

directory "creating #{destination}" do
  path destination
  recursive true
end
