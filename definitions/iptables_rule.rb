#
# Cookbook Name:: iptables
# Definition:: iptables_rule
#
# Copyright 2008-2009, Opscode, Inc.
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

define :iptables_rule, :rule => nil, :log => nil, :weight => 5 do
  include_recipe "nc_iptables::default"

  iptables_template = resources("template[/etc/sysconfig/iptables]")

  if params[:rule].kind_of?(String)
    rule_list = [params[:rule]]
  else
    rule_list = params[:rule]
  end

    iptables_template.variables[:input][params[:name]] = {
    :weight   => params[:weight],
    :rule     => rule_list,
    :log      => params[:log]
  }
end
