#!/bin/bash
#author: Gloria Palma Gonzalez ing.gloriapalmagonzalez@gmail.com
#desc: Script for rollback callcenter or backoffice.
#Instructions:
# For execute this script you should pass  parameter
# 1.- The application for deploy, cb it's for deploy in backoffice and callcenter, c it's for deploy only callcenter and b it's for deploy only backoffice
# example : ./rollback.sh cb
echo "Starting rollback ... glow glow"
#init vars
BACKUPSNAME="$(date +"%Y-%m-%d")"

while getopts ":cb:c:b" opt; do
  case $opt in
    cb)
		#Stop service apache for make the backups database
		echo "Go to stop service tomcat"
		service tomcat stop
		#Go to directory that contains apps
		echo 'Go to directory webapps'
		cd /usr/local/tomcat7/webapps/
		ls
       echo 'Remove wars callcenter and backoffice'
        #Remove wars
		rm -rf callcenter.war
        rm -rf backoffice.war 
        ls
		echo 'rollback backups callcenter and backoffice'
        #Backups apps
		mv  callcenter-"$BACKUPSNAME" callcenter.war
        mv  backoffice-"$BACKUPSNAME" backoffice.war 
        ls
        # Deleted folders app
        echo 'Deleting folders callcenter and backoffice'
		rm -rf callcenter
		rm -rf backoffice
		ls
		#Start service tomcat
		echo "Go to start service tomcat"
		service tomcat start
		echo "Finished rollback backoffice and callcenter ;)... i know, i'm very cool"
		#Let me see de log babe
		echo "Hey! You should see the logs"
		tail -f /usr/local/tomcat7/logs/catalina.out
      ;;
    b)
#Stop service apache for make the backups database
		echo "Go to stop service tomcat"
		service tomcat stop
		#Go to directory that contains apps
		echo 'Go to directory webapps'
		cd /usr/local/tomcat7/webapps/
		ls
       echo 'Remove war backoffice'
        #Remove wars
        rm -rf backoffice.war 
        ls
		echo 'rollback backup backoffice'
        #Backups apps
        mv  backoffice-"$BACKUPSNAME" backoffice.war 
        ls
        # Deleted folders app
        echo 'Deleting folder backoffice'
		rm -rf backoffice
		ls
		#Start service tomcat
		echo "Go to start service tomcat"
		service tomcat start
		echo "Finished rollback backoffice ;)... i know, i'm very cool"
		#Let me see de log babe
		echo "Hey! You should see the logs"
		tail -f /usr/local/tomcat7/logs/catalina.out
      ;;
    c)
		#Stop service apache for make the backups database
		echo "Go to stop service tomcat"
		service tomcat stop
		#Go to directory that contains apps
		echo 'Go to directory webapps'
		cd /usr/local/tomcat7/webapps/
		ls
		echo 'Remove war callcenter'
        #Remove wars
		rm -rf callcenter.war
        ls
		echo 'rollback backup callcenter'
        #Backups apps
		mv  callcenter-"$BACKUPSNAME" callcenter.war
        ls
        # Deleted folders app
        echo 'Deleting folders callcenter and backoffice'
		rm -rf callcenter
		ls
		#Start service tomcat
		echo "Go to start service tomcat"
		service tomcat start
		echo "Finished rollback callcenter ;)... i know, i'm very cool"
		#Let me see de log babe
		echo "Hey! You should see the logs"
		tail -f /usr/local/tomcat7/logs/catalina.out
       
      ;;
    \?)
        echo "You should introduce the parameter for rollback application:"
        echo "cb : is for rollback in callcenter and backoffice"
        echo "c : is for rollback in callcenter"
        echo "b : is for rollback in callcenter"
        echo "Example : ./deploy.sh cb"
      ;;
  esac
done

echo #