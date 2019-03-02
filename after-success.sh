#!/bin/bash
set -euxo pipefail

. ./setenv.sh

which gradle
gradle --version

echo ${TEST_VAR}
gradle uploadArchives 
mvn deploy --settings settings.xml
