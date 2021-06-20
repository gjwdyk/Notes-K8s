# Plan to be Developed Further

Below is a plan to develop the environment further, to include also F5 CIS and F5 Big-IP.



























## Planned Next

![K8s Cluster Logical Diagram - with Public IP only for Master Node](Figures/K8sClusterLogicalDiagramMasterIP.png)
Public IP Address is needed for each node to install softwares and/or get containers.

![K8s Cluster Logical Diagram - with Public IP for Master Node and Big-IP 1-NIC](Figures/K8sClusterLogicalDiagramMasterBigIPOneNIC.png)
Inconsistent design, either all or none of nodes have Public IP Address.

![K8s Cluster Logical Diagram - with Public IP for Big-IP 1-NIC](Figures/K8sClusterLogicalDiagramBigIPOneNIC.png)
Nodes Outgoing Traffic to be NAT-ed through Big-IP.







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


