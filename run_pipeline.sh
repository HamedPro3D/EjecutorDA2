#!/bin/bash

# Configuración
REPO_URL="https://github.com/usuario/repositorio-original.git"
REPO_NAME="repositorio-original"
RESULTS_FILE="results.txt"

# Iniciar servicio Docker dentro del contenedor principal
service docker start

# Clonar el repositorio original
echo "Clonando repositorio..."
git clone $REPO_URL
cd $REPO_NAME

# Crear archivo de resultados
echo "Tiempo de ejecución de cada lenguaje:" > ../$RESULTS_FILE

# Iterar sobre los lenguajes y ejecutar cada programa en su contenedor
for lang in C++ Go Java Python Rust Javascript; do
    echo "Ejecutando $lang..."
    START=$(date +%s%N)

    docker build -t $lang-container ./$lang
    docker run --rm $lang-container

    END=$(date +%s%N)
    DURATION=$(( (END - START) / 1000000 )) # Convertir a milisegundos

    echo "$lang: $DURATION ms" | tee -a ../$RESULTS_FILE
done

echo "Proceso completado. Resultados guardados en $RESULTS_FILE"
