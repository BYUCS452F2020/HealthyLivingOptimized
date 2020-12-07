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
# ENDPOINT = ssm.get_parameter(Name='HLO-DB-Endpoint')['Parameter']['Value']
# USR = ssm.get_parameter(Name='HLO-DB-User')['Parameter']['Value']
# DBNAME = ssm.get_parameter(Name='HLO-DB-Name')['Parameter']['Value']
# password = ssm.get_parameter(Name='HLO-DB-Password')['Parameter']['Value']

#gets the credentials from .aws/credentials
client = boto3.client('rds')
exercise_list = ['HIIT', 'Cardio', 'Strength Training', 'Mobility']
mood_list = ['Happy', 'Sad', 'Determined', 'Frustrated', 'Angry']
muscle_growth_list = ['Yes', 'No', 'N/A', 'Not Sure']

def get_random_date(start, end, rand):
    format = '%Y-%m-%d'
    stime = time.mktime(time.strptime(start, format))
    etime = time.mktime(time.strptime(end, format))

    ptime = stime + rand * (etime - stime)

    return time.strftime(format, time.localtime(ptime))


try:
    #conn =  mysql.connector.connect(host=ENDPOINT, user=USR, passwd=password, port=PORT, database=DBNAME)
    conn =  mysql.connector.connect(host="hlo.coxbpduxjpbi.us-east-1.rds.amazonaws.com", user="admin", passwd="HLOAdmin", port=PORT, database="HLO")
    cur = conn.cursor()
    cur.execute("SELECT * FROM User")
    query_results = cur.fetchall()
    numPerPerson = 100
    for result in query_results:
        email = result[0]
        for i in range(numPerPerson):
            stats_id = str(uuid.uuid4())
            date = get_random_date('2018-1-1','2020-10-18',random.random())
            hours_of_sleep = random.randint(4, 11)
            grams_of_protein = random.randint(20,300)
            type_of_exercise = exercise_list[random.randint(0,len(exercise_list)-1)]
            minutes_of_exercise = random.randint(0,400)
            current_weight = random.randint(100,200)
            mood = mood_list[random.randint(0,len(mood_list)-1)]
            muscle_growth = muscle_growth_list[random.randint(0,len(muscle_growth_list)-1)]
            sql = "INSERT INTO LifestyleStats (Stats_id, Email, Date, Hours_of_sleep, Grams_of_protein, Type_of_exercise, Minutes_of_exercise, Current_weight, Mood, Muscle_growth) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
            val = (stats_id, email, date, hours_of_sleep, grams_of_protein, type_of_exercise, minutes_of_exercise, current_weight, mood, muscle_growth)
            cur.execute(sql, val)
   
    cur.execute("SELECT * FROM LifestyleStats")
    query_results = cur.fetchall()
    # conn.commit()
    print(query_results)
except Exception as e:
    print("Database connection failed due to {}".format(e))          
    
    

                