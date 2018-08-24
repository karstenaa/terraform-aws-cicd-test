git merge-base --is-ancestor origin/master HEAD
if [ $? -ne 0 ]; then
    echo $?
    echo "Error: Commit isn't based on origin/master"
    git merge-base origin/master HEAD
    exit 1
fi
result=$(git diff origin/master --name-only | grep "\.tf$" | sed 's/\/[^/]\+\.tf$//g' | uniq)
echo "Folders contain tf file changes:
$result
"
if [[ $(echo $result | wc -l) -gt 1 ]]; then
    echo "Error: Multiple folder contain tf file changes"
    exit 1
fi
