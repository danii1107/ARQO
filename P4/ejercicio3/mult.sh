# Script para P4 ejercicio 3

#!/bin/bash

P=7
N1=(512+$P)
Nfinal=(1024+512+$P)
Npaso=64   
fDAT=matrix_mult.dat
fPNGt=mult_tiempos.png
fPNGsu=mult_speedup.png
 

rm -f $fDAT
rm -f fPNGt fPNGsu

touch $fDAT

echo "Running multiplication of matrix..."

for((N = N1 ; N <= Nfinal ; N += Npaso)); do
	echo "Matrix size: $N"

	echo "Mult en serie..."
	SerieTime=$(./mult $N | grep 'time' | awk '{print $3}')

	echo "Mult en paralelo..."
	ParTime=$(./mult_para $N 4 3 | grep 'time' | awk '{print $3}')

	SUaux=($SerieTime/$ParTime)
	SU=$(echo "scale=10; ${SUaux}"| bc | awk '{print $1}')

	echo "$N	$SerieTime	$ParTime	$SU" >> $fDAT
done

echo "Generating plot..."
    gnuplot << END_GNUPLOT
    set title "Tiempos de ejecucion"
    set ylabel "Tiempo"
    set xlabel "Matrix Size"
    set key right top
    set grid
    set term png
    set output "$fPNGt"
    plot "matrix_mult.dat" using 1:2 with lines lw 2 title "serie", \
         "matrix_mult.dat" using 1:3 with lines lw 2 title "paralelo"
    replot
    quit
END_GNUPLOT

echo "Generating plot..."
    gnuplot << END_GNUPLOT
    set title "Speed Up"
    set ylabel "Aceleracion"
    set xlabel "Matrix Size"
    set key right top
    set grid
    set term png
    set output "$fPNGsu"
    plot "matrix_mult.dat" using 1:4 with lines lw 2 title "aceleracion"
    replot
    quit
END_GNUPLOT







