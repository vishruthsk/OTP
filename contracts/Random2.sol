
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;


import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Random is VRFConsumerBase {
    uint256 public fee; 
    string public otp;    
    bytes32 public keyHash;
    event otpsent(address user, string otp,bytes32 requestId);
    
   
    constructor() VRFConsumerBase(0x8C7382F9D8f56b33781fE506E897a4F1e2d17255, 0x326C977E6efc84E512bB9C30f76E30c160eD06FB) public {
       keyHash = 0x6e75b569a01ef56d18cab6a8e71e6600d6ce853834d4a5748b720d06f878b3a4;
       fee = 0.001*10**18;   
    }

    function getotp() private returns (bytes32 requestId) {
        
        return requestRandomness(keyHash, fee);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal virtual override {
        
        string memory OTP;
        OTP = Strings.toString(randomness);     
        bytes memory a = new bytes(4);
        for(uint i=0;i<=3;i++){
            a[i] = bytes(OTP)[i];
        }        
        otp=string(a);    
        emit otpsent(msg.sender, otp,requestId);        
    }
    

    function OTP_gen() public returns(string memory){
        delete otp;
        getotp();
        
        return otp;
    }


}