#!/bin/bash

slow_executable="./slow"
fast_executable="./fast"

if [ -e "time_slow_fast.dat" ]; then
    rm "time_slow_fast.dat"
fi

for param in {1024..16384..1024}
do
    for i in {1..10}
    do
        slow_output=$($slow_executable $param)
        slow_time=$(echo "$slow_output" | grep "Execution time" | awk '{print $3}')

        fast_output=$($fast_executable $param)
        fast_time=$(echo "$fast_output" | grep "Execution time" | awk '{print $3}')

        echo "$param $slow_time $fast_time" >> "time_slow_fast.dat"
    done
done

echo "set terminal png
set output \"time_slow_fast.png\"

set title \"TIME SLOW FAST\"
set xlabel \"N (rows/cols)\"
set ylabel \"EXEC. TIME (s)\"

set style data linespoints
set key top left

set xrange [1024:17000]
set xtics 1024, 1024, 16384
set xtics rotate by 270 offset -1, 0

plot \"time_slow_fast.dat\" using 1:2 with linespoints title \"SLOW\", \\
     \"time_slow_fast.dat\" using 1:3 with linespoints title \"FAST\"" > plot_script.gp

gnuplot plot_script.gp
rm -rf plot_script.gp