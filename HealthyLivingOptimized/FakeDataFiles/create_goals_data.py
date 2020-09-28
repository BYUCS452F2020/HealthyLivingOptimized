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
goal_list = ['Weight Loss', 'Target Weight', 'Improved Mood', 'Muscle Gain']


try:
    conn =  mysql.connector.connect(host=ENDPOINT, user=USR, passwd=password, port=PORT, database=DBNAME)
    cur = conn.cursor()
    cur.execute("SELECT * FROM User")
    query_results = cur.fetchall()
    for result in query_results:
        email = result[0]
        goal_id = str(uuid.uuid4())
        goal = goal_list[random.randint(0,len(goal_list)-1)]
        target_weight = random.randint(100,180)
        sql = "INSERT INTO Goals (Goal_id, Email, Goal, Target_weight) VALUES (%s, %s, %s, %s)"
        val = (goal_id, email, goal, target_weight)
        cur.execute(sql, val)
   
    #TODO - for more realistic data, might want to change goal/target weight based on user's current height and weight
   
    cur.execute("SELECT * FROM Goals")
    query_results = cur.fetchall()
    conn.commit()
    print(query_results)
except Exception as e:
    print("Database connection failed due to {}".format(e))          
                