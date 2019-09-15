#!/bin/bash

# While loop while reading from file

while read line; do
    echo "Item: $line"
done < /tmp/grocery.txt

