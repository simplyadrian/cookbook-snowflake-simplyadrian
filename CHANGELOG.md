snowflake-nativex CHANGELOG
===========================

This file is used to list changes made in each version of the snowflake-nativex cookbook.

0.1.0
-----
- [Adrian Herrera] - Initial release of snowflake-nativex
	- sets up Maven
	- sets up git for cloning snowflake project and dependencies locally
	- clones the snowflake project and dependencies locally and compiles and installs them.
	- links the compiled snowflake project to /usr/local/
	- creates a snowflakerc file to export the snowflake home directory.

0.2.0
-----
-[Adrian Herrera]
   - adds support for install from source and archive.
   - adds dynamic datacenter and worker id configuration for snowflake project.
   - adds init.d script for stop, start and restart support of application.
   - adds registration with ELB support.


- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
