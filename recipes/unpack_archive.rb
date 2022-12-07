#
# Cookbook:: chef_archive_bugs
# Recipe:: unpack_archive
#
# Copyright:: 2022, The Authors, All Rights Reserved.
#

puts "-----------------------\n"
puts ''
puts "This recipe demonstrates that the 'directory' resource"
puts "does not create a directory that 'archive_file' can unpack"
puts 'into directly'
puts "and that the 'archive_file' resource fails silently in this scenario"
puts 'but does fail when the owner property is explicitly set.'
puts ''
puts "-----------------------\n"

tmpdir = node['tmpdir']
archive_file = File.join(tmpdir, node['archive_name'])
testdir = node['testdir_name']

# destination directory is a subdirectory of the tmp dir
destination = File.join(tmpdir, testdir)

owner = 'root'

# we observe that the following two resources report
# "up to date" despite no files being unpacked
archive_file "1. unpack to #{destination}" do
  path archive_file
  destination destination
end

archive_file "2. unpack to #{destination} again" do
  path archive_file
  destination destination
end

# we expect some of the destination contents to be missing
# despite the above reporting no errors
execute "list contents of #{destination}" do
  command "ls -al #{destination}"
end

# if the destination directory does not exist
# then the archive_file resource succeeds
archive_file "3. unpack to new subdirectory of #{destination}" do
  path archive_file
  destination destination + '/unpack'
end

archive_file "4. unpack to new subdirectory of #{destination} again" do
  path archive_file
  destination destination + '/unpack'
end

# we expect some of the destination contents to be missing
# despite the above reporting no errors
execute "list contents of #{destination}" do
  command "ls -al #{destination}/unpack"
end

# we expect this resource to fail with the error
# "No such file or directory @ apply2files"
# simply due to the presence of the 'owner' property
archive_file "5. unpack to #{destination} with owner" do
  path archive_file
  destination destination
  owner owner
  ignore_failure true
end
