#!/bin/bash

# This extension attribute uses cat to
# check the current contents of the
# specified output file.

output_file=/var/log/airdropped_pdfs.log

result=$(cat "$output_file")

echo "<result>$result</result>"