#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <feature-name>"
    exit 1
fi

FEATURE_NAME=$1
FEATURE_DIR="lib/features/$FEATURE_NAME"

if [ -d "$FEATURE_DIR" ]; then
    echo "Feature '$FEATURE_NAME' already exists."
    exit 1
fi

mkdir -p "$FEATURE_DIR/data/data_sources" "$FEATURE_DIR/data/models" "$FEATURE_DIR/data/repositories"
mkdir -p "$FEATURE_DIR/domain/entities" "$FEATURE_DIR/domain/repositories" "$FEATURE_DIR/domain/usescases"
mkdir -p "$FEATURE_DIR/presentation/bloc" "$FEATURE_DIR/presentation/page" "$FEATURE_DIR/presentation/widgets"

echo "Feature '$FEATURE_NAME' created successfully."
