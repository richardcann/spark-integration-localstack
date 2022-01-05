# Spark Integration with Localstack

Aiming to enable local testing of pyspark when uploading/downloading files from S3 buckets.
[Localstack](https://localstack.cloud/) aim to provide an easy way to bring up various AWS services locally using Docker.
Through the `spark/conf/` folder, the application knows to connect to a custom endpoint locally (localhost:4572) when executing pyspark commands (i.e. `spark.read.json('s3://my-test/data')`)

Check an integration test example in `tests/` folder.

Project is run with spark version 2.4.4

## Dependencies:

```
pip install pyspark
```

## Run the application:

```
make docker-run
```
