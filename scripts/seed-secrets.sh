#!/bin/sh

# example: scripts/seed-secrets.sh $(cat scripts/tmp.yml) kured

VALUES=$(echo $1)
NAMESPACE=$(echo $2)

echo "creating temp secret"
kubectl create secret generic slack-secrets --dry-run=client \
    --from-literal="values.yaml=${VALUES}" \
    -o yaml >/tmp/slack-secrets.yaml

echo "encrypting"
kubeseal -o yaml --namespace $NAMESPACE \
    --controller-name sealed-secrets \
    </tmp/slack-secrets.yaml >/tmp/slack-sealed-secret.yaml

mv /tmp/slack-sealed-secret.yaml .