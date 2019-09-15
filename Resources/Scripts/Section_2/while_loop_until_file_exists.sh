#!/bin/bash

# While loop until a file exists
while [[ ! -f /tmp/stop.txt ]]; do
     echo "File not found."
     sleep 3
done
echo "File is found."