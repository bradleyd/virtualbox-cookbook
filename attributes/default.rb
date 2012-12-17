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


default['virtualbox']['urlbase'] = "http://download.virtualbox.org/virtualbox/4.2.4"
default['virtualbox']['arch'] = node['kernel']['machine'] =~ /x86_64/ ? "amd64" : "i386"
case node['platform']
when "mac_os_x", "windows"
  default['virtualbox']['version'] = 'VirtualBox-4.2.4-81684'
when "ubuntu","debian"
  default['virtualbox']['version'] = "4.1"
end

default['virtualbox']['url'] = ""
default['virtualbox']['open_source_edition'] = false
