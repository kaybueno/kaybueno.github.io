#!/bin/sh

jekyll build

export tmpdir="/tmp/jekyll"
mkdir $tmpdir

echo "Copying _site to $tmpdir"
cp -r ./_site/* $tmpdir

git checkout master

CURRENT_BRANCH=`git branch | grep "*" | grep -Eo '\w+'`

if [ $CURRENT_BRANCH == 'master' ]; then
	echo "Deleting files in master branch"
	for file in *
	do
	    if  [ $file != .git -a $file != .gitignore -a $file != .nojekyll ]; then
	        rm -rf $file
	    fi
	done

	echo "Copying files from $tmpdir"
	cp -r $tmpdir/* .

	COMMIT_MSG="Last `tail -n 1 ~/kaybueno.github.io/.git/logs/refs/heads/source | grep "commit: .*" -o`"
	git add -A
	git commit -am "$COMMIT_MSG"
	git push

	git checkout source
fi

echo "Removing $tmpdir"
rm -rf $tmpdir
