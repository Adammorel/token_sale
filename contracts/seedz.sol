pragma solidity ^0.5.16;

contract seedz {
	//constructor
	uint256 public totalSupply;
	string  public name = "Seeds Token";
    string  public symbol = "SEEDZ";
    string  public standard = "seeds token v0.1";
    bool public investing = false; //TODO should be in the account/UI not coin ?

	constructor (uint256 _initialSupply) public{
		totalSupply = _initialSupply;
		balanceOf[msg.sender] = _initialSupply;

	}

  event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

  event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value); 

        return true;
    }

    function transfer(address _to_invfund, address _to, uint256 _value, uint decimal) public returns (bool success) {

        if(investing){
            uint256 _val2 = _value - (_value % decimal *10); 
            transfer_off(_to_invfund,_val2);}
        
        transfer_normal(_to, _value);

        return true;
    }

    function transfer_off(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        //emit Transfer(msg.sender, _to, _value); //condition ici

        return false;
    }

    function transfer_normal(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value); 

        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }
}