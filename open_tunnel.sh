#!/bin/bash

echo "Opening SSH tunnel via serveo.net..."
echo "Note: This will forward port 2222. The tunnel URL will be displayed below."
echo "Use the displayed host and port 2222 for SSH connection."
echo ""

ssh -R 2222:localhost:2222 serveo.net