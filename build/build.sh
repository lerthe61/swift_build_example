#!/bin/sh

# Source Helper Functions
source "$(dirname "$0")/helpers.sh"

# Only install tools only if not installed
if [ -n has_command xcpretty ]; then
  heading "Installing Tools"  
  gem install xcpretty
fi

has_command rake || fail "rake must be installed"
has_command xcodebuild || fail "xcode must be installed"
has_command xcpretty || fail "xcpretty must be installed"

#
# Build in release mode
#
heading "Building"
set -o pipefail && rake build[release] | xcpretty || \
  fail "Release Build Failed"

#
# Run Tests
#
heading "Running Tests"

set -o pipefail && rake test | xcpretty || \
  fail "Test Run failed"