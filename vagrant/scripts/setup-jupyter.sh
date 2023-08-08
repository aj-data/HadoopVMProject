#!/bin/bash

source "/vagrant/scripts/common.sh"
  
function installPythonAndPip {  
    #echo "Installing Python and Pip..."
    echo "Instalando Python y Pip..."  
    sudo apt-get install -y python3 python3-pip  
}  
  
function upgradePip {  
    #echo "Upgrading Pip..."
    echo "Actualizando Pip..."  
    #pip3 install --upgrade pip
    su - vagrant -c "pip3 install --upgrade pip"   
}  
  
#function installVirtualEnv {  
#    #echo "Installing Virtualenv..." 
#    echo "Instalando Virtualenv..." 
#    sudo pip3 install virtualenv  
#}  
  
#function createVirtualEnv {  
#    #echo "Creating virtual environment..."
#    echo "Creando entorno virtual..."  
#    mkdir mientorno  
#    cd mientorno  
#    virtualenv entornojupyter  
#}  
  
function installJupyter {  
    #echo "Activating virtual environment..."    
    #echo "Activando entorno virtual..."
    #source ~/mientorno/entornojupyter/bin/activate
    echo "Instalando Jupyter..."
    #pip install jupyter
    su - vagrant -c "pip3 install jupyter" 
    #echo "c.NotebookApp.username = 'jupyterusername'" >> ~/.jupyter/jupyter_notebook_config.py    
}

# Configurar variables de entorno de Jupyter
function addEnvPath {
    #echo "Setting up Jupyter environment variables..."
    echo "Configurando variables de entorno de Jupyter..."
	cp -f /vagrant/resources/misc/jupyter.sh /etc/profile.d/jupyter.sh
	. /etc/profile.d/jupyter.sh
    echo "Agregando variables al PATH..."
    /vagrant/resources/misc/jupyter-envs.sh
}

function generateJupyterConfig {
    echo "Generando configuración de Jupyter..."
    #sudo -u vagrant jupyter notebook --generate-config
    su - vagrant -c "jupyter notebook --generate-config"  
}

function setupJupyter {
    echo "Configurando Jupyter..."
    sudo -u vagrant echo "c.NotebookApp.ip = '0.0.0.0'" >> /home/vagrant/.jupyter/jupyter_notebook_config.py  
    sudo -u vagrant echo "c.NotebookApp.port = 8080" >> /home/vagrant/.jupyter/jupyter_notebook_config.py  
    sudo -u vagrant echo "c.NotebookApp.open_browser = False" >> /home/vagrant/.jupyter/jupyter_notebook_config.py  
    #echo "c.NotebookApp.password_required = True" >> ~/.jupyter/jupyter_notebook_config.py  
    #echo "from notebook.auth import passwd" >> ~/.jupyter/jupyter_notebook_config.py  
    sudo -u vagrant echo "c.NotebookApp.password = 'sha1:b39920d9193882c2f3416adba59f639555e12657'" >> /home/vagrant/.jupyter/jupyter_notebook_config.py 
}

# Call the functions  
installPythonAndPip
upgradePip
installJupyter
addEnvPath
generateJupyterConfig
setupJupyter  

