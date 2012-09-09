#
# Cookbook Name:: virtualbox
# Recipe:: webportal
#
# Copyright 2012, Ringo De Smet
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

# The phpvirtualbox webportal requires the Virtualbox webservice api to be active
include_recipe "virtualbox::webservice"

# This recipe requires the apache2 cookbook to be available
include_recipe "apache2"
include_recipe "apache2::mod_php5"

vbox_version = node['virtualbox']['version']
phpvirtualbox_build = node['virtualbox']['webportal']['versions'][vbox_version]
phpvirtualbox_version = "#{vbox_version}-#{phpvirtualbox_build}"

remote_file "#{Chef::Config['file_cache_path']}/phpvirtualbox-#{phpvirtualbox_version}.zip" do
  source "http://phpvirtualbox.googlecode.com/files/phpvirtualbox-#{phpvirtualbox_version}.zip"
  mode "0644"
end

package "unzip" do
  action :install
end

bash "extract-phpvirtualbox" do
  code <<-EOH
  cd /tmp
  unzip #{Chef::Config['file_cache_path']}/phpvirtualbox-#{phpvirtualbox_version}.zip
  cd phpvirtualbox-#{phpvirtualbox_version}
  mv * /var/www
  cd ..
  rm -rf phpvirtualbox-#{phpvirtualbox_version}
  EOH
end

template "/var/www/config.php" do
  source "config.php.erb"
  mode "0644"
  notifies :restart, "service[apache2]", :immediately
  variables(
      :password => data_bag_item('passwords','vboxweb-service')['password']
  )
end
