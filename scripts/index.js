web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
abi = JSON.parse('[{"constant":true,"inputs":[{"name":"candidate","type":"bytes32"}],"name":"totalVotesFor","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"candidate","type":"bytes32"}],"name":"validCandidate","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"bytes32"}],"name":"votesReceived","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"allCandidates","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"candidateList","outputs":[{"name":"","type":"bytes32"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"candidate","type":"bytes32"}],"name":"voteForCandidate","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"candidateNames","type":"bytes32[]"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]');

//Create contract object for interatction
VotingContract = web3.eth.contract(abi);

//assign the contract address, we find this via querying the contract in truffle console specifying for the address (see below)
//Voting.deployed().then(function(contractInstance) { console.log(contractInstance.address);});
//We could also make this dynamic by looking in the build folder
//Note: http://web3js.readthedocs.io/en/1.0/web3-eth-contract.html
contractInstance = VotingContract.at('0xf06450fb4f5c8e066a9395790f6f5411bae1556b');

//Note we are going to hard code this in but we can probably make it dynamic.
candidates = {"Bob": "candidate-1", "Alice": "candidate-2"};

//Here we will write a function to vote for a candidate
function voteForCandidate() {
  candidateName = $("#candidate").val();
  
 //Vote for the candidate and also return the new vote count as feedback
  contractInstance.voteForCandidate(candidateName, {from: web3.eth.accounts[0]}, function() {
    let div_id = candidates[candidateName];
    $("#" + div_id).html(contractInstance.totalVotesFor.call(candidateName).toString());
  });
}

$(document).ready(function(){
	candidateNames = Object.keys(candidates);
	for (var i = 0; i < candidateNames.length; i++) {
		let name = candidateNames[i];
		let val = contractInstance.totalVotesFor.call(name).toString()
		$("#" + candidates[name]).html(val);
	}
});
