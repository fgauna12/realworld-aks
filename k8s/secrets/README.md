
# "Sealing"/Encrypting a Secret

The native Kubernetes secrets are not very secure. They are just base64 encoded. They are _not safe for source control_. 

We can use an open source project called, "[sealed secrets](https://github.com/bitnami-labs/sealed-secrets)". 
It works by running an operator on the cluster in the `kube-system` namespace. When it detects a `SealedSecret` resource being created in Kubernetes, it will decrypt it using it's private key and create a Kubernetes native secret. 

<mark>You can commit a sealed secret to source control. It can only be decrypted by the "sealed secret" operator running on the cluster</mark>

## Creating a sealed secret

Create a secret like you would normally.

``` yaml
apiVersion: v1
data:
  CONNECTION_STRING: dG9kbwo=
kind: Secret
metadata:
  name: my-secret
  namespace: my-namespace
type: Opaque
```

Save it to a file. For example, `my-secret.yaml`

**Install sealed secret CLI - kubeseal**
https://github.com/bitnami-labs/sealed-secrets#homebrew

```
kubeseal --controller-name=sealed-secrets -o yaml <my-secret.yaml >my-secret-sealed.yaml
```

## Updating a sealed secret

There is a script called "update-sealed-secret.sh" in this directory. 
It helps update a sealed secret without acquiring all the original values or re-encrypting all the secrets.

Usage:

``` bash
./update-sealed-secret.sh [kubernetes secret name] [destination sealed secret yaml file] "[secret key]" "[secret new value]"
```

For example:

``` bash
./update-sealed-secret.sh my-secret my-secret-sealed.yaml "CONNECTION_STRING" "mysql2://root:somepassword@mysql:3306/"
```
