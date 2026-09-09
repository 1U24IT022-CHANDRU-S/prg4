#!/bin/bash

# SELinux Access Denial Practical
# Student Name:
# Register Number:

echo "===== SELinux Status ====="


echo "===== Creating Web Directory ====="
sudo mkdir -p "$WEB_DIR"
echo "===== Creating HTML File ====="
echo "<html><body><h1>SELinux Practical</h1><p>Access Test Successful</p></body></html>" | sudo tee "$HTML_FILE" > /dev/null

echo "===== Setting Linux Permissions ====="
sudo chmod 644 "$HTML_FILE"
sudo chmod 755 "$WEB_DIR"

echo "===== Checking Initial Context ====="
ls -Z "$HTML_FILE"

echo "===== Assigning Wrong SELinux Context ====="
sudo chcon -t default_t "$HTML_FILE"
echo "===== Checking Wrong Context ====="
ls -Z "$HTML_FILE"

echo "===== Checking AVC Denials ====="
sudo ausearch -m AVC -ts recent 2>/dev/null | tail -n 10

echo "===== Correcting SELinux Context ====="
sudo restorecon -v "$HTML_FILE"

echo "===== Checking Correct Context ====="
ls -Z "$HTML_FILE"

echo "===== Practical Completed ====="
