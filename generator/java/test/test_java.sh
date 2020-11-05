#!/bin/bash
##################################
# /file test_java
# Build and run simple tests for
# the java-generated mavlink. Meant
# to be run by CI
##################################

# exit on any error
set -e

# first generate V1 and V2 files. Compile both to verify no compilation errors
mavgen.py --lang='Java' --output=/tmp/mavgen_test/java1 mavlink/message_definitions/v1.0/common.xml --wire-protocol=1.0 --strict-units
mavgen.py --lang='Java' --output=/tmp/mavgen_test/java2 mavlink/message_definitions/v1.0/common.xml --wire-protocol=2.0 --strict-units

pushd /tmp/mavgen_test/java1
find . -name "*.java" -print | xargs javac
popd

pushd /tmp/mavgen_test/java2
find . -name "*.java" -print | xargs javac
popd
