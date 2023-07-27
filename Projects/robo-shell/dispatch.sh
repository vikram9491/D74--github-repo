yum install golang -y
useradd roboshop
mkdir /app 
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip 
cd /app 
unzip /tmp/dispatch.zip
systemctl daemon-reload
systemctl enable dispatch 
systemctl start dispatch