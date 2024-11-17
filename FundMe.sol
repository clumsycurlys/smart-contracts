// get funding form user 
// withdraw funding 
// set minimum funding 

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
    uint256 public myValue=5e18;

    address[] public funders;

    function fund() public payable {
        // user to fund 
        // minimum amount 
        myValue= myValue + 2;
        require (getConversionRate(msg.value) >= myValue, "Funding amount less than min"); 
        funders.push(msg.sender);
    } 
    
    function getPrice() public view returns(uint256){
        // address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }
    
    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
        
    }
    // function withdraw() public{}

    }
