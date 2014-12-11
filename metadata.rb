name              "nc_iptables"
maintainer        "News Corporation"
maintainer_email  "john.desposito@dowjones.com"
license           "Apache 2.0"
description       "Sets up iptables to use a script to maintain rules"
version           "0.12.0"

#recipe "nc_iptables::default", "Installs and configured iptables"

%w{centos rhel}.each do |os|
  supports os
end
