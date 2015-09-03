#!/bin/sh

#  backup.sh
#  
#
#  Created by Robert Schmicker on 5/4/15.
#

#Insert information here for file name formating
#################################################################
pc=TYPE_OF_COMPUTER
type=DIRECTORY_NAME
#################################################################

date=$(date "+%F")

#Insert file directories, temp ftp directory is needed (I know not the best implementation but it works)
#################################################################
backupwhat=WHAT_TO_BACKUP
googledrive=GOOGLE_DRIVE_DIRECTORY/$pc-$type-$date.tgz
onedrive=ONE_DRIVE_DIRECTORY/$pc-$type-$date.tgz
tempftp=$HOME/Temp_Documents/$pc-$type-$date.tgz
#################################################################

tar -cZf "$googledrive" $backupwhat
tar -cZf "$onedrive" $backupwhat
tar -cZf "$tempftp" $backupwhat
sudo chmod 777 "$googledrive"
sudo chmod 777 "$onedrive"

#FTP credentials and temp ftp directory
#################################################################
HOST=''
USER=''
PASSWD=''
#Location of temp ftp directory
cd TEMP_FTP_DIRECTORY/Temp_Documents/
FILE=$pc-$type-$date.tgz
ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
#Location for directory on ftp server
cd DIRECTORY_ON_FTP_SERVER
put $FILE
quit
END_SCRIPT

#Location of temp ftp directory
rm -rf TEMP_FTP_DIRECTORY/Temp_Documents/$pc-$type-$date.tgz
