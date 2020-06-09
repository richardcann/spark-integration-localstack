import os
from pyspark.sql import SparkSession

S3 = 'http://aws-docker:4572'
spark = SparkSession \
    .builder \
    .master('local') \
    .config('spark.hadoop.fs.s3a.endpoint', S3) \
    .config('spark.hadoop.fs.s3a.path.style.access', True) \
    .config('spark.hadoop.fs.s3a.change.detection.version.required', False) \
    .config('spark.hadoop.fs.s3a.multiobjectdelete.enable', False) \
    .getOrCreate()

os.system('aws --endpoint-url={} s3 mb s3://my-test'.format(S3))
os.system('aws --endpoint-url={} s3 sync data s3://my-test/data'.format(S3))
os.system('aws --endpoint-url={} s3 ls s3://my-test/data/'.format(S3))

remote_df = spark.read.json('s3://my-test/data')
remote_df.show()
remote_df.write.parquet("s3://my-test/result.parquet")
os.system('aws --endpoint-url={} s3 ls s3://my-test/result.parquet/'.format(S3))
