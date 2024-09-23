#!/bin/bash

# กำหนด URL ของไฟล์ต่าง ๆ ที่อยู่ใน Git repository
INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/username/repository/branch/install.sh"
CONFIG_SCRIPT_URL="https://raw.githubusercontent.com/username/repository/branch/config.sh"
SSL_SCRIPT_URL="https://raw.githubusercontent.com/username/repository/branch/ssl.sh"

# สร้างไดเรกทอรีชั่วคราวสำหรับดาวน์โหลดไฟล์
TEMP_DIR=$(mktemp -d)

# ดาวน์โหลดไฟล์ install.sh, config.sh และ ssl.sh ไปที่ไดเรกทอรีชั่วคราว
curl -sS $INSTALL_SCRIPT_URL -o $TEMP_DIR/install.sh
curl -sS $CONFIG_SCRIPT_URL -o $TEMP_DIR/config.sh
curl -sS $SSL_SCRIPT_URL -o $TEMP_DIR/ssl.sh

# ทำให้ไฟล์ install.sh รันได้
chmod +x $TEMP_DIR/install.sh

# เรียกใช้งานไฟล์ install.sh
$TEMP_DIR/install.sh

# ลบไดเรกทอรีชั่วคราวหลังจากใช้งานเสร็จ
rm -rf $TEMP_DIR
