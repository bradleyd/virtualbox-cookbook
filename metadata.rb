maintainer       "Chris Peplin"
maintainer_email "chris.peplin@rhubarbtech.com"
license          "Apache 2.0"
description      "Installs virtualbox"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.7.2"

%w{ubuntu mac_os_x windows}.each do |os|
  supports os
end
