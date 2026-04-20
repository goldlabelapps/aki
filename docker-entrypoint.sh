#!/bin/sh
set -e

# Start the backend (compiled JS) in the background and capture its PID
node aki-backend/dist/server.js &
BACKEND_PID=$!

# If the backend exits unexpectedly, kill the whole container
monitor_backend() {
  wait "$BACKEND_PID"
  echo "[AKI] Backend process exited — shutting down container"
  kill "$FRONTEND_PID" 2>/dev/null || true
  exit 1
}
monitor_backend &

# Start the Next.js frontend (production server) in the foreground
cd aki-frontend
node_modules/.bin/next start -p 1975 &
FRONTEND_PID=$!

# Forward SIGTERM / SIGINT to both child processes
trap 'kill "$BACKEND_PID" "$FRONTEND_PID" 2>/dev/null; exit 0' TERM INT

# Wait for the frontend process (main foreground process)
wait "$FRONTEND_PID"
