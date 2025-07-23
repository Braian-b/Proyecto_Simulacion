#!/bin/bash

# Configuración
OUT_FILE="Tiempos_relativos.txt"
EXEC="nekrs"
PARFILE="turbPipe.par"

# Encabezado
echo "Cores,Tiempo(s),Speedup_relativo,Eficiencia_relativa" > "$OUT_FILE"

# Ejecutar con 2 cores como base
np_base=2
echo "Ejecutando base con $np_base proceso(s)..."
START=$(date +%s.%N)
mpirun -np $np_base $EXEC --setup $PARFILE > "out_${np_base}.log"
END=$(date +%s.%N)
BASE_TIME=$(awk "BEGIN {print $END - $START}")
echo "$np_base,$BASE_TIME,1.0,1.0" >> "$OUT_FILE"

# Bucle de escalamiento desde 3 hasta 12
for np in {3..12}; do
    echo "Ejecutando con $np proceso(s)..."
    START=$(date +%s.%N)
    mpirun -np $np $EXEC --setup $PARFILE > "out_${np}.log"
    END=$(date +%s.%N)

    TIME=$(awk "BEGIN {print $END - $START}")
    SPEEDUP=$(awk "BEGIN {printf \"%.3f\", $BASE_TIME / $TIME}")
    EFFICIENCY=$(awk "BEGIN {printf \"%.3f\", $SPEEDUP / ($np / $np_base)}")

    echo "$np,$TIME,$SPEEDUP,$EFFICIENCY" >> "$OUT_FILE"
done

echo "Simulación finalizada. Resultados en $OUT_FILE"
