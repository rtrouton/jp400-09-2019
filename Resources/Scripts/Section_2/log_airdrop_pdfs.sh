#!/bin/bash

output_file=/var/log/airdropped_pdfs.log

# Create output file if it doesn't exist.

if [[ ! -f "$output_file" ]]; then
    touch "$output_file"
fi

# Look for PDF files which have been received via AirDrop
# Links:
# https://hcsonline.com/support/blog/entry/airdrop-logging-on-a-mac-computer
# https://ss64.com/osx/mdfind.html

/usr/bin/mdfind kind:pdf com.apple.AirDrop > $output_file