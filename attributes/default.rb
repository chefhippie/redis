#
# Cookbook Name:: redis
# Attributes:: default
#
# Copyright 2013, Thomas Boerger
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
when "debian"
  default["redis"]["packages"] = %w(
    redis-server
  )

  default["redis"]["service_name"] = "redis-server"
  default["redis"]["log_file"] = "/var/log/redis/redis-server.log"
  default["redis"]["pid_file"] = "/var/run/redis/redis-server.pid"
when "ubuntu"
  default["redis"]["packages"] = %w(
    redis-server
  )

  default["redis"]["service_name"] = "redis-server"
  default["redis"]["log_file"] = "/var/log/redis/redis-server.log"
  default["redis"]["pid_file"] = "/var/run/redis/redis-server.pid"
when "suse"
  default["redis"]["packages"] = %w(
    redis
  )

  default["redis"]["service_name"] = "redis"
  default["redis"]["log_file"] = "/var/log/redis/default.log"
  default["redis"]["pid_file"] = "/var/run/redis/default.pid"
end

default["redis"]["removed_files"] = %w(
  /etc/redis/default.conf.example
)

default["redis"]["removed_dirs"] = %w(

)

default["redis"]["zypper"]["alias"] = "server-database"
default["redis"]["zypper"]["title"] = "Server Database"
default["redis"]["zypper"]["repo"] = "http://download.opensuse.org/repositories/server:/database/openSUSE_#{node["platform_version"] == "12.1" ? "12.3" : node["platform_version"]}/"
default["redis"]["zypper"]["key"] = "#{node["redis"]["zypper"]["repo"]}repodata/repomd.xml.key"

default["redis"]["config_file"] = "/etc/redis/redis.conf"
default["redis"]["listen"] = "127.0.0.1"
default["redis"]["port"] = 6379
default["redis"]["password"] = nil
default["redis"]["memory"] = 128
default["redis"]["maxconn"] = 1024
default["redis"]["rename_commands"] = {}

default["redis"]["socket"]["enabled"] = false
default["redis"]["socket"]["path"] = "/tmp/redis.sock"
default["redis"]["socket"]["perm"] = "755"

default["redis"]["syslog"]["enabled"] = false
default["redis"]["syslog"]["ident"] = "redis"
default["redis"]["syslog"]["facility"] = "local0"
