git diff origin/master --name-only | grep "\.tf$" | sed 's/\/[^/]\+\.tf$//g' | uniq
