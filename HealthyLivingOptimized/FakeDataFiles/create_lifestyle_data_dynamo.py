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

dynamodb = boto3.resource('dynamodb')
entry_table = dynamodb.Table('DailyEntry')
user_table = dynamodb.Table('Users')

exercise_list = ['HIIT', 'Cardio', 'Strength Training', 'Mobility']
mood_list = ['Happy', 'Sad', 'Determined', 'Frustrated', 'Angry']
muscle_growth_list = ['Yes', 'No', 'N/A', 'Not Sure']

def get_random_date(start, end, rand):
    format = '%Y-%m-%d'
    stime = time.mktime(time.strptime(start, format))
    etime = time.mktime(time.strptime(end, format))

    ptime = stime + rand * (etime - stime)

    return time.strftime(format, time.localtime(ptime))


with entry_table.batch_writer() as batch:
    numPerPerson = 1000
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
        
        if minutes_of_exercise > 30 or type_of_exercise in ['Strength Training', 'HIIT']:
            muscle_growth = "Yes"
            
        
        batch.put_item(
            Item = {
                'key' : 'robinson.paz.jesus@gmail.com',
                'sort' : stats_id,
                'currentWeight' : str(current_weight),
                'date' : str(date),
                'entryId' : stats_id,
                'gramsOfProtein' : str(grams_of_protein),
                'hoursOfSleep' : str(hours_of_sleep),
                'minutesOfExercise' : str(minutes_of_exercise),
                'mood' : mood,
                'muscleGrowth' : muscle_growth,
                'typeOfExercise' : type_of_exercise
            }
        )