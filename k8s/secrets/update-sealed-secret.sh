#! /bin/bash

set -e

SECRET_NAME=$1
SEALED_SECRETS_FILENAME=$2
SECRET_KEY=$3
NEW_VALUE=$4

echo -n "$NEW_VALUE" | kubectl create secret generic $SECRET_NAME --dry-run=client \
  --from-file=$SECRET_KEY=/dev/stdin -o yaml \
  | kubeseal --controller-name=sealed-secrets -o yaml --merge-into $SEALED_SECRETS_FILENAME
