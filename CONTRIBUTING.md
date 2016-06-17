# Contributing

This tutorial covers basic commands for cloning and running HwProj in a shell on Linux or OS X. It was not tested to run in a Windows envirounment which is very different.

### Install required tools

```sh
# Ruby and Ruby Version Manager
\curl -L https://get.rvm.io | bash -s stable --ruby

# Ruby gems manager
gem install bundler
```

### Get and setup HwProj

```sh
# fork the repo on GitHub
# clone it using command like the one below
# git clone git@github.com:auduchinok/hwproj.git 

# change the working directory to the project
cd hwproj

# install needed ruby gems specified in Gemfile
bundle install --without production

# set up a database
rake db:migrate
```

### Running (still in the project directory)

```sh
# launch a local server
rails s

# launch ruby console with project loaded
rails c
```

### Console

```sh
# find last user and show the name
User.last.name

# another way
u = User.all[-1]
u.name

# make the user a teacher
u.teacher!

# check whether a user is a teacher (and check if user exist, i.e. not nil)
User.find(5).teacher? unless User.find(5).nil?
```
