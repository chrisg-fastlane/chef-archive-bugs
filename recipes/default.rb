#
# Cookbook:: chef_archive_bugs
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.
#

# create a test archive
include_recipe 'chef_archive_bugs::archive_setup'

# unpack the test archive
include_recipe 'chef_archive_bugs::unpack_archive'

# unpack the test archive with owner properties
include_recipe 'chef_archive_bugs::unpack_archive_owner'
