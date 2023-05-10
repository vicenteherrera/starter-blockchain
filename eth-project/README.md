# Ethereum Project

## How this project was created

Using regular Python and virtual environment:
```console
# from root repo folder
# Create virtual environment
python3 -m venv env
# Activate on Windows
env\Scripts\Activate
# Activate on Bash (Linux, MacOs)
source .\env\bin\activate
# Add dependencies
pip install web3
pip install py-solc-x
pip install eth-account
# Generate dependencies file
pip install pipreqs
pipreqs --savepath=requirements.in 
```

Using Pyenv and Poetry:
```console
# from root repo folder
# Install Python 3.9
pyenv install 3.9
# it takes a long time to finish
# Activate Python 3.9 for root directory
pyenv local 3.9
# Create client source project
poetry new --name client --src eth-project
cd eth-project
# Install dependencies
poetry add web3
poetry add py-solc-x
poetry add eth-account
```

## How to run this project

### Install Python 3.9 or higher

You can directly download and install the latest Python version
* [Python 3.9 or higher](https://www.python.org/downloads/)

On Windows remember to check the option to add it to your path.

Alternatively you can use PyEnv to download alternative Python versions:
* [pyenv](https://github.com/pyenv/pyenv)
* [Configure pyenv](https://github.com/pyenv/pyenv#installation)
* Install specific Python 3.9 version with PyEnv:  
  `pyenv install 3.9`  
  `pyenv local 3.9`

### Install requirements

On Windows you may need:
* [Microsoft C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools) (desktop development tools)

**With a virtual environment**

You can create a virtual environment, and activate it.

On Windows:
```console
# Create virtual environment
python3 -m venv env
# Activate on Windows
env\Scripts\Activate
# Activate on Bash (Linux, MacOs)
source .\env\bin\activate

# Install each dependency
pip install web3
pip install py-solc-x
pip install eth_account

# Or install all from text file
pip install -r requirements.in
```

**Without a virtual environment**

Alternative you can use Poetry to automatically install requirements on a virtual environment.

* [poetry installation](https://python-poetry.org/docs/)

```bash
# Install all dependencies with Poetry using pyproject.toml
poetry install
```

[More info on how to handle requirements on a Python project here](https://github.com/vicenteherrera/starter-python)

## Setup

Edit configuration file to set parameters as local environment variables:

On [Windows](https://www3.ntu.edu.sg/home/ehchua/programming/howto/Environment_Variables.html):

```powershell
# Copy `sample-env.bat` to `env.bat`, and modify it
# Activate it:
env.bat
```

On Bash (Linux, MacOs):

```bash
# Copy `sample.envrc` to `.envrc`, and modify it
# Activate it:
source ./.envrc
```

## Run the examples

To run the example programs follow these instructions.

Activate the virtual environment, setup environment variables, then run:
```bash
# Execute transfer example 
python3 ./src/client/1_transactions.py
# Execute smart contract example
python3 ./src/client/2_deploy_contract.py
```

If using Poetry, just setup environment variables, and run:
```bash
# Execute transfer example 
poetry run python3 ./src/client/1_transactions.py
# Execute smart contract example
poetry run python3 ./src/client/2_deploy_contract.py
```