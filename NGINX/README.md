# NGINX+ KIC Part, Explanation

Table below describes parameters requirements depending on whether you are building/compiling the NGINX+ KIC container image, or not; while launching the CloudFormation template.

| CFT Label (Parameter Name) | When Build/Compile NGINX+ KIC | SKIP Build/Compile NGINX+ KIC |
| --- | --- | --- |
| URL of NGINX+ Compilation Script (CompileNGINXPlusScript) | Mandatory | Mandatory |
| NGINX+ Repository Certificate (NGINXRepositoryCertificate) | Mandatory | Not Needed |
| NGINX+ Repository Private Key (NGINXRepositoryPrivateKey) | Mandatory | Not Needed |
| Repository (Docker Hub) User ID (DockerHubUserID) | Mandatory | Not Needed |
| Repository (Docker Hub) Password (DockerHubPassword) | Mandatory | Not Needed |
| NGINX+'s Repository (Docker Hub) Name (DockerHubRepositoryName) | Mandatory, need to be in sync with "Repository (Docker Hub) User ID" (DockerHubUserID) parameter | Mandatory |
| NGINX+ Version (NGINXPlusVersion) | Mandatory | Mandatory |
| URL of NGINX+ KIC Script (NGINXPlusIngressScript) | Mandatory | Mandatory |










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


