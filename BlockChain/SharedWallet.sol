//SPDX-License-Identifier: MIT
pragma solidity 0.8.1;

import "./Allowance.sol"; 

contract sharedWallet is Allowance {
    event MoneySent(address indexed _benfeciary, uint _amount);
    event MoneyReceived(address indexed _benfeciary, uint _amount); 
    
    function renounceOwnership() public view override onlyOwner {
        revert("can't renounceOwnership here"); //not possible with this smart contract
    }
    
    function withdraMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance,"Contract does not own enough money! "); 
        if (!isOwner()) {
            reduceAllowance(_to,_amount);         
        }
        emit MoneySent(_to,_amount); 
        _to.transfer(_amount); 
        }
    
    receive() external payable { 
        emit MoneyReceived(msg.sender,msg.value); 
    }
}
