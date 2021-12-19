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

    address private ECIO_TOKEN;

    constructor(
        address _ecioTokenAddr
    ) {
        ECIO_TOKEN = _ecioTokenAddr;
    }

    function _transferToOwner(address _owner, uint256 _amount) public onlyOwner nonReentrant {

        IERC20(ECIO_TOKEN).transfer(_owner, _amount);

    }

}
