#!/usr/bin/env bash
swift run --skip-build -c release --package-path BuildTools swift-format lint -p --strict --recursive ./Sources ./Tests ./scripts