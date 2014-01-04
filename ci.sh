#!/bin/bash

source "$HOME/.rvm/scripts/rvm"
rvm use 2.0.0

which bundle || gem install bundler --version 1.5.1
bundle install && bundle exec rake
