# An array of project names, uris and their branches need to build the NativeX snowflake project 
default['snowflake-nativex']['snowflake_git_dependencies'] = [{:name => 'twitter-scala-parent-overrides',
													          :uri => 'git@github.com:nativex/twitter-scala-parent-overrides.git',
													          :branch => 'master',
													          :depth => 1},
													          {:name => 'apache-scribe-client-overrides',
													          :uri => 'git@github.com:nativex/apache-scribe-client-overrides.git',
													          :branch => 'master',
													          :depth => 1}]
# The NativeX snowflake project name
default['snowflake-nativex']['nativex_snowflake_project_name'] = 'snowflake'
# The snowflake git repository uri
default['snowflake-nativex']['snowflake_git_repository_uri'] = 'git@github.com:nativex/snowflake.git'
# The snowflake revision or branch you want to checkout.
default['snowflake-nativex']['snowflake_git_repository_branch'] = 'master'
# The depth you want to which you want to clone the snowflake project.
default['snowflake-nativex']['snowflake_git_clone_depth'] = 1
# The operations home directory where github.com authentication will be setup
default['snowflake-nativex']['ssh']['home'] = '/root/.ssh'
# The user that owns the ssh keys.
default['snowflake-nativex']['ssh']['user'] = 'root'
# The group that owns the ssh key.
default['snowflake-nativex']['ssh']['user'] = 'root'
# The destination directory where the snowflake project will live after being compiled.
default['snowflake-nativex']['link']['destination_directory'] = '/usr/local'
# The snowflake project environment home directory
default['snowflake-nativex']['snowflake_home'] = '/usr/local/snowflake'
# The snowflake project options (example)
#default['snowflake-nativex']['snowflakerc']['opts'] = '-Dsnowflake.repo.local=$HOME/ -Xmx384m -XX:MaxPermSize=192m'