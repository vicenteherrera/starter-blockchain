import os
from eth_account import Account
from eth_account.signers.local import LocalAccount
from web3 import Web3
from web3.middleware import construct_sign_and_send_raw_middleware

# Connection using HTTP
ip = "127.0.0.1"
# Set Ganache to expose through WLS2 interface IP like 172.23.64.1 and use that IP address
ip = "172.23.64.1"
# Ganache uses port 7545, other networks uses 8545
port = "7545"


print("Connecting to "+ ip + " at port "+port)
w3 = Web3(Web3.HTTPProvider("http://" + ip + ":"+port))
connected = w3.is_connected()
print("Connected: "+str(connected))
if not connected:
  exit

last_block=w3.eth.get_block('latest')
print("timestamp of last block: " + str(last_block.timestamp))

# Private key for address, we expect it to come from an environment variable
# Make sure to set it from Ganache in .envrc
private_key = os.environ.get("PRIVATE_KEY")
assert private_key is not None, "You must set PRIVATE_KEY environment variable"
assert private_key.startswith("0x"), "Private key must start with 0x hex prefix"
account: LocalAccount = Account.from_key(private_key)
w3.middleware_onion.add(construct_sign_and_send_raw_middleware(account))

# Address for operations, change with one from Ganache
# address="0xe061f951eA9cBc6DE36fAea49DF6D04922BeFE83"
address=account.address

# Second address for sending funds example
address2="0x4D28F5eC48B6a6D27722185498960518790B3430"


print("Balance (" + address + "): " + str(w3.eth.get_balance(address) ))
print("Balance (" + address2 + "): " + str(w3.eth.get_balance(address2) ))

amount = w3.to_wei(1, 'ether')

# Example transaction, automatic gas calculation
# print("Sending transaction")
# w3.eth.send_transaction({
#   'to': address2,
#   'from': address,
#   'value': amount
# })

# Example transaction, specified max fee and priority fee per gas
w3.eth.send_transaction({
  'to': address2,
  'from': address,
  'value': amount,
  'gas': 21000,
  'maxFeePerGas': w3.to_wei(250, 'gwei'),
  'maxPriorityFeePerGas': w3.to_wei(2, 'gwei')
})


# # Send the transaction
# transaction_hash = w3.eth.sendRawTransaction(signed_transaction.rawTransaction)

# # Wait for the transaction to be mined
# transaction_receipt = w3.eth.waitForTransactionReceipt(transaction_hash)



# Show final balances
print("Balance (" + address + "): " + str(w3.eth.get_balance(address) ))
print("Balance (" + address2 + "): " + str(w3.eth.get_balance(address2) ))
