#!/usr/bin/env bash

sudo git add .
echo "Please enter the comment"
read in
sudo git commit -m "$in"
sudo git push
