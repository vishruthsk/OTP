//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "./Random.sol";
contract OneTimePass {
    Random random;
    string public oneTimePass;
    mapping(address => mapping(uint256=> bool)) PhNo;
    event success(address user, string message);
    event failed(address user,string message);


    constructor(address _random){
        random = Random(_random);
    }

    function _otp() external {
        random.OTP_gen();
        
        
    }    

    function EnterOtp(uint256 _pNO,string memory _Otp) public {
        delete oneTimePass;
        require(!PhNo[msg.sender][_pNO],"PhNo already verified");
        if(keccak256(abi.encodePacked(_Otp))==keccak256(abi.encodePacked(random.otp()))){
            PhNo[msg.sender][_pNO]= true;
            emit success(msg.sender, "Otp verification Successful");
            

        }
        else{
            emit failed(msg.sender, "Otp verification failed");

        }


    }


}