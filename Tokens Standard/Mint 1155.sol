// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function mintReward(address _userAdd) external returns (bool);
    function reward(address _userAdd) external returns (bool);

}
contract MyToken is ERC1155, Ownable {
        IERC20 public token;
    constructor() ERC1155("") {
           token = IERC20("");
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        onlyOwner
    {
        
        token.mintReward(account);
        token.reward(account);
        _mint(account, id, amount, data);
    }

    
}
