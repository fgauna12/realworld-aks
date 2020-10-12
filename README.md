# realworld-aks
A reference aks cluster following AKS best practices with GitOps

## Manual Items

- Run pipeline once, it will fail because AAD CRDs don't exist yet
- Add deploy key from flux to the github repo and give it write permissions
- Run pipeline again, it will pass
- Reencrypt the sealed secrets with the proper encryption key. Secrets are. 
   - `velero-credentials` - `./update-sealed-secret.sh velero-credentials velero-credentials-secret.yaml "cloud" $(cat ../../credentials-velero)`
