#!/bin/sh

export tmpdir="/tmp/jekyll"
mkdir $tmpdir

echo "Copying _site to $tmpdir"
cp -r ./_site/* $tmpdir

git checkout master

echo "Deleting files in master branch"
for file in *
do
    if  [ $file != .git -a $file != .gitignore -a $file != .nojekyll ]; then
        rm -rf $file
    fi
done

echo "Copying files from $tmpdir"
cp -r $tmpdir/* .

echo "Removing $tmpdir"
rm -rf $tmpdir

git checkout source
