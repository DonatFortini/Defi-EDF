FROM python:3.9-slim

WORKDIR /app

# Copy the core directory from the root build context
COPY ../core /app/core

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
