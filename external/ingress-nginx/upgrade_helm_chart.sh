#！/bin/bash

# define chart env
export helm_chart_version_new='4.10.1' # need to check the actual chart version format
export helm_repo_name='ingress-nginx'
export helm_repo_url='https://kubernetes.github.io/ingress-nginx'
export helm_chart_file_name='ingress-nginx' # need to check the actual file name prefix

# define harbor env
export harbor_host='harbor.hanxux.local'
export harbor_project='platform-external'
export harbor_username='admin'
export harbor_passwd='Harbor12345'

# define working directory
export work_dir='/home/s0001969/Cloud/helm-charts'

#print command before executing
set -x

# pull helm chart
echo "...pulling helm chart..."

helm repo add --force-update $helm_repo_name $helm_repo_url
helm repo update $helm_repo_name

cd $work_dir
helm pull $helm_repo_name/$helm_chart_file_name --version $helm_chart_version_new

# push to harbor
echo "...pushing helm chart to harbor..."

helm registry login $harbor_host --insecure --username $harbor_username --password $harbor_passwd
helm push $helm_chart_file_name-$helm_chart_version_new.tgz oci://$harbor_host/$harbor_project/ --insecure-skip-tls-verify


