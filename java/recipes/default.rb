#
# Cookbook:: java
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

tmp = Chef::Config[:file_cache_path]
java_home = node['java']['java_home']
default_java = node['java']['java_default']
arch = node['java']['arch']
jdk_version = node['java']['jdk_version']
jdk_list = node['java']['jdk_list']

Array jdkl = []
if jdk_list.empty? || jdk_list.nil?
  jdkl.push(jdk_version)
else
  jdkl = jdk_list
end

jdkl.each do |jdkv|
  jdkv = jdkv.to_s if jdkv.instance_of? Fixnum
  jdk_url = node['java']['jdk'][jdkv][arch]['url']
  jdk_checksum = node['java']['jdk'][jdkv][arch]['checksum']

  ruby_block 'java-home' do
    block do
      ENV['JAVA_HOME'] = java_home
    end
  end

  java_ark 'jdk' do
    url jdk_url
    checksum jdk_checksum
    app_home java_home
    app_default default_java
    bin_cmds %w(java javac)
    action :install
  end
end

execute 'java home' do
    command "export JAVA_HOME="/usr/java/default""
    retries 3
end

execute 'java path' do
    command "export PATH="$PATH:$JAVA_HOME/bin""
    retries 3
end
