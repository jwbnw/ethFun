//.sol file to hold our voting contract 

// Specify what version of the compiler we will use
pragma solidity ^0.4.19;

	
	//Define our contract
	contract Voting {
	
	/*Define a mapping field (similar to an associative array or hash)
	  our key is the candidate name stored as the bytes32 type and 
	  the value is an unsigned int (this will store the vote count)*/

	mapping (bytes32 => uint8) public votesReceived;
	
