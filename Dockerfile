# Specify the Python version from pyproject.toml (e.g., 3.9)
# Using a specific version is generally better for reproducibility
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies if any (e.g., for Isaac Gym or other libraries)
# RUN apt-get update && apt-get install -y <your-system-dependencies>

# Copy the pyproject.toml and install Python dependencies
# If you have a poetry.lock or requirements.txt, adjust accordingly
COPY pyproject.toml ./
RUN pip install --no-cache-dir .  # This will install dependencies listed in pyproject.toml

# If you have optional dependencies you need for a specific run, install them:
# For example, if you need the 'furniture' optional dependencies:
# RUN pip install --no-cache-dir ".[furniture]"

# Copy the rest of your application code into the container
COPY . .

# Command to run your application
# This might need adjustment based on how you pass Hydra configurations
# ENTRYPOINT ["python", "script/run.py"]
# CMD ["key=value"] # Example: pass hydra config overrides here

# If you need to ensure output is unbuffered (already handled in your script/run.py)
# ENV PYTHONUNBUFFERED=1 