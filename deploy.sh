#!/bin/bash
#author: Gloria Palma Gonzalez ing.gloriapalmagonzalez@gmail.com
#desc: Script for deploy callcenter or backoffice .
echo "Starting deploy ... glow glow"
#Stop service apache for make the backups database
service tomcat stop
#Make de bakups database
mysqldump --user=ventakmp --password=ws4.=Rt5gSd34 ventakmpscc >  ./dumps/dump-${1}.sql
#Bakup apps
cd /usr/local/tomcat7/webapps/
mv  backoffice.war backoffice-${1}
mv  callcenter.war callcenter-${1}
# Deleted folders app
rm -rf callcenter
rm -rf backoffice
#Return at root directory
cd
#Copy the wars in webapps
cp ./callcenter.war  /usr/local/tomcat7/webapps
cp ./backoffice.war  /usr/local/tomcat7/webapps
#Start service tomcat
service tomcat start
echo "Finished deploy ... i know, i'm very cool"
#Let me see de log babe
tail -f /usr/local/tomcat7/logs/catalina.out

echo #