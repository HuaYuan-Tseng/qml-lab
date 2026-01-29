#!/bin/bash

set -e
echo "-- Generating sources.cmake..."

ROOT_DIR=$(pwd)
OUTPUT_FILE="$ROOT_DIR/cmake/sources.cmake"
[ -f "$OUTPUT_FILE" ] && rm -f "$OUTPUT_FILE"

# src/app

APP_DIR="$ROOT_DIR/src/app"
echo "set(APP_SOURCE" >> "$OUTPUT_FILE"
find "$APP_DIR" -type f -name "*.cpp" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  \${CMAKE_SOURCE_DIR}/$RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

echo "set(APP_QML" >> "$OUTPUT_FILE"
find "$APP_DIR" -type f -name "*.qml" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  \${CMAKE_SOURCE_DIR}/$RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

