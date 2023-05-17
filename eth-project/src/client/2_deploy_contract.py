import sys
import time
import pprint
import os

from web3 import Web3
from solcx import compile_source, install_solc

def compile_source_file(file_path):
   with open(file_path, 'r') as f:
      source = f.read()
   return compile_source(source,output_values=['abi','bin'])

def deploy_contract(w3, contract_interface, from_address):
    tx_hash = w3.eth.contract(
        abi=contract_interface['abi'],
        bytecode=contract_interface['bin']).constructor().transact({'from': from_address})

    address = w3.eth.get_transaction_receipt(tx_hash)['contractAddress']
    return address

## URL endpoint to Ethereum node
eth_url = os.environ.get("ETH_URL").replace("\"","")
# Or hardcode the value here
# Ganache:
# eth_url="http://127.0.0.1:7545"
# If you are running Python from WSL, change Ganache to broadcast on this IP
# eth_url="http://172.23.64.1:7545"
# If using Infura, specify the project_id at the end of the URL
# eth_url="http://sepolia.infura.io/v3/replace_with_project_id"


# Connection using HTTP
print("Connecting to "+ eth_url )
w3 = Web3(Web3.HTTPProvider( eth_url ))
connected = w3.is_connected()
print("Connected: "+str(connected))
if not connected:
  sys.exit(1)

# Compile contract
install_solc("0.8.2")
contract_source_path = './src/solidity/storage.sol'
compiled_sol = compile_source_file(contract_source_path)
contract_id, contract_interface = compiled_sol.popitem()

# Deploy contract
# Change this to your source wallet address
from_address = os.environ.get("FROM_ADDRESS").replace("\"","")
# Or as an example, hardcode its value here (don't commit in this case)
# from_address = '0x000000000000000000000000000000000000000000'
# You could also infer from address from its private key, see 1_transactions.py
contract_address = deploy_contract(w3, contract_interface, from_address)
print(f'Deployed {contract_id} to: {contract_address}\n')
store_var_contract = w3.eth.contract(address=contract_address, abi=contract_interface["abi"])

# Execute contract method for store
gas_estimate = store_var_contract.functions.store(255).estimate_gas()
print(f'Gas estimate to transact with "store": {gas_estimate}')
if gas_estimate < 100000:
     print("Sending transaction to store(255)\n")
     tx_hash = store_var_contract.functions.store(255).transact({'from': from_address})
     receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
     print("Transaction receipt mined:")
     pprint.pprint(dict(receipt))
     print("\nWas transaction successful?")
     pprint.pprint(receipt["status"])
else:
     print("Gas cost exceeds 100000")

# Execute contract method for retrieve
gas_estimate = store_var_contract.functions.retrieve().estimate_gas()
print(f'Gas estimate to transact with "retrieve": {gas_estimate}')
if gas_estimate < 100000:
     print("Sending transaction to retrieve()\n")
     return_value = store_var_contract.functions.retrieve().call({'from': from_address})
     print("Return value: " + str(return_value))
else:
     print("Gas cost exceeds 100000")