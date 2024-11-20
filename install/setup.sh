#!/bin/bash

# If it receives one parameter, it will clone that repo
# otherwise, it assumes the repo is already accessible in `match-my-fashion-public-CodeCreators`

# docker build -t ruby-ssh .
# or to see command output
# docker build -t ruby-ssh . --progress plain

# Binding to host folder (linux)
#   docker run -d -p 8080:3000 --mount type=bind,src="$(pwd)",target=/home/match-my-fashion-public-CodeCreators --name test_container ruby-ssh

# Binding to host folder (windows)
#   docker run -d -p 8080:3000 --mount type=bind,src="%cd%",target=/home/match-my-fashion-public-CodeCreators --name test_container ruby-ssh

# With ssh
#   docker run -d -p 8080:3000 -p 3001:22 --mount type=bind,src="%cd%",target=/home/match-my-fashion-public-CodeCreators --name test_container ruby-ssh

# to connect to the docker
#   docker exec -it test_container bash
# and run the server
#   rails server -b 0.0.0.0 -p 3000

# clone repo
#   git clone https://github.com/vibalcam/match-my-fashion-public-CodeCreators
# git clone if parameter provided, if not ignore
if [ $# -eq 1 ]
then
    echo "Cloning repo..."
    git clone "$1"
fi

# install prerequisites packages, rvm and ruby
echo ""
echo "--------------------------------------"
echo "Installing prerequisites and rvm..."
echo "--------------------------------------"
sleep 2

cd match-my-fashion-public-CodeCreators/install
source setup_rvm.sh

# install ruby
rvm install ruby-3.2.2

echo ""
echo "--------------------------------------"
echo "Installing postgres"
echo "--------------------------------------"
sleep 2
# read -p "Press [Enter] key to continue..."

# install postgres
sudo apt install -y postgresql postgresql-contrib libpq-dev -y
# start postgres server
sudo service postgresql start
# make it start automatically at startup
sudo update-rc.d postgresql defaults
# create user for app
sudo -u postgres --  psql -c "CREATE USER beaverthing WITH PASSWORD 'beaverthing';"
# give user permissions
sudo -u postgres --  psql -c "alter user beaverthing createdb;"
# sudo -u postgres --  psql -c "alter user beaverthing superuser createrole createdb replication;"

# Should not be required to create databases (db:create should do it)
# if it does not work, do it manually as follows

# # create required databases
# sudo -u postgres --  psql -c "create database workspace_development;"
# sudo -u postgres --  psql -c "create database workspace_test;"
# # give access to databases to app user
# sudo -u postgres --  psql -c "GRANT ALL PRIVILEGES ON DATABASE workspace_development to beaverthing;"
# sudo -u postgres --  psql -c "GRANT ALL PRIVILEGES ON DATABASE workspace_test to beaverthing;"
# sudo -u postgres --  psql -c "ALTER DATABASE workspace_development owner to beaverthing;"
# sudo -u postgres --  psql -c "ALTER DATABASE workspace_test owner to beaverthing;"

# echo ""
# echo "--------------------------------------"
# echo "Installing brew"
# echo "--------------------------------------"
# sleep 2
# # read -p "Press [Enter] key to continue..."

# # install brew (required later)
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /root/.bash_profile
# echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bash_profile
# echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /root/.profile
# echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.profile
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# sudo apt-get install -y build-essential

# # install brew packages for the app
# brew install imagemagick


echo ""
echo "--------------------------------------"
echo "We will now bundle app"
echo "--------------------------------------"
sleep 2
# read -p "Press [Enter] key to continue..."

cd ..

gem install bundler
gem update --system

# # for ruby 2.4 with therubyracer
# sudo apt install libv8-dev
# gem install bundler -v 2.3.26
# gem update --system 3.2.3
# bundle config build.libv8 --with-system-v8
# gem uninstall libv8
# brew install v8
# gem install therubyracer

# install all gems (and hope for the best)
bundle install
bundle config set force_ruby_platform true
echo ""
echo "--------------------------------------"
echo "Setting up the database..."
echo "--------------------------------------"
sleep 2
# read -p "Press [Enter] key to continue..."

# setup tables
rails active_storage:install
rake db:create
rake db:migrate
rake db:seed
# bin/rails db:create RAILS_ENV=development
# bin/rails db:migrate RAILS_ENV=development
# bin/rails db:seed RAILS_ENV=development

# setup for test
rake db:test:prepare

echo ""
echo "--------------------------------------"
echo "Setup finished!, starting server on port 3000 (or localhost:8080 if port mapped on docker)..."
echo "--------------------------------------"
sleep 2
# read -p "Press [Enter] key to continue..."

# Start server
# it starts in port 3000
# if using docker with -p 8080:3000 option, you can also use localhost:8080
rails server -b 0.0.0.0 -p 3000

# if every works, that's great!
# if not, try using docker-compose
# GOOD LUCK!
