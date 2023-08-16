#!/bin/sh

if [ "$1" = 'hash-admin-password' ]; then
    exec /bin/deno run /app/hash-admin-password.ts
fi

exec "$@"
