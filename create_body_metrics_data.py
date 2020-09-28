from faker import Faker
import pandas
import numpy
import uuid
import mysql.connector
import sys
import boto3
import os
import random

fake = Faker()

ssm = boto3.client('ssm')

ENDPOINT = ssm.get_parameter(Name='HLO-DB-Endpoint')['Parameter']['Value']
PORT = "3306"
USR = ssm.get_parameter(Name='HLO-DB-User')['Parameter']['Value']
REGION = "us-east-1"
DBNAME = ssm.get_parameter(Name='HLO-DB-Name')['Parameter']['Value']
os.environ['LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN'] = '1'
password = ssm.get_parameter(Name='HLO-DB-Password')['Parameter']['Value']

#gets the credentials from .aws/credentials
client = boto3.client('rds')

age_range = list(range(18, 85))
height_range = list(range(59, 82))
weight_range = list(range(95,250))

try:
    conn =  mysql.connector.connect(host=ENDPOINT, user=USR, passwd=password, port=PORT, database=DBNAME)
    cur = conn.cursor()
    cur.execute("SELECT * FROM User")
    query_results = cur.fetchall()
    for result in query_results:
        metric_id = str(uuid.uuid4())
        username = result[0]
        age = random.randint(18, 85)
        height = random.randint(59, 82)
        weight = random.randint(95, 350)
        sql = "INSERT INTO BodyMetrics (Metric_id, Username, Age, Weight, Height_in_inches) VALUES (%s, %s, %s, %s, %s)"
        val = (metric_id, username, age, weight, height)
        cur.execute(sql, val)
    cur.execute("SELECT * FROM BodyMetrics")
    query_results = cur.fetchall()
    conn.commit()
    print(query_results)
except Exception as e:
    print("Database connection failed due to {}".format(e))          
                