//.sol file to hold our voting contract 

// Specify what version of the compiler we will use
pragma solidity ^0.4.18;

	
	//Define our contract
	contract Voting {
	
	//Here we will define a struct to save the voter info

	struct senderInfo {
		bool voted;
		uint32 voteCount;
		}
	
	/*Define a mapping field (similar to an associative array or hash)
	  our key is the candidate name stored as the bytes32 type and 
	  the value is an unsigned int (this will store the vote count)*/
	mapping (bytes32 => uint8) public votesReceived;

	//will also need mapping with address and voter struct
	mapping(address => senderInfo) public voters;
	//Define an arry of the bytes32 type to store our list of candidates

	bytes32[] public candidateList;

	//Define a counter for the votes
	uint32 public voteCount = 0;

	/*Define the constructor, this is called when we deploy the contract
	  to the blockchain. We are passing our constructor an
	  array of the candidate names */
	function Voting(bytes32[] candidateNames) public {
		candidateList = candidateNames;
	}

	//Define a function to return the total votes a candidate has received so far
	function totalVotesFor(bytes32 candidate) view public returns (uint8) {
		
		//check to see if our candidate is valid
		require(validCandidate(candidate));
		return votesReceived[candidate];
	}

	//Define a function to vote for a candidate 
	function voteForCandidate(bytes32 candidate) public {

		require(validCandidate(candidate));

		senderInfo sender = voters[msg.sender];
		require(!sender.voted);
		votesReceived[candidate] += 1;
		sender.voted = true;
		sender.voteCount = voteCount;
		voteCount++;
	}
	
	//Define a function to check if the candidate is valid
	function validCandidate(bytes32 candidate) view public returns (bool) {

		for(uint i = 0; i < candidateList.length; i++)
			{
				if (candidateList[i] == candidate) 
				{
					return true;
				}
			}
		return false;
	}		

	
	function allCandidates() view public returns (uint){


		return candidateList.length;
	
	}
}
