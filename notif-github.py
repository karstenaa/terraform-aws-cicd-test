import sys
import requests
import os

command = os.popen('terraform show tfplan -no-color')
tf_plan = command.read()
print tf_plan
command.close()

git_token = sys.argv[1]
headers = {"Authorization": "token " + git_token}
r = requests.post('https://api.github.com/repos/traveloka/terraform-aws-cicd-test/issues/1/comments', headers=headers, json={"body": tf_plan})
print r.text