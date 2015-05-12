# An array of project names, uris and their branches need to build the simplyadrian snowflake project 
default['snowflake-simplyadrian']['git']['snowflake_git_dependency'] = [{:name => 'twitter-scala-parent-overrides',
													          :uri => 'git@github.com:simplyadrian/twitter-scala-parent-overrides.git',
													          :branch => 'master',
													          :depth => 1},
													          {:name => 'apache-scribe-client-overrides',
													          :uri => 'git@github.com:simplyadrian/apache-scribe-client-overrides.git',
													          :branch => 'master',
													          :depth => 1}]
# The snowflake git repository uri
default['snowflake-simplyadrian']['git']['snowflake_git_repository_uri'] = 'git@github.com:simplyadrian/snowflake.git'
# The snowflake revision or branch you want to checkout.
default['snowflake-simplyadrian']['git']['snowflake_git_repository_branch'] = 'master'
# The depth you want to which you want to clone the snowflake project.
default['snowflake-simplyadrian']['git']['snowflake_git_clone_depth'] = 1