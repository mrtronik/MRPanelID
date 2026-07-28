#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'
KUNING='\033[33m'
declare -a STATUS
LOG_FILE="test.log"
banner() {
    clear
    echo "=============================================================="
    echo "                 $1"
    echo "=============================================================="
}
proses() {
    printf  "\r\033[K${KUNING} [>] $1...${NC}"
    echo "[>] $1..." >> "$LOG_FILE"
}

sukses() {
    printf  "\r\033[K${GREEN} [✓]%s${NC}\n" "$1"

    STATUS+=("[✓] $1")
}

gagal() {
    printf  "\r\033[K${RED} [✗]${NC} $1"
    echo "[✗] $1" >> "$LOG_FILE"
}
banner "MR Panel Installer v1.0"

echo ""
echo -e " ${GREEN}Selamat Datang di MR Panel Installer ${NC}"
echo ""
echo " Installer ini akan menyiapkan server Anda secara otomatis."
echo ""
echo " Yang akan dipersiapkan:"
echo "   ✓ Pemeriksaan Sistem"
echo "   ✓ Dependensi"
echo "   ✓ Basis Data"
echo "   ✓ PHP"
echo "   ✓ Web Server"
echo "   ✓ MR Panel"
echo "   ✓ Firewall"
echo ""
echo -e " ${KUNING}☕ Silakan ngopi dulu, biar kami yang bekerja.${NC}"
echo ""

while true
do
    echo "=============================================================="
    echo -e "  ${GREEN}1. Instalasi Baru ${NC}"
    echo -e "  ${RED}2. Reinstal MR Panel ${NC}"
    echo -e "  ${KUNING}3. Ngopi + Udud ☕🚬 ${NC}"
    echo -e "  4. Gak Jadi"
    echo "=============================================================="

    read -rp " Pilihan Anda : " MENU

    case "$MENU" in

        1)
            INSTALL_MODE="install"
            break
            ;;

        2)
            INSTALL_MODE="reinstall"
            break
            ;;

        3)
            banner "MODE NGOPI"

            echo ""
            echo "  ☕ Kopi siap..."
            sleep 1
            echo "  🚬 Rokok siap..."
            sleep 1
            echo ""
            echo "  Server belum siap 😁"
            echo ""
            read -rp " Tekan ENTER untuk kembali..."
            banner "MR Panel Installer v1.0"
            ;;

        4)
            echo ""
            echo "  Sampai jumpa lagi."
            exit
            ;;

        *)
            echo ""
            echo "  Pilihan tidak tersedia."
            sleep 1
            banner " MR Panel Installer v1.0"
            ;;

    esac
done
proses "Cek koneksi internet"
sleep 2
sukses "Internet OK"

proses "Menginstall Node.js"
sleep 2
sukses "Node.js berhasil diinstall"

proses "Menginstall PM2"
sleep 2
gagal "PM2 gagal diinstall"
echo ""
echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}        STATUS INSTALASI MR PANEL     ${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""

for s in "${STATUS[@]}"; do
    echo  "$s"
done
# ─── Summary ──────────────────────────────────
echo ""
echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}        INSTALASI MR PANEL SELESAI      ${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""

echo -e "  ${CYAN}MR Panel URL:${NC}       http://${PUBLIC_IP}:${PANEL_PORT}"
echo -e "  ${CYAN}OLS WebAdmin:${NC}       http://${PUBLIC_IP}:7080"
echo ""

echo -e "  ${CYAN}MySQL Root Pass:${NC}    ${MYSQL_ROOT_PASS}"
echo -e "  ${CYAN}OLS Admin Pass:${NC}     ${OLS_ADMIN_PASS}"
echo ""

echo -e "  ${CYAN}Panel Directory:${NC}    /opt/mrpanel"
echo -e "  ${CYAN}Install Log:${NC}        ${LOG_FILE}"
echo -e "  ${CYAN}Credentials:${NC}        ${CRED_FILE}"
echo ""

echo -e "  ${YELLOW}MR Panel Version:${NC}   V1.0"
echo -e "  ${YELLOW}Runtime:${NC}            MR Runtime Manager"
echo -e "  ${YELLOW}Copyright:${NC}          ${GREEN}© 2026 MR Projects${NC}"
echo ""

echo -e "  ${YELLOW}Saya Ucapkan terima kasih kepada:${NC}"
echo -e "  Allah SWT"
echo -e "  Ayah (Alm) & Ibu"
echo -e "  Istri Tercinta"
echo -e "  Anak anakku Tersayang"
echo -e "  WargaNet Indonesia"
echo -e "  PT. Mas Ranto Projects"
echo ""

echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}  Terima Kasih telah menggunakan MR Panel  ${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
