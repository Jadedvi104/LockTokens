// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

//    ########    #####     ##     #####
//    ##         ##    ##   ##   ##     ##
//    ##        ##          ##  ##       ##
//    ########  ##          ##  ##  ^_^  ##
//    ##        ##          ##  ##       ##
//    ##         ##    ##   ##   ##     ##
//    ########    #####     ##     #####

/// @author ECIO Engineering Team
/// @title Claimtoken Smart Contract

contract ECIOTeamToken is Ownable, ReentrancyGuard {

    address public ECIO_TOKEN;

    uint8 public constant PERIOD_1ST  = 1;
    uint8 public constant PERIOD_2ND  = 2;

    mapping(uint8 => uint256) amountPerPeriod;
    mapping(uint8 => uint256) periodReleaseTime;

    constructor(
        address _ecioTokenAddr

    ) {
        ECIO_TOKEN = _ecioTokenAddr;

        periodReleaseTime[PERIOD_1ST] = 1640034000;
        periodReleaseTime[PERIOD_2ND] = 1671570000;

    }


  function setPeriodReleaseTime(uint8 _periodId, uint256 _releaseTime) public onlyOwner{
      periodReleaseTime[_periodId] = _releaseTime;
  }

  function setAmountPerPeriod(uint8 _periodId, uint256 _amount) public onlyOwner{
      amountPerPeriod[_periodId] = _amount;
  }

  function _transferToOwner(address _owner, uint256 _amount, uint8 _periodId) public onlyOwner nonReentrant {
        require( block.timestamp >= periodReleaseTime[_periodId], "RealeaseTime: Your time has not come" );
        require( _amount <= amountPerPeriod[_periodId], "Amount: Token amount is too high" );
        IERC20(ECIO_TOKEN).transfer(_owner, _amount);
    }

  function checkIsAvailable(uint8 _periodId) public view returns (bool) {
        if( block.timestamp >= periodReleaseTime[_periodId] ) {
          return true;
        } else {
          return false;
        }
  }

}
