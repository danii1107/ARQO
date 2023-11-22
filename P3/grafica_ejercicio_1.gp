set terminal png
set output "time_slow_fast.png"

set title "TIME SLOW FAST"
set xlabel "N (rows/cols)"
set ylabel "EXEC. TIME (s)"

set style data linespoints
set key top left

set xrange [1024:17000]
set xtics 1024, 1024, 16384

plot "time_slow_fast.dat" using 1:2 with linespoints title "SLOW", \
     "time_slow_fast.dat" using 1:3 with linespoints title "FAST"
