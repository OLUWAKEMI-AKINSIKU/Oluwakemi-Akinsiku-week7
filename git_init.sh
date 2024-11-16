#!/usr/bin/env bash

# Check if .env file exists
if [[ ! -f ".env" ]]; then
  echo "File: .env does not exist. Please create .env and add all required variables."
  exit 1
fi

# Source environment variables from .env
source .env

# Check if git is configured globally
if git config --global --list > /dev/null 2>&1; then
  echo "Git has been configured globally."
else
  git config --global user.name "$USERNAME"
  git config --global user.email "$EMAIL"
fi

# Initialize git if not already done
if [ ! -d ".git" ]; then
  git init
  git remote add origin https://"${GIT_TOKEN}"@github.com/"${USERNAME}"/"${REPO}".git
fi

# Stage all untracked files
git add . 

# Input initial commit message
read -p "Enter commit message: " MESSAGE
git commit -m "${MESSAGE}"

# Rename the branch to main and push to remote
git branch -M main
git push -u origin main
