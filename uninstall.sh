#!/bin/bash

# กำหนด path ของ shell script ที่ต้องการลบออกจาก crontab
SCRIPT_PATH="${PWD}/ssl.sh"

# กำหนดเวลา cron job ที่ต้องการลบ
CRON_SCHEDULE="0 * * * *"

# กำหนด cron job ที่ต้องการลบ
CRON_JOB="$CRON_SCHEDULE /bin/bash $SCRIPT_PATH >> /var/log/ssl_update.log 2>&1"

# ตรวจสอบว่ามี cron job นี้อยู่ใน crontab หรือไม่
crontab -l 2>/dev/null | grep -F "$CRON_JOB" >/dev/null

if [ $? -eq 0 ]; then
  # ลบ cron job โดยเอาเฉพาะรายการที่ไม่ตรงกับ cron job ที่ต้องการลบออก
  crontab -l 2>/dev/null | grep -v -F "$CRON_JOB" | crontab -
  
  # ตรวจสอบผลการลบ
  if [ $? -eq 0 ]; then
    echo "Crontab job successfully removed!"
  else
    echo "Failed to remove crontab job."
    exit 1
  fi
else
  echo "Crontab job not found. No action taken."
fi
