//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Array {
    uint[] public nums;
    uint[10] public numsFixed;

    // function examples() external view{
    //     // nums.push(4);
    //     // uint x = nums[2];
    //     // nums[2] = 777; // 1, 3, 777, 5
    //     // delete nums[1]; //1, 0, 777, 5
    //     // nums.pop(); //1, 0, 777

    //     uint len = nums.length;

    //     //array in memory
    //     uint[] memory a = new uint[](5); // pop and push are not available for memory arrays 
    //     // a.pop();
    //     // a.push();

    //     //Allowed ops for memory arrays: 
    //     a[1] = 123;
    // }

    //AVOID RETURNING ARRAY FROM FUNC (SIMILAR TO BIG FOR LOOPS) YOU CAN'T KNOW HOW MUCH GAS WILL BE USED
    function returnArray() external view returns (uint[] memory){
        return nums;
    }

    //[1,2,3] remove(1) -> [1,3]
    function remove(uint _index) public {
        require(_index < nums.length, "Out of bound");

        for(uint i = _index; i < nums.length - 1; i++){
            nums[i] = nums[i + 1];
        }
        nums.pop();
    }

    function testRemove() external{
        nums = [1,2,3,4];
        remove(2);
        
        assert(nums[0] == 1);
        assert(nums[1] == 2);
        assert(nums[2] == 4);
        assert(nums.length == 3);
    }

    function simplerRemove(uint _index) public {
        nums[_index] = nums[nums.length - 1];
        nums.pop(); 
    }

    function testSimpleRemove() external{
        nums = [1,2,3];
        simplerRemove(2);

        assert(nums.length == 2);
        assert(nums[0] == 1);
        assert(nums[1] == 2);
    }

    
}