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
