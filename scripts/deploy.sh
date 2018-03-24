#!/bin/bash
set -x
if [ $TRAVIS_BRANCH == 'master' ] ; then
    # Initialize a new git repo in _site, and push it to our server.
    openssl aes-256-cbc -K $encrypted_a79c3ded4ca6_key -iv $encrypted_a79c3ded4ca6_iv -in deploy_key.enc -out deploy_key -d
    rm deploy_key.enc
    chmod 600 deploy_key
    mv deploy_key ~/.ssh/id_rsa
    openssl aes-256-cbc -K $encrypted_a79c3ded4ca6_key -iv $encrypted_a79c3ded4ca6_iv -in host_key.enc -out host_key -d
    rm host_key.enc
    cat host_key >> ~/.ssh/known_hosts

    git init
        
    git remote add deploy "deploy@felipequintanilla.cl:/apps"
    git config user.name "Travis CI"
    git config user.email "travisCI@mail.com"
    
    git add .
    git commit -m "Deploy"
    git push --force deploy master
else
    echo "Not deploying, since this branch isn't master."
fi

