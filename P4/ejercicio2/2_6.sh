#!/bin/bash

Tini=100000
step=100000
Tfin=10000000
output_file=data2.dat
niter=10

if [ -e data2.dat ]; then
    rm data2.dat
fi

for ((i = Tini; i <= Tfin+1; i = i+step)) do
    total_serie=0
    total_parallel=0
    for ((j=0; j<niter; j+=1)){
        make > /dev/null
        val_serie=$(./pescalar_serie $i | grep "Tiempo" | awk '{print $2}')
        total_serie=$(echo "scale=6; $val_serie+$total_serie" | bc)
        
        val_par=$(./pescalar_par3 $i | grep "Tiempo" | awk '{print $2}')
        total_parallel=$(echo "scale=6; $val_par+$total_parallel" | bc)
    }
    avg_parallel=$(echo "scale=6; $total_parallel/$niter" | bc)
    avg_serie=$(echo "scale=6; $total_serie/$niter" | bc)
	printf "$i	$avg_serie	$avg_parallel\n" >> $output_file
done