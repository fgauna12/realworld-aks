#! /bin/bash

echo -n "$NEW_VALUE" | kubectl create secret generic $SECRET_NAME --dry-run=client \
  --from-file=$SECRET_KEY=/dev/stdin -o yaml \
  | kubeseal --controller-name=sealed-secrets -o yaml --merge-into $SEALED_SECRETS_FILENAME
