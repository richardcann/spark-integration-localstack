DOCKER_NETWORK = spark-integration-s3_default
ENV_FILE = hadoop.env
build:
	docker build -t test_spark .

run:
	python ./spark/main.py

docker_run:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} test_spark make run

bash_in:
	docker run -it --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} test_spark /bin/bash