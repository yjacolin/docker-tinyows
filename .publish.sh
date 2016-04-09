#!/bin/bash -e
# Setup login
mkdir ${HOME}\/.docker/
openssl aes-256-cbc -K $encrypted_8219e3a8c0b5_key -iv $encrypted_8219e3a8c0b5_iv -in config.json.enc -out ${HOME}\/.docker/config.json -d

if [ "$TRAVIS_BRANCH" == "master" ]; then
  echo "Deploying image to docker hub for master (latest)"
  docker push "yjacolin/tinyows:latest"
elif [ ! -z "$TRAVIS_TAG" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo "Deploying image to docker hub for tag ${TRAVIS_TAG}"
  docker push "yjacolin/tinyows:${TRAVIS_TAG}"
elif [ ! -z "$TRAVIS_BRANCH" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo "Deploying image to docker hub for branch ${TRAVIS_BRANCH}"
  docker push "yjacolin/tinyows:${TRAVIS_BRANCH}"
else
  echo "Not deploying image"
fi
