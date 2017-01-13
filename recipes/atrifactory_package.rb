
_environment = node.chef_environment

package_path_java = "org/jfrog/test"
package_version_java = node["package_version_java"] 
package_version_java_name = "multi2"
package_version_java_SNAPSHOT = "6.1-SNAPSHOT"
art_url = node["art"]


directory 'DIR_TO_DOWNLOAD' do
  owner 'USER'
  mode '0644'
  group 'GROUP'
  recursive true
  action :create
end

remote_file "#{DIR_TO_DOWNLOAD}/#{package_name}-#{package_version}.XYZ" do
  source "#{art_url}/pypi-local/#{package_name}/#{package_version}/#{package_name}-#{package_version}.XYZ"
  owner 'USER'
  group 'GROUP'
  mode '0600'
end

