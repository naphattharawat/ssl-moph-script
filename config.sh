# Version ของ SSL ที่ต้องการเช็ค (ไม่ต้องแก้ไข)
version=0


# Path ที่จะวางไฟล์ SSL เช่น /etc/nginx/ssl หลายค่าคั่นด้วย space
paths=("/etc/nginx/ssl")

# คำสั่งที่ใช้ในการ restart service หลายคำสั่งคั่นด้วย space
restart_commands=("systemctl restart nginx")

token=