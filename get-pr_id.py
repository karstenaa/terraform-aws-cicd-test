import requests
import os

git_token = os.environ["GIT_TOKEN"]
git_commit_id = os.environ["GIT_COMMIT_ID"]
headers = {"Authorization": "token " + git_token}
payload = {"q": git_commit_id + "+is:merged"}
r = requests.get('https://api.github.com/search/issues', headers=headers, params=payload)
print r.text
