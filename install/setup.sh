#!/bin/bash

# If it receives one parameter, it will clone that repo
# otherwise, it assumes the repo is already accessible in `match-my-fashion-public-CodeCreators`

# docker build -t ruby-ssh .

# With ssh
# docker run -d -p 8080:3000 -p 3001:22 --name test_container ruby-ssh
# Without ssh
# docker run -d -p 8080:3000 --name test_container ruby-ssh
# Binding to host folder (linux)
# docker run -d -p 8080:3000 --mount type=bind,src="$(pwd)",target=/home/match-my-fashion-public-CodeCreators --name test_container ruby-ssh
# Binding to host folder (windows)
# docker run -d -p 8080:3000 --mount type=bind,src="%cd%",target=/home/match-my-fashion-public-CodeCreators --name test_container ruby-ssh

# docker exec -it test_container bash
# rails server -b 0.0.0.0 -p 3000

# install prerequisites packages
apt install sudo software-properties-common git -y
# other non-necesary but useful
apt install nano tmux
# install rvm
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm -y
source /etc/profile.d/rvm.sh
echo "source /etc/profile.d/rvm.sh" >> ~/.bashrc

read -p "We will now install rvm and ruby \nPress [Enter] key to continue..."

# update rvm
command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
rvm get stable
# install ruby
rvm install ruby-2.4.1

# clone repo
# git clone https://github.com/vibalcam/match-my-fashion-public-CodeCreators
# git clone if parameter provided, if not ignore
if [ $# -eq 1 ]
then
    echo "Cloning repo..."
    git clone "$1"
fi

read -p "We will now install postgres \nPress [Enter] key to continue..."

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

read -p "We will now install brew \nPress [Enter] key to continue..."

# install brew (required later)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /root/.bash_profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bash_profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sudo apt-get install build-essential

read -p "We will now bundle app \nPress [Enter] key to continue..."

# install gem files and dependencies
# sudo apt install libv8-dev
cd match-my-fashion-public-CodeCreators
gem install bundler -v 2.3.26
gem update --system 3.2.3
# fixes error regarding installing libv8
bundle config build.libv8 --with-system-v8
# fixes error installing regarding therubyracer
gem uninstall libv8
brew install v8
gem install therubyracer
# install all gems (and hope for the best)
bundle install

read -p "We will now setup database \nPress [Enter] key to continue..."

# setup tables
source /etc/profile.d/rvm.sh
bin/rails db:create RAILS_ENV=development
bin/rails db:migrate RAILS_ENV=development
bin/rails db:seed RAILS_ENV=development

# Start server
# it starts in port 3000
# if using docker with -p 8080:3000 option, you can also use localhost:8080
read -p "All setup, initializying server on port 3000 (or localhost:8080 on host if docker) \nPress [Enter] key to continue..."
rails server -b 0.0.0.0 -p 3000

# if every works, that's great!
# if not, try using docker
# GOOD LUCK!
