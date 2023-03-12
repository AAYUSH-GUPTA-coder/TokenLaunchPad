// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./Token.sol";

contract LaunchPad{

    // LaunchPad contract onwer
    address private immutable launchPadOwnerOwner;

    // number of Tokens Created
    uint256 public numOfTokensCreated;

    // struct to store all the data of Token and LaunchPad contract
    struct LaunchStruct {
        address launchPadAddress;
        address creator;
        string name;
        string symbol;
        bool setTotalCap;
        uint totalCap;
        bool wantInitialMint;
        uint initialMint;
        address[] whiteListAddresses;
    }

    // searching the struct data of Token and LaunchPad using creator address
    mapping(address => LaunchStruct) public allData;

    // creator address to check the addresses of token created
    mapping(address => address[]) public tokenAddresses;

    /**
     * @dev constructor to get the owner address of this contract factory
     */
    constructor(address _launchPadOwner) {
        launchPadOwnerOwner = _launchPadOwner;
    }

    /**
     * @dev function to create the contract MultiSigWallet
     */
    function CreateToken(address _creator, string _name, string _symbol, bool _setTotalCap, uint _totalCap, bool _wantInitialMint, uint _initialMint, address[] _whiteListAddresses) public {
        // Create a new Wallet contract
        Token token =  new Token(
            _creator,
            _name,
            _symbol,
            _setTotalCap,
            _totalCap,
            _wantInitialMint,
            _initialMint,
            _whiteListAddresses
        );
        // Increment the number of Tokens Created
        numOfTokensCreated++;

        // Add token to the mapping
        allData[_creator] = (
            LaunchStruct(
                address(this),
                _creator,
            _name,
            _symbol,
            _setTotalCap,
            _totalCap,
            _wantInitialMint,
            _initialMint,
            _whiteListAddresses
            )
        );

        // search the profile by using creator address
        // Solidity mappings with array type keys are not a good idea to use in practice, 
        // as the key data is stored in the contract storage and it will consume a lot of storage and gas cost.
        tokenAddresses[_creator].push(address(token));
    }
}