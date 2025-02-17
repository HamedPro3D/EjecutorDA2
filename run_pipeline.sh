#!/bin/bash

# Configuración
REPO_URL="https://github.com/HamedPro3D/ContenedoresDockerA2.git"
REPO_NAME="ContenedoresDockerA2"
RESULTS_FILE="results.txt"

# Verificar si Docker está instalado
if ! command -v docker &> /dev/null
then
    echo "Error: Docker no está instalado o no está disponible."
    exit 1
fi

# Iniciar Docker si es necesario
service docker start || echo "Advertencia: No se pudo iniciar Docker"

# Clonar el repositorio con los archivos solve.(extensión)
echo "Clonando repositorio..."
git clone $REPO_URL || { echo "Error clonando el repositorio"; exit 1; }
cd $REPO_NAME || { echo "Error entrando al directorio $REPO_NAME"; exit 1; }

# Crear archivo de resultados
echo "Tiempo de ejecución de cada lenguaje:" > ../$RESULTS_FILE

# Iterar sobre los lenguajes y ejecutar cada programa en su contenedor
for lang in cpp go java python rust javascript; do
    echo "Ejecutando $lang..."
    
    # Verificar que la carpeta del lenguaje exista
    if [ -d "$lang" ]; then
        START=$(date +%s%N)

        docker build -t ${lang}-container ./$lang || { echo "Error construyendo $lang"; continue; }
        docker run --rm ${lang}-container || { echo "Error ejecutando $lang"; continue; }

        END=$(date +%s%N)
        DURATION=$(( (END - START) / 1000000 )) # Convertir a milisegundos

        echo "$lang: $DURATION ms" | tee -a ../$RESULTS_FILE
    else
        echo "Advertencia: Carpeta '$lang' no encontrada, omitiendo..."
    fi
done

echo "Proceso completado. Resultados guardados en $RESULTS_FILE"
