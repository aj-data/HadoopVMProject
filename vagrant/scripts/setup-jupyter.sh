#!/bin/bash  
  
function installPythonAndPip {  
    echo "Installing Python and Pip..."  
    sudo apt install -y python3 python3-pip  
}  
  
function upgradePip {  
    echo "Upgrading Pip..."  
    sudo pip3 install --upgrade pip  
}  
  
function installVirtualEnv {  
    echo "Installing Virtualenv..."  
    sudo pip3 install virtualenv  
}  
  
function createVirtualEnv {  
    echo "Creating virtual environment..."  
    mkdir ~/mientorno  
    cd ~/mientorno  
    virtualenv entornojupyter  
}  
  
function activateVirtualEnv {  
    echo "Activating virtual environment..."  
    source ~/mientorno/entornojupyter/bin/activate  
}  
  
function installJupyter {  
    echo "Installing Jupyter..."  
    pip install jupyter  
}  
  
function generateJupyterConfig {  
    echo "Generating Jupyter config file..."  
    jupyter notebook --generate-config  
}  
  
function setupJupyterConfig {  
    echo "Setting up Jupyter config file..."  
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
