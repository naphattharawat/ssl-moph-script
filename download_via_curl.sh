#!/bin/bash

# กำหนด URL ของไฟล์ต่าง ๆ ที่อยู่ใน Git repository
CONFIG_SCRIPT_URL="https://raw.githubusercontent.com/naphattharawat/ssl-moph-script/refs/heads/main/config.sh"
INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/naphattharawat/ssl-moph-script/refs/heads/main/install.sh"
SSL_SCRIPT_URL="https://raw.githubusercontent.com/naphattharawat/ssl-moph-script/refs/heads/main/ssl.sh"

# สร้างไดเรกทอรีชั่วคราวสำหรับดาวน์โหลดไฟล์
TEMP_DIR=./ssl-script

mkdir -p $TEMP_DIR
# ดาวน์โหลดไฟล์ install.sh, config.sh และ ssl.sh ไปที่ไดเรกทอรีชั่วคราว
curl -sS $INSTALL_SCRIPT_URL -o $TEMP_DIR/install.sh
curl -sS $CONFIG_SCRIPT_URL -o $TEMP_DIR/config.sh
curl -sS $SSL_SCRIPT_URL -o $TEMP_DIR/ssl.sh

# ทำให้ไฟล์ install.sh รันได้
chmod +x $TEMP_DIR/install.sh

echo 'ไฟล์ ถูกสร้างไว้ที่โฟวเดอร์ ssl-script'
echo 'แก้ไข config.sh และสั่ง install.sh เพื่อติดตั้ง crontab หรือ ssl.sh เพื่อเรียกใช้งานทันที'


