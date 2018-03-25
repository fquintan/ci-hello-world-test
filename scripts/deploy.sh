#!/bin/bash
set -x
if [ $TRAVIS_BRANCH == 'master' ] ; then
    # Initialize a new git repo in _site, and push it to our server.
    openssl aes-256-cbc -K $encrypted_a79c3ded4ca6_key -iv $encrypted_a79c3ded4ca6_iv -in secure_files.tar.enc -out secure_files.tar -d
    tar xvf secure_files.tar
    chmod 600 id_rsa
    mv id_rsa ~/.ssh/id_rsa

    cat host_key >> ~/.ssh/known_hosts

    git init
        
    git remote add deploy deploy@felipequintanilla.cl:/home/deploy/apps/hello

    git config user.name "Travis CI"
    git config user.email "travisCI@mail.com"
    
    git add .
    git commit -m "Deploy"
    git push --force deploy master
else
    echo "Not deploying, since this branch isn't master."
fi

