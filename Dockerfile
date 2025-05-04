# Use an official Python runtime as a parent image
# We use Python 3.9 for better compatibility
FROM python:3.9-slim

 


# Create a non-root user for security
RUN useradd -m -u 1000 user
RUN chown -R user:user /app

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PORT=7860

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better cache usage
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Switch to non-root user
USER user

# Make port 7860 available
EXPOSE 7860

# Command to run the application
CMD ["chainlit", "run", "chatbot.py", "--host", "0.0.0.0", "--port", "7860"] 