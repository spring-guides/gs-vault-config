#!/bin/sh
# cd $(dirname $0)

# pkill vault
# rm -f target/vault*
# mkdir -p target
# cd target

# VAULT_VER=1.12.2
# UNAME=$(uname -s |  tr '[:upper:]' '[:lower:]')
# VAULT_ZIP="vault_${VAULT_VER}_${UNAME}_amd64.zip"

# wget "https://releases.hashicorp.com/vault/${VAULT_VER}/${VAULT_ZIP}"
# unzip ${VAULT_ZIP}

# ./vault server --dev --dev-root-token-id="00000000-0000-0000-0000-000000000000" &
# sleep 10

# export export VAULT_TOKEN="00000000-0000-0000-0000-000000000000"
# export VAULT_ADDR="http://127.0.0.1:8200"

# ./vault kv put secret/gs-vault-config example.username=demouser example.password=demopassword
# ./vault kv put secret/gs-vault-config/cloud example.username=clouduser example.password=cloudpassword
# cd ..

cd complete

./mvnw clean package
ret=$?
if [ $ret -ne 0 ]; then
  exit $ret
fi
rm -rf target

./gradlew build
ret=$?
if [ $ret -ne 0 ]; then
  exit $ret
fi
rm -rf build

cd ../initial

./mvnw clean compile
ret=$?
if [ $ret -ne 0 ]; then
  exit $ret
fi
rm -rf target

./gradlew compileJava
ret=$?
if [ $ret -ne 0 ]; then
  exit $ret
fi
rm -rf build

pkill vault
exit
