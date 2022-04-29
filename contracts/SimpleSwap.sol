// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "./tokenwithzeppelin.sol";

contract SimpleEthSwap{
    ERC20 private token;
    string public tokenName;
    uint256 public rate;

    event TokenExchanged(address account, uint256 amount, uint256 rate);

    constructor(ERC20 _token, uint256 _rate){
        token = _token;
        tokenName = _token.name();
        rate = _rate;

    }



    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    // Function to receive Ether. msg.data must be empty
    receive() external payable {

    }

    function getEthBalance() external view returns(uint256){
        return address(this).balance;
    }

    function getTokenBalance() external view returns(uint256){
        return token.balanceOf(address(this));
    }

    function getTokenBalanceOfSender() external view returns(uint256){
        return token.balanceOf(msg.sender);
    }

    function buyToken() external payable{
        //Calculate the Rate
        uint256 tokenAmount = msg.value * rate;
        //Check if the Token is available
        require(token.balanceOf(address(this)) >= tokenAmount, "Insufficient Supply");
        //Transfer the Token
        token.transfer(msg.sender, tokenAmount);

        emit TokenExchanged(msg.sender, tokenAmount, rate);
    }


     function sellTokens(uint _amount) external {
        //Check if the Token is available
        require(token.balanceOf(msg.sender) >= _amount, "Insufficient Supply");
        //Calculate the Rate
        uint256 etherAmount = _amount  / rate;   
        //Check for Allowance    
        uint256 allowance = token.allowance(msg.sender, address(this));
        
        require(allowance >= _amount, "Check the token allowance");
        //Transfer the Token
        token.transferFrom(msg.sender, address(this), _amount);
        //Send ETH to the Caller
        payable(msg.sender).transfer(etherAmount);

        emit TokenExchanged(msg.sender,  _amount, rate);
    }
}