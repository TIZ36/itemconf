#!/bin/bash

# Display help message
function show_help {
  echo "Usage: ./update.sh [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  -d, --dir DIR       Working directory (default: current directory)"
  echo "  -o, --old VER       Old Dify version (if not specified, assumes new deployment)"
  echo "  -n, --new VER       New Dify version (required)"
  echo "  -h, --help          Show this help message"
  echo ""
  echo "Example:"
  echo "  ./update.sh -n 1.0.0                   # New deployment with version 1.0.0"
  echo "  ./update.sh -o 0.10.2 -n 1.0.0         # Update from 0.10.2 to 1.0.0"
  echo "  ./update.sh -d ~/dify -o 0.10.2 -n 1.0.0  # Update with specific directory"
}

# Default values
DIFY_DIR=$(pwd)
OLD_VERSION=""
NEW_VERSION=""
IS_NEW_DEPLOYMENT=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -d|--dir)
      DIFY_DIR="$2"
      shift 2
      ;;
    -o|--old)
      OLD_VERSION="$2"
      shift 2
      ;;
    -n|--new)
      NEW_VERSION="$2"
      shift 2
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      echo "Error: Unknown option $1"
      show_help
      exit 1
      ;;
  esac
done

# Validate new version parameter
if [[ -z "$NEW_VERSION" ]]; then
  echo "Error: New version is required"
  show_help
  exit 1
fi

# Check if it's a new deployment
if [[ -z "$OLD_VERSION" ]]; then
  IS_NEW_DEPLOYMENT=true
  echo "No old version specified. Assuming this is a new deployment."
  read -p "Is this a new Dify deployment? (y/n): " CONFIRM
  if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo "Please specify the old version using -o or --old option."
    exit 1
  fi
fi

echo "========== Dify Update Process =========="
echo "Working directory: $DIFY_DIR"
if [[ "$IS_NEW_DEPLOYMENT" == true ]]; then
  echo "Operation: New deployment"
else
  echo "Operation: Update from $OLD_VERSION to $NEW_VERSION"
fi
echo "New version: $NEW_VERSION"
echo "========================================"

# Step 1: Download new version
echo -e "\n[Step 1/$(if [[ "$IS_NEW_DEPLOYMENT" == true ]]; then echo "3"; else echo "5"; fi)] Downloading Dify version $NEW_VERSION..."
./download_ver.sh "$DIFY_DIR" "$NEW_VERSION"
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to download Dify version $NEW_VERSION"
  exit 1
fi

# Step 2: Pull Docker images for new version
echo -e "\n[Step 2/$(if [[ "$IS_NEW_DEPLOYMENT" == true ]]; then echo "3"; else echo "5"; fi)] Pulling Docker images for Dify version $NEW_VERSION..."
./pull_image.sh "$DIFY_DIR" "$NEW_VERSION"
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to pull Docker images for Dify version $NEW_VERSION"
  exit 1
fi

# If this is an update (not a new deployment), perform stop and transfer
if [[ "$IS_NEW_DEPLOYMENT" == false ]]; then
  # Step 3: Stop current Dify instance and transfer volumes
  echo -e "\n[Step 3/5] Stopping current Dify instance and transferring volumes..."
  ./stop_and_transvolume.sh "$OLD_VERSION" "$NEW_VERSION"
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to stop Dify and transfer volumes"
    exit 1
  fi
fi

# Step 3/4: Set new version as current
if [[ "$IS_NEW_DEPLOYMENT" == true ]]; then
  echo -e "\n[Step 3/3] Setting Dify version $NEW_VERSION as current..."
else
  echo -e "\n[Step 4/5] Setting Dify version $NEW_VERSION as current..."
fi
./set_current.sh "$NEW_VERSION"
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to set Dify version $NEW_VERSION as current"
  exit 1
fi

# Step 5: Start new Dify instance (only for updates or if user wants to start immediately)
if [[ "$IS_NEW_DEPLOYMENT" == false ]]; then
  echo -e "\n[Step 5/5] Starting Dify version $NEW_VERSION..."
  ./start.sh
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to start Dify version $NEW_VERSION"
    exit 1
  fi
  
  echo -e "\n✅ Dify has been successfully updated from version $OLD_VERSION to $NEW_VERSION"
else
  read -p "Do you want to start the new Dify instance now? (y/n): " START_NOW
  if [[ "$START_NOW" == "y" || "$START_NOW" == "Y" ]]; then
    echo -e "\nStarting Dify version $NEW_VERSION..."
    ./start.sh
    if [[ $? -ne 0 ]]; then
      echo "Error: Failed to start Dify version $NEW_VERSION"
      exit 1
    fi
  else
    echo -e "\n✅ Dify $NEW_VERSION has been successfully deployed but not started."
    echo "You can start it later by running ./start.sh"
  fi
fi

echo "You can check the status by running ./status.sh"
