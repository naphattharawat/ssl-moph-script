#!/bin/bash

# กำหนด path ของ shell script ที่ต้องการให้ crontab เรียก
SCRIPT_PATH="${PWD}/ssl.sh"

# กำหนดเวลาให้ cron job (ตัวอย่างนี้คือทุกๆ 1 ชั่วโมง)
CRON_SCHEDULE="0 * * * *"

# กำหนด cron job ที่ต้องการเพิ่ม
CRON_JOB="$CRON_SCHEDULE /bin/bash $SCRIPT_PATH >> /var/log/ssl_update.log 2>&1"

# ตรวจสอบว่ามี cron job นี้อยู่แล้วหรือไม่
crontab -l 2>/dev/null | grep -F "$CRON_JOB" >/dev/null

# ถ้า cron job นี้ยังไม่มีอยู่ใน crontab ให้ทำการเพิ่ม
if [ $? -eq 1 ]; then
  (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
  
  # ตรวจสอบผลการทำงาน
  if [ $? -eq 0 ]; then
    echo "Crontab job successfully added!"
  else
    echo "Failed to add crontab job."
    exit 1
  fi
else
  echo "Crontab job already exists. No action taken."
fi
