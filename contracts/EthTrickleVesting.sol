/**
 * @title EthTrickleVesting
 * @dev An eth holder contract that can release its eth balance gradually
 * similar to a vesting scheme. Optionally revocable by the owner.
 */
 
//duration
//Every duration the contract releases a trickle percentage of the vested eth amount.

//trickle percentage
//The percentage used to calculate release and reinvest amounts.

//claim function
//this function is used to claim all of the released eth.

//release function
//After a specific duration a percentage of the eth vesting pool is move to the released amount

//reinvest function
//After a specific duration a percentage of the released amount is moved back to the eth vesting pool.

//displayReleased function
//outputs the available released eth available using the claim function.

//displayTotal function
//outputs the total amount of eth vested in the contract.

contract EthTrickleVesting {
    /**
     * @dev Set owner
     * @param owner the address that can claim the eth and revoke the contract
     */
    address private owner;
    
    // modifier to check if caller is owner
    modifier isOwner() {
        // If the first argument of 'require' evaluates to 'false', execution terminates and all
        // changes to the state and to Ether balances are reverted.
        // This used to consume all gas in old EVM versions, but not anymore.
        // It is often a good idea to use 'require' to check if functions are called correctly.
        // As a second argument, you can also provide an explanation about what went wrong.
        require(msg.sender == owner, "Caller is not owner");
        _;
    }
    
    /**
     * @dev Set contract deployer as owner
     */
    constructor() public {
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit OwnerSet(address(0), owner);
    }
    
    /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getOwner() external view returns (address) {
        return owner;
    }
    
}
