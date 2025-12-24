# AWS Services Monorepo

A monorepo containing Spring Boot microservices that demonstrate integration with various AWS services using LocalStack for local testing and development.

## Overview

This repository contains production-ready templates for AWS service integrations that can be copied and used with minimal configuration. Each service is designed with Domain-Driven Design (DDD) principles and comprehensive testing using LocalStack.

## Project Goals

- **Testability**: All AWS services are tested locally using LocalStack
- **Code Coverage**: Target 80% line coverage and 60% branch coverage
- **Architecture**: Domain-Driven Design (DDD) principles
- **Reusability**: Copy-paste ready with minimal configuration needed

## Quick Start

### Creating a New Project

Use the included bash script to automatically generate a new project from the template:

```bash
./create-project.sh <project-name>
```

**Example:**
```bash
./create-project.sh user-service
```

This will:
- Create a new directory with your project name
- Copy all template files
- Update package names and class references
- Generate a customized README with build/run instructions
- Clean up build artifacts

### Manual Setup

If you prefer to copy a project manually:

1. Copy the desired project directory
2. Update `settings.gradle` with your project name
3. Update package names in `build.gradle` and source files
4. Update the README.md with your project-specific information

## Testing with LocalStack

All projects in this monorepo use LocalStack for testing AWS services locally. This provides:
- Fast, local development without AWS costs
- Consistent test environments
- Integration tests that run in CI/CD pipelines

## Code Quality Standards

### Testing Coverage
- **Line Coverage**: Minimum 80%
- **Branch Coverage**: Minimum 60%

### Architecture
Projects follow Domain-Driven Design principles:
- Clear domain model separation
- Repository pattern for data access
- Service layer for business logic
- Clean separation of concerns

## Prerequisites

- Java 21 or higher
- Gradle 9.x (wrapper included in each project)
- Docker (for LocalStack)

## Available Services

Check individual project directories for AWS service-specific implementations.
