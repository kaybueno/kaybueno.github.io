#!/bin/sh

jekyll build

export tmpdir="/tmp/jekyll"
mkdir $tmpdir

echo "Copying _site to $tmpdir"
cp -r ./_site/* $tmpdir

git checkout master

CURRENT_BRANCH=`git branch | grep "*" | grep -Eo '\w+'`

if [ $CURRENT_BRANCH == 'master' ]; then
	echo "In master branch!"
	# echo "Deleting files in master branch"
	# for file in *
	# do
	#     if  [ $file != .git -a $file != .gitignore -a $file != .nojekyll ]; then
	#         rm -rf $file
	#     fi
	# done

	# echo "Copying files from $tmpdir"
	# cp -r $tmpdir/* .

	# COMMIT_MSG="Last `tail -n 1 ~/kvanderwater.github.io/.git/logs/refs/heads/source | grep "commit: .*" -o`"
	# echo $COMMIT_MSG

	git checkout source
fi

echo "Removing $tmpdir"
rm -rf $tmpdir
