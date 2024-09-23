#!/bin/bash

# กำหนด path ของ shell script ที่ต้องการให้ crontab เรียก
SCRIPT_PATH="${PWD}/ssl.sh"

# กำหนดเวลาให้ cron job (ตัวอย่างนี้คือทุกๆ 1 ชั่วโมง)
CRON_SCHEDULE="0 * * * *"

# ตรวจสอบว่ามี crontab อยู่แล้วหรือไม่ ถ้ามีจะเพิ่ม cron job เข้าไป ถ้าไม่มีก็สร้างใหม่
(crontab -l 2>/dev/null; echo "$CRON_SCHEDULE /bin/bash $SCRIPT_PATH >> /var/log/ssl_update.log 2>&1") | crontab -

# ตรวจสอบผลการทำงาน
if [ $? -eq 0 ]; then
  echo "Crontab job successfully added!"
else
  echo "Failed to add crontab job."
  exit 1
fi
