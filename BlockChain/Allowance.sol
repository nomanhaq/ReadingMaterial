//SPDX-License-Identifier: MIT
pragma solidity 0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol"; 

contract Allowance is Ownable {
    uint  public Cbalance ; 
    event AllownceChanges(address indexed _forWho, address indexed _byWho, uint  _oldAmount, uint  _newAmount); 
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender; // the owner() function from the Ownable.sol contract 
    }
    mapping (address => uint) public allowance; // Here we are going to add a mapping so we can store addresses and its unit amounts 
    
    function addAllowance(address _who, uint _amount) public onlyOwner{
        emit AllownceChanges(_who,msg.sender,allowance[_who],_amount); 
        allowance[_who] = _amount; 
    }
    
    modifier ownerOrAllowed(uint _amount){
        require(isOwner() || allowance[msg.sender] >= _amount,"You are not owner allowed or Allownce limit is exceeded");
        _;
    }
    
    function sendMoney() payable public {
        require(msg.sender == owner(),'Only owner can transfer the funds');
        Cbalance =  address(this).balance; 
    }
    
    function reduceAllowance(address _who, uint _amount) internal ownerOrAllowed(_amount) {
        emit AllownceChanges(_who,msg.sender,allowance[_who],_amount); 
        allowance[_who] -= _amount; 
    }
    
}

