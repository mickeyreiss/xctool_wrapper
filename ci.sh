#!/bin/bash

which bundle || gem install bundler --version 1.5.1
bundle install && bundle exec rake
