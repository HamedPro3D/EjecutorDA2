#!/bin/bash

# CONFIGURACIÓN
REPO_URL="https://github.com/HamedPro3D/ContenedoresDockerA2.git"
REPO_NAME="ContenedoresDockerA2"
RESULTS_FILE="results.txt"

echo "Clonando repositorio ${REPO_URL}..."
git clone ${REPO_URL} || { echo "Error al clonar el repositorio"; exit 1; }
cd ${REPO_NAME} || { echo "No se pudo acceder al directorio ${REPO_NAME}"; exit 1; }

# Imprimimos el contenido del repositorio para verificar que las carpetas existan
echo "Contenido del repositorio clonado:"
ls -l

# Creamos el archivo para guardar los resultados en el directorio superior
echo "Tiempo de ejecución de cada lenguaje:" > ../${RESULTS_FILE}

# Lista de lenguajes (las carpetas deben llamarse así)
for lang in cpp go java python rust javascript; do
    echo "Procesando ${lang}..."
    if [ -d "${lang}" ]; then
        START=$(date +%s%N)
        
        # Construimos la imagen del contenedor para el lenguaje
        docker build -t ${lang}-container ${lang} || { echo "Error al construir imagen para ${lang}"; continue; }
        
        # Ejecutamos el contenedor
        docker run --rm ${lang}-container || { echo "Error al ejecutar contenedor para ${lang}"; continue; }
        
        END=$(date +%s%N)
        DURATION=$(( (END - START) / 1000000 ))  # Duración en milisegundos
        
        echo "${lang}: ${DURATION} ms" >> ../${RESULTS_FILE}
    else
        echo "Directorio ${lang} no encontrado. Omitiendo..."
    fi
done

echo "Proceso completado. Revisa el archivo ../${RESULTS_FILE} para ver los resultados."
