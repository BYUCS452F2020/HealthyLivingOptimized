import sklearn
import pandas as pd
import pymysql
import boto3
import json
from boto3.dynamodb.conditions import Key, Attr

email = "robinson.paz.jesus@gmail.com"
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('DailyEntry')

response = table.query(
    KeyConditionExpression=Key('key').eq(email)    
)

items = response['Items']
my_dict = {}

for i in range(len(items)):
    entry_id = items[i]['entryId']
    my_dict[entry_id] = items[i]
    
import datetime
from json import JSONEncoder

class DateTimeEncoder(JSONEncoder):
        #Override the default method
        def default(self, obj):
            if isinstance(obj, (datetime.date, datetime.datetime)):
                return obj.isoformat()

report_df = pd.DataFrame(my_dict)
entry_df = report_df.transpose()

relevant_cols = [
    'gramsOfProtein', 
    'minutesOfExercise',
    'hoursOfSleep',
    'mood',
    'muscleGrowth',
    'typeOfExercise',
    'currentWeight'
]

filtered_df = entry_df[relevant_cols].copy()
for col in ['gramsOfProtein', 'minutesOfExercise', 'hoursOfSleep', 'currentWeight']:
    filtered_df[col] = filtered_df[col].astype(int)
    
print("Original number of records:", len(filtered_df))

from sklearn.preprocessing import OneHotEncoder
from sklearn.model_selection import GridSearchCV
from sklearn.ensemble import RandomForestClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split

##Classifiers
knn = KNeighborsClassifier()
rf = RandomForestClassifier()

#Data Cleaning
bin_map = {
    "Yes" : 1,
    "Not Sure" : 1,
    "No" : 0,
    "N/A" : 0
}

filtered_df['muscleGrowth'] = filtered_df['muscleGrowth'].map(bin_map)

print("Number of records after mapping for binary values:", len(filtered_df))

filtered_df = filtered_df.dropna()

print("Number of records after dropping NA:", len(filtered_df), '\n')

#OneHotEncoding
mood_cat_df = pd.get_dummies(filtered_df['mood'], columns=["mood"])
exercise_type_df = pd.get_dummies(filtered_df['typeOfExercise'], columns=['typeOfExercise'])

# merge with main df on key values
filtered_df = filtered_df.join(mood_cat_df)
filtered_df = filtered_df.join(exercise_type_df)
filtered_df = filtered_df.drop(columns=['mood', 'typeOfExercise'])
print(filtered_df.head())

##Train Test Split
X = filtered_df.copy().drop(['muscleGrowth'], axis=1)
Y = filtered_df['muscleGrowth'].copy()

X_train, X_test, y_train, y_test = train_test_split(X,Y,test_size=0.2, random_state=30)

##Model Parameter Tuning
n_neighbors = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50]
algos = ['ball_tree', 'kd_tree']
leaf_sizes = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50]

knn_params = {
    'n_neighbors': n_neighbors,
    'algorithm' : algos,
    'leaf_size' : leaf_sizes
}

# max_samples = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
# n_estimators = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
# criterion = ['gini', 'entropy']
# max_features = ['auto', 'sqrt', 'log2']

# rf_params = {
#     'n_estimators' : n_estimators,
#     'criterion' : criterion,
#     'max_features' : max_features,
#     'max_samples' : max_samples
# }

# #Randomized Grid Search
grid = GridSearchCV(knn, param_grid=knn_params, cv=10)
# grid = GridSearchCV(rf, param_grid=rf_params, cv=5)

grid.fit(X_train, y_train)
print ("\nscore = %3.2f" %(grid.score(X_test,y_test)))
print (grid.best_params_, '\n')

best_params = grid.best_params_

print('Muscle Growth Yes:', len(filtered_df[filtered_df['muscleGrowth'] == 1]))
print('Muscle Growth No:', len(filtered_df[filtered_df['muscleGrowth'] == 0]))