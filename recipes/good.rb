#
# Cookbook:: chef_archive_bugs
# Recipe:: good
#
# Copyright:: 2022, The Authors, All Rights Reserved.
#

include_recipe 'chef_archive_bugs::archive_setup'
include_recipe 'chef_archive_bugs::delete_testdir'
include_recipe 'chef_archive_bugs::unpack_archive'
