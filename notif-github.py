import sys
import requests
import os

command = os.popen('terraform show build/tfplan -no-color')
tf_plan = command.read()
command.close()

git_token = os.environ["GIT_TOKEN"]
tf_working_dir = os.environ["TF_WORKING_DIR"]
f = open("build/metadata.json", "r")
metadata = f.read()

headers = {"Authorization": "token " + git_token}
r = requests.post('https://api.github.com/repos/traveloka/terraform-aws-cicd-test/issues/1/comments', headers=headers, json={"body": "```json\n" + metadata + "```\n```hcl\n" + tf_plan +"\n"})
