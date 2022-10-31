pragma solidity ^0.8.4;  
 contract basicFunction {
     address public owner;
     mapping(address => uint) balance;
     

     modifier onlyOwner() {
         require(owner == msg.sender, "You are not the Owner");
         _;
     }
     receive () external payable {

     }
     fallback() external payable {

     }

     constructor() {
         owner = msg.sender;
     }

     function deposit() external payable returns(uint) {
         require(msg.value > 0, "We don't accept Zero tokens");
         return balance[msg.sender] += msg.value;
     }

     function withdraw() public returns(bool success) {
         require(msg.sender == owner, "Only the Owner can withdraw");
         balance[msg.sender] = 0;
//         payable(msg.sender).call{value: balance[msg.sender]}("");
         success; 
         
     }
     function withdrawSomeBalance (uint _sum) public returns(bool) {
         uint tokenAmount = _sum *10 * 18;
         require(msg.sender == owner, "Incorrect Address");
         require(balance[msg.sender] >= tokenAmount, "Insufficient Funds");
         balance[msg.sender] = balance[msg.sender] - tokenAmount;
        (bool sent, ) = payable(msg.sender).call{value: balance[msg.sender]}("");
        return sent;
        
     }

     function balanceOf() public view returns(uint) {
         return balance[msg.sender];
     }
 }
