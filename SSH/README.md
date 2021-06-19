# K8s Nodes SSH Private and Public Key-Pair specific for this CloudFormation template

The K8s Nodes SSH Private and Public Key-Pair are normal SSH Key-Pair, which can be generated with common ssh tools, such as `ssh-keygen`.
As with normal SSH Key-Pair, you need to ***keep the Private Key information/file securely***, since if it falls into the wrong hand, it can be used to access your EC2 instances which carry the Public Key.

In this CloudFormation template, the K8s Nodes SSH Private and Public Key-Pair are used only between K8s Master Node to send instructions to all K8s Worker Nodes.
It is recommended that you generate a new SSH Key-Pair specific for this CloudFormation template only, and not using your AWS Key-Pair or other SSH Key-Pair you use for other purposes.
On the other hand, do not use the SSH Key-Pair you generate for this CloudFormation template for other purposes.
These restrictions improve your security posture, since separate SSH Key-Pair isolates the damage only to systems which use the leaked SSH Key-Pair only.

Why not use URL to pick up the SSH Key-Pair files? Because URL can be (and needs to be) accessed by the public Internet. Which means the SSH Key-Pair are already exposed to public Internet.
Using a masked text input (on the CloudFormation template) means you are the only one who is able to provide the SSH Key-Pair, and the SSH Key-Pair do not need to be exposed to public Internet.
Due to this security measure, the SSH Key-Pair need to be formatted to fit into AWS CloudFormation template's masked text input parameter.

In summary, the Key-Pair files content which can contain multiple lines, need to be formatted into a single line; with the `new-line` character substituted with escaped sequence `\n`.


```
ubuntu@ubuntu:~$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/ubuntu/.ssh/id_rsa):
Created directory '/home/ubuntu/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/ubuntu/.ssh/id_rsa
Your public key has been saved in /home/ubuntu/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:sjPFrwnN3n4NayVYrjNa5RbhsFq7yYwxc57xc2IUYt8 ubuntu@ubuntu
The key's randomart image is:
+---[RSA 3072]----+
|                 |
|                 |
|          . .    |
|       .  o+o.   |
|      . S.o*+o   |
|       * +.+*.E  |
|      = B *oo*   |
|       = #+BB o  |
|        *oX*.+   |
+----[SHA256]-----+
ubuntu@ubuntu:~$
```



ubuntu@ubuntu:~$ ls -lap
total 32
drwxr-xr-x 4 ubuntu ubuntu 4096 Jun 19 05:31 ./
drwxr-xr-x 3 root   root   4096 Dec 16  2020 ../
-rw------- 1 ubuntu ubuntu   27 Dec 16  2020 .bash_history
-rw-r--r-- 1 ubuntu ubuntu  220 Feb 25  2020 .bash_logout
-rw-r--r-- 1 ubuntu ubuntu 3771 Feb 25  2020 .bashrc
drwx------ 2 ubuntu ubuntu 4096 Dec 16  2020 .cache/
-rw-r--r-- 1 ubuntu ubuntu  807 Feb 25  2020 .profile
drwx------ 2 ubuntu ubuntu 4096 Jun 19 05:31 .ssh/
-rw-r--r-- 1 ubuntu ubuntu    0 Dec 16  2020 .sudo_as_admin_successful
ubuntu@ubuntu:~$ cd .ssh/
ubuntu@ubuntu:~/.ssh$ ls -lap
total 16
drwx------ 2 ubuntu ubuntu 4096 Jun 19 05:31 ./
drwxr-xr-x 4 ubuntu ubuntu 4096 Jun 19 05:31 ../
-rw------- 1 ubuntu ubuntu 2602 Jun 19 05:31 id_rsa
-rw-r--r-- 1 ubuntu ubuntu  567 Jun 19 05:31 id_rsa.pub
ubuntu@ubuntu:~/.ssh$ cat id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
ubuntu@ubuntu:~/.ssh$ cat id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCyyA3uy4iBoHuA7g01tOOVWa8Fd4ieohUCLl4tlQ8E7d8piTgcBmW7oDH6CEm8PmXsObQHdyhMnq517ktUIgryR341xnytCZSKaSywctfJsbDT+OEos3Ny6AoBPzrug00jhVwy2W6QAFTyAu0XPSEbL2xw9tbgGSUK1LnO336MTBoMEHibmOqtTC/nkfYp2Ek95opRK5JKB1G9UDqPbloyoP/voj7TC4opz1C51llOqeEqdTfkIPsrVzE1lAyKhh8b96Kja3X1BbYxIRWaMAFtnEF0VKCrwL0V+mL0n6p9SK72pkWzg5TS7MpWJkiZhSr8umCKWNkBYwSJ8fHWuWPwHNq4d7C/jACWHSQuAgOTmJiQO4KYKWbHgQapFux/EcUWwSPBTlGn5w+blcevCc19R61YfzBBMzYGMrQQ31g9e7Jd4ISx9NS4Ag/GCojTPYtnQyfGN2ZXxOgAe96DJo3S87X6xtqk8xREQx1FItw3Np6PxJPjyOWGwRw+2x7+lnU= ubuntu@ubuntu
ubuntu@ubuntu:~/.ssh$






