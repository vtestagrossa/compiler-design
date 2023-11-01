#!/bin/bash
# Compiler Theory and Design
# Project 1
# 23OCT2023
# Vincent Testagrossa

# This shell script automates running the tests and collects
# each result in its own txt file along with a full summary.
echo "Output Summary" > output_summary.txt
for file in test*.txt ; do
    date > output_$file
    echo $file >> output_$file
    echo ---------------------------------------------------------- >> output_$file
    ../build/compile < $file >> output_$file
done
for file in output_test*.txt ; do
    cat $file >> output_summary.txt
done