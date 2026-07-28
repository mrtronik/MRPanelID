#!/bin/bash

banner "Mode Reinstall MR Panel"

proses "Menghentikan MR Runtime Manager..."

if command -v pm2 &>/dev/null; then
    pm2 delete mrpanel >> "$LOG_FILE" 2>&1 || true
fi

sukses "Runtime MR Panel dihentikan"


# ─── Backup Credential ────────────────────────
if [ -f /root/mrpanel-credentials.txt ]; then
    proses "Membackup Credential..."

    cp /root/mrpanel-credentials.txt \
    /root/mrpanel-credentials-backup.txt

    sukses "Credential berhasil dibackup"
fi


# ─── Hapus Folder Panel ───────────────────────
if [ -d /opt/mrpanel ]; then

    proses "Menghapus MR Panel lama..."

    rm -rf /opt/mrpanel

    sukses "Folder MR Panel dihapus"

fi


# ─── Hapus Database Panel ─────────────────────
proses "Membersihkan Database MR Panel..."

mysql <<EOF >> "$LOG_FILE" 2>&1 || true
DROP DATABASE IF EXISTS belajar_node;
EOF

sukses "Database MR Panel dibersihkan"


# ─── Clone ulang nanti di mrpanel.sh ──────────
sukses "Reinstall siap dilakukan"