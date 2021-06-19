# NGINX+ KIC Part, Explanation

Table below describes parameters requirement depending on whether you are building/compiling the NGINX+ KIC container image or not; while launching/deploying the CloudFormation template.

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

On both cases, the scripts are all mandatory, and there are no differences in usage or treatment between both cases.



## When SKIPPING Building/Compiling NGINX+ KIC Container Image

When you select to SKIP building/compiling the NGINX+ KIC container image, you do NOT need to supply the:
- [ ] NGINX+ Repository Certificate (NGINXRepositoryCertificate)
- [ ] NGINX+ Repository Private Key (NGINXRepositoryPrivateKey)
- [ ] Repository (Docker Hub) User ID (DockerHubUserID)
- [ ] Repository (Docker Hub) Password (DockerHubPassword)

This also means you are using NGINX+ KIC container image which has been built/compiled and stored in some repository somewhere.
![gjwdyk/nginx-ingress](../Figures/gjwdyknginxingress.png)





## When Building/Compiling NGINX+ KIC Container Image








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


