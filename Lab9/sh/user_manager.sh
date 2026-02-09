#!/bin/bash

# Must run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit 1
fi

# ---------- GROUP ----------
while true; do
  read -p "Enter new group name: " GROUP
  if getent group "$GROUP" > /dev/null; then
    echo "❌ Group already exists. Try another."
  else
    groupadd "$GROUP"
    echo "✅ Group created: $GROUP"
    break
  fi
done

# ---------- USER ----------
while true; do
  read -p "Enter new username: " USER
  if getent passwd "$USER" > /dev/null; then
    echo "❌ User already exists. Try another."
  else
    useradd -m -s /bin/bash -g "$GROUP" "$USER"
    echo "✅ User created: $USER"
    break
  fi
done

# ---------- PASSWORD ----------
passwd "$USER"

# ---------- DIRECTORY ----------
DIR="/$USER"
mkdir "$DIR"

# Ownership
chown "$USER:$GROUP" "$DIR"

# Permissions
chmod 770 "$DIR"     # Full for owner & group
chmod +t "$DIR"      # Sticky bit (only owner can delete)

echo "----------------------------------"
echo "Setup completed successfully!"
echo "User: $USER"
echo "Group: $GROUP"
echo "Directory: $DIR"
ls -ld "$DIR"
