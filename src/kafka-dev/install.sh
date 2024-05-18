#!/usr/bin/env bash

CONFLUENT_PLATFORM_VERSION=${VERSION}

. /etc/os-release

if [ "${ID}" != "debian" ] && [ "${ID_LIKE}" != "debian" ]; then
  echo "The linux distribution ${ID} is not supported by this feature. Submit a PR?"
  exit 1
fi

mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.confluent.io/deb/${CONFLUENT_PLATFORM_VERSION}/archive.key  | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
sudo echo "deb https://packages.confluent.io/deb/${CONFLUENT_PLATFORM_VERSION} stable main" | tee /etc/apt/sources.list.d/confluent.list
sudo echo "deb https://packages.confluent.io/clients/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/confluent_client.list
sudo apt-get update && sudo apt-get install confluent-community kcat
