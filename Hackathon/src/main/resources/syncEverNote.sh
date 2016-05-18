#!/usr/bin/env bash

mail_from=XXXX
mail_to=XXXX
mail_pass=XXX #TODO: Update the password

AS_User=XXXX

rm -r /fse/temp/ariya/evernote/abala #Place to store the imported notes for every run
cd /fse/temp/ariya/evernote
echo "Syncing from Evernote :: $(date)"
java -jar evernote-1.0-SNAPSHOT-jar-with-dependencies.jar /fse/temp/ariya/evernote
echo "Syncing to AlphaSense"
XXXX/smtp-cli.pl --server smtp.gmail.com --from $from --to $to --enable-auth --user $AS_User --pass $mail_pass $
echo "Hurray !!!! Sync done"