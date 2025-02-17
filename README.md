# EjecutorDA2
Secuencia de ejecución actividad Docker 2
 
Tutorial de ejecución
1) Mucha paciencia
2) Dentro de la página web de Play with Docker: https://labs.play-with-docker.com creamos una cuenta (o entramos a nuestra cuenta) y creamos una nueva instancia.
3) En la nueva instancia escribimos el comando "git clone https://github.com/HamedPro3D/EjecutorDA2.git".
4) Después entramos a la carpeta "Ejecutor" con el comando "cd EjecutorDA2". Podrás ver que estás dentro de la carpeta en el momento en que encima de tu línea de texto aparezca un mensaje "/EjecutorDA2".
5) Le construimos la instancia del docker en esa carpeta tal que así: "docker build -t ayuda .", y le damos el tiempo a que se cree.
6) Después escribimos el comando "docker run --privileged -v /var/run/docker.sock:/var/run/docker.sock --rm ayuda" para ejecutar el contenedor que creamos arriba. --privileged para darle "permisos de administrador" dentro del docker, -v nos aseguramos de que estamos dentro de una versión de docker y le decimos el path donde estará el docker daemon para que pueda ejecutarse correctamente, --rm para que se elimine el contenedor al utilizarse y el nombre. Esperamos a que se ejecute todo y dará los tiempos de cada arreglo con su respectivo tiempo ordenado.
7) Esta opción es opcional, pero puedes ver los segundos dentro de "results.txt" con el comando "cat results.txt".
8) ¡Disfruta!

¿Que cambio respecto a la otra entrega?

- Ahora el programa funciona como fue solicitado, arreglando errores del docker, estando en dos repositorios y pueden funcionar bien sin mucho problema y con un buen manual de uso.