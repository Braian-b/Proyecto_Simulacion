#!/bin/bash

echo "Generando gráficas separadas..."

# Gráfica de Speedup relativo
gnuplot << EOF
set terminal pdfcairo enhanced color font "Arial,12" size 7in,4in
set output "grafica_speedup_relativo.pdf"

set datafile separator ","
set title "Speedup relativo (base 2 cores)"
set xlabel "Número de cores"
set ylabel "Speedup relativo"
set xrange [2:*]
set xtics 2,1
set grid
set key outside center bottom

# Escalado ideal: speedup = x / 2
set style line 1 lt 2 lw 2 lc rgb "#999999"
f(x) = x / 2
plot \
    f(x) title "Escalado ideal" with lines ls 1, \
    "Tiempos_relativos.txt" using 1:3 title "Speedup relativo" with linespoints lw 2 lt 1 lc rgb "#0072BD"
EOF

# Gráfica de Eficiencia relativa
gnuplot << EOF
set terminal pdfcairo enhanced color font "Arial,12" size 7in,4in
set output "grafica_eficiencia_relativa.pdf"

set datafile separator ","
set title "Eficiencia relativa (base 2 cores)"
set xlabel "Número de cores"
set ylabel "Eficiencia relativa"
set xrange [2:*]
set yrange [0:*]
set xtics 2,1
set grid
set key outside center bottom

plot \
    "Tiempos_relativos.txt" using 1:4 title "Eficiencia relativa" with linespoints lw 2 lt 1 lc rgb "#D95319"
EOF

echo "Gráficas generadas:"
echo "- grafica_speedup_relativo.pdf"
echo "- grafica_eficiencia_relativa.pdf"