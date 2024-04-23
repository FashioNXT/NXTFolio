[![Maintainability](https://api.codeclimate.com/v1/badges/0728492bc199d77a82b7/maintainability)](https://codeclimate.com/github/FashioNXT/NXTFolio/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/0728492bc199d77a82b7/test_coverage)](https://codeclimate.com/github/FashioNXT/NXTFolio/test_coverage)

Heroku link - https://nxtfolio.herokuapp.com/

# NXTFolio

[![Ruby on Rails CI](https://github.com/vibalcam/NXTFolio/actions/workflows/rubyonrails.yml/badge.svg)](https://github.com/vibalcam/NXTFolio/actions/workflows/rubyonrails.yml)

- [Setup and Testing:](#setup-and-testing)
  - [Recommended: Using docker-compose (Ubuntu 18.04 and selenium firefox)](#recommended-using-docker-compose-ubuntu-1804-and-selenium-firefox)
  - [Using Dockerfile (Ubuntu 18.04)](#using-dockerfile-ubuntu-1804)
  - [Run on Linux without docker (tested on AWS E2C, Ubuntu 18.04)](#run-on-linux-without-docker-tested-on-aws-e2c-ubuntu-1804)
  - [Helpful fixes](#helpful-fixes)
- [How to Deploy :](#how-to-deploy)
- [Using AWS S3 as Image Backend](#using-aws-s3-as-image-backend)
- [Country/States/Cities Database](#countrystatescities-database)
- [Geocoding](#geocoding)
- [What will you see on the web app?](#what-will-you-see-on-the-web-app)
- [To get started](#to-get-started)
- [Home Page Features](#home-page-features)
- [Search Features](#search-features)
- [Rating Featues](#rating-featues)
- [Forgot Password Feature:](#forgot-password-feature)
- [Job Feature:](#job-features)
- [Tag features:](#tag-features)
- [Travel features:](#travel-features)
- [Gallery features:](#gallery-features)
- [CRM API:](#How-to-add-NXTFolio-to-the-CRM)
- [Contact:](#contact)

<!-- ## (OLD) DEMO
https://sheltered-woodland-21494.herokuapp.com/


Click on the above link, and open the demo app. The Facebook login feature will not work, as a result of privacy reasons, I took down the app developers account for it.
Get Facebook Login to function:
1. Create Facebook developers acccount  [https://developers.facebook.com/](https://developers.facebook.com/)
2. Create a facebook login app 
3. Use the API key of Facebook app, in the source code. You can find the required details in the document.
4. Start serving Facebook login easily -->

## Setup and Testing

Go to `config/environments/test.rb` and set `config.use_remote_webdriver` to true if using docker-compose, and to false otherwise.

### Recommended: Using docker-compose (Ubuntu 18.04 and selenium firefox)

This is the fastest way to get started. 
It uses docker-compose to set up two containers
- ruby: container with the app and in which you will be developing
- browser: container with selenium web driver needed for testing with cucumber

The files to setup docker-compose can be found in the `install` folder.

0. If you are using M1 chip, change in `docker-compose.yml` the `browser` image to 
 
    `image: seleniarm/standalone-firefox`

1. Clone the repository

    ```bash
    git clone https://github.com/vibalcam/match-my-fashion-public-CodeCreators --config core.autocrlf=input
    ```

2. Go into the `install` folder

    ```bash
    cd install
    ```

3. Build and start the containers for docker-compose (-d used to do start in detach mode)

    ```bash
    docker-compose up -d
    ```

    The project folder has been binded to `/home/match-my-fashion-public-CodeCreators`.
    In other words, it is shared by the container and host so it you can continue developing in your host machine.

4. Run a bash terminal on the ruby container

    ```bash
    docker-compose exec ruby bash
    ```

5. Copy the setup script and cd to home

    ```bash
    cd /home
    cp match-my-fashion-public-CodeCreators/install/setup.sh .
    sudo chmod +x setup.sh
    ```

6. Run `setup.sh` script and follow the instructions (more details about what it does can be found in `install/setup.sh`)

    ```bash
    source setup.sh
    ```

    If you run into trouble, try looking the script since the comments might help.

7. You should be set. Whenever you want to run the server just run

    ```ruby
    rails server -b 0.0.0.0 -p 3000
    ```
    
8.  To connect to the website go to:

    [http://localhost:8080](http://localhost:8080)


When you are done developing, you can stop the docker-compose 

```bash
cd install
docker-compose stop
```

The next time you want to connect you just have to run the following:

```bash
cd install
docker-compose start
```

or start the docker-compose from the desktop app.

#### Running Tests

In the root directory, run "rails cucumber"
When running cucumber tests (`rails cucumber`), you can access the following website to see what the tests are doing

[http://localhost:7900/?autoconnect=1&resize=scale&password=secret](http://localhost:7900/?autoconnect=1&resize=scale&password=secret)

This combined with the cucumber step `When I debug` is a powerful tool to debug the cucumber tests.


##### Possible issues ->

1. Capybara Timeout issue : Go to /install -> docker-compose down -> docker-compose up -d -> run setup steps from step 4 above.


### Using Dockerfile (Ubuntu 18.04)

This is the fastest way to get started. 
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

        source setup.sh

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

- **Changes to css or javascript not reflecting on test**

    Try recompiling the assets by running `rake assets:clobber` and `rake assets:precompile`.

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
    
- **Error: Is the server running on host "127.0.0.1" and accepting TCP/IP connections on port 5432?**

    First go to the setup script and try to run all the postgres related commands

        sudo apt install -y postgresql postgresql-contrib libpq-dev -y

    If an error occurs involving the "dpkg is locked" then there are other processes trying to use apt. You need to kill these processes

    To get a list of processes using apt run the follow command 

        ps aux | grep -i apt

    Hopefully it will show that some other processes are trying to use apt, kill these processes by running

        sudo kill <process_id>

    Once the processes are killed try installing postgres again using the lines specified in the setup script.


<!-- ### (OLD) How to start a local server:

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

        rails db:migrate 
        rails db:seed
    
    Useful to check migration status if something goes wrong:
    
        rake db:migrate:status

7. Start the rails server

        rails server

8. The local server will start on the following link

    [http://localhost:3000](http://localhost:3000) -->

9. Execute tests as follows:
      bundle exec rails
      bundle exec cucumber

## How to Deploy 

1. heroku create -a [appname]
2. heroku config:set AWS_ACCESS_KEY=AKIAV5IDIKICCNPVFZ3U
3. heroku config set AWS_BUCKET=nxtfolio-s3 
4. heroku config:set AWS_REGION=us-west-2
5. heroku config:set AWS_SECRET_KEY=/q8xUNLrsVtMOmE+h2UsyKjjJyQA04PcIQcz+f22
6. heroku addons:create heroku-postgresql:essential-2
7. git push heroku master
8. heroku run rails db:migrate
9. heroku run rails db:seed

## Using AWS S3 as Image Backend

If you wish to use the S3 image backend (allowing images to be saved for more than 2 days), you will need to create an S3 bucket(AWS_BUCKET). You will then need to set AWS_BUCKET, AWS_SECRET_KEY ,  AWS_ACCESS_KEY and AWS_REGION so that Rails can find that bucket. For local environments: 
    ```AWS_SECRET_KEY=x AWS_ACCESS_KEY=y rails server```  where ```x``` and ```y``` are replaced by your account details from Amazon Web Services

For deployed Heroku environments: (assuming the site is already deployed)

```heroku config:set AWS_SECRET_KEY=x``` and then ```heroku config:set AWS_ACCESS_KEY=y```
  
## Country/States/Cities Database

To update the country/state/city database visit [countries-states-cities-database](https://github.com/dr5hn/countries-states-cities-database) to obtain the latest json file and replace it for the one located at `db/seed_files/countries+states+cities.json`.

Then run 

```bash
rake db:reset_countries
```

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
7. forgot Password option in the Sign In Page.
8. Search with keywords matching for profile’s name, bio, compensation type, and highlights. And filtering by country, state, city, and professions.  
9. Search results will be sorted by a logic based on rating, gallery numbers, names and location. 
10. Add/delete individual images in the gallery, also tag collaborate contributors to a gallery. 
11. Add travel information to users. 
12. Mobile view of each page. 


## To get started

1. Click on sign up and create your profile in 3 quick steps.  
2. Once your profile is created, you will be shown logged in to the account  
3. Click on my profile page, to see your profile information.  
4. If you want to edit your profile, you can click on the three main links available on the edit profile page. You can find two options, “Edit Personal Info” and “Edit Professional Info”. You can edit your profile according to your preferences  
5. Social Media handles are shown in the profile details page,  
6. You can add projects and upload up to 5 photos to the project. You can view the average project rating of your project. If you are the creator of the project, you will be able to find a link to creating the project. 

## Home Page Features

1. Home page will show the list of the projects based on current user’s city, state, and country. 
2. Buttons of Home page are updated and professional can see the projects filtered by specific professions. 
3. The professionals can see both the profile details and project details page link from the home page.  
4. The users can search directly from Home page now. 

## Search Features

1. The user can search from home page directly. 
2. The user can search with keywords matching for profile’s name, bio, compensation type, and highlights. And filtering by country, state, city, and professions. 
3. The search results will be sorted by a logic based on rating, gallery numbers, names and location. 
4. The users can also find travelling profiles during their travelling time. 
5. If there are no results for a search, the recommending profiles based on user’s location will be listed. 

## Rating Featues

1. The user can add star ratings from the profile page now in (1 to 5 scale).
2. To rate another professional, the user has to be signed in.
3. One can add only one rating to a project and edit their rating after that. A professional cannot rate their own project.


## Forgot Password Feature
    
1. The user can request a password reset  in their registered email address.
2. A temporary link (validity: 15 minutes) has been generated for the resetting password
3. After resetting, they will be redirected to the sign in page again.

## Job Features

1. The user can go to the pages to post jobs, edit jobs, and delete jobs. 
2. There is a separate search engine in which users can search for matching jobs. 

## Tag features

1. User can tag users in project to show that they work together to do a project. 
2. User can invite users to collaborate by sending email to others, and then the invitor can edit it directly from the link in project. 

## Travel features

1. User can add travel info in their profile. 
2. Travelling user will show up in search results. 

## Gallery features

1. The user can add and delete gallery in their profile page. 
2. The user can add/delete individual images in their gallery. (no more than 5) 
3. The user can edit their text info in a gallery. 

## AI Chatbot feature

For Deployed App: 
- Update the 'OPEN_AI_API_KEY' on Heroku website => Settings => Config Vars 
- In chat_service.rb, use the line: $@openaiClient = OpenAI::Client.new(access_token: ENV["OPEN_AI_API_KEY"],

For Running Locally:
- Set up local key on Terminal: $EDITOR="nano" bundle exec rails credentials:edit
- Add the line in the nano editor: $open_ai_api_key: YOUR-API-KEY
- In chat_service.rb, use the line: $@openaiClient = OpenAI::Client.new(access_token: Rails.application.credentials.open_ai_api_key,

## Possible Future Improvements
1. Developing an algorithm for recommending Profile, Projects, and Jobs
- An algorithm can be developed for displaying projects and profiles that are based on the user’s history or interest. Likewise, Jobs can also be recommended.
2. Fixing bugs and displaying the availability of a user based on the Travel dates
3. Tuning the Collaborator Comment Feature into a points based system
4. Introducing a new points/rating based system where users are not only given comment access based on their taggings/collaborations. They are given access when the number of points cross a certain threshold like 80. 
5. Mobile View
6. Reverse Image Search

## How to add NXTFolio to the CRM

1. Open the CRM either locally or on heroku
2. Login as admin (default admin information is in seed.rb)
3. Go to application management
4. Click the new applicaiton button
5. In the API URL add the home link of NXTFolio and then add /api/user to the end of it for example "https://nxtfolio.herokuapp.com/api/users
6. Fill in the callback and the home page with the same values
7. The other fields are self explanatory
8. From here NXTFolio should be available on the left side menu to see the statistics

## Contact

Contact previous teams for testing, deployment and issues related to following features :

1. AI Chatbot -> liewgh1995@tamu.edu
2. Collaborator Commenting -> pisharan@tamu.edu, vasan2001@tamu.edu
3. Job Posting -> quanqi-hu@tamu.edu
4. CRM -> jubey.s.garza@tamu.edu
5. General -> sknc@tamu.edu
