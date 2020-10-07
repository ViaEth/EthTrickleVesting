pragma solidity >=0.4.22 <0.7.0;
 /**
 * @title EthTrickleVesting
 * @dev An eth holding contract that releases its eth balance gradually,
 * similar to a vesting scheme. Optionally revocable by the owner.
 */

contract EthTrickleVesting {
	/**
	* @dev Set owner
	* @param owner the address that can claim the eth.
	*/
	address payable private owner;
	
	// event for EVM logging
	event OwnerSet(address indexed oldOwner, address indexed newOwner);
    
	/**
	* @dev Change owner
	* @param newOwner address of new owner
	*/
	function changeOwner(address payable newOwner) public isOwner {
		emit OwnerSet(owner, newOwner);
        	owner = newOwner;
	}
    	
	/**
	* @dev Return owner address 
	* @return address of owner
	*/
	function getOwner() external view returns (address) {
		return owner;
	}
    
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

	//duration
	//Every duration the contract releases a trickle percentage of the vested eth amount. In days.
	uint256 duration = 30;

	//lastClaim
	//A block time from the last time Ether was claimed.
 	//If no ether has been claimed then this is the block time this conctract was deployed

	//tricklePercentage
	//The percentage to release or reinvest
	uint256 tricklePercentage = 10;

	//releasedAmount
	//The amount of eth that can be releasedAmount
	uint256 releasedAmount = 0;

	//lockedAmount
	//The amount of locked eth
	uint256 lockedAmount = 0;

	//totalAmount (LockedAmount+releasedAmount)
	//The total amount of eth in this contract
 	uint256 totalAmount = lockedAmount + releasedAmount;
    
	/**
	* @dev Set contract deployer as owner
	*/
	constructor() public {
		owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
		//Updates lastClaimed.
		emit OwnerSet(address(0), owner);
	}

	//displayReleased
	//Outputs the amount of eth avaliable for release.
	function displayReleased() external view returns (uint256) {
		//Caluclate releasedAmount
		return releasedAmount;
	}
	
	//displayLocked
	//Outputs the amount of eth locked in the contract.
	function displayLocked() external view returns (uint256) {
		//Caluclate lockedAmount
		return lockedAmount;
	}

	//displayTotal
	//Outputs the total (Released+Locked) amount of eth in the contract.
	function displayTotal() external view returns (uint256) {
		return address(this).balance;
	}
	
	//claim function
	//this function is used to claim all of the released eth which moves it from the contract to the owners address.
	function claim() public isOwner {
        	//require(now >= unlockDate);
        	//Updated locked and released.
		//Updated lastclaimed.
        	msg.sender.transfer(address(this).balance);
    	}
    
	//lock function
	//this fucntion is payable and locks the eth until its released.
	//double check external vs internal.
	function lock() external payable {
        	lockedAmount = lockedAmount + msg.value;
        	//Update Amounts
    	}
	
	//release function
	//After a specific duration a percentage of the eth vesting pool is move to the released amount
	//If less then 1/100th of 1 eth then its all released, time based.
	function release() internal {
		//Uses tricklePercentage
		//increases releasedAmount
		//decreases lockedAmount
	}

	//reinvest function
	//After a specific duration a percentage of the released amount is moved back to the eth vesting pool, time based.
	function reinvest() internal {
		//Uses tricklePercentage
		//increases lockedAmount
		//decreased releasedAmount
	}
}
