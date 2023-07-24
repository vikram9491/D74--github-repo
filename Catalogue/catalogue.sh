
log=/tmp/roboshop.log
echo -e "\e[36m>>>>>>>>>> create catalogue service <<<<<<<<<<<<<\e[0m"
cp catalogue.sh  /etc/systemd/system/catalogue.service &>>${log}
echo -e "\e[36m>>>>>>>>>> create mongo db repo <<<<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}
echo -e "\e[36m>>>>>>>>>> Install nodeJS Repos  <<<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
echo -e "\e[36m>>>>>>>>>> Install nodeJS <<<<<<<<<<<<<\e[0m"
yum install nodejs -y &>>${log}
echo -e "\e[36m>>>>>>>>>> Create application User <<<<<<<<<<<<<\e[0m"
useradd roboshop &>>${log}
echo -e "\e[36m>>>>>>>>>>Cleaning up the directory and unzipping  <<<<<<<<<<<<<\e[0m"
rm -rf /app &>>${log}
echo -e "\e[36m>>>>>>>>>>Create Application directory <<<<<<<<<<<<<\e[0m"
mkdir /app &>>${log}
echo -e "\e[36m>>>>>>>>>> Download Application content  <<<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}

cd /app 
unzip /tmp/catalogue.zip &>>${log}
cd /app  
echo -e "\e[36m>>>>>>>>>> Download NodeJS Dependencies <<<<<<<<<<<<<\e[0m"
npm install &>>${log}
echo -e "\e[36m>>>>>>>>>> install  Mongo client <<<<<<<<<<<<<\e[0m" | tee -a ${log}
yum install mongodb-org-shell -y &>>${log}
echo -e "\e[36m>>>>>>>>>> Load Catalogue <<<<<<<<<<<<<\e[0m" | tee -a ${log}
mongo --host mongodb.vikramdevops.tech </app/schema/catalogue.js
echo -e "\e[36m>>>>>>>>>> starting catalogue component  <<<<<<<<<<<<<\e[0m" | tee -a ${log}
systemctl daemon-reload &>>${log}
systemctl enable catalogue &>>${log}
systemctl restart catalogue &>>${log}