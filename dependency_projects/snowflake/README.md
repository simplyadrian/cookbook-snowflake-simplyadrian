snowflake
=========

Fixes/Workarounds for [twitter/snowflake] (https://github.com/twitter/snowflake) .

Instructions
=========
1. Install a [JDK] (http://www.oracle.com/technetwork/java/javase/downloads/index.html) and [Apache Maven] (http://maven.apache.org/download.html)
2. Clone [simplyadrian/twitter-scala-parent-overrides] (https://github.com/simplyadrian/twitter-scala-parent-overrides) and run this in that project's directory:

        mvn clean install
3. Clone [simplyadrian/apache-scribe-client-overrides] (https://github.com/simplyadrian/apache-scribe-client-overrides) and run this in that project's directory:

        mvn clean install
4. Clone this repo and run this command in the project directory:

        mvn clean package
5. Receive ~~[bacon] (http://foodcourtlunch.com/wp-content/uploads/2010/08/push-button-receive-bacon.png)~~:

        target/
            snowflake...zip
            libs/
        src/
            scripts/
        config/
            