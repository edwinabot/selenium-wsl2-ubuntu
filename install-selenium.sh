#!/usr/bin/bash
chrome_for_testing_endpoint="https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json"
versions_file_path="/tmp/last-known-good-versions-with-downloads.json"
cft_download_path=/tmp/chromefortesting.zip
chromedriver_download_path=/tmp/chromedriver.zip

echo "Changing to home directory..."
pushd "$HOME"

echo "Update the repository..."
sudo apt update

echo "Install prerequisite packages..."
sudo apt install wget unzip jq -y

echo "Get the latest known good version..."
wget $chrome_for_testing_endpoint -O $versions_file_path

chrome_version=$(cat $versions_file_path | jq .channels.Stable.version)
echo "Chrome version: ${chrome_version}"

echo "Downloading Chrome For Testing..."
wget $(cat $versions_file_path | jq -r .channels.Stable.downloads.chrome[0].url) -O $cft_download_path

echo "Downloading Chromedriver..."
wget $(cat $versions_file_path | jq -r .channels.Stable.downloads.chromedriver[0].url) -O $chromedriver_download_path

echo "Unziping..."
mkdir -p "chromefortesting"
unzip -q $cft_download_path -d "chromefortesting"
unzip -q $chromedriver_download_path -d "chromefortesting"

popd
