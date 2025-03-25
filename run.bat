#!/bin/bash

# Bersihkan build sebelumnya
echo "Cleaning the project..."
dotnet clean

# Build proyek
echo "Building the project..."
dotnet build

# Jalankan aplikasi
echo "Running the application..."
dotnet run