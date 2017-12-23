#!/bin/bash -ev

echo ${TEST_VAR}
gradle uploadArchives -Psigning.password=${GPG_PASSPHRASE}
mvn deploy --settings settings.xml
