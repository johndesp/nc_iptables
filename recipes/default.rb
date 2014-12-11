#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2008-2009, GE, Inc.
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

package "iptables"

template "/etc/sysconfig/iptables" do
  source "iptables.erb"
  owner "root"
  group "root"
  mode "0600"
  variables(:input => {})
  notifies :restart, "service[iptables]"
end

iptables_rule "loopback" do
  log  "-A INPUT -m limit --limit 5/min -j LOG --log-prefix \"LOOPBACK: \" --log-level 7"
  rule "-A INPUT -i lo -j ACCEPT"
  weight 0
end

iptables_rule "ssh" do
  log  "-A INPUT -p tcp -m limit --limit 5/min -j LOG --log-prefix \"TCP_SSH: \" --log-level 7"
  rule "-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT"
  weight 0
end

service "iptables" do
  action [ :enable, :start ]
  supports :status => true, :start => true, :stop => true, :restart => true
end

