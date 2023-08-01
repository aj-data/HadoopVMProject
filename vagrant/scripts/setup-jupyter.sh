#!/bin/bash  
  
function installPythonAndPip {  
    #echo "Installing Python and Pip..."
    echo "Instalando Python y Pip..."  
    sudo apt install -y python3 python3-pip  
}  
  
function upgradePip {  
    #echo "Upgrading Pip..."
    echo "Actualizando Pip..."  
    sudo pip3 install --upgrade pip  
}  
  
function installVirtualEnv {  
    #echo "Installing Virtualenv..." 
    echo "Instalando Virtualenv..." 
    sudo pip3 install virtualenv  
}  
  
function createVirtualEnv {  
    #echo "Creating virtual environment..."
    echo "Creando entorno virtual..."  
    mkdir mientorno  
    cd mientorno  
    virtualenv entornojupyter  
}  
  
function activateVirtualEnv {  
    #echo "Activating virtual environment..."    
    echo "Activando entorno virtual..."
    source ~/mientorno/entornojupyter/bin/activate  
}  
  
function installJupyter {  
    #echo "Installing Jupyter..." 
    echo "Instalando Jupyter..." 
    pip install jupyter  
}  
  
function generateJupyterConfig {  
    #echo "Generating Jupyter config file..." 
    echo "Generando archivo de configuración de Jupyter..." 
    jupyter notebook --generate-config  
}  
  
function setupJupyterConfig {  
    #echo "Setting up Jupyter config file..."
    echo "Configurando archivo de configuración de Jupyter..."  
    echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py  
    echo "c.NotebookApp.port = 8080" >> ~/.jupyter/jupyter_notebook_config.py  
    echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py  
    echo "c.NotebookApp.password_required = True" >> ~/.jupyter/jupyter_notebook_config.py  
    echo "from notebook.auth import passwd" >> ~/.jupyter/jupyter_notebook_config.py  
    echo "c.NotebookApp.password = passwd('jupyterpassword')" >> ~/.jupyter/jupyter_notebook_config.py  
    echo "c.NotebookApp.username = 'jupyterusername'" >> ~/.jupyter/jupyter_notebook_config.py  
}  
  
# Call the functions  
installPythonAndPip  
upgradePip  
installVirtualEnv  
createVirtualEnv  
activateVirtualEnv  
installJupyter  
generateJupyterConfig  
setupJupyterConfig  
