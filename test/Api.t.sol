// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../../contracts/test/MockV3Aggregator.sol";
import "../../contracts/MonitorContract.sol";


contract OracleTest is Test {
    MockV3Aggregator public oracle;
    PriceConsumerV3 public consumer;

    function setUp() public {
        // Create a new oracle
        oracle = new MockV3Aggregator(
            18, //decimals
            1   //initial data
        );
        // Create a new consumer
        consumer = new PriceConsumerV3(
            address(oracle)
        );
    }

    function testCallOracleData() public {
        int price = consumer.getLatestPrice(); //call oracle price from consumer
        assertEq(price, 1); //price should be 1 (initialized data)
    }

    function testChangeOracleData() public {
        oracle.updateAnswer(2); //change oracle data from 1 to 2
        int price = consumer.getLatestPrice(); //call oracle price from consumer
        assertEq(price, 2); //price should be 2 (new data)
    }
}