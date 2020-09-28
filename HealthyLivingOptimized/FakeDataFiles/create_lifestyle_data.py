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

ENDPOINT = ssm.get_parameter(Name='HLO-DB-Endpoint')['Parameter']['Value']
PORT = "3306"
USR = ssm.get_parameter(Name='HLO-DB-User')['Parameter']['Value']
REGION = "us-east-1"
DBNAME = ssm.get_parameter(Name='HLO-DB-Name')['Parameter']['Value']
os.environ['LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN'] = '1'
password = ssm.get_parameter(Name='HLO-DB-Password')['Parameter']['Value']

#gets the credentials from .aws/credentials
client = boto3.client('rds')
exercise_list = ['HIIT', 'Cardio', 'Strength Training', 'Mobility']


try:
    conn =  mysql.connector.connect(host=ENDPOINT, user=USR, passwd=password, port=PORT, database=DBNAME)
    cur = conn.cursor()
    cur.execute("SELECT * FROM User")
    query_results = cur.fetchall()
    for result in query_results:
        email = result[0]
        stats_id = str(uuid.uuid4())
        date = time.strftime('%Y-%m-%d %H:%M:%S')
        hours_of_sleep = random.randint(5, 10)
        grams_of_protein = random.randint(50,250)
        type_of_exercise = exercise_list[random.randint(0,len(exercise_list)-1)]
        minutes_of_exercise = random.randint(0,300)
        sql = "INSERT INTO LifestyleStats (Stats_id, Email, Date, Hours_of_sleep, Grams_of_protein, Type_of_exercise, Minutes_of_exercise) VALUES (%s, %s, %s, %s, %s, %s, %s)"
        val = (stats_id, email, date, hours_of_sleep, grams_of_protein, type_of_exercise, minutes_of_exercise)
        cur.execute(sql, val)
   
    cur.execute("SELECT * FROM LifestyleStats")
    query_results = cur.fetchall()
    conn.commit()
    print(query_results)
except Exception as e:
    print("Database connection failed due to {}".format(e))          
                