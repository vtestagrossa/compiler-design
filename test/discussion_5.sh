#!/bin/bash
# Compiler Theory and Design
# Project 2
# 23OCT2023
# Vincent Testagrossa

# This shell script automates running the tests and collects
# each result in its own txt file along with a full summary.
file="discussion_5_input.txt"
echo "Discussion 5" > discussion_5.txt
date >> discussion_5.txt
echo ---------------------------------------------------------- >> discussion_5.txt
../src/compile < $file >> discussion_5.txt