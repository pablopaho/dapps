pragma solidity ^0.4.17;

contract Campaign {

    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
    }

    address public manager;
    uint public minimunContribution;
    address[] public approvers;
    Request[] public request; 
    
    modifier restricted(){
        require(msg.sender == manager);
        _;
    }
    
    function Campaign(uint minimum) public {
        manager = msg.sender;
        minimunContribution = minimum;
    }
    
    function contribute() public payable {
        require(msg.value > minimunContribution);
        approvers.push(msg.sender);
        request.push(msg.sender);
    }
    
    function createRequest(string description, uint value, address recipient) 
        public restricted {
        Request newRequest = Request({
           description: description,
           value: value,
           recipient: recipient,
           complete: false
        });
        
        request.push(newRequest);
    }
    
}
