#!/bin/bash

mult_executable="./mult"
trasp_executable="./trasp"
OUTPUT_FILE="mult.dat"

# Elimina archivos existentes
if [ -e "$OUTPUT_FILE" ]; then
    rm "$OUTPUT_FILE"
fi

for param in {128..2176..256}; do
    multtotal_time=0
    trasptotal_time=0

    for i in {1..10}; do
        mult_output=$($mult_executable $param)
        mult_time=$(echo "$mult_output" | grep "Execution time" | awk '{print $3}')
        multtotal_time=$(echo "$multtotal_time + $mult_time" | bc -l)

        trasp_output=$($trasp_executable $param)
        trasp_time=$(echo "$trasp_output" | grep "Execution time" | awk '{print $3}')
        trasptotal_time=$(echo "$trasptotal_time + $trasp_time" | bc -l)
    done

    multavg_time=$(echo "$multtotal_time / 10" | bc -l)
    traspavg_time=$(echo "$trasptotal_time / 10" | bc -l)

    valgrind --tool=cachegrind --cachegrind-out-file=mult_output.txt "$mult_executable" "$param"
    valgrind --tool=cachegrind --cachegrind-out-file=trasp_output.txt "$trasp_executable" "$param"
 
    D1MR_NORMAL=$(cg_annotate mult_output.txt | awk 'NR>17 {print $9; exit}' | tr -d ',')
    D1MW_NORMAL=$(cg_annotate mult_output.txt | awk 'NR>17 {print $15; exit}' | tr -d ',')

    D1MR_TRASP=$(cg_annotate trasp_output.txt | awk 'NR>17 {print $9; exit}' | tr -d ',')
    D1MW_TRASP=$(cg_annotate trasp_output.txt | awk 'NR>17 {print $15; exit}' | tr -d ',')

    echo "$param $multavg_time $D1MR_NORMAL $D1MW_NORMAL $traspavg_time $D1MR_TRASP $D1MW_TRASP" >> "$OUTPUT_FILE"

    rm -f mult_output.txt
    rm -f trasp_output.txt
done

echo "
set terminal pngcairo enhanced font 'arial,10' size 800, 600

# Gráfica para fallos de caché en lectura
set output 'mult_cache_read.png'
set title 'Fallos de caché en lectura'
set xlabel 'N'
set ylabel 'Fallos de caché'
plot '$OUTPUT_FILE' using 1:3 title 'Normal' with linespoints, \
     '' using 1:6 title 'Trasp' with linespoints

# Gráfica para fallos de caché en escritura
set output 'mult_cache_write.png'
set title 'Fallos de caché en escritura'
set xlabel 'N'
set ylabel 'Fallos de caché'
plot '$OUTPUT_FILE' using 1:4 title 'Normal' with linespoints, \
     '' using 1:7 title 'Trasp' with linespoints

# Gráfica para tiempos de ejecución
set output 'mult_time.png'
set title 'Tiempos de ejecución'
set xlabel 'N'
set ylabel 'Tiempo (s)'
plot '$OUTPUT_FILE' using 1:2 title 'Normal' with linespoints, \
     '' using 1:5 title 'Trasp' with linespoints
" > plot_script.gp

gnuplot plot_script.gp
rm -rf plot_script.gp