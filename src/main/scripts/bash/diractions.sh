#!/bin/sh

find -iname "schema.xml" | grep statements | xargs -I path ls -latr path