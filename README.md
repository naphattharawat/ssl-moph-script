# SSL Script 
ssl script จะช่วยในการติดตั้งและคอยอัพเดต SSL ให้ใหม่เสมอ ไมว่าจะเป็นกรณีที่ หมดอายุ หรือโดน revoke

## วิธีการติดตั้ง
เข้าไปโฟวเดอร์ที่ต้องการจะติดตั้ง script และใช้คำสั่ง
```
curl -sS https://raw.githubusercontent.com/naphattharawat/ssl-moph-script/main/download_via_curl.sh | bash
```


###  แก้ไขไฟล์ config.sh
* path="" ให้ใส่ path ที่จะเก็บไฟล์ ssl เช่น /etc/nginx/ssl, /etc/httpd/conf.d
* restart_command="" ให้ใส่คำสั่งที่จะ restart service เช่น service httpd restart, systemctl restart nginx
* token="" ให้ใส่ token ที่ได้รับจาก ศทส.

## หมายเหตุ
ในไฟลฺ์ Config ของ Web Server ให้เช็คชื่อไฟล์ให้ถูกต้อง ตามด้านล่างนี้ 
```
bundle.crt
wildcard_moph_go_th.key
ssl_certificate.pfx
```

#### วิธีการ config web server แต่ละแบบ

#### apache
```
SSLCertificateFile /etc/httpd/conf.d/bundle.crt
SSLCertificateKeyFile /etc/httpd/conf.d/wildcard_moph_go_th.key
```
#### nginx
```
ssl_certificate "/etc/nginx/ssl/bundle.crt";
ssl_certificate_key "/etc/nginx/ssl/wildcard_moph_go_th.key";
```
#### tomcat
```
certificateKeystoreFile="/etc/ssl/ssl_certificate.pfx"
certificateKeystorePassword="moph"
```
