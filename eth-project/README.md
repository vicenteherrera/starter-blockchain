# Ethereum Project

## Prerequisites

* You need Python or Anaconda:
  * Install [Python 3.9 or higher](https://www.python.org/downloads/)
  * Install [Anaconda](https://www.anaconda.com/download/)
* On Windows you also need [Microsoft C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools)  
  (You only need to install "Desktop development with C++")
* Create an [Infura](https://infura.io) account

## Set up this project

### Using Anaconda

Open Anaconda, and choose to run a terminal with conda available. Then navigate to the `eth-project` folder, create a virtual environment for Python 3.11.5, activate it, and install the requirements:

```
cd eth-project
conda create --name myenv python=3.11.5
conda activate myenv
pip install -r requirements.in
```

### Using Python

Make sure you have Python version 3.9 or later. Then navigate to the `eth-project` folder, create a virtual environment, activate it, and install requirements:

```
cd eth-project
python -V
python -m venv .env
# Example activation for Windows:
.env\Scripts\Activate
# Example activation for bash (Linux, MacOs)
source ./.env/bin/activate
pip install -r requirements.in
```

### Configure the Infura key, wallet address, and private key

Modify the env.txt file with your Infura key, your wallet address, and private key.
**DO NOT COMMIT THIS FILE TO GIT. PROTECT YOUR PRIVATE KEY.**

## Run the examples

### Using Anaconda

```bash
# Execute transfer example 
conda run -m myenv python3 ./src/client/1_transactions.py

# Execute smart contract example
conda run -m myenv python3 ./src/client/2_deploy_contract.py
```

### Using Python

After the virtual environment has been activated, run:

```bash
# Execute transfer example 
python3 ./src/client/1_transactions.py

# Execute smart contract example
python3 ./src/client/2_deploy_contract.py
```



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
pip install python-dotenv
# Generate dependencies file
pip install pipreqs
pipreqs --savepath=requirements.in 
```
