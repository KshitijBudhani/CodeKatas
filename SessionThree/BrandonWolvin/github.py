import requests;
import dateutil.parser;
import datetime;
import pytz;

# user
# --repos
# ---repo name
# ---days since last push
# ---contributors
# ----git user name

userName=raw_input('Enter a username : ')

user = {}
payload = {'client_id':'9613c70811f05af5e75e', 'client_secret':'077e2a2b8b990e70b9a3dc1b020c08cf662f7cd3'}

def getUsersByUserName():
  get_users_url = 'https://api.github.com/users/' + userName + '/repos'
  get_users = requests.get(get_users_url, params=payload)
  return get_users.json()

def getFormattedTimeStamp(timestamp):
  formattedTimeStamp = dateutil.parser.parse(timestamp)
  return formattedTimeStamp

def getCurrentDate():
  now = datetime.datetime.now(pytz.utc)
  return now

def getDaysSinceLastPushed(timestamp):
  lastPushedDate = getFormattedTimeStamp(timestamp)
  currentDate = getCurrentDate()
  difference = currentDate - lastPushedDate;
  return difference.days;

def getListofContributors(repoName):
  contributorsResponse = getContributors(repoName)
  contributorsList = []

  for item in contributorsResponse:
    contributorsList.append({'userName': item['login']})

  return contributorsList

def getContributors(repoName):
  get_contributors_url = 'https://api.github.com/repos/' + userName + '/' + repoName + '/contributors'
  get_contributors = requests.get(get_contributors_url, params=payload)
  return get_contributors.json()

def buildUser():
  user[userName] = {}
  user[userName]['repo_list'] = []
  response = getUsersByUserName()

  for item in response:
    timestamp = item['pushed_at']
    name = item['name']
    details = []
    details.append({
      'name' : item['name'],
      'last pushed' : getDaysSinceLastPushed(timestamp),
      'contributors' : getListofContributors(name)
    })
    user[userName]['repo_list'].append(details)

buildUser()

print(user)