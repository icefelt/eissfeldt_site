---
layout: post
title: "Redirecting standard error into standard output from your unix commands into log files"
date: "2017-10-03T16:30:21-07:00"
tags: 
  - log
  - unix
---

Sometimes, we're not able to view the output of standard error, or we'd like to keep this in a log file to search later. Saving the results of standard output can be useful for troublshooting issues the future. 

To do this, we can redirct standard error into standard output and save this to a log file. 

Adding "2>&1" to the end of your command will redirct the standard error into standard output. 
Piping the output from the command above using the tee command with a .log file will save the output to a log file. 

Here's an example that uses local environment variables and a date stamp for the log file: 
```
ansible-playbook -vvvv -i inventory/ec2.py playbook-zabbix-config.yml 2>&1 | tee -a "${envname}-${envnumber}-playbook-zabbix-config-"`date '+%Y-%m-%d-%H-%M'`.log
```

