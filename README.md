# k8s-vault
k8s-vault is a simple shell script tool which enables the management of kubeconfig files for multiple k8s clusters securely on local computers.
With k8s-vault, kubeconfigs of all clusters are always encrypted on local disk. When you need one of them, only the needed kubeconfig is available after a password prompt and it only exists within a subshell. Therefore, cleartext version is gone after you exit that shell. 
Inspired from the much more sophisticated "aws-vault" tool (https://github.com/99designs/aws-vault) k8s-vault handles kubeconfig files which are especially hard to secure locally due to their long-term nature. 
Major cloud service providers (CSP), recognizing the need, offer tools to derive short-term kubeconfigs with ways such as "aws eks update-kubeconfig --region region-code --name my-cluster". However, K8s clusters on minor CSPs and on-prem installations lack this luxury.

## How to install
1. 
