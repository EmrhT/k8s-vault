# k8s-vault
1. k8s-vault is a simple shell script tool which enables the management of kubeconfig files for multiple k8s clusters securely on local computers.
2. With k8s-vault, kubeconfigs of all clusters are always encrypted on local disk. When you need one of them, only the needed kubeconfig is available after a password prompt and it only exists within a subshell. Therefore, cleartext version is gone after you exit that shell.
3. Inspired from the much more sophisticated "aws-vault" tool (https://github.com/99designs/aws-vault) k8s-vault handles kubeconfig files which are especially hard to secure locally due to their long-term nature.
4. Major cloud service providers (CSP), recognizing the need, offer tools to derive short-term kubeconfigs with ways such as "aws eks update-kubeconfig --region region-code --name my-cluster". However, K8s clusters on minor CSPs and on-prem installations lack this luxury.

## How to Prepare Your Local Computer
1. Encrypt existing kubeconfig files using **openssl** ``openssl aes-256-cbc -pbkdf2 -salt -in ~/.kube/cluster1-kubeconfig -out  ~/.kube/cluster1-kubeconfig.enc``. Create a strong password to protect encrypted files.
2. Create a directory under ~/.kube with ``mkdir -p ~/.kube/encrypted`` (this is the default, configurable within the shell script).
3. Move all encrypted kubeconfig files under that directory with ``mv  ~/.kube/*.enc  ~/.kube/encrypted/``
4. Delete existing non-encrpyted kubeconfig files (you might want to back them up somewhere safe before deleting them). 

## How to Install and Use 
1. Simply clone the repo with ``git clone https://github.com/EmrhT/k8s-vault.git`` and cd into it with ``cd k8s-vault``.
2. Make the shell script executable with ``chmod +x 600 k8s-vault``.
3. (Optional) copy it to somewhere within your PATH ``cp k8s-vault /usr/local/bin``
4. List the available clusters with ``k8s-vault list``.
5. Enable the needed cluster with ``k8s-vault use cluster1``. Enter the password for decryption. 
6. After you finish with that cluster exit the subshell ``exit``.
