snowflake-simplyadrian Cookbook
==========================
This cookbook does the install and configuration of the simplyadrian::snowflake project according to the README located here: https://github.com/simplyadrian/snowflake

Requirements
------------

#### packages
- `java JDK` - Snowflake-simplyadrian needs a JDK to complete the build of the project.
- `Maven` - Snowflake-simplyadrian needs mvn in the system path to build the snowflake project.
- `Git` - Snowflake-simplyadrian needs the git resource to download the snowflake project and its dependencies locally for the build process.
- `Ark` - This cookbook uses ark to download, unpack and add a archive to the system.
- `AWS` - This cookbook needs the AWS cookbook to register a node with a ELB.

#### data_bags
This cookbook requires the data bag "ids" exists. The cookbook will create it and add the initial content if it is not created manually.

* Chef 11 or higher

#### Supported OS Distributions
Tested on:

* CentOS 6.5 x86_64 HVM minimal

Recipes
----------
The provided recipes are:

* `snowflake-simplyadrian::default`: 
  * The main recipe that coordinates the cookbooks run_list.

* `snowflake-simplyadrian::set_datacenterid_and_workerid`:
  * Checks for the required 'ids' data bag and creates it if it doesn't exist.
  * Opens the data bag for operation:
    * If the datacenter_id is equal to or greater than 31 it will reset the contents to 0.
    * If the worker_id is equal to or greater than 31 it will increment the datacenter_id by 1 and reset the worker_id to 0.
    * Otherwise it will just increment the worker_id by 1.

* `snowflake-simplyadrian::install`:
  * Checks the 'install_method' attribute and will install by `source` or by `s3 archive`.

* `snowflake-simplyadrian::snowflake_from_archive`:
  * Utilizes ark to download the snowflake project from an s3 bucket
  * Unpacks the tarballs.
  * Adds them to the system path.

* `snowflake-simplyadrian::snowflake_from_source`:
  * Moves github.com:simplyadrian's chef user private key into place for authentication.
  * Creates the git_wrapper.sh script to help the git resource authenticate against github.com.
  * Uses the git resource to clone the snowflake depenencies locally and install them with maven.
  * Uses the git resource to clone the snowflake project locally and uses maven to package the project.

* `snowflake-simplyadrian::configure`:
  * Creates a symlink between the cwd and "/usr/local/".
  * Sets up the init.d script for snowflake to support start, stop and restart of the snowflake java process.
  * Creates and populates the config.scala file for the snowflake project.
  * Enables the snowflake init.d script.
  * Sets a node attribute for idempotence.

* `snowflake-simplyadrian::add_to_elb`:
  * Adds the newly bootstraped node to the previously deployed ELB.

Attributes
----------

#### snowflake-simplyadrian::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['application_name']</tt></td>
    <td>String</td>
    <td>The snowflake project name you want to use. i.e. folder_name</td>
    <td><tt>snowflake</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['archive']</tt></td>
    <td>Array</td>
    <td>An array of hashes describing the dependencies and there location on s3.</td>
    <td><tt>[{:name => 'twitter-scala-parent-overrides',
              :url => 'https://s3-us-west-2.amazonaws.com/archive-code-simplyadrian/twitter-scala-parent-overrides.tgz'},
              {:name => 'apache-scribe-client-overrides',
              :url => 'https://s3-us-west-2.amazonaws.com/archive-code-simplyadrian/apache-scribe-client-overrides.tgz'},
            {:name => 'snowflake',
              :url => 'https://s3-us-west-2.amazonaws.com/archive-code-simplyadrian/snowflake.tgz'}]</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['install_method']</tt></td>
    <td>String</td>
    <td>This attribute supports `archive` and `source` which then calls the appropriate install recipe.</td>
    <td><tt>archive</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['snowflake_home']</tt></td>
    <td>String</td>
    <td>The snowflake environment you want added to your system path.</td>
    <td><tt>/usr/local/snowflake</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['snowflake_log']</tt></td>
    <td>String</td>
    <td>The file name of where you want snowflake to write its logs.</td>
    <td><tt>snowflake.log</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['elb']['name']</tt></td>
    <td>String</td>
    <td>The name of the ELB you will be registering your snowflake too for load balancing.</td>
    <td><tt>DAW1AL-flakeELB</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['link']['destination_directory']</tt></td>
    <td>String</td>
    <td>The location you want to link the compiled snowflake project.</td>
    <td><tt>/usr/local</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['zookeeper']['host_list']</tt></td>
    <td>String</td>
    <td>Zookeeper hosts lists ** currently hardcoded with zookeeper hostnames until zookeeper cookbook development is complete.</td>
    <td><tt>pchdvl-zookpr01.teamfreeze.com,pchdvl-zookpr02.teamfreeze.com,pchdvl-zookpr03.teamfreeze.com</tt></td>
  </tr>
