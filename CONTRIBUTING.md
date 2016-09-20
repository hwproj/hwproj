# Contributing

This tutorial covers basic commands for cloning and running HwProj on a Linux/macOS machine. Windows environment may differ and is not covered here.

### Install Ruby and Bundler

Install Ruby with [ruby-install](https://github.com/postmodern/ruby-install), it's easier to work with than with RVM. We curretly use Ruby 2.2.3. [chruby](https://github.com/postmodern/chruby) switches Ruby versions automatically when `.ruby-version` file is present.

Run `gem install bundler`. Bundler is used to install all needed gems (Ruby libraries) for a project.

Run `echo "gem: --no-document" >> ~/.gemrc` if you want to skip local documentation install which can speed up gems installation.

### Project setup

Fork the [repo](github.com/auduchinok/hwproj) on GitHub.

```sh
git clone git@github.com:auduchinok/hwproj.git
# and add a git remote for your fork

# change the working directory to the project
cd hwproj

# install gems specified in the project Gemfile
bundle install --without production

# set up a new database
rake db:migrate
```

### Running a local server

```sh
# launch a local server
rails s

# launch ruby console with loaded app
rails c
```

### Rails console

```ruby
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
