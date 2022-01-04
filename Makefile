DOCKER_NETWORK = spark-integration-localstack_default
ENV_FILE = hadoop.env
build:
	docker build -t test_spark .

run:
	python ./spark/main.py

integration_test:
	python3 -m unittest tests/*

localstack:
	docker-compose up -d

deps: localstack build

docker_run: deps
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} test_spark make integration_test

bash_in:
	docker run -it --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} test_spark /bin/bash