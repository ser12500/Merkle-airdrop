// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MerkleAirdrop} from "src/MerkleAirdrop.sol";
import {Token} from "src/Token.sol";
import {Script} from "forge-std/Script.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdrop is Script {
    bytes32 private ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 private AMOUNT_TO_TRANSFER = (25 * 1e18);

    function deployMerkleAirdrop() public returns (MerkleAirdrop, Token) {
        vm.startBroadcast();
        Token token = new Token();
        MerkleAirdrop airdrop = new MerkleAirdrop(ROOT, IERC20(token));
        token.mint(token.owner(), AMOUNT_TO_TRANSFER);
        IERC20(token).transfer(address(airdrop), AMOUNT_TO_TRANSFER);
        vm.stopBroadcast();
        return (airdrop, token);
    }

    function run() external returns (MerkleAirdrop, Token) {
        return deployMerkleAirdrop();
    }
}
