#!/usr/bin/env bash
while true; do
    if [[ "$PRIMARY_TO_CLIP" != "$(xsel -bo)" ]]; then
        xsel -bo | xsel -pi
        PRIMARY_TO_CLIP=$(xsel -bo)
    fi
    sleep 0.5
done
