#/bin/bash

branch=$(date +%s)
tempdir="/tmp/a_$branch"

if [ ! -d "$tempdir" ]; 
then
    mkdir "$tempdir"
fi
cd "$tempdir"

gh repo clone net-daemon/homeassistant-addon --depth=1

cd homeassistant-addon

git checkout -b "$branch"

sed -i '/  "version": /c\  "version": "10.0.1",' "$tempdir/homeassistant-addon/netdaemon/config.json"
git add "$tempdir/homeassistant-addon/netdaemon/config.json"
git commit -m "Release "

git push --set-upstream origin "$branch"
gh pr create --fill --title "Release 10.0.1" --head "$branch"
