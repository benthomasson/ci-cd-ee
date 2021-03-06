
.PHONY: all build


all: build

build:
	ansible-builder build --tag quay.io/bthomass/events-demo-ci-cd:latest --container-runtime docker

docker-build:
	docker build -f context/Dockerfile -t quay.io/bthomass/events-demo-ci-cd:latest context

run:
	docker rm cicd || true
	docker run --name cicd --privileged -v /var/run/docker.sock:/var/run/docker.sock -it --env-file env quay.io/bthomass/events-demo-ci-cd:latest ansible-events --rules github-ci-cd-rules.yml -i inventory.yml -S sources --env-vars connection_str,queue_name,repo_name,gh_user,gh_token

shell:
	docker run -it  --env-file env quay.io/bthomass/events-demo-ci-cd:latest /bin/bash

push:
	docker push quay.io/bthomass/events-demo-ci-cd:latest
