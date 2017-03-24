#! /bin/bash

ruby salesforce-backup.rb

gdsfbackupfolderId='yourbasicfolderId'
yearfolderId
monthfolderId
backUpfolderName=$(date +"%Y-%b-%e")
echo $backUpfolderName

year=$(date +"%Y")
echo $year
month=$(date +"%b")
echo $month

checkYearFolderResult=`gdrive list -q "name='$year' and '$gdsfbackupfolderId' in parents" --no-header`
echo $checkYearFolderResult

# check year folder exists, if not, create
if [[ $checkYearFolderResult ]]; then
	echo 'Year folder exists on Google Drive'
	IFS='\ ' read -ra ADDR <<< "$checkYearFolderResult"
	yearfolderId="${ADDR[0]}"
else
	echo 'Year folder not exists, Created'
	result=`gdrive mkdir -p $gdsfbackupfolderId $year`
	IFS='\ ' read -ra ADDR <<< "$result"
	yearfolderId="${ADDR[1]}"
fi

echo $yearfolderId

#check month folder under year folder
checkMonthFlderResult=`gdrive list -q "name='$month' and '$yearfolderId' in parents" --no-header`

# check year folder exists, if not, create
if [[ $checkMonthFlderResult ]]; then
	echo 'Month folder exists on Google Drive'
	IFS='\ ' read -ra ADDR <<< "$checkMonthFlderResult"
	monthfolderId="${ADDR[0]}"
else
	echo 'Month folder not exists, Created'
	result=`gdrive mkdir -p $yearfolderId $month`
	IFS='\ ' read -ra ADDR <<< "$result"
	monthfolderId="${ADDR[1]}"
fi

echo $monthfolderId

#create backup file folder
createBackupFolderResult=`gdrive mkdir -p $monthfolderId $backUpfolderName`
IFS='\ ' read -ra ADDR <<< "$createBackupFolderResult"
backupFolderId="${ADDR[1]}"
echo $backupFolderId

echo 'Foldre Preparation finished!!! Start uploading...'

for f in ./archive/salesforce/*; do
  gdrive upload -p $backupFolderId $f
done

echo 'Backup file upload finished!!'

echo 'Start clear local file'

rm -rf ./archive/salesforce/*

echo 'Clear finished!'
