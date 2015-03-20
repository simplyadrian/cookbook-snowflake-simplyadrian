snowflake-nativex Cookbook
==========================
This cookbook does the basic compile and install of the nativex::snowflake project according to the README located here: https://github.com/nativex/snowflake

Requirements
------------

#### packages
- `java JDK` - snowflake-nativex needs a JDK to complete the build of the project.
- `Maven` - snowflake-nativex needs mvn in the system path to build the snowflake project.
- `Git` - snowflake-nativex needs the git resource to download the snowflake project and its dependencies locally for the build process.

* Chef 11 or higher

#### Supported OS Distributions
Tested on:

* CentOS 6.5 x86_64 HVM minimal

Recipes
----------
The provided recipes are:

* `snowflake-nativex::default`: The main recipe that:
  * Moves github.com:nativex's chef user private key into place for authentication.
  * Creates the git_wrapper.sh script to help the git resource authenticate against github.com.
  * Uses the git resource to clone the snowflake depenencies locally and install them with maven.
  * Uses the git resource to clone the snowflake project locally and uses maven to package the project.
  * Creates a symlink between the cwd and "/usr/local/".
  * Creates an environment rc file for snowflake in "/etc/snowflakerc".

Attributes
----------

#### snowflake-nativex::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['snowflake-nativex']['snowflake_git_dependencies']</tt></td>
    <td>Array</td>
    <td>An array of hashes describing the dependencies and what to do with them.</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-nativex']['nativex_snowflake_project_name']</tt></td>
    <td>String</td>
    <td>The snowflake project name you want to use. i.e. folder_name</td>
    <td><tt>snowflake</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-nativex']['snowflake_git_repository_uri']</tt></td>
    <td>String</td>
    <td>The snowflake project uri on github.com.</td>
    <td><tt>git@github.com:nativex/snowflake.git</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-nativex']['snowflake_git_repository_branch']</tt></td>
    <td>String</td>
    <td>The snowflake branch you want cloned locally.</td>
    <td><tt>master</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-nativex']['snowflake_git_clone_depth']</tt></td>
    <td>Integer</td>
    <td>The depth you wish to clone the projects history locally.</td>
    <td><tt>1 or shallow clone</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-nativex']['ssh']['home']</tt></td>
    <td>String</td>
    <td>The location you want your github.com ssh_key stored.</td>
    <td><tt>/root/.ssh</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-nativex']['ssh']['user']</tt></td>
    <td>String</td>
    <td>The user you want to set as the owner of the github.com ssh_key.</td>
    <td><tt>root</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-nativex']['ssh']['group']</tt></td>
    <td>String</td>
    <td>The group you want to set as the owner of the github.com ssh_key.</td>
    <td><tt>root</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-nativex']['link']['destination_directory']</tt></td>
    <td>String</td>
    <td>The location you want to link the compiled snowflake project.</td>
    <td><tt>/usr/local</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-nativex']['snowflake_home']</tt></td>
    <td>String</td>
    <td>The snowflake environment you want added to your system path.</td>
    <td><tt>/usr/local/snowflake</tt></td>
  </tr>
  <tr>
</table>

Usage
-----
#### snowflake-nativex::default

Just include `snowflake-nativex` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[snowflake-nativex]"
  ]
}
```

License and Authors
-------------------
Authors: Adrian Herrera (<simplyadrian@gmail.com>)
