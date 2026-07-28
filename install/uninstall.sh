#!/bin/bash

banner "FACTORY RESET MR PANEL"

proses "Menghentikan layanan MR Panel..."


# PM2
if command -v pm2 &>/dev/null; then
    pm2 delete all >> "$LOG_FILE" 2>&1 || true
    pm2 kill >> "$LOG_FILE" 2>&1 || true
fi


# Hapus aplikasi
proses "Menghapus MR Panel..."

rm -rf /opt/mrpanel
rm -f /root/mrpanel-credentials.txt

sukses "File MR Panel dihapus"


# Database
proses "Menghapus Database..."

mysql <<EOF >> "$LOG_FILE" 2>&1 || true
DROP DATABASE IF EXISTS belajar_node;
DROP USER IF EXISTS 'mrpanel'@'localhost';
FLUSH PRIVILEGES;
EOF

sukses "Database dihapus"


# PM2
proses "Menghapus PM2..."

npm uninstall -g pm2 >> "$LOG_FILE" 2>&1 || true

sukses "PM2 dihapus"


# Composer
proses "Menghapus Composer..."

rm -f /usr/local/bin/composer

sukses "Composer dihapus"


# Bind9
proses "Menghapus Bind9..."

apt purge -y bind9 bind9-utils bind9-doc >> "$LOG_FILE" 2>&1 || true

rm -rf /etc/bind

sukses "Bind9 dihapus"


# WebServer
proses "Menghapus WebServer..."

systemctl stop lshttpd >> "$LOG_FILE" 2>&1 || true
systemctl disable lshttpd >> "$LOG_FILE" 2>&1 || true

apt purge -y openlitespeed >> "$LOG_FILE" 2>&1 || true

rm -rf /usr/local/lsws

sukses "WebServer dihapus"


# MariaDB
proses "Menghapus Database Server..."

apt purge -y mariadb-server mariadb-client >> "$LOG_FILE" 2>&1 || true

rm -rf /var/lib/mysql
rm -rf /etc/mysql

sukses "MariaDB dihapus"


# PHP
proses "Menghapus PHP..."

apt purge -y php* >> "$LOG_FILE" 2>&1 || true

sukses "PHP dihapus"


# Node
proses "Menghapus NodeJS..."

apt purge -y nodejs npm >> "$LOG_FILE" 2>&1 || true

sukses "NodeJS dihapus"


# Cleanup
proses "Membersihkan paket..."

apt autoremove -y >> "$LOG_FILE" 2>&1
apt autoclean >> "$LOG_FILE" 2>&1


sukses "FACTORY RESET SELESAI"

echo ""
echo "Server sudah dikembalikan mendekati Ubuntu bersih."
echo "Disarankan reboot:"
echo ""
echo "  reboot"
echo ""