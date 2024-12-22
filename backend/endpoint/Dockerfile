FROM python:3.12-bookworm
WORKDIR /app

# dépendances système
RUN apt-get update \
    && apt-get install -y \
    libpq-dev \
    gcc \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

COPY ./backend/core /app/core
COPY ./backend/endpoint/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY ./backend/endpoint /app/endpoint
WORKDIR /app/endpoint

EXPOSE 5000
CMD ["python", "app.py"]
