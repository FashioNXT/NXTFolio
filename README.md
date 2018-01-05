How to start a local server:
1. git clone the repository to your local machine  ex: (git clone https://github.tamu.edu/avinsaxe/match-my-fashion_old.git)
2. Once the files are downloaded, follow the standard procedure of installing ruby on rails. Click here to get started https://gorails.com/setup/ubuntu/17.10
3. It is recommended to use rvm over rbenv. It worked better for us.
4. Once Ruby on Rails is installed, you have to install the dependencies available in gem file. 
Important to note that the dependencies and other rail commands will only work, when installed rails version and ruby version matches the versions mentioned in Gemfile.
5. To ensure same versions are installed, open  Gemfile, and check ruby version. Do the following:
   a. rvm install 2.4.1    #(2.4.1 is the version used in Gemfile)
   b. rvm use 2.4.1       #(once installed start using it)
6. gem install bundler
7. bundle install
8. rails server  

The last command will start the rails server and you can access the web app on localhost:3000

What will you see on the web app?
1. Home page
2. Login/Signup, Search
3. My Profile


a. Facebook Login is supported.
b. Search uses regular expressions
c. Admin user has been added, with privilege for using the admin APIs

Features Implemented:
1.	Search Feature with Regex
Before: 
Search implemented earlier was non-regex based and was implemented using OR operator. This resulted in unnecessary results, sometimes too many results for user to handle.
Now:
I wanted our user to have the ability to generalize the search based on few of the input parameters, without the hassle of creating his own regular expression. This kind of search incorporating the below parameters is very strong, and can be used to narrow down to very relevant results.

Idea:
1.	Use search parameters like
a.	Contains- Matches any data which contains the searched word
b.	Starts With- Matches any data which starts with the searched word 
c.	Ends With- Matches any data which ends with the searched word
d.	Exactly Matches- Matches any data that exactly matches the searched word
Notes:
1.	You can always choose to keep the default value of contains in the regular expression-based search, which guarantees the best possible results without any hassle of choosing a regular expression.
2.	You can keep all the search fields blank for the search, and in that case, the page displays all the possible search results. Simply put, all the fields in the search are totally optional and any combination of search parameters can be utilized to improve the search results.

2.	These search features are used with specific search options like-
a.	First name
b.	Last Name
c.	City
 

2.	Bugs Resolved:

1.	Sign In/Sign Up button home page fixed
When the user logged-in, the sign-in and sign-up page wouldn’t disappear from the index page, and thus the option of sign-in and sign-up was available to the user, which is wrong.

I fixed this, by checking the session. If the session contains the current user key, it should not display the sign-in and sign-up button on index page.

                      Before user signs in, the page displays log-in/sign-up buttons
 
After user signs in, the page changes to 
Based on session, the sign-in and sign-up button are either displayed or not displayed.


2.	States and Country available in Search Page

Earlier search parameters didn’t include the country and didn’t make states available for user. Now I have included the country parameter in the search form, and included the states as a select option in the drop-down list.

Now the search will support country-based search as well.

RESOLVED ADDITIONAL QUERIES FROM CUSTOMER


1. Query: Is there any feature to Contact the person after user finds the match? 
a. I am now displaying phone number of person, in the show profile page. 
b. I have added phone number in the create page
c. I have also added the phone number in the search page
Resolved the bug of displaying social links, when they were empty. Now links will be displayed only if the links are present.
Same goes for phone number.

 

Improved search criteria: Added email id in the search criteria

Had to change data model and lot of other things, as I believe search via email id is tremendously powerful. The add-on may look straight-forward,
but I had to change a lot in the background.
Now you can either search by email id, or choose to search like before. Here are the example images
Email id also has the regex-based search, involving contains, starts with, ends with and exactly matches.


 
