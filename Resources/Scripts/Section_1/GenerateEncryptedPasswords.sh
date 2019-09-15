#!/bin/bash

encrypted_password_output=$(mktemp)
password_to_encrypt="password_goes_here"

function GenerateEncryptedString() {
local STRING="${1}"
local SALT=$(openssl rand -hex 8)
local K=$(openssl rand -hex 12)
local ENCRYPTED=$(echo "${STRING}" | openssl enc -aes256 -a -A -S "${SALT}" -k "${K}")
echo "Encrypted String: ${ENCRYPTED}"
echo "Salt: ${SALT} | Passphrase: ${K}"
}

GenerateEncryptedString "$password_to_encrypt" > "$encrypted_password_output"
echo "Encrypted credentials available at $encrypted_password_output"