#！/bin/bash

# define chart env
export helm_chart_version='4.10.1' # need to check the actual chart version format
export helm_repo_name='ingress-nginx'
export helm_repo_host='https://kubernetes.github.io/ingress-nginx'
export helm_chart_file_name='ingress-nginx' # need to check the actual file name
export helm_ns='ingress-nginx'
export helm_release_name='ingress-nginx'

# define harbor env
export harbor_host='harbor.hanxux.local'
export harbor_project='platform-external'
export harbor_username='admin'
export harbor_passwd='Harbor12345'

# define working directory
export work_dir='/home/s0001969/Cloud/helm-charts'

# print command before executing
set -x

# diff upgrade
echo "...diff upgrade helm chart from harbor..."

helm registry login https://$harbor_host --insecure --username $harbor_username --password $harbor_passwd
helm diff upgrade -i $capsule_release_name -n $helm_ns oci://$harbor_host/$harbor_project/$helm_chart_file_name --version $helm_chart_version -f ./values.yaml --insecure-skip-tls-verify

# upgrade helm chart from harbor
echo "...upgrade helm chart from harbor..."

helm upgrade -i $capsule_release_name -n $helm_ns oci://$harbor_host/$harbor_project/$helm_chart_file_name --version $helm_chart_version -f ./values.yaml --insecure-skip-tls-verify