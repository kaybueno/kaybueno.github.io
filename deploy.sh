#!/bin/sh

export tmpdir="/tmp/jekyll"
mkdir $tmpdir

echo "Copying _site to $tmpdir"
cp -r ./_site/* $tmpdir

git checkout master

# echo "Deleting files in master branch"
# for file in *
# do
#     if  [ $file != .git -a $file != .gitignore -a $file != .nojekyll ]; then
#         rm -rf $file
#     fi
# done

# echo "Copying files from $tmpdir"
# cp -r $tmpdir/* .

COMMIT_MSG="Last `tail -n 1 ~/kvanderwater.github.io/.git/logs/refs/heads/source | grep "commit: .*" -o`"
echo $COMMIT_MSG

echo "Removing $tmpdir"
rm -rf $tmpdir

git checkout source
