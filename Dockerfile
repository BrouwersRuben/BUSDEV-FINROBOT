# Use lightweight base image
FROM python:3.11-slim

# Prevents Python from writing .pyc files and buffering stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirement files first (better caching)
COPY requirements.txt .

# Install Python dependencies (app + Jupyter)
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir jupyterlab

# Copy source code
COPY . .

# Expose Jupyter port
EXPOSE 8888

# Start JupyterLab by default
# --ip=0.0.0.0 allows external connections
# --no-browser stops it from opening locally
# --allow-root is needed for running as root in containers
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
