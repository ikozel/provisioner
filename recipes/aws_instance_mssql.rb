require "chef/provisioning/aws_driver"
Chef::Config.chef_provisioning({:image_max_wait_time => 660, :machine_max_wait_time => 660})

with_driver "aws"
org = "aig"
environment = node.chef_environment
with_chef_environment "#{environment}"

machine "AIG_APP_MSQL" do
  machine_options(
    :bootstrap_options => {
      :image_id => "ami-<ID>", # Windows 2012 R2
      :instance_type => "m1.medium",
      :key_name => "<AWS_KEY>",
      :security_group_ids => "sg-<ID>",
      :subnet_id => "subnet-<ID>",
      :associate_public_ip_address => true
    },
      transport_address_location: :public_ip,
      is_windows: true,
      winrm_username: "Administrator",
      winrm_password: "<PWD>",
    :convergence_options => {
      :ssl_verify_mode => 'verify_none'
    }
  )
  attributes(
    sql_server: {
      server_sa_password: "<PWD>",
      accept_eula: true,
      version: '2012'
    }
  )
  recipe "sql_server::default"
  recipe "sql_server::server"
  converge true
end
