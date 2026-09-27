# aks-terraform

az aks get-credentials --resource-group kml_rg_main-12e2f44b646b4f06 --name jfoods-aks-dev



az aks scale \
  --resource-group "kml_rg_main-84f58a54ad19475d" \
  --name "jfoods-aks-dev" \
  --node-count 2



  az aks show \
  --resource-group kml_rg_main-2a33bd0b3a344370 \
  --name jfoods-aks-dev \
  --query nodeResourceGroup \
  -o tsv
