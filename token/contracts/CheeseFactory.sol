pragma solidity >=0.5.0 <0.6.0;

import "./ownable.sol";
import "./safemath.sol";

contract CheeseFactory is Ownable {

  using SafeMath for uint256;
  using SafeMath for uint32;
  using SafeMath for uint16;

  event NewCheese(uint cheeseId, string name, uint dna);

  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  uint cooldownTime = 1 days;

  struct Cheese {
    string name;
    uint dna;
    uint32 level;
    uint32 readyTime;
    uint16 winCount;
    uint16 lossCount;
  }

  Cheese[] public Cheeses;

  mapping (uint => address) public cheeseToOwner;
  mapping (address => uint) ownerCheeseCount;

  function _createCheese(string memory _name, uint _dna) internal {
    uint id = Cheeses.push(Cheese(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;
    cheeseToOwner[id] = msg.sender;
    ownerCheeseCount[msg.sender] = ownerCheeseCount[msg.sender].add(1);
    emit NewCheese(id, _name, _dna);
  }

  function _generateRandomDna(string memory _str) private view returns (uint) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % dnaModulus;
  }

  function createRandomCheese(string memory _name) public {
    require(ownerCheeseCount[msg.sender] == 0);
    uint randDna = _generateRandomDna(_name);
    randDna = randDna - randDna % 100;
    _createCheese(_name, randDna);
  }

}
