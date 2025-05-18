#!/bin/zsh

##################### Paths #####################

# Set default paths
DEFAULT_DATA_DIR="${PWD}/data"
DEFAULT_LOG_DIR="${PWD}/log"
# Prompt the user for input, allowing overrides
# read "DATA_DIR?Enter the desired data directory [default: ${DEFAULT_DATA_DIR}], leave empty to use default: "
DPPO_DATA_DIR=${DATA_DIR:-$DEFAULT_DATA_DIR}  # Use user input or default if input is empty

# read "LOG_DIR?Enter the desired logging directory [default: ${DEFAULT_LOG_DIR}], leave empty to use default: "
DPPO_LOG_DIR=${LOG_DIR:-$DEFAULT_LOG_DIR}  # Use user input or default if input is empty

# Export to current session
export DPPO_DATA_DIR="$DPPO_DATA_DIR"
export DPPO_LOG_DIR="$DPPO_LOG_DIR"

# Confirm the paths with the user
echo "Data directory set to: $DPPO_DATA_DIR"
echo "Log directory set to: $DPPO_LOG_DIR"

# Append environment variables to .zshrc
echo "export DPPO_DATA_DIR=\"$DPPO_DATA_DIR\"" >> ~/.zshrc
echo "export DPPO_LOG_DIR=\"$DPPO_LOG_DIR\"" >> ~/.zshrc

echo "Environment variables DPPO_DATA_DIR and DPPO_LOG_DIR added to .zshrc and applied to the current session."

##################### WandB #####################

DEFAULT_WANDB_ENTITY_SCRIPT="far-wandb" # Renamed to avoid conflict with potential ENV var

# Use environment variable ENTITY if it exists, otherwise use script's default
TARGET_DPPO_WANDB_ENTITY="${ENTITY:-$DEFAULT_WANDB_ENTITY_SCRIPT}"

if [ -n "$TARGET_DPPO_WANDB_ENTITY" ]; then
  export DPPO_WANDB_ENTITY="$TARGET_DPPO_WANDB_ENTITY"
  echo "WandB entity set to: $DPPO_WANDB_ENTITY"
  echo "export DPPO_WANDB_ENTITY=\"$DPPO_WANDB_ENTITY\"" >> ~/.zshrc
  echo "Environment variable DPPO_WANDB_ENTITY added to .zshrc and applied to the current session."
else
  echo "DPPO_WANDB_ENTITY is not set. Consider setting the ENTITY environment variable or updating script defaults."
  echo "Please set wandb=null when running scripts to disable wandb logging and avoid error."
fi

# Source .zshrc to make variables available immediately
source ~/.zshrc
