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

# src/pos-layout

POS_LAYOUT_DIR="$ROOT_DIR/src/pos-layout"
echo "set(POS_LAYOUT_SOURCE" >> "$OUTPUT_FILE"
find "$POS_LAYOUT_DIR" -type f -name "*.cpp" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  \${CMAKE_SOURCE_DIR}/$RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

echo "set(POS_LAYOUT_QML" >> "$OUTPUT_FILE"
find "$POS_LAYOUT_DIR" -type f -name "*.qml" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  $RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

# src/custom-qml

CUSTOM_QML_DIR="$ROOT_DIR/src/custom-qml"
echo "set(CUSTOM_QML_SOURCE" >> "$OUTPUT_FILE"
find "$CUSTOM_QML_DIR" -type f -name "*.cpp" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  \${CMAKE_SOURCE_DIR}/$RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

echo "set(CUSTOM_QML_QML" >> "$OUTPUT_FILE"
find "$CUSTOM_QML_DIR" -type f -name "*.qml" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  $RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

# src/song-player

SONG_PLAYER_DIR="$ROOT_DIR/src/song-player"
echo "set(SONG_PLAYER_SOURCE" >> "$OUTPUT_FILE"
find "$SONG_PLAYER_DIR" -type f -name "*.cpp" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    if [[ ! "$RELATIVE_PATH" =~ audio_info\. ]]; then
        echo "  \${CMAKE_SOURCE_DIR}/$RELATIVE_PATH" >> "$OUTPUT_FILE"
    fi
done
echo ")" >> "$OUTPUT_FILE"

echo "set(SONG_PLAYER_QML_CPP_SOURCE" >> "$OUTPUT_FILE"
find "$SONG_PLAYER_DIR" -type f \( -name "audio_info.cpp" -o -name "audio_info.h" \) 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  \${CMAKE_SOURCE_DIR}/$RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

echo "set(SONG_PLAYER_QML" >> "$OUTPUT_FILE"
find "$SONG_PLAYER_DIR" -type f -name "*.qml" 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  $RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

echo "set(SONG_PLAYER_RESOURCE" >> "$OUTPUT_FILE"
find "$SONG_PLAYER_DIR" -type f \( -name "*.ico" -o -name "*.png" -o -name "*.jpg" -o -name "*.avi" -o -name "*.mp3" \) 2>/dev/null | sort | while IFS= read -r FILE_PATH; do
    RELATIVE_PATH="${FILE_PATH#$ROOT_DIR/}"
    RELATIVE_PATH="${RELATIVE_PATH//\\//}"
    echo "  $RELATIVE_PATH" >> "$OUTPUT_FILE"
done
echo ")" >> "$OUTPUT_FILE"

