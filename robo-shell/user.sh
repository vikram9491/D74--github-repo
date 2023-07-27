cp mongo.repo  /etc/yum.repos.d/mongo.repo 
cp user.sh  /etc/systemd/system/user.service
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
mkdir /app 
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
cd /app 
unzip /tmp/user.zip
cd /app 
npm install
yum install mongodb-org-shell -y
mongo --host mongodb.vikramdevops.tech </app/schema/user.js 
systemctl daemon-reload 
systemctl enable user 
systemctl restart user