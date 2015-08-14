# Models

# -babyName
# --results
# ---count, ethnicity

# -ethnicity
# --names
# ---name, count

import csv
from collections import defaultdict
from operator import itemgetter

BabyNameRecords = {}
EthnicityRecords = {}

def getMothersEthnicityResultsByName(name, gender):
  name = name.title()
  babyNameResults = BabyNameRecords[name]['results']
  results =  sorted(babyNameResults, key=lambda x: int(x['count']), reverse=True)
  return getEthnicityResults(results) 

def getEthnicityResults(results):
  resultStr = ''
  for result in results:
    resultStr += result['ethnicity'] + ', ' + result['count'] + result['gender'] + '\n'
  return resultStr

def getBabyNameListByEthnicity(ethnicity):
  ethnicity = ethnicity.title()
  babyNameList = EthnicityRecords[ethnicity]['names']
  results =  sorted(babyNameList, key=lambda x: int(x['count']), reverse=True)
  return getBabyNameListResults(results)

def getBabyNameListResults(results):
  resultStr = ''
  count = 0
  length = 5
  for result in results:
    if count < length:
      if count == length - 1:
        resultStr += result['name'] + ', ' + result['count']
      else:
        resultStr += result['name'] + ', ' + result['count'] + '\n'
      count += 1
  return resultStr

def getHeaderColumnValues(header):
  Header = {}
  Header['columns'] = {}
  for columnName in header:
    if columnName == 'BRTH_YR':
      value = 'birth-year'
    elif columnName == 'GNDR':
      value = 'gender'
    elif columnName == 'CNT':
      value = 'count'
    elif columnName == 'ETHCTY':
      value = 'ethnicity'
    elif columnName == 'NAME':
      value = 'name'
      
    Header['columns'][value] = columnName
  return Header['columns']

with open('babyNames.csv') as f:
  reader = csv.DictReader(f)
  header = reader.next()

  Headers = getHeaderColumnValues(header)

  for row in reader:

    babyName = row[Headers['name']].title()
    count = row[Headers['count']]
    ethnicity = row[Headers['ethnicity']].title()
    gender = row[Headers['gender']].title()

    babyResultsRecord = {'count': count, 'ethnicity' : ethnicity, 'gender' : gender}
    babyNamesRecord = {'name': babyName, 'count' : count, 'gender' : gender}

    if babyName in BabyNameRecords:
      BabyNameRecords[babyName]['results'].append(babyResultsRecord)
    else:
      BabyNameRecords[babyName] = {}
      BabyNameRecords[babyName]['results'] = []
      BabyNameRecords[babyName]['results'] = [babyResultsRecord]

    if ethnicity in EthnicityRecords:
      EthnicityRecords[ethnicity]['names'].append(babyNamesRecord)
    else:
      EthnicityRecords[ethnicity] = {}
      EthnicityRecords[ethnicity]['names'] = []
      EthnicityRecords[ethnicity]['names'] = [babyNamesRecord]


getMothersEthnicityResultsByName('Olivia', 'female')

# babyNameInput=raw_input('Enter a baby name : ')
# print(getMothersEthnicityResultsByName('Olivia', 'female'))

# ethnicityInput=raw_input('Enter an ethnicity : ')
# print(getBabyNameListByEthnicity(ethnicityInput))


