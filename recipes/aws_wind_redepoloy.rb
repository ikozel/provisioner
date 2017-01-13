require 'chef/provisioning/ssh_driver'
require 'openssl'
Chef::Config.chef_provisioning({:image_max_wait_time => 660, :machine_max_wait_time => 660})

with_driver 'ssh'
org = "aig"
environment = node.chef_environment
with_chef_environment "#{environment}"

machine "AIG_APP" do
  action :converge
  machine_options  :transport_options => {
    'is_windows' => true,
    'host' => '<HIOST_IP>',
    'port' => 5985,
    'username' => 'Administrator',
    'password' => '<PWD>'
  }
  converge true
end
