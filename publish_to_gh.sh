# 在用这个脚本前，需要做一些准备工作，如果不清楚，不理解，就不要贸然用，可以先去做测试.
# echo "public" >> .gitignore
# git checkout --orphan gh-pages
# git reset --hard
# git commit --allow-empty -m "Initializing gh-pages branch"
# git push origin gh-pages
# rm -rf docs
# git worktree add -B gh-pages docs origin/gh-pages
# git checkout master

#!/bin/sh

if [ "`git status -s`" ]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Deleting old docsation"
rm -rf docs
mkdir docs
git worktree prune
rm -rf .git/worktrees/docs/

echo "Checking out gh-pages branch into docs"
git worktree add -B gh-pages docs origin/gh-pages

echo "Removing existing files"
rm -rf docs/*

echo "Generating site"
gitbook build . docs

echo "Updating gh-pages branch"
cd docs && git add --all && git commit -m "Publishing to gh-pages (publish.sh)"

#echo "Pushing to github"
git push --all
