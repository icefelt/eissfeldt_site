---
layout: post
title: "Workaround for Terraform Error DBParameterGroup not found"
date: "2017-10-06T16:19:45-07:00"
tags:
  - linux
  - terraform
---
The terraform destroy command outputs a false error as it is not able to delete an AWS RDS MySQL DB. 

```
Error refreshing state: 1 error(s) occurred:

* module.hortonworks.aws_db_parameter_group.hortonworks: aws_db_parameter_group.hortonworks: DBParameterGroupNotFound: DBParameterGroup not found: dsdev-105-rds-param-hortonworks
  status code: 404, request id: c9083eec-aadb-11e7-9855-8f67280331c5
```

To workaround this error, use the terraform state rm command to remove the module where terraform is showing an error.  
```
Fri Oct 06 14:21:18 root@M062-PDX /Users/seissfeldt/ssdc/dexcom-ansible/terraform/aws/env-main-us-dev  $ terraform state rm module.hortonworks.aws_db_parameter_group.hortonworks
Item removal successful.
```

Run the terraform destroy command again, and you should see terraform destory successfully complete with the follwoing output:
```
Destroy complete! Resources: 1 destroyed.
```

