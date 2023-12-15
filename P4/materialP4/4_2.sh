#!/bin/bash

if [ -e data.dat ]; then
    rm data.dat
fi

gcc -o pi_serie pi_serie.c -lm
gcc -o pi_par1 pi_par1.c -fopenmp -lm
gcc -o pi_par2 pi_par2.c -fopenmp -lm
gcc -o pi_par3 pi_par3.c -fopenmp -lm
gcc -o pi_par4 pi_par4.c -fopenmp -lm
gcc -o pi_par5 pi_par5.c -fopenmp -lm
gcc -o pi_par6 pi_par6.c -fopenmp -lm
gcc -o pi_par7 pi_par7.c -fopenmp -lm

echo "Ejecutable Tiempo Speedup Correcto" >> data.dat
echo "---------------------------------" >> data.dat

tiempo_serie=$(./pi_serie | grep "Tiempo" | awk '{print $2}')
resultado_serie=$(./pi_serie | grep "Resultado" | awk '{print $2}')

i=1
for prog in pi_par1 pi_par2 pi_par3 pi_par4 pi_par5 pi_par6 pi_par7
do
    tiempo_prog=$(./$prog | grep "Tiempo" | awk '{print $2}')
    
    speedup=$(awk "BEGIN {printf \"%.6f\", $tiempo_serie / $tiempo_prog}")

    resultado_prog=$(./$prog | grep "Resultado" | awk '{print $2}')
    
    correcto=0
    if [ "$resultado_serie" = "$resultado_prog" ]; then
        correcto=1
    fi

    printf "%d %s %s %d\n" "$((i++))" "$tiempo_prog" "$speedup" "$correcto" >> data.dat
done

rm pi_serie pi_par1 pi_par2 pi_par3 pi_par4 pi_par5 pi_par6 pi_par7
