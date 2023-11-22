#!/bin/bash

slow_executable="./slow"
fast_executable="./fast"

for param in {1024..16384..1024}
do
    for i in {1..10}
    do
        slow_output=$($slow_executable $param)
        slow_time=$(echo "$slow_output" | grep "Execution time" | awk '{print $3}')

        fast_output=$($fast_executable $param)
        fast_time=$(echo "$fast_output" | grep "Execution time" | awk '{print $3}')

        echo "$param $slow_time $fast_time"
    done
done
