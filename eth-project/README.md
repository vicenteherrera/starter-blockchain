# Ethereum Project

## How this project was created

```console
# from root repo folder
pyenv install 3.9
# it takes a long time to finish
pyenv local 3.9
poetry new --name client --src eth-project
cd eth-project
poetry add web3
poetry add py-solc-x
```

## How to run this project

### Install prerequisites
* Python 3
* [pyenv](https://github.com/pyenv/pyenv)
* [poetry](https://python-poetry.org/docs/)

### Setup
* [Configure pyenv](https://github.com/pyenv/pyenv#installation)
* Install specific Python 3.9 version:  
  `pyenv install 3.9`  
  `pyenv local 3.9`  
* Copy `sample.envrc` to `.envrc`, and edit it with a Ganache private key. 
  * You can use [direnv]() with `direnv allow` to automatically load the variable into memory.
  * Or you can load it manually with `source .direnv` on _Linux/Macos Bash_.
  * Or you can manually set up the variable:  
  On windows with `set PRIVATE_KEY=0x1234...`, [more info](https://www3.ntu.edu.sg/home/ehchua/programming/howto/Environment_Variables.html)

[More info on how to setup a Python project here](https://github.com/vicenteherrera/starter-python)

### Run
```bash
# Execute transfer example 
poetry run python3 ./src/client/example1.py
# Execute smart contract example
poetry run python3 ./src/client/deploy_contract.py
```