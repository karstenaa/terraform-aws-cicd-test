import sys
import requests
import os

command = os.popen('terraform show tfplan -no-color')
tf_plan = command.read()
command.close()

git_token = os.environ["GIT_TOKEN"]
headers = {"Authorization": "token " + git_token}
r = requests.post('https://api.github.com/repos/traveloka/terraform-aws-cicd-test/issues/1/comments', headers=headers, json={"body": "```hcl\n" + tf_plan})
