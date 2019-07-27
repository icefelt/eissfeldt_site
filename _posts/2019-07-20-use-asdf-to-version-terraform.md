---
layout: post
title: "Use ASDF to switch terraform versions"
date: "2019-07-20T16:49:08-08:00"
tags:
  - terraform
  - ASDF
---

## Use `asdf` to switch terraform versions
`asdf-vm` or `asdf` is a CLI tool that manages multiple language runtime versions on a per-project basis. It's like `gvm`, `nvm`, `rbenv`, and `pyenv` and more.

## Purpose
This post shows you how to install and configure multiple versions of terraform using `asdf`. I used brew on OSX to install asdf in a bash shell. There are also instructions to install with git using linux bash, ZSH, and fish on [Getting Started with asdf-vim](https://asdf-vm.com/#/core-manage-asdf-vm).

## Procedure

1. Install asdf with brew
```bash
brew install asdf
```

Successful output includes
``` bash
==> Summary
🍺  /usr/local/Cellar/asdf/0.7.3: 92 files, 194.4KB, built in 3 seconds
```

2. Test for a successful instal using the asdf version command
```bash
asdf --version
```

Successful output includes a version number like this
``` bash
v0.7.3
```

3. Configure your shell to use asdf using your .bash_profile
```bash
echo -e '\n. $(brew --prefix asdf)/asdf.sh' >> ~/.bash_profile
echo -e '\n. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash' >> ~/.bash_profile
```
To test, cat your ~/.bash_profile and filter for asdf. You should see this output from the cat command
``` bash
cat ~/.bash_profile | grep -i asdf
. $(brew --prefix asdf)/asdf.sh
. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash
```

Test your ASDF_DIR and PATH is set properly env and filtering for asdf. You should see an `ASDF_DIR` entry as well as a PATH entry that includes `/.asdf/shims`
```bash
env | grep -ir asdf
(standard input):ASDF_DIR=/usr/local/opt/asdf
(standard input):PATH=/Users/scott/.asdf/shims:/usr/local/opt/asdf/bin:/Users/scott/.gem/ruby/2.6.0/bin:/Users/scott/.rbenv/shims:/usr/local/opt/ruby/bin:/Users/scott/anaconda3/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/scott/bin
```

4. Install dependencies for plugins
```bash
brew install \
  coreutils automake autoconf openssl \
  libyaml readline libxslt libtool unixodbc \
  unzip curl
```

Successful output from brew includes a `Summary` and a `Pouring` for each dependency. This shows output for libxml
``` bash
==> Summary
🍺  /usr/local/Cellar/libxml2/2.9.9_2: 281 files, 10.5MB

==> Pouring libxslt-1.1.33_1.mojave.bottle.tar.gz
```

#### Now, we have `asdf` installed and configured in our shell, and we'll install the terraform plugin and manage between v.0.11 and v.0.12.

#### Install Terraform plugin for `asdf`
```
asdf plugin-add terraform https://github.com/Banno/asdf-hashicorp.git
```
Successful output includes `Cloning` from the reop and `Unpacking` the objects
```bash
Sat Jul 27 08:04:08 scott@Scotts-MacBook-Pro ~/code/vernonpta $ asdf plugin-add terraform https://github.com/Banno/asdf-hashicorp.git
Cloning into '/Users/scott/.asdf/plugins/terraform'...
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 57 (delta 0), reused 0 (delta 0), pack-reused 56
Unpacking objects: 100% (57/57), done.
```

#### List versions of terraform
```bash
asdf list-all terraform
```
Successful output includes a list versions like this
``` bash
0.11.11
0.11.12-beta1
0.11.12
0.11.13
0.11.14
0.12.0-alpha1
0.12.0-alpha2
0.12.0-alpha3
0.12.0-alpha4
0.12.0-beta1
0.12.0-beta2
0.12.0-rc1
0.12.0
0.12.1
0.12.2
0.12.3
0.12.4
0.12.5
```

#### We chose to install the latest version at the time of this writing, 0.12.5 as well as the latest version of terraform 0.11; which is 0.11.14

#### Install the latest v 0.11.x terraform using `asdf`
```bash
asdf install terraform 0.11.14
```

expected output includes
```
Downloading terraform version 0.11.14 from https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_darwin_amd64.zip
Cleaning terraform previous binaries
Creating terraform bin directory
Extracting terraform archive
```
#### Install the latest v 0.12.x terraform using `asdf`
```bash
asdf install terraform 0.12.5
```
expected output includes
```
Downloading terraform version 0.12.5 from https://releases.hashicorp.com/terraform/0.12.5/terraform_0.12.5_darwin_amd64.zip
Cleaning terraform previous binaries
Creating terraform bin directory
Extracting terraform archive
```

#### Set the global terraform version to 0.12.5
```bash
asdf global terraform 0.12.5
```
there is NO expected output from this command. test with the `terraform --verison` command

```bash
terraform --version
```
expected output includes a terraform version number
```bash
Terraform v0.12.5
```
#### Test the current version of terraform using `asdf`
```bash
asdf current
```
expected output includes a terraform version
```bash
terraform      0.12.5   (set by /Users/scott/.tool-versions)
```

#### Switch to the older version of terraform using `asdf` to set the global version pf asdf


```bash
asdf global terraform 0.11.14
```

```bash
terraform --version
```
expected output includes a terraform version number
```bash
Terraform v0.11.14
Your version of Terraform is out of date! The latest version
is 0.12.5. You can update by downloading from www.terraform.io/downloads.html
```

#### Test the current version of terraform using `asdf`
```bash
asdf current
```

expected output includes a terraform version
```bash
terraform      0.11.14  (set by /Users/scott/.tool-versions)
```

#### You have now installed `asdf`, added the plugin for terraform, installed two different versions of terraform, and you can switch between those versions using the `asdf global` command. Nice work.
