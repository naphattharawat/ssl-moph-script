#!/bin/bash

# กำหนด URL ของไฟล์ต่าง ๆ ที่อยู่ใน Git repository
CONFIG_SCRIPT_URL="https://raw.githubusercontent.com/naphattharawat/ssl-moph-script/main/config.sh"
INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/naphattharawat/ssl-moph-script/main/install.sh"
UNINSTALL_SCRIPT_URL="https://raw.githubusercontent.com/naphattharawat/ssl-moph-script/main/uninstall.sh"
SSL_SCRIPT_URL="https://raw.githubusercontent.com/naphattharawat/ssl-moph-script/main/ssl.sh"

# สร้างไดเรกทอรีชั่วคราวสำหรับดาวน์โหลดไฟล์
TEMP_DIR=./ssl-script

mkdir -p $TEMP_DIR
# ดาวน์โหลดไฟล์ install.sh, config.sh และ ssl.sh ไปที่ไดเรกทอรีชั่วคราว
curl -sS $INSTALL_SCRIPT_URL -o $TEMP_DIR/install.sh
curl -sS $UNINSTALL_SCRIPT_URL -o $TEMP_DIR/uninstall.sh
curl -sS $CONFIG_SCRIPT_URL -o $TEMP_DIR/config.sh
curl -sS $SSL_SCRIPT_URL -o $TEMP_DIR/ssl.sh

# ทำให้ไฟล์ install.sh รันได้
chmod +x $TEMP_DIR/install.sh
chmod +x $TEMP_DIR/uninstall.sh
chmod +x $TEMP_DIR/config.sh
chmod +x $TEMP_DIR/ssl.sh
echo "
 ▗▄▄▖ ▗▄▄▖▗▖            ▗▄▄▖ ▗▄▄▖▗▄▄▖ ▗▄▄▄▖▗▄▄▖▗▄▄▄▖
▐▌   ▐▌   ▐▌           ▐▌   ▐▌   ▐▌ ▐▌  █  ▐▌ ▐▌ █  
 ▝▀▚▖ ▝▀▚▖▐▌            ▝▀▚▖▐▌   ▐▛▀▚▖  █  ▐▛▀▘  █  
▗▄▄▞▘▗▄▄▞▘▐▙▄▄▖        ▗▄▄▞▘▝▚▄▄▖▐▌ ▐▌▗▄█▄▖▐▌    █  

"
echo 'ไฟล์ ถูกสร้างไว้ที่โฟวเดอร์ ssl-script'
echo '==========================================================================='
echo 'แก้ไข config.sh และสั่ง install.sh เพื่อติดตั้ง crontab หรือ ssl.sh เพื่อเรียกใช้งานทันที'
echo '==========================================================================='


