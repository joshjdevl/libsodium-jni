gpg --import public.key
gpg --allow-secret-key-import --import private.key 

mvn versions:set

gradle build
gradle uploadArchives

mvn clean install -P release-sign-artifacts
mvn clean deploy  -P release-sign-artifacts

mvn scm:tag
