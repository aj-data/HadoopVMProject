#!/bin/bash

function SSHKey {
    echo "Creando par de claves..."
    ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    chmod 0600 ~/.ssh/authorized_keys
    cp -f /vagrant/resources/ssh/config ~/.ssh
}

SSHKey