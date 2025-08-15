#!/bin/bash

run_with_tty() {
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        # Windows with Git Bash
        winpty version-push
    elif command -v script &> /dev/null; then
        # Linux/macOS with script command
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            script -q /dev/null version-push
        else
            # Linux
            script -qec "version-push" /dev/null
        fi
    elif [ -r /dev/tty ]; then
        # Fallback: redirect from TTY
        exec < /dev/tty
        version-push
    else
        # Last resort: run without TTY
        echo "Warning: Running version-push without TTY support"
        version-push
    fi
}

run_with_tty