# --- Stage 1: Build dependencies ---
FROM python:3.13-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip && pip install --user -r requirements.txt

# --- Stage 2: Final image ---
FROM python:3.13-slim

WORKDIR /app

# Copy only requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy source code (for production, but will be mounted in dev)
COPY src ./src

EXPOSE 8000

CMD ["uvicorn", "src.app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]