ubuntu@ubuntu:~$ cat /home/ubuntu/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
ubuntu@ubuntu:~$ cat /home/ubuntu/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQdTEvUYrH/5xvdOarPH04BP+xmcM8a0jvwfJIUKD+QSPu7gHAZzqvbgwW5+Utq4B/4zpwtenP5H1nt8SZDmLrbRMCB2XV31wnUcYvAU0tyfts225GqrlcQ9XctmBmElzrgAs/bIZpa3sKcrtkPhAfkS1dAVtiKs/XDOxQqx3acV7EcY8kbGTuo7lMTXN10uEdHSlhiMCScLIMyAIWSxvoA26QGYYMCLrGWLAppYbG9fO2azF3ZfFwx0edqIKQSEVPut0jp1DYNL0ksvpSWDgz6KD0l9rBb1K/whm0abnn/IctF2HASyCZ8oq39mIUX02wEnGwwMe1iSb6iSTbeJaHTYwDvr3KI3g3sV1/HprNJJc2P6FQveqpDfTGDdu9ivFczIZUnL/qGuKe0+a388qbbWp/cmRBzrXidCVlEQRS6CW+pfiqbdZ2VrqUWkpUJ+V02R4t5JKAZl6kqCJoLURowMKhKMHl4wUFKAYi4PgcFcQa6f4E9u42Vqgs= ubuntu@ubuntu
ubuntu@ubuntu:~$ cat /home/ubuntu/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQdTEvUYrH/5xvdOarPH04BP+xmcM8a0UjvwfJIUKD+QSPu7gHAZzqvbgwW5+Utq4B/4zpwtenP5H1nt8SZDmLrbRMCB2XV31wnUcYvQAU0tyfts225GqrlcQ9XctmBmElzrgAs/bIZpa3sKcrtkPhAfkS1dAVtiKs/XDOxQqx3acVK7EcY8kbGTuo7lMTXN10uEdHSlhiMCScLIMyAIWSxvoA26QGYYMCLrGWLAppYbG9fO2azF3eZfFwx0edqIKQSEVPut0jp1DYNL0ksvpSWDgz6KD0l9rBb1K/whm0abnn/IctF2HASyCZ8oGq39mIUX02wEnGwwMe1iSb6iSTbeJaHTYwDvr3KI3g3sV1/HprNJJc2P6FQveqpDfTGDdu9aivFczIZUnL/qGuKe0+a388qbbWp/cmRBzrXidCVlEQRS6CW+pfiqbdZ2VrqUWkpUJ+V02RC4t5JKAZl6kqCJoLURowMKhKMHl4wUFKAYi4PgcFcQa6f4E9u42Vqgs= ubuntu@ubuntu
ubuntu@ubuntu:~$








