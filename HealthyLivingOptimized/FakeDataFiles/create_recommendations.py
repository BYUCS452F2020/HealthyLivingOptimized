from faker import Faker
import pandas
import numpy
import uuid
import mysql.connector
import sys
import boto3
import os
import time
import random

fake = Faker()

ssm = boto3.client('ssm')
PORT = "3306"
REGION = "us-east-1"
os.environ['LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN'] = '1'
client = boto3.client('rds')


# what are some recommendations?
recommendation_list = ['Increase protein intake']

try:
    #conn =  mysql.connector.connect(host=ENDPOINT, user=USR, passwd=password, port=PORT, database=DBNAME)
    conn =  mysql.connector.connect(host="hlo.coxbpduxjpbi.us-east-1.rds.amazonaws.com", user="admin", passwd="HLOAdmin", port=PORT, database="HLO")
    cur = conn.cursor()

    
    for rec in recommendation_list:
        rec_id = str(uuid.uuid4())
        sql = "INSERT INTO Recommendations (Recommendation_id, Recommendation) VALUES (%s, %s)"
        val = (rec_id, rec)
        cur.execute(sql, val)
   
    # cur.execute("SELECT * FROM Recommendations")
    # query_results = cur.fetchall()
    # print(query_results)
    # conn.commit()
except Exception as e:
    print("Database connection failed due to {}".format(e))          
    
    

