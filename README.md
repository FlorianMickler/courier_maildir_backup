# courier_maildir_backup

In the need for a way to backup my maildir i found https://gist.github.com/fwenzel/280896 by fwenzel and https://gist.github.com/pkern/3730543 which based on that by pkern. 

These scripts do a really big part of what i needed: Separating my huge maildir folders into archive-folders by year and month in order to tar.gz-backup them separately (low frequency) from my new mails (which i rsync high frequently). This greatly reduces the rsync overhead for the not-changing part of my maildir. I just exclude the .archive. folders from the rsync and use local tar-bzip2 backup mechanism for those (with something like debian backup-manager)

I created this repo for the case, i need to modify parts of this in the future and in order to ease deployment on more machines. 
