#!/bin/bash

# While loop using a counter
counter=0

while (( counter <= 10 )); do
    echo "$counter"
    (( counter++ ))
    sleep 1
done