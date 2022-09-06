//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;


import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Random is VRFConsumerBase {
    uint256 public fee; 
    string public otp; 
    bytes32 public keyHash;    
    uint8[] public numbers =[1,2,3,4,5,6,7,8,9,0];
    string[] public OTP ;
    event otpsent(address user, string otp,bytes32 requestId);
    uint256 constant efee= 0.001 ether;
   
    constructor(address vrfCoordinator, address linkToken,bytes32 vrfKeyHash, uint256 vrfFee) VRFConsumerBase(vrfCoordinator, linkToken) {
       keyHash = vrfKeyHash;
       fee = vrfFee ;      
    }

   function getotp() private returns (bytes32 requestId) {       
        return requestRandomness(keyHash, fee);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal virtual override {        
        otp = string(abi.encodePacked(otp,Strings.toString(numbers[randomness % numbers.length])));
        emit otpsent(msg.sender, otp,requestId);        
    }

    function OTP_gen() public returns(string memory){
        delete otp;
        for(uint256 i=1;i<=4;i++){
            getotp();
        }
        return otp;
    }

    


}



