#!/bin/bash  

source "/vagrant/scripts/common.sh"

function installSSHPass {
	apt-get update
	apt-get install -y sshpass
}

function overwriteSSHCopyId {
	cp -f $RES_SSH_COPYID_MODIFIED /usr/bin/ssh-copy-id
}

function createSSHKey {
	#echo "generating ssh key"
    echo "Generando clave ssh"
	ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
	cp -f $RES_SSH_CONFIG ~/.ssh
}

# Call the functions
installSSHPass
createSSHKey
overwriteSSHCopyId