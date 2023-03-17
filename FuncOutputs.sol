//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract FuncOutputs{
    function returnMany() public pure returns(uint, bool){
        return (1, false);
    }

    function returnManyWithNames() public pure returns(uint x, bool b){
        return (1, false);
    }

     function assigned() public pure returns(uint x, bool b){
        x = 1;
        b = true;
    }

    function destructReturnFuncs() public pure {
       (uint x, bool b) = returnMany();
       (, bool onlyB) = returnMany();
    }
}