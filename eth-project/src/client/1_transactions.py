import os
from dotenv import load_dotenv
from eth_account import Account
from eth_account.signers.local import LocalAccount
from web3 import Web3
from web3.middleware import construct_sign_and_send_raw_middleware
import sys

# Load configuration
load_dotenv("env.txt")  # take environment variables from env.txt

# URL endpoint to Ethereum node
eth_url = os.environ.get("ETH_URL").replace("\"","")

# Connection using HTTP
print("Connecting to "+ eth_url )
w3 = Web3(Web3.HTTPProvider( eth_url ))
connected = w3.is_connected()
print("Connected: "+str(connected))
if not connected:
  sys.exit(1)

# Test connection showing information for latest block in the blockchain
last_block=w3.eth.get_block('latest')
print("timestamp of last block: " + str(last_block.timestamp))

## PRIVATE KEY for SOURCE ADDRESS
private_key = os.environ.get("PRIVATE_KEY").replace("\"","")
assert private_key is not None, "You must set private_key variable"
assert private_key.startswith("0x"), "Private key must start with 0x hex prefix"
account: LocalAccount = Account.from_key(private_key)
w3.middleware_onion.add(construct_sign_and_send_raw_middleware(account))
# Address for operations, we automatically get it from the PRIVATE_KEY address
address=account.address
print("Source wallet: " + address)

# DESTINATION ADDRESS
# Destination for transaction operations
address2 = os.environ.get("TO_ADDRESS").replace("\"","")
print("Source wallet: " + address2)

## EXAMPLE START

print("Initial balance of wallets")
print("Balance (" + address + "): " + str(w3.eth.get_balance(address) ))
print("Balance (" + address2 + "): " + str(w3.eth.get_balance(address2) ))

amount = w3.to_wei(0.0001, 'ether')

## EXECUTE TRANSITION

# Example transaction, specified max fee and priority fee per gas
transaction_hash = w3.eth.send_transaction({
  'to': address2,
  'from': address,
  'value': amount,
  'gas': 21000,
  'maxFeePerGas': w3.to_wei(250, 'gwei'),
  'maxPriorityFeePerGas': w3.to_wei(2, 'gwei')
})

# # Wait for the transaction to be mined
print("Waiting for the transaction")
transaction_receipt = w3.eth.wait_for_transaction_receipt(transaction_hash)

## ALTERNATIVE: 
## Transaction with automatic gas calculation
## and no waiting for mining
# print("Sending transaction")
# w3.eth.send_transaction({
#   'to': address2,
#   'from': address,
#   'value': amount
# })

## CHECK FINAL STATE

print("Showing final balances")
print("Balance (" + address + "): " + str(w3.eth.get_balance(address) ))
print("Balance (" + address2 + "): " + str(w3.eth.get_balance(address2) ))
