# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy repo contents
COPY . /app

# Install dependencies
RUN pip install --upgrade pip && \
    pip install -e . && \
    pip install jupyter

# Expose Jupyter port
EXPOSE 8888

# Start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
