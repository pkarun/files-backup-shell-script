#!/bin/bash

THEDATE=`date +%d-%m-%Y-TIME-%H-%M`
FOLDER_LOC="/var/www/html/"
ZIP_DIR="/var/www/html/example.com/downloads/files/temp/"
BACKUP_DIR="/var/www/html/example.com/downloads/files"
EXCLUDE_LIST="/var/www/backups/script/files-backup/exclude-list.txt"


mkdir -p "$BACKUP_DIR"
mkdir -p "$ZIP_DIR"

echo " "
echo "Keeping latest 1 backup and deleting rest of the files..."

#keep latest 2 ( -n +3)files and delete rest of the files
cd $BACKUP_DIR
ls -t1 | tail -n +3 | xargs -r rm -vr
echo "Done"
echo " "




#cd /var/backups/test/maindir
cd $FOLDER_LOC


for i in */;
do


echo "Compressing: $i"
tar -czf "${ZIP_DIR}/${i%/}-${THEDATE}.tar.gz" --exclude-from="$EXCLUDE_LIST" "$i";
done

echo " "
echo "Adding all tar files to one tar.gz file..."
#cd /var/backups/test/dest/
cd $ZIP_DIR
tar -czf ${BACKUP_DIR}/files-${THEDATE}.tar.gz *
echo "Done"

echo " "
echo "Cleaning Folder now.."
rm -r $ZIP_DIR
echo "Done"
echo " "


echo " "
echo " "
echo "Backup Placed in: "http://example.com/downloads/files/files-${THEDATE}.tar.gz" "
echo " "
echo " "

