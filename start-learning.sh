#!/bin/bash
# Run this script to setup your learning environment
# we recommend using github codespaces

chmod +x check.sh
chmod +x new-question.sh

# download duckdb CLI
curl https://install.duckdb.org | bash

duckdb --version

code getting-started/use-the-cli.md