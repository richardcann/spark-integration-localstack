from pyspark.sql import SparkSession
import sys
from typing import List


def read_df(spark_session, path):
    return spark_session.read.json(path)


def transform(df):
    return df


def upload_df(df, output_path):
    df.write.parquet(output_path)


def run(args: List[str], spark: SparkSession) -> None:
    input_s3_path = args[0]
    output_s3_path = args[1]

    input_df = read_df(spark, input_s3_path)
    transformed_df = transform(input_df)
    upload_df(transformed_df, output_s3_path)


if __name__ == '__main__':
    args = sys.argv[1:]
    spark = SparkSession \
        .builder \
        .master('local') \
        .getOrCreate()
    run(args, spark)
