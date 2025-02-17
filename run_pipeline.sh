#!/bin/bash

# Configuración
REPO_URL="https://github.com/HamedPro3D/EjecutorDA2.git"
REPO_NAME="EjecutorDA2"
RESULTS_FILE="results.txt"

# Iniciar servicio Docker dentro del contenedor
service docker start || echo "No se pudo iniciar Docker"

# Clonar el repositorio original
echo "Clonando repositorio..."
git clone $REPO_URL || { echo "Error clonando el repositorio"; exit 1; }
cd $REPO_NAME || { echo "Error entrando al directorio"; exit 1; }

# Crear archivo de resultados
echo "Tiempo de ejecución de cada lenguaje:" > ../$RESULTS_FILE

# Iterar sobre los lenguajes y ejecutar cada programa en su contenedor
for lang in cpp go java python rust javascript; do
    echo "Ejecutando $lang..."
    START=$(date +%s%N)

    docker build -t ${lang}-container ./$lang
    docker run --rm ${lang}-container

    END=$(date +%s%N)
    DURATION=$(( (END - START) / 1000000 )) # Convertir a milisegundos

    echo "$lang: $DURATION ms" | tee -a ../$RESULTS_FILE
done

echo "Proceso completado. Resultados guardados en $RESULTS_FILE"
