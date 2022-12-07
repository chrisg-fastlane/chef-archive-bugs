#
# Cookbook:: chef_archive_bugs
# Recipe:: unpack_archive_owner
#
# Copyright:: 2022, The Authors, All Rights Reserved.
#

puts "-----------------------\n"
puts ''
puts "This recipe demonstrates that the 'archive_file' resource"
puts "is not idempotent when the 'owner' or 'group' property is defined"
puts ''
puts "-----------------------\n"

tmpdir = node['tmpdir']
archive_file = File.join(tmpdir, node['archive_name'])
testdir = node['testdir_name'] + '_owner'

# destination directory is a subdirectory of the tmp dir
destination = File.join(tmpdir, testdir)

owner = 'root'

# unpack to a new directory (thus avoiding the
# directory creation issue demonstrated elsewhere)
archive_file "1. unpack to #{destination}" do
  path archive_file
  destination destination
end

# list unpacked contents to show ownership
execute "list contents of #{destination}" do
  command "ls -al #{destination}"
end

%w(1 2 3).each do |count|
  # unpack again to demonstrate idempotency (i.e. archive is "up to date")
  archive_file "2.#{count} unpack to #{destination} again" do
    path archive_file
    destination destination
  end

  # unpack again with 'owner' defined
  archive_file "3.#{count} unpack to #{destination} again with owner defined" do
    path archive_file
    destination destination
    owner owner
  end

  # unpack again with 'group' defined
  archive_file "4.#{count}. unpack to #{destination} again with group defined" do
    path archive_file
    destination destination
    group owner
  end

  # unpack again with 'owner' and 'group' defined
  archive_file "5.#{count}. unpack to #{destination} again with owner:group defined" do
    path archive_file
    destination destination
    owner owner
    group owner
  end
end
