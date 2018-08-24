git merge-base --is-ancestor origin/master HEAD
if [ $? -ne 0 ]; then
    echo "Error: Commit isn't based on origin/master"
    exit 1
fi
export TF_WORKING_DIR=$(git diff origin/master --name-only | grep "\.tf$" | sed 's/\/[^/]\+\.tf$//g' | uniq)
echo "Folders contain tf file changes:
$TF_WORKING_DIR
"
if [[ $(echo $TF_WORKING_DIR | wc -l) -gt 1 ]]; then
    echo "Error: Multiple folder contain tf file changes"
    exit 1
fi