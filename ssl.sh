#!/bin/bash

# Load variables from config.sh
current_dir=$(dirname "$0")

source $current_dir/config.sh

# Check if config.sh exists
if [ ! -f "$current_dir/config.sh" ]; then
  echo "config.sh not found!"
  exit 1
fi

# Call API to check for new SSL version
response=$(curl -s "https://dev.moph.go.th/ssl-moph-api/download/check?version=$version&token=$token")

# Check if the response is true
if [ "$response" != "true" ]; then
  echo "No new SSL version available."
  exit 0
fi


# Call API and get JSON response
response=$(curl -s "https://dev.moph.go.th/ssl-moph-api/download?type=LINUX&token=$token")

# Extract file name from the JSON response (assuming it's under "file_name")
file_name=$(echo $response | awk -F'"file_name":"|"' '{print $2}')

mkdir $current_dir/download
public_ip=$(curl -s ifconfig.me)
# Download the file with the correct file name
curl -o "$current_dir/download/$file_name.zip" "https://dev.moph.go.th/ssl-moph-api/download/$file_name?type=LINUX&token=$token&public_ip=$public_ip"


# Check if the file was downloaded successfully
if [ ! -f "$current_dir/download/$file_name.zip" ]; then
  echo "Failed to download the SSL zip file."
  exit 1
fi

# sed -i "s/^version=.*/version=$file_name/" config.sh
# Save the new version (file name) in config.sh
# sed -i '' "s|^version=.*|version=$file_name|" config.sh
sed -i "s|^version=.*|version=$file_name|" $current_dir/config.sh

# Extract the zip file to each path specified in paths array
for p in "${paths[@]}"; do
  mkdir -p "$p"
  unzip -o "$current_dir/download/$file_name.zip" -d "$p"
done

rm -rf $current_dir/download
# Restart each service using the commands from restart_commands array
for cmd in "${restart_commands[@]}"; do
  $cmd
done

echo "SSL updated and service restarted."
