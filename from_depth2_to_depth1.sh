#!/bin/sh

BASE=$HOME/Maildir
ARCHIVEBASE=$HOME/Maildir

#for folder in `find $BASE -regextype posix-extended  -maxdepth 1 -type d \! -iregex ".*\.archiv(\..*)?" \! -name cur \! -name tmp \! -name new \! -name search \! -regex '.*\.SPAM.*' \! -name "courier*"`
for folder in `find $BASE -regextype posix-extended -maxdepth 1 -type d -iregex ".*\.archiv(\..*)?" \! -name cur \! -name tmp \! -name new \! -name \.Mail_Search \! -regex '.*\.SPAM.*' \! -name "courier*" \! -name "search" | sort`
do
  srcfolder=$(basename $folder)
  if [ "${srcfolder}" = "Maildir" ]; then srcfolder=INBOX; fi
  #TargetFolder=`echo -n $srcfolder | awk -F. 'BEGIN{OFS="."}{if (NF == 5 && $(NF-1) ~ /2[0-9][0-9][0-9]/) print $1"."$2"."$3"."$4; if (NF == 4 && $(NF-1) ~ /2[0-9][0-9][0-9]/)  print $1"."$2"."$3}'`
  TargetFolder=`echo -n $srcfolder | awk -F. 'BEGIN{OFS="."}NF>1{if ($(NF-2) ~ /^archiv$/ && $(NF-1) ~ /2[0-9][0-9][0-9]/ && $NF ~ /[01][0-9]/) NF=NF-1}1'`
  ./mv-maildir.py --maildir-root=$BASE -v ${srcfolder} ${TargetFolder}
  if [ $? -eq 0 ]; then
	rm $folder/courierimapacl
	rm $folder/courierimapuiddb
	rmdir $folder/*
	rmdir $folder
  fi
#  echo "./cleanup-maildir.py --archive-subfolder=archiv --maildir-root=$BASE --folder-prefix="" --age=90 -d 2 -k -u -v archive ${folder} > logfile.txt"
done
