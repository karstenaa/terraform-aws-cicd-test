import sys
import requests
import os

command = os.popen('terraform show build/tfplan -no-color')
tf_plan = command.read()
command.close()

git_token = os.environ["GIT_TOKEN"]
f = open("build/metadata.json", "r")
metadata = f.read()
headers = {"Authorization": "token " + git_token}
print git_token
json = {"body": "```json\n" + metadata + "```\n```hcl\n" + tf_plan +"```\n"}
print json
r = requests.post('https://api.github.com/repos/traveloka/terraform-aws-cicd-test/issues/1/comments', headers=headers, json=json)
print r.text
print r.json
