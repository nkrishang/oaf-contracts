// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "./IERC20.sol";

contract Token is IERC20 {
    /*
    Must have:
            1. Token Name 
            2. Token Symbol
            3. Decimals
            4. Totalsupply()
            5. Balanceof
            6. transfer
            7. transferfrom
            8. approve
            9. allowance
    */
    
    string public name;
    string public symbol;
    uint public Decimals;
    uint public _totalSupply;
    mapping(address => uint) balance;


    constructor(){
        name = "Qaders Token";
        symbol = "QT";
        Decimals = 8;
        _totalSupply = 1000000;
        balance[msg.sender] = _totalSupply;

    }
    function totalSupply() external view returns(uint){
        return _totalSupply;
    }
    function balanceOf(address account) external view returns (uint256){
        return balance[account];
    }

    function transfer (address to, uint amount) external returns (bool){
        require(balance[msg.sender] >= amount , 'insufficent amount');
        balance[msg.sender] -= amount;
        balance[to] +=amount;
        return true;
    }
    // Did not understand this
     function allowance(address owner, address spender) external view returns (uint256){
        // owner has allowed spender to spend a certain amount of his own balance. 
        return 121;
     }
     
    // Did not understand this
     function approve(address spender, uint256 amount) external returns (bool){
        emit Approval(msg.sender, spender, amount);
        return true;
     }
     function transferFrom(address from, address to, uint256 amount) external returns (bool){
        require(balance[from] >= amount , 'insufficent amount');
        balance[from] -= amount;
        balance[to] +=amount;
        return true;
     }
}
