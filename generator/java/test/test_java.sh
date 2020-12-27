#!/bin/bash
####################################################################
# /file test_java
# Build and run simple tests for the mavlink Java implementation.
# Tests mavlink v1.0 and v2.0
####################################################################

# exit on any error
set -e

RED='\033[1;31m'
GRN='\033[1;32m'
NC='\033[0m' # No Color

# Verbosity levels: 0 means low; 1 means some; 2 means high verbosity
VERBOSITY='0'
OUT0="/dev/stdout"
OUT1="/dev/null"
OUT2="/dev/null"

if [ "$VERBOSITY" = "1" ]; then
OUT1="/dev/stdout"
fi
if [ "$VERBOSITY" = "2" ]; then
OUT1="/dev/stdout"
OUT2="/dev/stdout"
fi

# set MDEF to a default if not already set
test -z "$MDEF" && MDEF="../../../../message_definitions"

# first generate v1 and v2 files
printf "${RED}Generate Mavlink v1 and v2 Java implementations${NC}\n"
mavgen.py --lang='Java' --output=/tmp/mavgen_test/java_v1 $MDEF/v1.0/common.xml --wire-protocol=1.0 --strict-units > $OUT2
mavgen.py --lang='Java' --output=/tmp/mavgen_test/java_v2 $MDEF/v1.0/common.xml --wire-protocol=2.0 --strict-units > $OUT2

# Compile v1 and v2 to verify no errors/warnings
printf "${RED}Compile Mavlink v1 and v2 Java implementations${NC}\n"

pushd /tmp/mavgen_test/java_v1 > $OUT2
mkdir -p build/
find . -name "*.java" -print | xargs javac -Werror -d build/
popd > $OUT2

pushd /tmp/mavgen_test/java_v2 > $OUT2
mkdir -p build/
find . -name "*.java" -print | xargs javac -Werror -d build/
popd > $OUT2
