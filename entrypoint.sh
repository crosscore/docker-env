#!/bin/bash

git config --global user.email "yuu"
git config --global user.name "crosscore.g@gmail.com"
git config --global core.autocrlf input

# Set SSH key permissions
chmod 600 /root/.ssh/id_rsa
chmod 644 /root/.ssh/id_rsa.pub

# Log the new permissions
echo "New permissions for /root/.ssh:"
ls -l /root/.ssh/id_rsa
ls -l /root/.ssh/id_rsa.pub

# Set environment variables for Flask
export FLASK_APP=app.py
export FLASK_ENV=development

# Run the container's main process (zsh in this case)
exec "/usr/bin/zsh"