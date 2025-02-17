# Usamos una imagen base de Ubuntu 20.04
FROM ubuntu:20.04

# Instalamos las dependencias necesarias:
# - git: para clonar el repositorio
# - docker.io: para poder ejecutar comandos docker (usando el socket del host)
# - dos2unix: para asegurarnos de que los scripts tengan el formato correcto
RUN apt-get update && apt-get install -y \
    git \
    docker.io \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Copiamos el script de ejecución al contenedor
COPY run_pipeline.sh /run_pipeline.sh

# Convertimos el script a formato Unix y lo hacemos ejecutable
RUN dos2unix /run_pipeline.sh && chmod +x /run_pipeline.sh

# Al iniciar el contenedor se ejecutará el script
CMD ["/bin/bash", "/run_pipeline.sh"]
