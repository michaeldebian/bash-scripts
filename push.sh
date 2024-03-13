#!/usr/bin/env bash

sudo git add .
echo "Please enter the comment"
read in
git commit -m "$in"
git push
