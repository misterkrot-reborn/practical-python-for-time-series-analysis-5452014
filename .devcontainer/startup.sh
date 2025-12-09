#!/bin/bash

# The virtual environment is already created at /opt/venv by the Dockerfile
# We just need to ensure it's in the PATH and install the Jupyter kernel

# Add the virtual environment to PATH
export PATH="/opt/venv/bin:$PATH"

# Also add to bashrc for persistence
echo 'export PATH="/opt/venv/bin:$PATH"' >> ~/.bashrc

# Install Jupyter kernel using the virtual environment's Python
echo "Installing IPython kernel..."
/opt/venv/bin/python -m ipykernel install --user --name time-series --display-name "Python (Time Series)"

# Set up IPython startup configuration
echo "Setting up IPython configuration..."
mkdir -p ~/.ipython/profile_default/startup && cp .devcontainer/pandas-startup.py ~/.ipython/profile_default/startup/00-pandas-options.py

#libs for virtual env
#i added those last three lines because the venv wasn't getting the libs properly
/opt/venv/bin/python -m ensurepip --upgrade
/opt/venv/bin/python -m pip install --upgrade pip
/opt/venv/bin/pip install pandas pyarrow fastparquet plotly nbformat nbconvert seaborn scikit-learn statsmodels ipykernel matplotlib numpy scipy prophet ruff jupyter notebook openpyxl

echo "Devcontainer setup complete!"