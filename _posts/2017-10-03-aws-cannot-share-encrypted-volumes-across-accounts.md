---
layout: post
title: "Aws Cannot Share Encrypted Volumes Across Accounts"
date: "2017-10-06T17:20:30-07:00"
tags: 
  - aws
  - ami
---
We use different AWS accounts for production and development. We also use encrypted AMI's. Writing some ansible code, I kept erroring out on a known-good AMI. The reason was I could not share AMI across encrypted accounts. 

> You can't copy an encrypted AMI that was shared with you from another account. Instead, if the underlying snapshot and encryption key were shared with you, you can copy the snapshot while re-encrypting it with a key of your own. You own the copied snapshot, and can register it as a new AMI.
> You can't copy an AMI with an associated billingProduct code that was shared with you from another account. This includes Windows AMIs and AMIs from the AWS Marketplace. To copy a shared AMI with a billingProduct code, launch an EC2 instance in your account using the shared AMI and then create an AMI from the instance. For more information, see Creating an Amazon EBS-Backed Linux AMI.

[AWS page on copying an AMI](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/CopyingAMIs.html "Copying an AMI")

