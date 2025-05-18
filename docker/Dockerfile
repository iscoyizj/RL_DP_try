# Base image with CUDA 12.2
ARG CUDA_VERSION=12.2.2
ARG UBUNTU_VERSION=20.04
ARG CUDNN_VERSION=8 # Adjust if needed, check compatibility with Isaac Gym
FROM nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN_VERSION}-devel-ubuntu${UBUNTU_VERSION}

# Set environment variables to non-interactive (prevents some prompts)
ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3.8 and other common dependencies
RUN apt-get update && apt-get install -y \
    python3.8 python3.8-venv python3.8-dev python3-pip python3-setuptools \
    wget unzip git curl software-properties-common \
    libosmesa6-dev libgl1-mesa-glx libglfw3 patchelf cmake \
    && rm -rf /var/lib/apt/lists/*

# Make python3.8 the default python and pip
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1 && \
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

RUN python -m pip install --upgrade pip

# --- MuJoCo 210 Installation ---
# Manually download mujoco210-linux-x86_64.tar.gz and place it in the build context
COPY mujoco210-linux-x86_64.tar.gz /tmp/
RUN mkdir -p /opt/mujoco210 && \
    tar -xf /tmp/mujoco210-linux-x86_64.tar.gz -C /opt/mujoco210 && \
    rm /tmp/mujoco210-linux-x86_64.tar.gz

# Set MuJoCo environment variables
ENV MUJOCO_PY_MUJOCO_PATH=/opt/mujoco210
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/mujoco210/bin
ENV MUJOCO_GL=osmesa 

# Install mujoco (user changed from 2.1.2 to latest)
# RUN pip install mujoco-py==2.1.2.14 # Check compatibility with Isaac Gym and Python 3.8
# OR consider the newer `mujoco` package:
RUN pip install mujoco

# --- Isaac Gym Preview 4 Installation ---
# Manually download IsaacGym_Preview_4_Package.tar.gz and place it in the build context
COPY IsaacGym_Preview_4_Package.tar.gz /tmp/
RUN tar -xzf /tmp/IsaacGym_Preview_4_Package.tar.gz -C /opt && \
    rm /tmp/IsaacGym_Preview_4_Package.tar.gz

WORKDIR /opt/isaacgym/python

# Isaac Gym installation - it usually involves installing its Python packages
# It might have specific dependencies, review its docs.
# The following command is typical for Isaac Gym preview releases.
RUN pip install -e .

# Install other common RL/robotics libraries if needed
# RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 # Adjust for CUDA 12.2
# Isaac Gym often bundles a compatible PyTorch version, check its requirements.
# If Isaac Gym's setup installs PyTorch, you might not need the line above.

# Verify Isaac Gym installation (optional, might require a display or specific setup)
# RUN python -c "import isaacgym; print(isaacgym.__version__)"

# Set a working directory for your projects
WORKDIR /workspace

# Default command (optional)
CMD ["/bin/bash"]