## Instrucciones de uso

A continuación se describen los pasos necesarios para ejecutar la simulación dentro de un contenedor Docker y generar las gráficas de speedup relativo y eficiencia paralela relativa.

### 1. Clonar el repositorio

Abre una terminal y ejecuta:

git clone  https://github.com/Braian-b/Proyecto_Simulacion.git
cd Proyecto_simulacion

### 2. Construir la imagen de Docker

Ejecuta el siguiente comando dentro de la carpeta del repositorio:

docker build -t simulacion-escalamiento .

Esto crea una imagen llamada simulacion-escalamiento que contiene todas las herramientas necesarias para ejecutar la simulación y generar gráficas.

### 3. Ejecutar el contenedor

Lanza el contenedor de forma interactiva con soporte para múltiples núcleos:

docker run -it --rm -v "$(pwd)":/app -w /app simulacion-escalamiento

comado de prueba (Opcional)

mpirun-np 6 nekrs --setup turbPipe.par

### 4. Ejecutar la simulación

Una vez dentro del contenedor, lanza la simulación escribiendo:

bash simulacion_relativa.sh

Este script ejecutará el programa con diferentes cantidades de núcleos (desde 2 hasta 12), y almacenará los tiempos de ejecución en el archivo Tiempos.txt.

### 5. Generar las gráficas

Luego de la simulación, genera las gráficas ejecutando:

bash graficar_relativa.sh

Esto producirá dos archivos PDF:

- speedup_relativo.pdf
- eficiencia_relativa.pdf

Las gráficas representan el comportamiento del programa con respecto al número de núcleos disponibles.

### 6. Salir del contenedor

Escribe exit en la terminal del contenedor para salir:

exit

### 7. (Opcional) Copiar resultados al sistema host

Si deseas guardar los archivos generados fuera del contenedor, puedes usar un volumen al ejecutar el contenedor:

docker run -it --rm -v $(pwd):/simulacion simulacion-escalamiento

Esto hará que los archivos .txt y .pdf generados dentro del contenedor aparezcan también en tu máquina local.
