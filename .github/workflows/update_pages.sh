#!/usr/bin/env bash
BRANCH=gh-pages
OUTPUT_FOLDER=result

echo -e "Starting to deploy to GitHub Pages\\n"
echo -e "$WORKFLOW"
if [ "$WORKFLOW" == "Build" ]; then
    git config --global user.email "action@github.com"
    git config --global user.name "GitHub Action"
fi
# Using token, clone gh-pages branch
git clone --depth 1 --quiet --branch=$BRANCH "https://$GITHUB_TOKEN@github.com/$TARGET_REPO" build > /dev/null 2>&1
# Go into directory and copy data we're interested in to that directory
cd build || exit 1
rsync -avvL --inplace --no-whole-file --delete --exclude=.git  ../$OUTPUT_FOLDER/ ./
# Add, commit and push files
git add --all .
git commit --allow-empty -m "build $RUN_NUMBER pushed to GitHub Pages"
git push -fq origin $BRANCH > /dev/null
echo -e "Deploy completed\n"
