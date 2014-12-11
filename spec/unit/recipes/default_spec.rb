## Comments make me happy, I guess

require 'spec_helper'

describe "nc_iptables::default" do
  let(:chef_run) do
    runner = ChefSpec::ChefRunner.new(
      log_level: :error,
      cookbook_path: COOKBOOK_PATH
    )
    Chef::Config.force_logger true
    runner.converge('recipe[nc_iptables::default]')
  end

  it "installs iptables" do
     expect(chef_run).to install_package "iptables"
  end

  it "enables and starts the iptables service" do
     expect(chef_run).to start_service "iptables"
     expect(chef_run).to set_service_to_start_on_boot "iptables"
  end

  it "has a rule allowing ssh" do
     expect(chef_run).to create_file_with_content(
       "/etc/sysconfig/iptables",
       "-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT"
     )
  end

  it "has a rule allowing loopback" do
     expect(chef_run).to create_file_with_content(
       "/etc/sysconfig/iptables",
       "-A INPUT -i lo -j ACCEPT"
     )
  end
end


describe "nc_iptables::test_rules" do
   let(:chef_run) do
     runner = ChefSpec::ChefRunner.new(
       log_level: :error,
       cookbook_path: COOKBOOK_PATH
     )
     Chef::Config.force_logger true
     runner.converge('recipe[nc_iptables::test_rules]')
   end

  it "has a rule allowing ssh" do
     expect(chef_run).to create_file_with_content(
       "/etc/sysconfig/iptables",
       "-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT"
     )
  end

  it "has a rule allowing snmp" do
     expect(chef_run).to create_file_with_content(
       "/etc/sysconfig/iptables",
       "-A INPUT -p tcp -m tcp --dport 161 -j ACCEPT"
     )
     expect(chef_run).to create_file_with_content(
       "/etc/sysconfig/iptables",
       "-A INPUT -p udp -m udp --dport 161 -j ACCEPT"
     )
     expect(chef_run).to create_file_with_content(
       "/etc/sysconfig/iptables",
       "-A INPUT -p tcp -m tcp --dport 162 -j ACCEPT"
     )
     expect(chef_run).to create_file_with_content(
       "/etc/sysconfig/iptables",
       "-A INPUT -p udp -m udp --dport 162 -j ACCEPT"
     )
  end

  it "has a rule allowing smtp" do
     expect(chef_run).to create_file_with_content(
       "/etc/sysconfig/iptables",
       "-A INPUT -p tcp -m tcp --dport 25 -j ACCEPT"
     )
  end
end
