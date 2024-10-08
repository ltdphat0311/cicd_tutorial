FROM ubuntu:latest

# Maintainer information
LABEL maintainer="Tuan Thau 'tuanthai@example.com'"

# Install system dependencies
RUN apt-get update -y && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /flask_app

# Copy requirements file first to leverage caching
COPY requirements.txt .

# Create a virtual environment and install dependencies
RUN python3 -m venv venv && \
    ./venv/bin/pip install --upgrade pip && \
    ./venv/bin/pip install -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port your app runs on (adjust as necessary)
EXPOSE 5000

# Command to run your application
ENTRYPOINT ["./venv/bin/python"]
CMD ["flask_docker.py"]
