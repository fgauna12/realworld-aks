#!/bin/sh

SLACK_WEBHOOK=$(echo $1)
ENVIRONMENT=$(echo $2)
SLACK_CHANNEL=$(echo $3)
NAMESPACE=$(echo $4)

echo "creating temp secret"
kubectl create secret generic slack-secrets --dry-run=client \
    --from-literal="slack-webhook=$SLACK_WEBHOOK" \
    --from-literal="slack-username=$ENVIRONMENT" \
    --from-literal="slack-channel=$SLACK_CHANNEL" \
    -o yaml >/tmp/slack-secrets.yaml

echo "encrypting"
kubeseal -o yaml --namespace $NAMESPACE \
    --controller-name sealed-secrets \
    </tmp/slack-secrets.yaml >/tmp/slack-sealed-secret.yaml

mv /tmp/slack-sealed-secret.yaml .