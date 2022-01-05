import os
from pyspark.sql import SparkSession
from unittest import TestCase
from spark.main import run

S3 = 'http://aws-docker:4572'


class UploaderIntegrationTest(TestCase):

    def setUp(self) -> None:
        self.spark = SparkSession \
            .builder \
            .master('local') \
            .getOrCreate()

        # Setup aws buckets
        os.system('aws --endpoint-url={} s3 mb s3://my-test'.format(S3))
        os.system('aws --endpoint-url={} s3 sync data s3://my-test/data'.format(S3))
        os.system('aws --endpoint-url={} s3 ls s3://my-test/data/'.format(S3))

    def test_upload_to_s3(self):
        run(["s3://my-test/data", "s3://my-test/result.parquet"], self.spark)

        output_df = self.spark.read.parquet('s3://my-test/result.parquet/*')
        self.assertEqual(output_df.count(), 2)
