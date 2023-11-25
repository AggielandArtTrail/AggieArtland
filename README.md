# README

## GENERAL INTRODUCTION

The Aggieland Art Trail spans the entire Bryan-College Station area, showcasing art galleries, public art and installation in our community, including the Texas A&M University campus, and the George H.W. Bush Presidential Library and Museum. It is part of the volunteer mission of the Visual Art Society of Bryan-College Station for supporting art and artists in the Bryan-College Station area. 

## FUNCTIONALITIES

Administrators can add art pieces with their information and locations to our app. When users check-in at a certain art piece on the map, a stamp is awarded. Badges are awarded at certain milestones (such as a particular number of stamps collected), defined by administrators. Users can also find all art works in their vicinity. The path the user traveled would be recorded and can be shared on social media together with all their visited art works.

## INSTALLATION 
1. Clone the repo: ```git clone https://github.com/AggielandArtTrail/AggieArtland.git```
2. Install dependencies: `bundle install`
3. Install migrations: `rails db:migrate`
4. Seed the database: `rails db:seed`
5. Run the server: `rails server`
6. Access website on: `http://127.0.0.1:3000`

## TESTING
1. Run 'rails db:migrate RAILS_ENV=test'
2. To run Cucumber tests: `bundle exec cucumber`
3. To run RSpec tests: `bundle exec rspec`


## SETUP AWS FOR RAILS ACTIVE STORAGE:
   - Follow this Medium article (**skip** the "Setting up Active Storage" section and steps 4 and 5 of the "Adding AWS credentials to rails app" section), using 
`aggie-art-dev` and `aggie-art-prod` as the S3 bucket names: https://medium.com/@rmg007/rails-6-0-upload-images-using-active-storage-and-amazon-simple-storage-service-amazon-s3-36861c03dc4a
   
   - Note for creating the IAM user: 
     - Access key can be created after you create the user
     - Select "Attach Policies Directly" on the "Set Permissions" screen
     - Click "Create Policy"
     - Select JSON instead of Visual editor and paste in policy from article step #6, with the bucket names substituted in (aggie-art-dev and aggie-art-prod)
     - Click next, give the policy a name, finish the policy
     - Go back to the user "Set Permissions" page, refresh the policies and search for the policy you just made
     - Select the policy and click next, then create user
     - Click into the user, then click on the "Security credentials" tab
     - Scroll down to "Access keys" and hit "Create access key"
     - Select any option (they are just best practice warnings), click next, set a description if needed and click next.
     - Download the `.csv` file and continue following the Medium article.
   
   - Remember to substitute the bucket names! 
   - If `credentials:edit` doesn't work with VSCode, try with vi or vim (e.g. `EDITOR="vi" bin/rails credentials:edit`)
   - For production: 
     - Repeat the `credentials:edit` step for the production environment" (`EDITOR="vi" bin/rails credentials:edit --environment production`)
     - Run `bundle exec rake secret`, and copy the outputted secret key
     - In `config/environments/production.rb`, change the `config.secret_key_base` to the generated secret key from the last step
   - The `credentials:edit` command generates a `master.key` file (under `config/`) and the production one generates a `production.key` file (under `config/credentials`). The contents of these need to be set as environment variables in Heroku (shown later in the Heroku section)
   
   - **OPTIONAL:** If you want to host/modify the hosted icons (like map markers, default art piece icons, etc.): 
     - Create a new S3 bucket called `aggie-art-public`, unchecking "Block all public access" 
     - Click into the bucket, go to the "Permissions" tab
     - Edit the "Bucket policy" and paste the below:
       ```
       {
           "Version": "2012-10-17",
           "Statement": [
               {
                   "Sid": "PublicReadGetObject",
                   "Effect": "Allow",
                   "Principal": "*",
                   "Action": "s3:GetObject",
                   "Resource": "arn:aws:s3:::aggie-art-public/*"
               }
           ]
       }
       ```
     - Replace all references in the code from `https://aggie-art-public.s3.us-east-2.amazonaws.com/` to your AWS domain for images you upload to your public bucket


## HOSTING THE APP ON HEROKU

### Prerequisites

Make sure you have everything you will need for hosting your application on Heroku

Heroku Account: Sign up for free at heroku.com 
Note: Heroku is a service that allows you to host and manage your applications.

Git Installed: Install Git from git-scm.com 
Note: Git is a version control system that tracks changes in your files. It allows you to create snapshots (commits) of your work, experiment with different ideas using branches, and merge changes seamlessly.

Rails App: Make sure you have a Ruby on Rails app ready. 


### Getting started

Install Heroku:  We need to install Heroku. Click here to download and install Heroku.

Login to Heroku: Open your terminal or command prompt. Ensure your terminal is open in the project directory. If not, navigate to your project folder using the cd command. Now type in

heroku login

If Rails app is not a Git repository, let’s make it one. Type the following commands in the terminal.
	
	git init
	git add .
	git commit -m “Initial commit”

Create Heroku app: Let’s create an app on Heroku
	
	heroku create <Insert App Name> 

Add a Database: We will need to add on a database to our app
	
	heroku addons:create heroku-postgresql

Edit the Cofig Variables in Heroku: Navigate to the setting og your Heroku app. Add the following cofig variables to the already existing ones.

`RAILS_MASTER_KEY`: master key (the contents of `config/credentials/production.key`) 

`SECRET_KEY_BASE`: `config.secret_key_base` value from `config/environments/production.rb`

See the AWS section if you don't recognize these values.

Push Code to Heroku: Time to send the application to Heroku

	git push heroku main

Migrate the Database: Now we’ll set up the database that was added previously.

	heroku run rake db:migrate

Open your App: To see the app live
	
	heroku open -a <Insert App Name>

 

	
	
	





