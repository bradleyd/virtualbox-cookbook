#
# Cookbook Name:: virtualbox
# Attributes:: default
#
# Copyright 2011, Joshua Timberman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['virtualbox']['urlbase'] = "http://download.virtualbox.org/virtualbox/4.0.8"
default['virtualbox']['arch'] = node['kernel']['machine'] =~ /x86_64/ ? "amd64" : "i386"
case node['platform']
when "mac_os_x"
  default['virtualbox']['version'] = "VirtualBox-4.0.8-71778"
when "ubuntu","debian"
  default['virtualbox']['version'] = "4.1"

  # Settings for integrating virtualbox as a system service, automatically rebooting VMs at host startup
  default['virtualbox']['systemservice']['enabled'] = false
  default['virtualbox']['systemservice']['user'] = 'virtualbox'

  # Settings for activating the included vboxweb-service
  #default['virtualbox']['webservice']['enabled'] = false
  #default['virtualbox']['webservice']['log']['location'] = '/var/log/vboxwebsrv'
  #default['virtualbox']['webservice']['log']['rotate'] = 5 # archived log files
  #default['virtualbox']['webservice']['log']['size'] = 10485760 # 10 MByte
  #default['virtualbox']['webservice']['log']['interval'] = 604800 # 1 week

  # Settings for activating the optional phpvirtualbox web frontend
  #default['virtualbox']['webfrontend']['enabled'] = false
end

default['virtualbox']['url'] = ""
default['virtualbox']['open_source_edition'] = false
