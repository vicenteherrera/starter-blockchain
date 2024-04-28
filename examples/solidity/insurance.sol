// SPDX-License-Identifier: GPL-3.0

// Open in Remix IDE online with: https://remix.ethereum.org/vicenteherrera/starter-blockchain/blob/main/examples/solidity/insurance.sol

pragma solidity >=0.8.2 <0.9.0;

contract Insurance {

    uint256 public payoutAmount;
    uint256 public premiumAmount;
    bool public isClaimed;

    function claimInsurance() public {
        require(!isClaimed);
        isClaimed = true;
        payable(msg.sender).transfer(payoutAmount);
    }

    //-- Created new code here -----------------------------

}
