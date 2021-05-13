# creation du VG oracle avec 1er PV /dev/sdb
sudo vgcreate oracle /dev/sdb
# creation du LV backup dans le VG oracle
# accessible ensuite en tant que /dev/oracle/backup ou /dev/mapper/oracle-backup
sudo lvcreate -n backup -L 7G oracle
sudo mkfs -t ext4 /dev/oracle/backup
sudo mkdir /backup
# montage provisoire
sudo mount /dev/oracle/backup /backup
sudo chown oracle: /backup
sudo mkdir /backup/ORALIN19
sudo chown -R oracle: /backup
# same thing for archivelogs
sudo lvcreate -n archivelog -L 2G oracle
sudo mkdir /archivelog
sudo mount /dev/oracle/archivelog /archivelog/
sudo chown oracle: /archivelog/
sudo mkdir /archivelog/ORALIN19
sudo chown oracle: /archivelog/ORALIN19
# check everything
lsblk -f
ls -al /archivelog/
ls -al /backup/
df -hT

# add the following 2 lines in /etc/fstab
# /dev/oracle/archivelog /archivelog ext4 defaults 0 0
# /dev/oracle/backup /backup ext4 defaults 0 0
