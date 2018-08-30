export PR_ID="$(curl -H \"Authorization: token $GIT_TOKEN\" -X GET https://api.github.com/search/issues?q=${GIT_COMMIT_ID}+is:merged | jq '.items[0].number')"
