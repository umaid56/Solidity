// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract NFTMarketPlace{
    using SafeMath for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    Counters.Counter private _itemIds;
    Counters.Counter private _itemSold;
     address private nftcontract;
    struct MarketplaceItem{ 
        uint256 id;
        uint256 tokenId;
        address nftContract;
        uint256 price;
        bool bidstart;
        uint256 endTime;
        address payable creator;
        address payable seller;
        address payable owner;
        address payable highest_bidder;
        uint256 highestBid;
        bool sold;
    }
    uint256 public PrimaryFee;
    uint256 public SecondaryFee;
    address private owner;

    mapping(uint256 => MarketplaceItem) public marketplaceitem;

    constructor(uint256 _PrimaryFee, uint256 _SecondaryFee){
        PrimaryFee = _PrimaryFee;
        SecondaryFee = _SecondaryFee;
        owner = payable(msg.sender);
    }

    function CreateMarketPlace(address _nftcontract, uint256 _tokenid, uint256 _price) payable external{
        require(_nftcontract != address(0),"Address can't be Zero");
        require(_price != 0, "Price can't be Zero");
        require(IERC721(_nftcontract).ownerOf(_tokenid)==msg.sender,"Only Owner of nft can sell nft");
        _itemIds.increment();
        uint256 item = _itemIds.current();
        marketplaceitem[item] = MarketplaceItem(item,_tokenid,_nftcontract, _price, false, 0, payable(msg.sender), payable(msg.sender), payable(address(0)), payable (address(0)), 0, false);
    }
    function BuyNFT(uint256 _nftid) external payable{
        require(marketplaceitem[_nftid].price == msg.value, "The Price is less that current selling Price" );
        require(marketplaceitem[_nftid].owner == address(0), "Already Sold");
        require(marketplaceitem[_nftid].bidstart =  false, "NFT is in alreadt bidding");
        if(marketplaceitem[_nftid].seller == marketplaceitem[_nftid].creator){
            uint _loyalty = (msg.value * SecondaryFee) /100;
            uint _seller = msg.value - _loyalty;
            marketplaceitem[_nftid].seller.transfer(_seller);
            marketplaceitem[_nftid].creator.transfer(_loyalty);
        IERC721(marketplaceitem[_nftid].nftContract).transferFrom(marketplaceitem[_nftid].seller,msg.sender,marketplaceitem[_nftid].tokenId);
        }
        else{
            uint _SecondaryFee = (msg.value * SecondaryFee)/100;
            uint _PrimaryFee = (msg.value* PrimaryFee)/100;
            uint _seller = msg.value - _SecondaryFee - _PrimaryFee;
            marketplaceitem[_nftid].seller.transfer(_seller);
            marketplaceitem[_nftid].creator.transfer(_SecondaryFee);
            payable(owner).transfer(_PrimaryFee);
            IERC721(marketplaceitem[_nftid].nftContract).transferFrom(marketplaceitem[_nftid].seller,msg.sender,marketplaceitem[_nftid].tokenId);
        }
    }

    function ownedNfts() public view returns(MarketplaceItem[] memory){
        uint _total= _itemIds.current();
        uint _sold =0;
        uint currentindex = 0;
        for(uint i=0; i<_total; i++){
            if(marketplaceitem[i+1].owner==msg.sender){
                _sold+=1;
            }
        }
       MarketplaceItem[] memory items = new MarketplaceItem[](_sold);
       for(uint256 i=0; i<_total; i++){
           if(marketplaceitem[i+1].owner==msg.sender){
               uint currentId = i + 1;
            MarketplaceItem storage current_item = marketplaceitem[currentId];
            items[currentindex]=current_item;
            currentindex+=1;
           }
       }
       return items;
    }
     function AllNfts() public view returns(MarketplaceItem[] memory){
        uint _total = _itemIds.current();
        uint _sold = 0;
        uint currentIndex = 0;
          for(uint i=0;i<_total;i++){
            if(marketplaceitem[i+1].sold==false){
                _sold+=1;
            }
        }
       MarketplaceItem[] memory items = new MarketplaceItem[](_sold);
       for(uint256 i=0;i<_total;i++){
           if(marketplaceitem[i+1].sold==false){
               uint currentId = i + 1;
            MarketplaceItem storage current_item = marketplaceitem[currentId];
            items[currentIndex]=current_item;
            currentIndex+=1;
           }
       }
       return items;
    }

     function StartAuction(uint256 _nftid,uint256 _endAt)public{
         require(marketplaceitem[_nftid].seller==payable(msg.sender),"Only Owner of Nft can with Start auction");
        
         marketplaceitem[_nftid].bidstart= true;
         marketplaceitem[_nftid].endTime= block.timestamp + _endAt;
    }

    function placebid(uint256 _nftid,uint256 _price) public{
            require(marketplaceitem[_nftid].bidstart == true,"biding not starting yet");
            require(marketplaceitem[_nftid].endTime> block.timestamp, "Bid ended");
            require(marketplaceitem[_nftid].price < _price, "Price must be greater then initial price");
            require(marketplaceitem[_nftid].highestBid <_price, "Price must be greater then initial price");
            
            marketplaceitem[_nftid].highest_bidder=payable(msg.sender);
            marketplaceitem[_nftid].highestBid = _price;
    }

    function withdraw_nft(uint256 _nftid) public payable{
        require(marketplaceitem[_nftid].owner==address(0),"Nft already Sold");
        require(marketplaceitem[_nftid].endTime<block.timestamp,"Bid not ended yet");
        require(marketplaceitem[_nftid].highestBid==msg.value,"Enter value is less then highest bid price");
        require(marketplaceitem[_nftid].highest_bidder==msg.sender,"Only Highest bidder can with draw nft");
     
        if(marketplaceitem[_nftid].seller != marketplaceitem[_nftid].creator){
        uint256 royality = (msg.value*SecondaryFee)/100;
        uint256 _toSeller = msg.value -royality;
        
        IERC721(marketplaceitem[_nftid].nftContract).transferFrom(marketplaceitem[_nftid].seller,marketplaceitem[_nftid].highest_bidder,marketplaceitem[_nftid].tokenId);
        marketplaceitem[_nftid].seller.transfer(_toSeller);
        marketplaceitem[_nftid].creator.transfer(royality);
      } 
      else
      {
         uint256 royality = (msg.value*SecondaryFee)/100;
        uint256 primary_fee = (msg.value*PrimaryFee)/100;
        uint256 _toSeller = msg.value -royality-primary_fee;
       
        IERC721(marketplaceitem[_nftid].nftContract).transferFrom(marketplaceitem[_nftid].seller,marketplaceitem[_nftid].highest_bidder,marketplaceitem[_nftid].tokenId);
       
        marketplaceitem[_nftid].seller.transfer(_toSeller);
        marketplaceitem[_nftid].creator.transfer(royality);
        payable(owner).transfer(primary_fee); 
      }
        marketplaceitem[_nftid].owner = payable(msg.sender);
        marketplaceitem[_nftid].sold = true;
        marketplaceitem[_nftid].bidstart=false;
    }

}  
