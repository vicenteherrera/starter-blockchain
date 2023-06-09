import os
from eth_account import Account
from eth_account.signers.local import LocalAccount
from web3 import Web3
from web3.middleware import construct_sign_and_send_raw_middleware
import sys

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

# Test connection showing information for latest block in the blockchain
last_block=w3.eth.get_block('latest')
print("timestamp of last block: " + str(last_block.timestamp))

## PRIVATE KEY for SOURCE ADDRESS
private_key = os.environ.get("PRIVATE_KEY").replace("\"","")
# Or as an example, hardcode its value here (don't commit in this case)
# private_key = '0x0000000000000000000000000000000000000000000000000000000000000000'
assert private_key is not None, "You must set private_key variable"
assert private_key.startswith("0x"), "Private key must start with 0x hex prefix"
account: LocalAccount = Account.from_key(private_key)
w3.middleware_onion.add(construct_sign_and_send_raw_middleware(account))
# Address for operations, we automatically get it from the PRIVATE_KEY address
address=account.address

# DESTINATION ADDRESS
# Destination for transaction operations
address2 = os.environ.get("TO_ADDRESS").replace("\"","")
# Or hardcode it here
# address2="0x000000000000000000000000000000000000000000"


## EXAMPLE START

print("Initial balance of wallets")
print("Balance (" + address + "): " + str(w3.eth.get_balance(address) ))
print("Balance (" + address2 + "): " + str(w3.eth.get_balance(address2) ))

amount = w3.to_wei(0.01, 'ether')

# Example transaction, automatic gas calculation
# print("Sending transaction")
# w3.eth.send_transaction({
#   'to': address2,
#   'from': address,
#   'value': amount
# })

## EXECUTE TRANSITION

# Example transaction, specified max fee and priority fee per gas
w3.eth.send_transaction({
  'to': address2,
  'from': address,
  'value': amount,
  'gas': 21000,
  'maxFeePerGas': w3.to_wei(250, 'gwei'),
  'maxPriorityFeePerGas': w3.to_wei(2, 'gwei')
})

## ALTERNATIVE WAY TO EXECUTE THE TRANSITION

# # Send the transaction
# transaction_hash = w3.eth.sendRawTransaction(signed_transaction.rawTransaction)

# # Wait for the transaction to be mined
# transaction_receipt = w3.eth.waitForTransactionReceipt(transaction_hash)

## FINAL STATE

print("Showing final balances")
print("Balance (" + address + "): " + str(w3.eth.get_balance(address) ))
print("Balance (" + address2 + "): " + str(w3.eth.get_balance(address2) ))
