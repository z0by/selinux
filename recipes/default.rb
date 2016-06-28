#
# Cookbook Name:: selinux_test
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
selinux_status 'test' do
  action :enforcing
end