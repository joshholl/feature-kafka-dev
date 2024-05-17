#!/usr/bin/env bash

CONFLUENT_PLATFORM_VERSION=${VERSION}

. /etc/os-release

if [ "${ID}" != "debian" ] && [ "${ID_LIKE}" != "debian" ]; then
  echo "The linux distribution ${ID} is not supported by this feature. Submit a PR?"
  exit 1
fi

wget -qO - https://packages.confluent.io/deb/${CONFLUENT_PLATFORM_VERSION}/archive.key | sudo apt-key add -
sudo add-apt-repository "deb https://packages.confluent.io/deb/${CONFLUENT_PLATFORM_VERSION} stable main"
sudo add-apt-repository "deb https://packages.confluent.io/clients/deb $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install confluent-community kcat
