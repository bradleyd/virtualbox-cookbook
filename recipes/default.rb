#
# Cookbook Name:: virtualbox
# Recipe:: default
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

require 'open-uri'

case node['platform']
when "mac_os_x"
  distfile = "-OSX.dmg"
when "ubuntu","debian"
  distfile = "~#{node['platform'].capitalize}~#{node['lsb']['codename']}_#{node['virtualbox']['arch']}.deb"
end

filename = "#{node['virtualbox']['version']}#{distfile}"
url = node['virtualbox']['url'].empty? ? "#{node['virtualbox']['urlbase']}/#{filename}" : node['virtualbox']['url']
target = "#{Chef::Config[:file_cache_path]}/#{filename}"

case node['platform']
when "mac_os_x"

  sha256sum = "" # retrieve the sha256sums from the virtualbox mirror
  open("#{node['virtualbox']['urlbase']}/SHA256SUMS").each do |line|
    sha256sum = line.split(" ")[0] if line =~ /#{distfile}/
  end

  dmg_package "Virtualbox" do
    source url
    type "mpkg"
    checksum sha256sum
  end

when "ubuntu","debian"

  if not node['virtualbox']['open_source_edition']

    bash "apt-get update" do
      code "apt-get update"
      action :nothing
    end

    bash "add Oracle key" do
      code "wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | apt-key add -"
      action :nothing
      notifies :run, resources(:bash => "apt-get update"), :immediately
    end

    template "/etc/apt/sources.list.d/oracle-virtualbox.list" do
      source "oracle-virtualbox.list.erb"
      mode 0644
      notifies :run, resources(:bash => "add Oracle key"), :immediately
    end
  end

  package "virtualbox-#{node['virtualbox']['version']}"

  if node['virtualbox']['systemservice']['enabled']

    user 'virtualbox-systemservice-user' do
      username node['virtualbox']['systemservice']['user']
      gid 'vboxusers'
      password data_bag_item('passwords','virtualbox-systemservice-user')['password']
      home "/home/#{node['virtualbox']['systemservice']['user']}"
      shell "/bin/bash"
      system true
      manage_home true
    end

    cookbook_file "/etc/init.d/vboxcontrol" do
      source "vboxcontrol"
      mode "0755"
    end

    directory "/etc/virtualbox" do
      mode "0755"
    end

    unless FileTest.exists?("/etc/virtualbox/machines_enabled")
      cookbook_file "/etc/virtualbox/machines_enabled" do
        source "machines_enabled"
        mode "0644"
      end
    end

    host_interface = node[:network][:default_interface]
    addresses = node[:network][:interfaces][host_interface][:addresses]
    host_ip = 'unknown'
    addresses.each do |ip, params|
      host_ip = ip if params['family'].eql?('inet')
    end

    template "/etc/virtualbox/config" do
      source "config.erb"
      mode "0644"
      variables(
          :host_interface => host_interface,
          :host_ip => host_ip
      )
    end

    service "vboxcontrol" do
      action [:enable, :start]
    end

  end

end

