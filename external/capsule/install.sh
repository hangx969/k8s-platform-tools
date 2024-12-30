#！/bin/bash

# define chart env
export helm_chart_version='0.6.2' # need to check the actual chart version format
export helm_repo_name='projectcapsule'
export helm_repo_url='https://projectcapsule.github.io/charts'
export helm_chart_name='capsule' # need to check the actual file name
export helm_ns='capsule-system'
export helm_release_name='capsule'

# define harbor env
export harbor_url='https://harbor.hanxux.local'
export harbor_project='platform-external'

# define working directory
export work_dir='/home/s0001969/Cloud/helm-charts'

#print command before executing
set -x

# install helm chart from harbor
helm registry login harbor.hanxux.local --insecure
helm install $capsule_release_name -n $helm_ns oci://$harbor_url/$harbor_project/$helm_chart_name --version $helm_chart_version -f ./values.yaml --insecure-skip-tls-verify