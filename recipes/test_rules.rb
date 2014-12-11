#
# Cookbook Name:: iptables
# Recipe:: test_rules
#
# Copyright 2008-2009, Opscode, Inc.
#

include_recipe "nc_iptables::default"

iptables_rule "snmp" do
  rule [
    "-A INPUT -p tcp -m tcp --dport 161 -j ACCEPT",
    "-A INPUT -p udp -m udp --dport 161 -j ACCEPT",
    "-A INPUT -p tcp -m tcp --dport 162 -j ACCEPT",
    "-A INPUT -p udp -m udp --dport 162 -j ACCEPT"
  ]
  log  "-A INPUT -p tcp -m limit --limit 5/min -j LOG --log-prefix \"TCP_SNMP: \" --log-level 7"
  weight 10
end

iptables_rule "smtp" do
  rule [
    "-A INPUT -p tcp -m tcp --dport 25 -j ACCEPT",
  ]
  log  "-A INPUT -p tcp -m limit --limit 5/min -j LOG --log-prefix \"TCP_SMTP: \" --log-level 7"
  weight 1
end