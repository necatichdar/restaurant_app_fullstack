echo "Url giriniz"
read modelUrl
mkdir -p lib/app/model
get generate model on model from "$modelUrl" --skipProvider
