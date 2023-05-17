@echo off

REM Do not commit this file to the git repository!
echo "Setting up environment variables"

set PRIVATE_KEY="0x0000000000000000000000000000000000000000000000000000000000000000"
set FROM_ADDRESS="0x000000000000000000000000000000000000000000"
set TO_ADDRESS="0x000000000000000000000000000000000000000000"

REM Ganache uses port 7545, other networks uses 8545
set ETH_URL="http://127.0.0.1:7545"

REM If you are running Python from WSL, change Ganache to broadcast on this IP
REM set ETH_URL="http://172.23.64.1:7545"

REM If using Infura, specify the project_id at the end of the URL
set set ETH_URL="http://sepolia.infura.io/v3/replace_with_project_id"
