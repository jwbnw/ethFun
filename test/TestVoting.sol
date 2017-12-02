pragma solidity ^0.4.18;


import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Voting.sol";

contract TestVoting {
	 
	//Test our candidate names
	function testCandidateNames() public{

		//Build a dynamic Array to pass to contract when initialized
		bytes32[] testListNames;
	

		bytes32 Bob = stringToBytes32("Bob");
		bytes32 Alice = stringToBytes32("Alice");

		//use push function since array is dynamic
		testListNames.push(Bob);
		testListNames.push(Alice);

		Voting vote = new Voting(testListNames);
				
		bytes32 expected1 = stringToBytes32("Bob");
		bytes32 expected2 = stringToBytes32("Alice");

		bytes32 result1 = vote.candidateList(0);
		bytes32 result2 = vote.candidateList(1);

		//truffle testing framework 	
		Assert.equal(result1,expected1,"Candidate 1 is not as expected");
		Assert.equal(result2,expected2,"Candidate 2 is not as expected");
	}
	
	//test the Initial Candidates
	function testCandidateNum() public{

		//since our contract is already initialized we will pass it no additional values
		bytes32[] testListNames;
		Voting vote = new Voting(testListNames);

		uint result = vote.allCandidates(); //try passing this to the assert
		uint expected = 2;

		Assert.equal(result,expected, "Number of candidates is not valid");

	}
	function testVote() public{

		bytes32[] testListNames;
		Voting vote = new Voting(testListNames);

		bytes32 testBobVote = stringToBytes32("Bob");
		uint8 testBobVotePre = vote.totalVotesFor(testBobVote);
		vote.voteForCandidate(testBobVote);
		
		uint8 testBobVotePost = vote.totalVotesFor(testBobVote);
		
		//Assert lib does not like uint8 being a 1; hence the conversion
		int testBobVotePre1= int(testBobVotePre);
		int testBobVotePost1 =int(testBobVotePost);
		

		Assert.notEqual(testBobVotePost1,testBobVotePre1,"Vote Failed");
	}
	
	//test our storage for the sender to the contract
	function testMessageSenderStorage() public{

		//bytes32[] testListNames;
		//Voting vote = new Voting(testListNames);

		//var testS = vote.senderInfo;
	}


	//Helper Functions
	function stringToBytes32(string memory source) public returns (bytes32 result)  {

		bytes memory tempEmptyStringTest = bytes(source);
		
		if (tempEmptyStringTest.length == 0) {
			return 0x0;
		}

		assembly {
			result := mload(add(source,32))
		}
	}

	struct testStruct {
		bool voted;
		uint vote;
		}

}