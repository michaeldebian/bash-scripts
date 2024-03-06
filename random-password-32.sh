#!/usr/bin/env bash

# Define the character sets
lowercase='abcdefghijklmnopqrstuvwxyz'
uppercase='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
numbers='0123456789'
special='!@#$%^&*()-=_+[]{}|;:,.<>?'

# Concatenate all character sets
all_chars="${lowercase}${uppercase}${numbers}${special}"

# Get the length of the concatenated character set
len=${#all_chars}

# Initialize the password variable
password=""

# Generate the random password
for i in {1..32}; do
    # Get a random index within the range of the concatenated character set length
    index=$((RANDOM % len))
    
    # Append the character at the random index to the password
    password="${password}${all_chars:index:1}"
done

# Print the generated password
echo "Generated password: $password"
