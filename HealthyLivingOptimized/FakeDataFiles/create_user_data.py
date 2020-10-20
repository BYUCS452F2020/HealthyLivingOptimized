from faker import Faker
import pandas
import numpy
import uuid

fake = Faker()

import mysql.connector
import sys
import boto3
import os

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

try:
    conn =  mysql.connector.connect(host=ENDPOINT, user=USR, passwd=password, port=PORT, database=DBNAME)
    cur = conn.cursor()
    for i in range(10):
        profile = fake.profile()
        email = profile['mail'] #in faker
        password = profile['username']#in faker
        name_list = profile['name'].split(" ")
        first_name = name_list[0] #in faker
        last_name = name_list[1] #in faker
        sql = "INSERT INTO User (Email, Password, First_name, Last_name) VALUES (%s, %s, %s, %s)"
        val = (email, password, first_name, last_name)
        cur.execute(sql, val)
    cur.execute("SELECT * FROM User")
    query_results = cur.fetchall()
    conn.commit()
    print(query_results)
except Exception as e:
    print("Database connection failed due to {}".format(e))          
                