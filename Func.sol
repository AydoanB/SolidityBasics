//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract FuncModifier {
    uint public count;
    bool public paused;

    function setPause(bool _paused) external {
        paused = _paused;
    }

    modifier whenNotPaused(){
        require(!paused, "Paused was set to true");
        _;
    }

    function inc() external whenNotPaused {
        count++;
    }

    function dec() external whenNotPaused {
        count--;
    }

    modifier cap(uint x){
        require(x < 100, "x >= 100");
        _; //Will execute the code in the func which uses
    }

    function incBy(uint _s) external whenNotPaused cap(_s) sandwichModifier{
        count += _s;
    }

    modifier sandwichModifier(){
        count += 10;
        _; //Will execute the code in the func which uses
        count += 99;
    }

}

