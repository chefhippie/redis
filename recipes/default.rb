#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2013-2014, Thomas Boerger <thomas@webhippie.de>
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

case node["platform_family"]
when "suse"
  include_recipe "zypper"

  zypper_repository node["redis"]["zypper"]["alias"] do
    uri node["redis"]["zypper"]["repo"]
    key node["redis"]["zypper"]["key"]
    title node["redis"]["zypper"]["title"]

    action :add

    only_if do
      node["redis"]["zypper"]["enabled"]
    end
  end
end

node["redis"]["packages"].each do |name|
  package name do
    action :install
  end
end

node["redis"]["removed_files"].each do |name|
  file name do
    action :delete

    only_if do
      File.exists? name
    end
  end
end

node["redis"]["removed_dirs"].each do |name|
  directory name do
    action :delete
    recursive true

    only_if do
      File.directory? name
    end
  end
end

template node["redis"]["config_file"] do
  source "redis.conf.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["redis"]
  )

  notifies :restart, "service[redis]"
end

service "redis" do
  service_name node["redis"]["service_name"]
  action [:enable, :start]
end
