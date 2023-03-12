// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20, Ownable {
    uint internal totalCap;
    uint internal initialMint;
    address internal creator;


    mapping (address => bool) internal whiteList;

    modifier onlyAllowList(){
        require(whiteList[msg.sender] || msg.sender == creator,"not allowed");
        _;
    }


    constructor(address _creator, string memory _name, string memory _symbol, bool _setTotalCap, uint _totalCap, bool _wantInitialMint, uint _initialMint, address[] memory _whiteListAddresses) ERC20(_name, _symbol) {
        totalCap = _totalCap;
        initialMint = _initialMint;
        if(_setTotalCap == false){
            totalCap = type(uint256).max;
        }
        if(_wantInitialMint == false ){
            initialMint = 0;
        }
        for(uint i=0; i < _whiteListAddresses.length; i++){
            whiteList[_whiteListAddresses[i]] = true;
        }
        creator = _creator;
        _mint(_creator, _initialMint);
    }

    function mint(address to, uint256 amount) public onlyAllowList {
        _mint(to, amount);
    }

    function getTotalCap() public view returns(uint){
        return totalCap;
    }

    function getInitialMint() public view returns(uint){
        return initialMint;
    }

    function getCreator() public view returns(address){
        return creator;
    }
}