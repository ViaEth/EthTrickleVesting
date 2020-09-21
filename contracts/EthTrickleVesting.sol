/**
 * @title EthTrickleVesting
 * @dev An eth holding contract that releases its eth balance gradually,
 * similar to a vesting scheme. Optionally revocable by the owner.
 */

contract EthTrickleVesting {
	/**
	* @dev Set owner
	* @param owner the address that can claim the eth and revoke the contract
	*/
	address private owner;

	//duration
	//Every duration the contract releases a trickle percentage of the vested eth amount. In days.
	unit256 duration = 30;

	//tricklePercentage
	//The percentage to release or reinvest
	uint256 tricklePercentage = 10;


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

	//displayReleased
	//Outputs the amount of eth avaliable for release.
	function displayReleased() external view returns () {
	}
	
	//displayLocked
	//Outputs the amount of eth locked in the contract.
	function displayLocked() external view returns () {
	}

	//displayTotal
	//Outputs the total (Released+Locked) amount of eth in the contract.
	function displayTotal() external view returns () {
	}	
	
	//claim function
	//this function is used to claim all of the released eth.
	function claim() {
	}
	
	//release function
	//After a specific duration a percentage of the eth vesting pool is move to the released amount
	//If less then 1/100th of 1 eth then its all released.
	function release() {
	}

	//reinvest function
	//After a specific duration a percentage of the released amount is moved back to the eth vesting pool.
	function reinvest() {
	}
}
