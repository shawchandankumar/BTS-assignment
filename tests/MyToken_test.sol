// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "remix_tests.sol";
import "../contracts/CSDP.sol";

contract MyTokenTest is CSDP(10) {

    function testTokenInitialValues() public {
        Assert.equal(name(), "CSDP", "token name did not match");
        Assert.equal(symbol(), "CSDP", "token symbol did not match");
        Assert.equal(decimals(), 18, "token decimals did not match");
        Assert.equal(totalSupply(), 0, "token supply should be zero");
    }
}