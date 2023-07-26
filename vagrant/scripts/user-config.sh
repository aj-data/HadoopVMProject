#!/bin/bash

# Crear usuario hadoop
sudo useradd -m -s /bin/bash hadoop
sudo passwd hadoop

# Agregar al grupo sudo
sudo usermod -aG sudo hadoop

# Cambiar al usuario hadoop
su - hadoop

# Instalar SSH si no está instalado
if ! dpkg -s openssh-server openssh-client >/dev/null 2>&1; then
  sudo apt install -y openssh-server openssh-client
fi

# Generar llaves SSH
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa

# Agregar llave pública a authorized_keys
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Cambiar permisos de authorized_keys
chmod 0600 ~/.ssh/authorized_keys

# Probar conexión SSH sin contraseña
ssh -i ~/.ssh/id_rsa localhost