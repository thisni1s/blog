---
title: "OpenSuse FIDO2 Login"
date: 2021-02-21T12:57:54+01:00
draft: false
toc: false
images:
tags:
  - linux
  - fido2
  - opensuse
  - lang:english
---

## Register the keys

First make sure you have the ```pam_u2f``` packet installed and that its version is at least 1.1.0.
After installing it you should be able to call ```pamu2fcfg```. This is what we use to register our keys.
Because OpenSuse uses the root password for sudo by default we have to register the key not only for ourselves but also for the root user. To do that we run ```pamu2fcfg```. You first have to enter your authenticator pin and touch it afterwards. The result should look like this:

 ```nils:<keyhandle>,<userkey>,es256,+presence```

You should save the output for later and run the command again but this time as root with sudo. Again you should save the output.
Now create a new file ```/etc/u2f_mappings```. This file contains the information of our registered keys an looks like this:

``` shell
<username1>:<KeyHandle1>,<UserKey1>,<Options1>:<KeyHandle2>,<UserKey2>,<Options2>:
<username2>:<KeyHandle1>,<UserKey1>,<Options1>:<KeyHandle2>,<UserKey2>,<Options2>:
```

We paste in the outputs saved earlier and **add a colon at the end of each line**.

## Configure PAM

Now we can configure PAM to use pam_u2f for authentication.
In Tubleweed pam configuration files are stored under ```/etc/pam.d/``` and ```/usr/etc/pam.d/```. We then find a program we want to use U2F with and edit its configuration file. For sudo that would be ```/usr/etc/pam.d/sudo```. Open it and add the U2F config at the top:

```sudo vim /usr/etc/pam.d/sudo```

Add this line: ```auth sufficient pam_u2f.so authfile=/etc/u2f_mappings cue pinverification=1```

The result should look similar to this.

``` shell
#%PAM-1.0
auth sufficient pam_u2f.so authfile=/etc/u2f_mappings cue pinverification=1
auth     include        common-auth
account  include        common-account
password include        common-password
session  optional       pam_keyinit.so revoke
session  include        common-session
```  

Other config files worth changing are:
- /etc/pam.d/sddm - Login at boot
- /usr/etc/pam.d/kde - Screen unlocking in KDE

Any changes to these files should take immediate affect and you should be able to use your FIDO2 key for authentication.

#### Ressources

- https://smart-tux.de/post/pam-u2f/ - Guide for Fedora
- https://developers.yubico.com/pam-u2f/ - pam_u2f documentation
- https://en.opensuse.org/SDB:Facial_authentication - SuSe guide for implementing face unlocking
