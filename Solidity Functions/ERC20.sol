// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;


interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);


    //event Transfer(address indexed from, address indexed to, uint256 value);
    //event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract ERC20Basic is IERC20 {

    string private  name ;
    string private  symbol ;
    uint8 private  decimals;


    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);


    mapping(address => uint256) balances;

    mapping(address => mapping (address => uint256)) allowed;

    uint256 totalSupply_;
    address admin;



   constructor(string memory _name,string memory _symbol,uint8 _decimal, uint256 total) public {
    totalSupply_ = total;
    balances[msg.sender] = totalSupply_;
    name = _name;
    symbol= _symbol;
    decimals = _decimal;
    admin = msg.sender;
    }
    modifier onlyadmin{
        require(msg.sender == admin ,"Only Admin can do this");
        _;
    }   
    function Minning(uint _qty) public onlyadmin returns (uint) {
        totalSupply_ +=_qty;
        balances[msg.sender] += _qty;
        return totalSupply_;
    }
    function totalSupply() public override view returns (uint256) {
    return totalSupply_;
    }

    function balanceOf(address tokenOwner) public override view returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] -=(numTokens);
        balances[receiver] +=(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint256 numTokens) public override returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public override view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);
        balances[owner] -=(numTokens);
        allowed[owner][msg.sender]-=(numTokens);
        balances[buyer] +=(numTokens);
        emit Transfer(owner, buyer, numTokens);
        allowed[owner][msg.sender] -= numTokens;
        return true;
    }
}

