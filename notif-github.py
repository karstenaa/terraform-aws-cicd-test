import sys
import requests
import os

command = os.popen('terraform show build/terraform.tfplan -no-color')
tf_plan = command.read()
command.close()

git_token = os.environ["GITHUB_TOKEN"]
pr_id = os.environ["PR_ID"]
f = open("build/metadata.json", "r")
metadata = f.read()
headers = {"Authorization": "token " + git_token}
json = {
    "body": "metadata.json\n```json\n" + metadata + "```\nterraform.tfplan\n```hcl\n" + tf_plan +"```\n"
}
r = requests.post('https://api.github.com/repos/traveloka/terraform-aws-cicd-test/issues/' + pr_id +'/comments', headers=headers, json=json)
print r.json
