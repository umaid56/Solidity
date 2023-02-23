// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function mintReward(address _userAdd) external returns (bool);
    function reward(address _userAdd) external returns (bool);

}


contract MyNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    IERC20 public token;

    struct listing {
        uint256 price;
        address seller;
    }
    constructor() ERC721("ABC", "ABC") {
        token = IERC20("");  //erc20 contract address
    }
    mapping(uint256 => listing) public listings;

    function Mint_NFT(address recipient, string memory tokenURI) public  onlyOwner
        returns (uint256)
    {
        token.mintReward(recipient);
        token.reward(recipient);
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
    }
     
}

