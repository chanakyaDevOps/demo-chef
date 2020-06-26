default['java']['install_flavor'] = "oracle"
default['java']['jdk_version'] = '8'
default['java']['arch'] = kernel['machine'] =~ /x86_64/ ? "x86_64" : "i586"
default['java']['jdk_list'] = []
default['java']['java_home'] = "/usr/java/latest"
default['java']['java_default'] = "/usr/java/default"
default['java']['jdk']['8']['x86_64']['url'] = ''
