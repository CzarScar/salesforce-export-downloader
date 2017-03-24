
salesforce-export-downloader
============================

A Ruby script that downloads a scheduled backup files from salesforce. The script sends out email on completion of failure to download.

see also: http://stackoverflow.com/questions/10178279/how-to-automate-download-of-weekly-export-service-files




upload.sh
============================
Add action to upload backup files to Google Drive automatically. It needs [gdrive][https://github.com/prasmussen/gdrive] supports. So make sure to add gdrive to /usr/local/bin.

This shell will create yourbasicfolder/year/month/year-mon-dd folder structure and upload the files to year-mon-dd.

for example: you are doing a backup on Mar 24, 2017. The folder structure will be yourbasicfolder/2017/Mar/2017-Mar-24

