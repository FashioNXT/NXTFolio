# NXTFolio

- [(OLD) DEMO](#old-demo)
- [Install local server](#install-local-server)
  - [Using Dockerfile (Ubuntu 18.04)](#using-dockerfile-ubuntu-1804)
  - [Run on Linux without docker (tested on AWS E2C, Ubuntu 18.04)](#run-on-linux-without-docker-tested-on-aws-e2c-ubuntu-1804)
  - [Helpful fixes](#helpful-fixes)
  - [(OLD) How to start a local server:](#old-how-to-start-a-local-server)
- [Using AWS S3 as Image Backend](#using-aws-s3-as-image-backend)
- [Geocoding](#geocoding)
- [What will you see on the web app?](#what-will-you-see-on-the-web-app)
- [To get started](#to-get-started)
- [Home Page Features](#home-page-features)
- [Search Features](#search-features)
- [Rating Featues](#rating-featues)
- [Forgot Password Feature:](#forgot-password-feature)

## (OLD) DEMO
https://sheltered-woodland-21494.herokuapp.com/


Click on the above link, and open the demo app. The Facebook login feature will not work, as a result of privacy reasons, I took down the app developers account for it.
Get Facebook Login to function:
1. Create Facebook developers acccount  [https://developers.facebook.com/](https://developers.facebook.com/)
2. Create a facebook login app 
3. Use the API key of Facebook app, in the source code. You can find the required details in the document.
4. Start serving Facebook login easily

## Install local server

### Using Dockerfile (Ubuntu 18.04)

This is the fastest way to getting started. 
The Dockerfile and script to automatically setup app can be found in the `install` folder.

1. Clone the repository

        git clone https://github.com/vibalcam/match-my-fashion-public-CodeCreators --config core.autocrlf=input

2. Build the Dockerfile using

        docker build -t ruby-ssh install/

3. Run docker container

    If using Windows:

        docker run -d -p 8080:3000 --mount type=bind,src="%cd%",target=/home/match-my-fashion-public-CodeCreators --name test_container ruby-ssh

    If using Linux:

        docker run -d -p 8080:3000 --mount type=bind,src="$(pwd)",target=/home/match-my-fashion-public-CodeCreators --name test_container ruby-ssh

    We are mapping port 3000 (used by rails server) to 8080 in the host. 
    
    We are also binding the project folder to `/home/match-my-fashion-public-CodeCreators` so it is shared by the container and host.

4. Connect to terminal in container

        docker exec -it test_container bash

5. Copy the setup script and cd to home

        cd /home
        cp match-my-fashion-public-CodeCreators/install/setup.sh setup.sh
        sudo chmod +x setup.sh

6. Run `setup.sh` script and follow the instructions (more details about what it does can be found in `install/setup.sh`)

        ./setup.sh

    If you run into trouble, try looking the script since the comments might help

7. You should be set. Whenever you want to run the server just run

        rails server -b 0.0.0.0 -p 3000
    
9. To connect to the website go to:

        [http://localhost:8080](http://localhost:8080)


### Run on Linux without docker (tested on AWS E2C, Ubuntu 18.04)

1. Copy `install/setup.sh` to folder where you want to download the app
2. Give permission to run the script

        sudo chmod +x setup.sh

3. Run `setup.sh` script (more details about what it does can be found in `install/setup.sh`)

    If you have already cloned the repo:

        ./setup.sh

    If you have just copied the script:

        ./setup.sh https://github.com/vibalcam/match-my-fashion-public-CodeCreators

    If you run into trouble, try looking the script since the comments might help

4. You should be set. Whenever you want to run the server just run

        rails server -b 0.0.0.0 -p 3000

5. To connect to the website go to:

        [http://localhost:8080](http://localhost:8080)

### Helpful fixes

- **env: ruby\r: No such file or directory**

    Windows uses a different line ending to linux, which is makes linux not read correctly windows files.
    Use `git clone url --config core.autocrlf=input` or `dos2unix` linux package to fix.
    
- **error: Homebrew on Linux is not supported on ARM processors**

    Problem with M1 chip macOS - brew not available for arm64 processor. Use platform option in docker build and run commands.
    
        docker build --platform linux/amd64 -t ruby-ssh install/
        docker run -d -p 8080:3000 --platform linux/amd64 --mount type=bind,src="$(pwd)",target=/home/match-my-fashion-public-CodeCreators --name nxtfolio ruby-ssh
    
- **error: brew not found**

    Make sure to run the steps which are displayed in console after installing brew.
    
        (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /root/.profile
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


### (OLD) How to start a local server:

1. git clone the repository to your local machine  
    `https://github.com/vibalcam/match-my-fashion-public-CodeCreators`
2. Once the files are downloaded, follow the standard procedure of installing ruby on rails. 
   Click [here](https://gorails.com/setup/ubuntu/17.10)
3. It is recommended to use `rvm` over `rbenv`. 
4. Once Ruby on Rails is installed, you have to install the dependencies available in gem file. 
   Important to note that the dependencies and other rail commands will only work, when installed rails version and ruby version matches the versions mentioned in Gemfile.
5. To ensure same versions are installed, open  Gemfile, and check ruby version. Do the following:
   
        rvm install 2.4.1
        rvm use 2.4.1

6. Install the bundler
    
        gem install bundler
    
    If you run into an error for libv8, try 
        
        bundle config build.libv8 --with-system-v8

7. Bundle install to install all the dependencies in Gemfile

        bundle install

8. Start the rails server

        rails server

9.  The local server will start on the following link
    
    [http://localhost:3000](http://localhost:3000)

If there is any problem about pg database. Try the steps below:

1. Install postgres

        brew update
        brew install postgres

2. open PG console

    For Ubuntu 18:

        sudo su - postgres
        psql

    If that does not work, open another terminal to run PG server

        postgres -D /usr/local/var/postgres

    Open PG console (Open one more terminal to run the code below)

        psql postgres

4. Create admin user (more details in /config/database.yml)

        create user beaverthing;
        \password beaverthing

    type in password(beaverthing) twice

    If that does not work, you can also try

        create password beaverthing;

    Make sure to give the correct roles to the user created and to create the databases with that user.
    These commands in the psql terminal might help:

        GRANT ALL PRIVILEGES ON  DATABASE database_name to new_user;

        ALTER DATABASE database_name owner to new_user;

5. Create database follow the previous team’s setting

        create database workspace_development;
    
        create database workspace_test;

        create database workspace_production;

    PG console setting completed. You can close the console here.

6. Generate table with database

        bin/rails db:migrate RAILS_ENV=development
    
    Useful to check migration status if something goes wrong:
    
        rake db:migrate:status

7. Start the rails server

        rails server

8. The local server will start on the following link

    [http://localhost:3000](http://localhost:3000)
    
## Using AWS S3 as Image Backend

If you wish to use the S3 image backend (allowing images to be saved for more than 2 days), you will need to create an S3 bucket(AWS_BUCKET). You will then need to set AWS_BUCKET, AWS_SECRET_KEY ,  AWS_ACCESS_KEY and AWS_REGION so that Rails can find that bucket. For local environments: 
    ```AWS_SECRET_KEY=x AWS_ACCESS_KEY=y rails server```  where ```x``` and ```y``` are replaced by your account details from Amazon Web Services

For deployed Heroku environments: (assuming the site is already deployed)

```heroku config:set AWS_SECRET_KEY=x``` and then ```heroku config:set AWS_ACCESS_KEY=y```
   
## Geocoding

For searching by location, a Google Geocoding API key will be required. This must be set as an environment variable (see Using AWS S3... above) with the name "GOOGLE_KEY".

Once this key is set, it is necessary to run "rake geocode:all CLASS=GeneralInfo" to populate the gecoded fields. For Heroku environments, prepend the previous command with "heroku run".
    
## What will you see on the web app?

1. Home page with project view 
2. Login/Signup, Search
3. My Profile
4. Rating/ Review feature on application
5. Admin user has been added, with privilege for using the admin APIs. This is only available to the single admin user, added by the developer. Contact admin for help
6. Direct Messaging (DM) and Notification feature on Profile Details page.
7. orgot Password option in the Sign In Page.


## To get started

1. Click on sign up and create your profile in 3 quick steps.
2. Once your profile is created, you will be shown logged in to the account
3. Click on my profile page, to see your profile information.
4. If you want to edit your profile, you can click on the three main links available on the edit profile page. You can find two options, “Edit Personal    Info” and “Edit Professional Info”.  You can edit your profile according to your preferences
5. Social Media handles are shown in the profile details page, 
6. You can add projects and upload up to 5 photos in the project. You can view the average project rating of your project. If you are the creator of the    project, you will be able to find a link of creating the project.

## Home Page Features

1. Home page will show the list of the projects sorted by their ratings. Most rated projects will appear first.
2. Buttons of Home page are updated and professional can see the projects filtered by specific professions
3. The professionals can see both the profile details and project details page link from the home page.
4. The users can search directly from Home page Now

## Search Features

1. The user can search from home page directly
2. Search matching algorithm now matches Full name (Previously not supported) and email on searching professionals. They can also search by category, profession, Country, city, and state.

## Rating Featues

1. The user can add star ratings from the profile page now in (1 to 5 scale).
2. To rate another professional, the user has to be signed in.
3. One can add only one rating to a project and edit their rating after that. A professional cannot rate their own project.


## Forgot Password Feature:
    
1. The user can request a password reset  in their registered email address.
2. A temporary link (validity: 15 minutes) has been generated for the resetting password
3. After resetting, they will be redirected to the sign in page again.
