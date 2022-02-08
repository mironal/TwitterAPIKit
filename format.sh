#!/usr/bin/env bash
swift run --skip-build -c release --package-path BuildTools swift-format -p --recursive ./Sources ./Tests ./scripts --in-place