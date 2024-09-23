#!/bin/bash

# Load variables from config.sh
source config.sh

# Check if config.sh exists
if [ ! -f "config.sh" ]; then
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

mkdir ./download

# Download the file with the correct file name
curl -o "./download/$file_name.zip" "https://dev.moph.go.th/ssl-moph-api/download/$download/file_name?type=LINUX&token=$token"


# Check if the file was downloaded successfully
if [ ! -f "./download/$file_name.zip" ]; then
  echo "Failed to download the SSL zip file."
  exit 1
fi

# sed -i "s/^version=.*/version=$file_name/" config.sh
# Save the new version (file name) in config.sh
# sed -i '' "s|^version=.*|version=$file_name|" config.sh
sed -i "s|^version=.*|version=$file_name|" config.sh

# Extract the zip file to each path specified in paths array
for p in "${paths[@]}"; do
  mkdir -p "$p"
  unzip -o "./download/$file_name.zip" -d "$p"
done

rm -rf ./download
# Restart each service using the commands from restart_commands array
for cmd in "${restart_commands[@]}"; do
  $cmd
done

echo "SSL updated and service restarted."
