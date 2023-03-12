// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract LaunchPad{
    // LaunchPad contract onwer
    address private immutable launchPadOwnerOwner;

    // number of Tokens Created
    uint256 public numOfTokensCreated;

    /**
     * @dev constructor to get the owner address of this contract factory
     */
    constructor(address _launchPadOwner) {
        launchPadOwnerOwner = _launchPadOwner;
    }

    /**
     * @dev function to create the contract MultiSigWallet
     */
    function CreateToken(address _creator, string _name, string _symbol, bool _setTotalCap, uint _totalCap, bool _wantInitialMint, uint initialMint, address[] whiteListAddresses) public {
        // Create a new Wallet contract
        MultiSigWallet multiSigWallet =  new MultiSigWallet(
            _onwers,
            _required
        );
        // Increment the number of Tokens Created
        numOfTokensCreated++;

        // Add the new MultiSigWallet to the mapping
        allMultiSigWallet[msg.sender] = (
            multiFactoryStruct(
                _onwers,
                _required,
                address(this)
            )
        );

        // search the profile by using owner address
        // Solidity mappings with array type keys are not a good idea to use in practice, 
        // as the key data is stored in the contract storage and it will consume a lot of storage and gas cost.
        searchByAddress[msg.sender].push(address(multiSigWallet));
    }
}