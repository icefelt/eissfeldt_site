---
layout: post
title: "Which-Is-Kerberos-Admin-Server"
date: "2017-10-03T17:07:07-07:00"
tags: 
  - kerberos
---

To see which keytab server your client is trying to authenticate, you can run these commands.

```
export KRB5_TRACE=/dev/stdout 
kinit -k -t username.keytab username@EC2.INTERNAL -V
```

