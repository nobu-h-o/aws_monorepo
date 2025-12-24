#!/bin/bash

# Script to create a new project from the template
# Usage: ./create-project.sh <project-name>

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if project name is provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: Project name is required${NC}"
    echo "Usage: ./create-project.sh <project-name>"
    exit 1
fi

PROJECT_NAME=$1
PROJECT_NAME_LOWER=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]')
PROJECT_NAME_CAPITALIZED=$(echo "$PROJECT_NAME" | sed 's/\b\(.\)/\u\1/g')

# Validate project name (alphanumeric and hyphens only)
if [[ ! "$PROJECT_NAME" =~ ^[a-zA-Z0-9-]+$ ]]; then
    echo -e "${RED}Error: Project name can only contain letters, numbers, and hyphens${NC}"
    exit 1
fi

# Check if directory already exists
if [ -d "$PROJECT_NAME" ]; then
    echo -e "${RED}Error: Directory '$PROJECT_NAME' already exists${NC}"
    exit 1
fi

# Check if template directory exists
if [ ! -d "template" ]; then
    echo -e "${RED}Error: Template directory not found${NC}"
    exit 1
fi

echo -e "${GREEN}Creating new project: $PROJECT_NAME${NC}"

# Copy template directory
echo "Copying template files..."
cp -r template "$PROJECT_NAME"

# Remove template-specific build artifacts and IDE files
echo "Cleaning build artifacts..."
rm -rf "$PROJECT_NAME/.gradle"
rm -rf "$PROJECT_NAME/build"
rm -rf "$PROJECT_NAME/.idea"

# Process README.md
echo "Generating README.md..."
sed -i.bak "s/{{PROJECT_NAME}}/$PROJECT_NAME_CAPITALIZED/g" "$PROJECT_NAME/README.md"
sed -i.bak "s/{{PROJECT_NAME_LOWER}}/$PROJECT_NAME_LOWER/g" "$PROJECT_NAME/README.md"
rm "$PROJECT_NAME/README.md.bak"

# Update settings.gradle
echo "Updating settings.gradle..."
sed -i.bak "s/rootProject.name = 'template'/rootProject.name = '$PROJECT_NAME_LOWER'/g" "$PROJECT_NAME/settings.gradle"
rm "$PROJECT_NAME/settings.gradle.bak"

# Update build.gradle
echo "Updating build.gradle..."
sed -i.bak "s/description = 'template'/description = '$PROJECT_NAME'/g" "$PROJECT_NAME/build.gradle"
rm "$PROJECT_NAME/build.gradle.bak"

# Rename package directories
echo "Renaming package directories..."
if [ -d "$PROJECT_NAME/src/main/java/com/nobuho/template" ]; then
    mv "$PROJECT_NAME/src/main/java/com/nobuho/template" "$PROJECT_NAME/src/main/java/com/nobuho/$PROJECT_NAME_LOWER"
fi

if [ -d "$PROJECT_NAME/src/test/java/com/nobuho/template" ]; then
    mv "$PROJECT_NAME/src/test/java/com/nobuho/template" "$PROJECT_NAME/src/test/java/com/nobuho/$PROJECT_NAME_LOWER"
fi

# Rename Java class files
echo "Renaming Java classes..."
if [ -f "$PROJECT_NAME/src/main/java/com/nobuho/$PROJECT_NAME_LOWER/TemplateApplication.java" ]; then
    mv "$PROJECT_NAME/src/main/java/com/nobuho/$PROJECT_NAME_LOWER/TemplateApplication.java" \
       "$PROJECT_NAME/src/main/java/com/nobuho/$PROJECT_NAME_LOWER/${PROJECT_NAME_CAPITALIZED}Application.java"
fi

if [ -f "$PROJECT_NAME/src/test/java/com/nobuho/$PROJECT_NAME_LOWER/TestTemplateApplication.java" ]; then
    mv "$PROJECT_NAME/src/test/java/com/nobuho/$PROJECT_NAME_LOWER/TestTemplateApplication.java" \
       "$PROJECT_NAME/src/test/java/com/nobuho/$PROJECT_NAME_LOWER/Test${PROJECT_NAME_CAPITALIZED}Application.java"
fi

if [ -f "$PROJECT_NAME/src/test/java/com/nobuho/$PROJECT_NAME_LOWER/TemplateApplicationTests.java" ]; then
    mv "$PROJECT_NAME/src/test/java/com/nobuho/$PROJECT_NAME_LOWER/TemplateApplicationTests.java" \
       "$PROJECT_NAME/src/test/java/com/nobuho/$PROJECT_NAME_LOWER/${PROJECT_NAME_CAPITALIZED}ApplicationTests.java"
fi

# Update package names and class references in all Java files
echo "Updating package names and class references..."
find "$PROJECT_NAME/src" -type f -name "*.java" -exec sed -i.bak \
    -e "s/package com\.nobuho\.template/package com.nobuho.$PROJECT_NAME_LOWER/g" \
    -e "s/import com\.nobuho\.template/import com.nobuho.$PROJECT_NAME_LOWER/g" \
    -e "s/TemplateApplication/${PROJECT_NAME_CAPITALIZED}Application/g" \
    {} \;

# Remove backup files
find "$PROJECT_NAME/src" -type f -name "*.bak" -delete

# Remove HELP.md if it exists (Spring Initializr generated file)
if [ -f "$PROJECT_NAME/HELP.md" ]; then
    rm "$PROJECT_NAME/HELP.md"
fi

echo -e "${GREEN}✓ Project '$PROJECT_NAME' created successfully!${NC}"
echo ""
echo "Next steps:"
echo "  1. cd $PROJECT_NAME"
echo "  2. ./gradlew build"
echo "  3. ./gradlew bootRun"
echo ""
