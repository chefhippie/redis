#
# Cookbook Name:: redis
# Attributes:: default
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

default["redis"]["packages"] = value_for_platform_family(
  "debian" => %w(
    redis-server
  ),
  "suse" => %w(
    redis
  )
)

default["redis"]["service_name"] = value_for_platform_family(
  "debian" => "redis-server",
  "suse" => "redis"
)

default["redis"]["log_file"] = value_for_platform_family(
  "debian" => "/var/log/redis/redis-server.log",
  "suse" => "/var/log/redis/default.log"
)

default["redis"]["pid_file"] = value_for_platform_family(
  "debian" => "/var/run/redis/redis-server.pid",
  "suse" => "/var/run/redis/default.pid"
)

default["redis"]["removed_files"] = %w(
  /etc/redis/default.conf.example
)

default["redis"]["removed_dirs"] = %w(
)

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

default["redis"]["zypper"]["enabled"] = true
default["redis"]["zypper"]["alias"] = "server-database"
default["redis"]["zypper"]["title"] = "Server Database"
default["redis"]["zypper"]["repo"] = "http://download.opensuse.org/repositories/server:/database/openSUSE_#{node["platform_version"]}/"
default["redis"]["zypper"]["key"] = "#{node["redis"]["zypper"]["repo"]}repodata/repomd.xml.key"
