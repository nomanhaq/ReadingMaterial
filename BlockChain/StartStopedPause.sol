pragma solidity ^0.8.0;

contract StartStopPause {
    
    address public owner; 
    bool public paused; 
    
    constructor() {
        owner = msg.sender; 
    }
    
    function sendMoney() public payable {
        require (paused == false, "contract is paused!");
    }
    
    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You cannot paused as you are not an owner!"); 
        
        paused = _paused; 
    }
    
    function withdrawAllMoney(address payable _to) public {
        require (owner == msg.sender,"You cannot withraw as you are not owner");
        require (paused == false, "contract is paused!"); 
        _to.transfer(address(this).balance); 
    }
    
    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner of contract"); 
        selfdestruct(_to);
    }
}

