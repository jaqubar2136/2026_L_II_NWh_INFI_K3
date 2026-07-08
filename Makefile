.PHONY: deps lint test run docker_build docker_run docker_stop docker_start docker_rm docker_push

IMAGE_NAME=hello-world-printer
TAG=$(USERNAME)/hello-world-printer-k3-2026

deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

test:
	PYTHONPATH=. pytest

run:
	python main.py

docker_build:
	docker build -t $(IMAGE_NAME) .

docker_run: docker_build
	docker rm -f hello-world-printer-dev 2>/dev/null || true
	docker run \
		--name hello-world-printer-dev \
		-p 5000:5000 \
		-d $(IMAGE_NAME)

docker_stop:
	docker stop hello-world-printer-dev

docker_start:
	docker start hello-world-printer-dev

docker_rm:
	docker rm hello-world-printer-dev

docker_push: docker_build
	@echo "$$DOCKER_PASSWORD" | docker login --username "$(USERNAME)" --password-stdin
	docker tag $(IMAGE_NAME) $(TAG)
	docker push $(TAG)
	docker logout
