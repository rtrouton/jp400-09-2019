#!/bin/bash

# Until loop using a counter
counter=0

until (( counter > 10 )); do
    echo "$counter"
    (( counter++ ))
    sleep 1
done