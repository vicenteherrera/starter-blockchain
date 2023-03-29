// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.2 <0.9.0;

interface IERC20 {
    function transferFrom(
        address _from,
        address _to,
        uint _value
    )
        external
        returns (bool success);
}

contract Tokens {
    function deposit(address _tokenAddress, uint _amount) public {
        IERC20(_tokenAddress).transferFrom(msg.sender, address(this), _amount);
    }
}