---
layout: post
title: "In Centos, manually add user and add ssh keys"
date: "2017-09-25T16:13:57-07:00"
tags: 
  - linux
  - add users
  - centos
---

Manual steps to add a user with sudo accecss in centos
```
adduser -U -G adm,wheel username -s /bin/bash && su -l username && mkdir .ssh && chmod 0700 .ssh && cd .ssh/

vi authorized_keys

ssh-rsa AAAAB3NzaThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFakeThisIsFake SomeThingFor@EveryOne.local

chmod 0600 authorized_keys
```


