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

In summary, the Key-Pair files' content which can contain multiple lines, need to be formatted into a single line; with the `new-line` character substituted with escaped sequence `\n`.

Below a guidance to generate a new SSH Key-Pair and to properly format the SSH Key-Pair for this CloudFormation template.



<br><br><br>
***

Generate a new SSH Key-Pair with `ssh-keygen` with ***NO Passphrase***.

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
SHA256:abcdefghijklmnopqrstuvwxyz0123456789ABCDEFG ubuntu@ubuntu
The key's randomart image is:
+---[RSA 3072]----+
| /$$   /$$       |
|| $$  | $/$$$$$$ |
|| $$  | /$$__  $$|
|| $$$$$|$$$  \__/|
|| $$__ |$$$      |
|| $$  ||$$$      |
|| $$  ||$$$    $$|
||__/  ||_/$$$$$$/|
|        \______/ |
+----[SHA256]-----+
ubuntu@ubuntu:~$
```

Locate the resulted new SSH Key-Pair.

```
ubuntu@ubuntu:~$ ls -lap /home/ubuntu/.ssh/
total 16
drwx------ 2 ubuntu ubuntu 4096 Jun 19 05:31 ./
drwxr-xr-x 4 ubuntu ubuntu 4096 Jun 19 05:31 ../
-rw------- 1 ubuntu ubuntu 2602 Jun 19 05:31 id_rsa
-rw-r--r-- 1 ubuntu ubuntu  567 Jun 19 05:31 id_rsa.pub
ubuntu@ubuntu:~$
```



<br><br><br>
***

Below is a ***SAMPLE*** of SSH Private Key file's content. Note that actual SSH Private Key file may contains much more lines.

```
ubuntu@ubuntu:~$ cat /home/ubuntu/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345
abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345
abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345
abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345
abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345
abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345
abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345
abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345
abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345
abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ==
-----END OPENSSH PRIVATE KEY-----
ubuntu@ubuntu:~$
```

Replace every `new-line` character with escape sequence `\n`, so the end result of re-formatted SSH Private Key becomes like below.

```
ubuntu@ubuntu:~$ cat /home/ubuntu/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ==\n-----END OPENSSH PRIVATE KEY-----
ubuntu@ubuntu:~$
```



<br><br><br>
***

Below is a ***SAMPLE*** of SSH Public Key file's content, which usually already formatted in one line. No changes needed. Also note that the actual SSH Public Key file may have more/longer characters in the one-line.

```
ubuntu@ubuntu:~$ cat /home/ubuntu/.ssh/id_rsa.pub
ssh-rsa abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ== ubuntu@ubuntu
ubuntu@ubuntu:~$
```



<br><br><br>
***

During CloudFormation template launch, copy paste the one-line formatted Key-Pair files content to respective parameters.

<br>

Following the example above, copy paste:
```
-----BEGIN OPENSSH PRIVATE KEY-----\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345\nabcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ==\n-----END OPENSSH PRIVATE KEY-----
```
into `K8s Nodes SSH Private Key` (`K8sSSHPrivateKey`) parameter input field.

<br>

And copy paste:
```
ssh-rsa abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ012345abcdefghijklmnopqrstuvwxyz+0123456789/ABCDEFGHIJKLMNOPQRSTUVWXYZ== ubuntu@ubuntu
```
into `K8s Nodes SSH Public Key` (`K8sSSHPublicKey`) parameter input field.



<br><br><br>
***

<br><br><br>
```
╔═╦═════════════════╦═╗
╠═╬═════════════════╬═╣
║ ║ End of Document ║ ║
╠═╬═════════════════╬═╣
╚═╩═════════════════╩═╝
```
<br><br><br>


