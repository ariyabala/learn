# Hackathon - Evernote
This project is the outcome of Hackathon on May 11 - May 14 2016
It was a POC to integrate Evernote into AlphaSense system

Below steps enable to import Evernote notes from all notebooks into AS as UserDoc with each Evernote as its attachment

# Update the EDAMDemo.java with your dev token on AUTH_TOKEN variable
# Build and package the project using 
    mvn clean compile assembly:single
# Update the syncEverNote.sh with appropriate credentials
# Place the built evernote-1.0-SNAPSHOT-jar-with-dependencies.jar in the appropriate path as referred in the sync script
# Configure the script in a cron for ex, so that it imports the notes from Evernote and sends the html version of Notes to AS via Email Gateway

