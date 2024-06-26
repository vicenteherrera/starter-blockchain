import sys
import time
import pprint
import os
from dotenv import load_dotenv
from web3.middleware import construct_sign_and_send_raw_middleware
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
     return tx_hash


# Load configuration
load_dotenv("env.txt")  # take environment variables from env.txt

## Configure variables
eth_url = os.environ.get("ETH_URL").replace("\"","")
private_key = os.environ.get("PRIVATE_KEY").replace("\"","")
from_address = os.environ.get("FROM_ADDRESS").replace("\"","")

# Connection using HTTP
print("Connecting to "+ eth_url )
w3 = Web3(Web3.HTTPProvider( eth_url ))
connected = w3.is_connected()
print("Connected: "+str(connected))
if not connected:
  print("Can't connect")
  sys.exit(1)

# Configure middleware to sign transactions
# from_address = w3.eth.account.privateKeyToAccount(private_key)
w3.middleware_onion.add(construct_sign_and_send_raw_middleware(private_key))

# Compile contract
contract_source_path = './src/solidity/storage.sol'
print("Compiling smart contract " + contract_source_path)
install_solc(version="latest") #"0.8.2")
contract = compile_source_file(contract_source_path)
contract_id, contract_interface = contract.popitem()

# Deploy contract
print("Deploying smart contract from: " + from_address)
tx_hash = deploy_contract(w3, contract_interface, from_address)
w3.eth.wait_for_transaction_receipt(tx_hash)
print("Waiting for contract to be in a block")
contract_address = w3.eth.get_transaction_receipt(tx_hash)['contractAddress']
print(f'Deployed to: {contract_address}\n')

# Execute contract method function "store"
store_var_contract = w3.eth.contract(address=contract_address, abi=contract_interface["abi"])
gas_estimate = store_var_contract.functions.store(255).estimate_gas()
print(f'Gas estimate to transact with "store()": {gas_estimate}')
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

# Execute contract method function "retrieve"
gas_estimate = store_var_contract.functions.retrieve().estimate_gas()
print(f'Gas estimate to transact with "retrieve()": {gas_estimate}')
if gas_estimate < 100000:
     print("Sending transaction to retrieve()\n")
     return_value = store_var_contract.functions.retrieve().call({'from': from_address})
     print("Return value: " + str(return_value))
else:
     print("Gas cost exceeds 100000")