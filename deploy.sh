#!/bin/bash
#author: Gloria Palma Gonzalez ing.gloriapalmagonzalez@gmail.com
#desc: Script for deploy callcenter or backoffice.
#Instructions:
# For execute this script you should pass  parameter
# 1.- The application for deploy, bc it's for deploy in backoffice and callcenter, c it's for deploy only callcenter and b it's for deploy only backoffice
# example : ./deploy.sh bc
echo "Starting deploy ... glow glow"
#init vars
FILE="$(date +"%Y-%m-%d")-dump.sql.gz"
BACKUPSNAME="$(date +"%Y-%m-%d")"
#Stop service apache for make the backups database
echo "Go to stop service tomcat"
service tomcat stop
#Make de bakups database
echo "Go to make dumps"
mysqldump --user=ventakmp --password=ws4.=Rt5gSd34 ventakmpscc >  ./dumps/"$FILE"
chmod 776 ./dumps/"$FILE"
#Bakup apps
cd /usr/local/tomcat7/webapps/
case "$1" in
    "bc")
		echo 'Creating backups callcenter and backoffice'
        #Backups apps
		mv  callcenter.war callcenter-"$BACKUPSNAME"
        mv  backoffice.war backoffice-"$BACKUPSNAME"
        ls
        # Deleted folders app
        echo 'Deleting folders callcenter and backoffice'
		rm -rf callcenter
		rm -rf backoffice
		ls
		#Return at root directory
		echo 'Returning to directory root'
		cd
		ls
		#Set permits to the wars
		echo "Setting permits tho the wars"
		chown root:root callcenter.war
		chown root:root backoffice.war
		ls -la
		#Copy the wars in webapps
		echo "Copiying wars in /usr/local/tomcat7/webapps"
		cp ./callcenter.war  /usr/local/tomcat7/webapps
		cp ./backoffice.war  /usr/local/tomcat7/webapps
		cd /usr/local/tomcat7/webapps
		ls
		cd
		#Start service tomcat
		echo "Go to start service tomcat"
		service tomcat start
		echo "Finished deploy backoffice and callcenter ;)... i know, i'm very cool"
		#Let me see de log babe
		echo "Hey! You should see the logs"
		tail -f /usr/local/tomcat7/logs/catalina.out
        ;;
    "b")
		echo 'Creating backup backoffice'
        #Backups apps
        mv  backoffice.war backoffice-"$BACKUPSNAME"
        ls
        # Deleted folders app
        echo 'Deleting folder backoffice'
		rm -rf backoffice
		ls
		#Return at root directory
		echo 'Returning to directory root'
		cd
		ls
		#Set permits to the wars
		echo "Setting permits tho the wars"
		chown root:root backoffice.war
		ls -la
		#Copy the wars in webapps
		echo "Copiying war in /usr/local/tomcat7/webapps"
		cp ./backoffice.war  /usr/local/tomcat7/webapps
		cd /usr/local/tomcat7/webapps
		ls
		cd
		#Start service tomcat
		echo "Go to start service tomcat"
		service tomcat start
		echo "Finished deploy backoffice and callcenter ;)... i know, i'm very cool"
		#Let me see de log babe
		echo "Hey! You should see the logs"
		tail -f /usr/local/tomcat7/logs/catalina.out
    "c")
        echo 'Creating backup callcenter'
        #Backups apps
		mv  callcenter.war callcenter-"$BACKUPSNAME"
        ls
        # Deleted folders app
        echo 'Deleting folder callcenter'
		rm -rf callcenter
		ls
		#Return at root directory
		echo 'Returning to directory root'
		cd
		ls
		#Set permits to the wars
		echo "Setting permits tho the war"
		chown root:root callcenter.war
		ls -la
		#Copy the wars in webapps
		echo "Copiying wars in /usr/local/tomcat7/webapps"
		cp ./callcenter.war  /usr/local/tomcat7/webapps
		cp ./backoffice.war  /usr/local/tomcat7/webapps
		cd /usr/local/tomcat7/webapps
		ls
		cd
		#Start service tomcat
		echo "Go to start service tomcat"
		service tomcat start
		echo "Finished deploy callcenter ;)... i know, i'm very cool"
		#Let me see de log babe
		echo "Hey! You should see the logs"
		tail -f /usr/local/tomcat7/logs/catalina.out
        ;;
    *)
        echo "You should introduce the parameter for deploy application:"
        echo "bc : is for deploy in callcenter and backoffice"
        echo "c : is for deploy in callcenter"
        echo "b : is for deploy in callcenter"
        echo "Example : ./deploy.sh bc"
        ;; 
esac

echo #