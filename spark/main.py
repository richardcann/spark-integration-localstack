import os
from pyspark.sql import SparkSession

S3 = 'http://aws-docker:4572'
spark = SparkSession \
    .builder \
    .master('local') \
    .getOrCreate()

os.system('aws --endpoint-url={} s3 mb s3://my-test'.format(S3))
os.system('aws --endpoint-url={} s3 sync data s3://my-test/data'.format(S3))
os.system('aws --endpoint-url={} s3 ls s3://my-test/data/'.format(S3))

remote_df = spark.read.json('s3://my-test/data')
remote_df.show()
remote_df.write.parquet("s3://my-test/result.parquet")
os.system('aws --endpoint-url={} s3 ls s3://my-test/result.parquet/'.format(S3))
local_df = spark.read.parquet('s3://my-test/result.parquet/*')
local_df.show()
