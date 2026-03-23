#!/usr/bin/env bash
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Script directory: $script_dir"

default_dir="/usr/local/bin"
echo "Checking default directory: $default_dir"

# ensure default_dir exists before checking for 'no'
if [ ! -d "$default_dir" ]; then
  echo "No default directory found, please input your terminal directory below:"
  read -r user_dir
  if [ -z "$user_dir" ] || [ ! -d "$user_dir" ]; then
    echo "Provided directory is invalid or does not exist. Exiting."
    exit 1
  fi
  default_dir="$user_dir"
fi

existing_no="$default_dir/no"
if [ -e "$existing_no" ]; then
  printf "A no was found at %s, would you like to remove it and replace it? type y if yes and n if no: " "$existing_no"
  read -r reply
  if [ "$reply" = "y" ] || [ "$reply" = "Y" ]; then
    if sudo rm -f "$existing_no"; then
      echo "Removed existing $existing_no (with sudo)"
    else
      echo "Failed to remove $existing_no with sudo. Exiting."
      exit 1
    fi
  else
    echo "Aborting installation."
    exit 0
  fi
fi

target_path="$default_dir/no"
tmpfile="$(mktemp)"
cat > "$tmpfile" <<'EOF'
#!/usr/bin/env bash
while true; do
  printf 'n\n'
done
EOF

if [ -w "$default_dir" ]; then
  mv "$tmpfile" "$target_path"
  chmod 755 "$target_path"
  echo "A no was successfully created at $target_path"
else
  if sudo mkdir -p "$default_dir" 2>/dev/null || true && sudo mv "$tmpfile" "$target_path" && sudo chmod 755 "$target_path"; then
    echo "A no was successfully created at $target_path"
  else
    echo "Failed to install $target_path with sudo. Exiting."
    exit 1
  fi
fi

while true; do
  echo
  echo "Options:"
  echo "1) Exit script"
  echo "2) Test the no"
  echo "3) Remove the no (uses sudo)"
  printf "Enter choice (1/2/3): "
  read -r choice
  case "$choice" in
    1) exit 0 ;;
    2) "$target_path" ;;
    3)
      if sudo rm -f "$target_path"; then
        echo "Removed $target_path (with sudo)"
      else
        echo "Failed to remove $target_path with sudo."
      fi
      exit 0
      ;;
    *) echo "Invalid choice." ;;
  esac
done

