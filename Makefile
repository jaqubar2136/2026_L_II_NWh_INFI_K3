.PHONY: deps lint test run docker_build docker_run docker_stop docker_start docker_rm

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
	docker build -t hello-world-printer .

docker_run: docker_build
	docker rm -f hello-world-printer-dev 2>/dev/null || true
	docker run \
		--name hello-world-printer-dev \
		-p 5000:5000 \
		-d hello-world-printer

docker_stop:
	docker stop hello-world-printer-dev

docker_start:
	docker start hello-world-printer-dev

docker_rm:
	docker rm hello-world-printer-dev
