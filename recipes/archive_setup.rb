#
# Cookbook:: chef_archive_bugs
# Recipe:: archive_setup
#
# Copyright:: 2022, The Authors, All Rights Reserved.
#
#
# create an archive for unpacking
#

tmpdir = node['tmpdir']
archive_name = node['archive_name']
archive_path = File.join(tmpdir, archive_name)
dummy = node['dummy_file']

file dummy do
  content 'This is a dummy file.'
  path File.join(tmpdir, dummy)
end

execute 'create archive of lone dummy file' do
  command "cd #{tmpdir}; tar czf #{archive_name} #{dummy}"
  not_if { ::File.exist?(archive_path) }
end
