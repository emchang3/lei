#!/usr/local/bin/dash

# Provide port number as argument.
RUBYOPT="--jit"; puma -b tcp://0.0.0.0:$1