</table>

#### snowflake-simplyadrian::git
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['snowflake_git_dependencies']</tt></td>
    <td>Array</td>
    <td>An array of hashes describing the dependencies and what to do with them.</td>
    <td><tt>[{:name => 'twitter-scala-parent-overrides',
              :uri => 'git@github.com:simplyadrian/twitter-scala-parent-overrides.git',
              :branch => 'master',
              :depth => 1},
            {:name => 'apache-scribe-client-overrides',
              :uri => 'git@github.com:simplyadrian/apache-scribe-client-overrides.git',
              :branch => 'master',
              :depth => 1}]</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['snowflake_git_repository_uri']</tt></td>
    <td>String</td>
    <td>The snowflake project uri on github.com.</td>
    <td><tt>git@github.com:simplyadrian/snowflake.git</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['snowflake_git_repository_branch']</tt></td>
    <td>String</td>
    <td>The snowflake branch you want cloned locally.</td>
    <td><tt>master</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['snowflake_git_clone_depth']</tt></td>
    <td>Integer</td>
    <td>The depth you wish to clone the projects history locally.</td>
    <td><tt>1 or shallow clone</tt></td>
  </tr>
</table>

#### snowflake-simplyadrian::java
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['java']['main_jar']</tt></td>
    <td>String</td>
    <td>The snowflake project main jar file.</td>
    <td><tt>snowflake-1.0.1-SNAPSHOT.jar</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['java']['main_class']</tt></td>
    <td>String</td>
    <td>The snowflake class search path of directories and zip/jar files.</td>
    <td><tt>com.twitter.service.snowflake.SnowflakeServer</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['java']['heap_opts']</tt></td>
    <td>String</td>
    <td>Java heap options for the snowflake application.</td>
    <td><tt>-Xmx700m -Xms700m -Xmn500m</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['java']['jmx_opts']</tt></td>
    <td>String</td>
    <td>Java JMX optiosn for the snowflake application.</td>
    <td><tt>-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['java']['gc_opts']</tt></td>
    <td>String</td>
    <td>Java garbage collection settings for the snowflake application.</td>
    <td><tt>-XX:+UseConcMarkSweepGC -verbosegc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseParNewGC -Xloggc:/var/log/snowflake_gc.log</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['java']['debug_opts']</tt></td>
    <td>String</td>
    <td>Java debug options for the snow application.</td>
    <td><tt>-XX:ErrorFile=/var/log/$APP_NAME_java_error%p.log</tt></td>
  </tr>
  <tr>
    <td><tt>['snowflake-simplyadrian']['java']['java_opts']</tt></td>
    <td>String</td>
    <td>The complete Java options being passed to the snowflake application.</td>
    <td><tt>-server $GC_OPTS $JMX_OPTS $HEAP_OPTS $DEBUG_OPTS</tt></td>
  </tr>
</table>

#### snowflake-simplyadrian::maven
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['maven']['version']</tt></td>
    <td>String</td>
    <td>Maven version.</td>
    <td><tt>3</tt></td>
  </tr>
  <tr>
    <td><tt>['maven']['setup_bin']</tt></td>
    <td>boolean</td>
    <td>Adds maven to system path if true.</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['maven']['install_java']</tt></td>
    <td>boolean</td>
    <td>Installs java using the community cookbook if true.</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### snowflake-simplyadrian::default

Just include `snowflake-simplyadrian` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[snowflake-simplyadrian]"
  ]
}
```

License and Authors
-------------------
Authors: Adrian Herrera (<simplyadrian@gmail.com>)
