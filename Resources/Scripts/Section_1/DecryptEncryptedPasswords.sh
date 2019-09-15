#!/bin/bash

EncryptedString="U2FsdGVkX1+1nTgI0CtcIWeucYoiUzsRzEiQKmbBKDQ="
Salt="b59d3808d02b5c21"
Passphrase="21899c3d8247dce72ad190d9"


function DecryptString() {
echo "${1}" | /usr/bin/openssl enc -aes256 -d -a -A -S "${2}" -k "${3}"
}
string=$(DecryptString "${EncryptedString}" "${Salt}" "${Passphrase}") 
echo "$string"