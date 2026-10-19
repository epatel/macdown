#!/bin/sh
# Build MacDown (Debug, arm64 only, ad-hoc signed).
# Output: build/DerivedData/Build/Products/Debug/MacDown.app
set -e

cd "$(dirname "$0")"

git submodule update --init
pod install
make -C Dependency/peg-markdown-highlight

xcodebuild \
    -workspace MacDown.xcworkspace \
    -scheme MacDown \
    -configuration Debug \
    -derivedDataPath build/DerivedData \
    CODE_SIGN_IDENTITY=- \
    MACOSX_DEPLOYMENT_TARGET=10.13 \
    ARCHS=arm64 \
    ONLY_ACTIVE_ARCH=NO \
    build

echo "Built: build/DerivedData/Build/Products/Debug/MacDown.app"
