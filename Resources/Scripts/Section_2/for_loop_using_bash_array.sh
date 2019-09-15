#!/bin/bash

arr[0]="green"
arr[1]="purple"
arr[2]="orange"

for color in ${arr[@]}; do
    echo ${color} && say ${color}
    sleep 1
done