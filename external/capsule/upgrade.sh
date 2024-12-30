#！/bin/bash

# define chart env
export helm_chart_version_new='0.6.2' # need to check the actual chart version format
export helm_repo_name='projectcapsule'
export helm_repo_url='https://projectcapsule.github.io/charts'
export helm_chart_name='capsule' # need to check the actual file name

# define harbor env
export harbor_url='https://harbor.hanxux.local'
export harbor_project='platform-external'

# define working directory
export work_dir='/home/s0001969/Cloud/helm-charts'

#print command before executing
set -x

# pull helm chart
helm repo add --force-update $helm_repo_name $helm_repo_url
helm repo update $helm_repo_name
cd $work_dir
helm pull $helm_repo_name/$helm_chart_name --version $helm_chart_version_new

# push to harbor
helm registry login $harbor_url --insecure
helm push $helm_chart_name-$helm_chart_version_new.tgz oci://$harbor_url/$harbor_project/ --insecure-skip-tls-verify


