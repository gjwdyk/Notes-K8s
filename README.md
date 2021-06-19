# Notes-K8s

This repository builds a Kubernetes Cluster within a AWS VPC using CloudFormation template as well as bash scripts. The Kubernetes Cluster is built from N units of EC2 Ubuntu servers (where N can be between 1 to 9 worker nodes).
There is only one K8s Master Node built on this repository.

Why not use AWS EKS instead? To have the exposure of provisioning and/or managing the K8s Master Instances, as not everyone who wants to implement containerization service can do it on EKS. Some of us still need to build our own Kubernetes Cluster.
The goal of this repository is to be able to quikly have environment where some demos can be performed; especially ones which involves K8s, NGINX and F5 Big-IP.
Further down the line, the Environment built by this repository will involve F5 CIS and F5 Big-IP, which may not be possible with AWS EKS, since F5 CIS needs tweaks of the internal interworking of the K8s Cluster itself.

Diagram below depicts the logical diagram of nodes within AWS VPC.

![K8s Cluster Logical Diagram - with Public IP for each Node](Figures/K8sClusterLogicalDiagramAllIP.png)



***

## PreRequisites

Before you start, you need to prepare the followings:

SSH Private and Public Keys

Docker Hub Account
![DockerHub Default Repository Privacy](Figures/DockerHubDefaultRepositoryPrivacy.png)

NGINX Repository Certificate and Private Key



***

## Template Parameters

| CFT Label | Parameter Name | Required | Description |
| --- | --- | --- | --- |
| Stack Name | Stack Name | Mandatory and Unique Across Account | Give a unique name to the CloudFormation stack. Stack name will be used to prefix all resources created by this CloudFormation template. Stack name can include letters (A-Z and a-z), numbers (0-9), and dashes (-). |
| PreFix for Name Tags | TagPreFix | Optional | Give a Prefix to be used for Prefix-Naming all resources created by this CloudFormation template. In an account where there are multiple users, using initial will help to identify who owns the resources which this CloudFormation template creates. |
| K8s Nodes' Image ID | K8sNodeImageID | Mandatory with Default Value | Input a valid AMI ID of a Ubuntu Server to be used for the K8s Nodes. The Default AMI ID are based on https://cloud-images.ubuntu.com/locator/ec2/ . |
| K8s Nodes' Image Type | K8sNodeImageType | Mandatory with Default Value | Select an EC2 Image Type for the K8s Nodes. Allowed values are "ubuntu1804amd64", "ubuntu1804arm64", "ubuntu2004amd64", "ubuntu2004arm64" which represent Ubuntu Server version 18.04 and version 20.04 on AMD64 and ARM64 architectures. Note that this repository was tested only on the Default value which is "ubuntu2004amd64". |
| K8s Nodes' Instance Type | K8sNodeInstanceType | Mandatory with Default Value | Select an EC2 Instance Type for the K8s Nodes. Note that instance type also influences the number of CPU and amount of Memory available for the K8s Node. Refer also to official guides from Ubuntu (https://help.ubuntu.com/community/Installation/SystemRequirements) and Kubernetes (https://docs.kublr.com/installation/hardware-recommendation/) on the minimal system requirements for each platform, and pick the largest specification on each aspect. |
| Number of K8s Worker Node(s) | NumberOfK8sWorkerNode | Mandatory with Default Value | Select from 1 to 9 Worker Nodes to be created by the CloudFormation template. |
| EC2 SSH Key-Pair | EC2SSHKeyPair | Optional | This Key-Pair will be used for SSH access into the EC2 instances or the K8s Nodes. Select a Key-Pair from the drop-down list of Existing Key-Pairs. If the Key-Pair you want to use is created after you execute/launch this CloudFormation template (example: on separate browser's tab you created a new Key-Pair after you execute/launch this CloudFormation template), the new Key-Pair will not be shown. You need to assign/use a Key-Pair if you'd like to access any of the K8s Node's CLI. |
| Existing Registered Domain Name in AWS Route53 | ParentDomainName | Blah | Blah |
| K8s Nodes SSH Private Key | K8sSSHPrivateKey | Mandatory | Blah |
| K8s Nodes SSH Public Key | K8sSSHPublicKey | Mandatory | Blah |
| Time Zone | TimeZone | Optional with Default Value | Blah |
| URL of OS Preparation Script | OSPreparationScript | Mandatory with Default Value | Blah |
| URL of Docker Preparation Script | DockerPreparationScript | Mandatory with Default Value | Blah |
| URL of Common K8s Preparation Script | CommonK8sPreparationScript | Mandatory with Default Value | Blah |
| URL of K8s Master Preparation Script | K8sMasterPreparationScript | Mandatory with Default Value | Blah |
| URL of Cluster Networking (flannel) YAML File | ClusterNetworkConfiguration | Mandatory with Default Value | Blah |
| URL of K8s Worker Preparation Script | K8sWorkerPreparationScript | Mandatory with Default Value | Blah |
| URL of K8s Fundamental Services Script | K8sServicePreparationScript | Optional with Default Value | Blah |
| URL of NGINX+ Compilation Script | CompileNGINXPlusScript | Optional with Default Value | Blah |
| NGINX+ Version | NGINXPlusVersion | Optional with Default Value | Blah |
| NGINX+ Repository Certificate | NGINXRepositoryCertificate | Optional | Blah |
| NGINX+ Repository Private Key | NGINXRepositoryPrivateKey | Optional | Blah |
| Repository (Docker Hub) User ID | DockerHubUserID | Optional | Blah |
| Repository (Docker Hub) Password | DockerHubPassword | Optional | Blah |
| NGINX+'s Repository (Docker Hub) Name | DockerHubRepositoryName | Optional | Blah |
| Skip NGINX+ Compilation ? | SkipNGINXPlusCompilation | Optional with Default Value | Blah |
| URL of NGINX+ KIC Script | NGINXPlusIngressScript | Optional with Default Value | Blah |
| Blah | ApplicationServiceScript | Optional with Default Value | Blah |






































## Planned Next

![K8s Cluster Logical Diagram - with Public IP only for Master Node](Figures/K8sClusterLogicalDiagramMasterIP.png)
Public IP Address is needed for each node to install softwares and/or get containers.

![K8s Cluster Logical Diagram - with Public IP for Master Node and Big-IP 1-NIC](Figures/K8sClusterLogicalDiagramMasterBigIPOneNIC.png)
Inconsistent design, either all or none of nodes have Public IP Address.

![K8s Cluster Logical Diagram - with Public IP for Big-IP 1-NIC](Figures/K8sClusterLogicalDiagramBigIPOneNIC.png)
Nodes Outgoing Traffic to be NAT-ed through Big-IP.


