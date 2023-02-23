// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IERC721 {
    function safeTransferFrom(address from,address to,uint tokenId) external;

    function transferFrom(address,address,uint) external;   
    }

contract EnglishAuction {
    event start();
    event Bidding(address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event end(address winner, uint amount);

    IERC721 public nft;
    uint public nftId;
    address payable public seller;
    uint public endAt;
    bool public started;
    bool public ended;
    address public HighestBidder;
    uint public HighestBid;
    mapping(address => uint) public bids;

    constructor(
        address _nft, uint _nftId, uint _startingBid) {
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        HighestBid = _startingBid;                           //
    }

    function Start() external {                     
        require(msg.sender == seller, "not seller");
        require(!started, "started");                       //only call once
        started = true;
        endAt = uint32(block.timestamp + 60);
        nft.transferFrom(msg.sender, address(this), nftId);
        emit start();
    }

    function Bid() external payable {
        require(started, "not started");
        require(block.timestamp < endAt, "ended");
        require(msg.value > HighestBid, "value is less than highest Bid");

        if (HighestBidder != address(0)) {
            bids[HighestBidder] += HighestBid;
        }

        HighestBidder = msg.sender;
        HighestBid = msg.value;
       emit Bidding(msg.sender, msg.value);
    }

    function withdraw() external {
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
         emit Withdraw(msg.sender, bal);
    }

    function End() external {
        require(started, "Not Started");
        require(block.timestamp >= endAt, "Not ended");
        require(!ended, "Ended");

        ended = true;
        if (HighestBidder != address(0)) {
            nft.safeTransferFrom(address(this), HighestBidder, nftId);
            seller.transfer(HighestBid);
        } else {
            nft.safeTransferFrom(address(this), seller, nftId);
        }
        emit end(HighestBidder, HighestBid);
    }
}
