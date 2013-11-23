name             "virtualbox"
maintainer       "Chris Peplin"
maintainer_email "chris.peplin@rhubarbtech.com"
license          "Apache 2.0"
description      "Installs virtualbox"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.2"

%w{ubuntu debian centos redhat mac_os_x windows}.each do |os|
  supports os
end

depends "dmg"
depends "windows"
depends "apt"
depends "yum"
depends "apache2"
