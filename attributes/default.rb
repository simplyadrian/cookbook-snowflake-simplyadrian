# An array of project names, urls and their branches need to build the NativeX snowflake project 
default['snowflake-nativex']['snowflake_git_dependencies'] = [{:name => 'twitter-scala-parent-overrides',
													          :url => 'git://github.com:nativex/twitter-scala-parent-overrides.git',
													          :branch => 'master',
													          :depth => 1},
													          {:name => 'apache-scribe-client-overrides',
													          :url => 'git://github.com:nativex/apache-scribe-client-overrides.git',
													          :branch => 'master',
													          :depth => 1}]
# The NativeX snowflake project name
default['snowflake-nativex']['nativex_snowflake_project_name'] = 'snowflake'
# The snowflake git repository url
default['snowflake-nativex']['snowflake_git_repository_url'] = 'git://github.com:nativex/snowflake.git'
# The snowflake revision or branch you want to checkout.
default['snowflake-nativex']['snowflake_git_repository_branch'] = 'master'
