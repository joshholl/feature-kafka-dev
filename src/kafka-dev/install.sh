#!/usr/bin/env bash

CONFLUENT_PLATFORM_VERSION=${VERSION}

. /etc/os-release

if [ "${ID}" != "debian" ] && [ "${ID_LIKE}" != "debian" ]; then
  echo "The linux distribution ${ID} is not supported by this feature. Submit a PR?"
  exit 1
fi

sudo mkdir -p /etc/apt/keyrings
sudo curl -fsSL https://packages.confluent.io/deb/${CONFLUENT_PLATFORM_VERSION}/archive.key  | sudo gpg --dearmor -o /etc/apt/keyrings/confluent.gpg
sudo echo "deb [signed-by=/etc/apt/keyrings/confluent.gpg] https://packages.confluent.io/deb/${CONFLUENT_PLATFORM_VERSION} stable main" | sudo tee /etc/apt/sources.list.d/confluent.list
sudo echo "deb [signed-by=/etc/apt/keyrings/confluent.gpg] https://packages.confluent.io/clients/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/confluent_client.list
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update && sudo apt-get -y install confluent-community-* kcat
