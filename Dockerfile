FROM ubuntu:latest

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    git \
    docker.io \
    time \
    && rm -rf /var/lib/apt/lists/*

# Copiar el script de ejecución
COPY run_pipeline.sh /run_pipeline.sh
RUN chmod +x /run_pipeline.sh

# Ejecutar el script al iniciar el contenedor
CMD ["/bin/bash", "/run_pipeline.sh"]
