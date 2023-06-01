FROM python:3.8.10

# Set working directory
WORKDIR /app

# Copy requirements.txt untuk menginstal dependencies
COPY requirements.txt .

# Menginstal dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy file main.py ke dalam container
COPY main.py .

# Copy file model.h5 ke dalam container
COPY model.h5 .

# Copy file artikel.json ke dalam container
COPY artikel.json .

# Copy file tempat.json ke dalam container
COPY tempat.json .

# Menjalankan aplikasi FastAPI pada port 8080
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
