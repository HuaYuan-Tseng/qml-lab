#!/bin/bash

set -e
echo "-- Generating sources.cmake..."

ROOT_DIR=$(pwd)
OUTPUT_FILE="$ROOT_DIR/cmake/sources.cmake"
[ -f "$OUTPUT_FILE" ] && rm -f "$OUTPUT_FILE"

# src/hello-qml

HELLO_QML_DIR="$ROOT_DIR/src/hello-qml"
echo "set(HELLO_QML_SOURCE" >> "$OUTPUT_FILE"
find "$HELLO_QML_DIR" -type f -name "*.cpp" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  \${CMAKE_SOURCE_DIR}/$RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

echo "set(HELLO_QML_QML" >> "$OUTPUT_FILE"
find "$HELLO_QML_DIR" -type f -name "*.qml" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  $RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

# src/signal-lsot

SIGNAL_SLOT_DIR="$ROOT_DIR/src/signal-slot"
echo "set(SIGNAL_SLOT_SOURCE" >> "$OUTPUT_FILE"
find "$SIGNAL_SLOT_DIR" -type f -name "*.cpp" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  \${CMAKE_SOURCE_DIR}/$RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

echo "set(SIGNAL_SLOT_QML" >> "$OUTPUT_FILE"
find "$SIGNAL_SLOT_DIR" -type f -name "*.qml" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  $RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

# src/qobject-tree

QOBJECT_TREE_DIR="$ROOT_DIR/src/qobject-tree"
echo "set(QOBJECT_TREE_SOURCE" >> "$OUTPUT_FILE"
find "$QOBJECT_TREE_DIR" -type f -name "*.cpp" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  \${CMAKE_SOURCE_DIR}/$RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

echo "set(QOBJECT_TREE_QML" >> "$OUTPUT_FILE"
find "$QOBJECT_TREE_DIR" -type f -name "*.qml" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  $RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"
#
# src/intro-quick

INTRO_QUICK_DIR="$ROOT_DIR/src/intro-quick"
echo "set(INTRO_QUICK_SOURCE" >> "$OUTPUT_FILE"
find "$INTRO_QUICK_DIR" -type f -name "*.cpp" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  \${CMAKE_SOURCE_DIR}/$RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

echo "set(INTRO_QUICK_QML" >> "$OUTPUT_FILE"
find "$INTRO_QUICK_DIR" -type f -name "*.qml" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  $RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

