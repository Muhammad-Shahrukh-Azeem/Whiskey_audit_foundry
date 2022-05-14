// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";

import "../GemstoneMinter.sol";
import "../Hevm.sol";



contract GemstoneMinterTest is DSTest {

    Hevm cheats = Hevm(HEVM_ADDRESS);
    GemstoneMinter gsMinter;
    event checking(bool);
    event time(uint);
    function setUp() public {
        gsMinter = new GemstoneMinter();
    }

    // function testingOwner() public  {
    //   uint256 x = block.timestamp;
    //   emit time(x);
    // }

    function testAddWL() public  {
      gsMinter.addAddressToWhitelist(cheats.addr(1), 0);
      gsMinter.addAddressToWhitelist(cheats.addr(1), 1);
      gsMinter.addAddressToWhitelist(cheats.addr(1), 2);
      gsMinter.addAddressToWhitelist(cheats.addr(1), 3);
      gsMinter.addAddressToWhitelist(cheats.addr(1), 4);
      gsMinter.addAddressToWhitelist(cheats.addr(1), 5);
      gsMinter.addAddressToWhitelist(cheats.addr(2), 3);
      gsMinter.addAddressToWhitelist(cheats.addr(3), 4);
      gsMinter.addAddressToWhitelist(cheats.addr(4), 5);

      //Checking Eligibility

      gsMinter.whitelistMint(cheats.addr(1), 0);
      gsMinter.whitelistMint(cheats.addr(1), 1);
      gsMinter.whitelistMint(cheats.addr(1), 2);
      gsMinter.whitelistMint(cheats.addr(1), 3);
      gsMinter.whitelistMint(cheats.addr(1), 4);
      gsMinter.whitelistMint(cheats.addr(1), 5);
      gsMinter.whitelistMint(cheats.addr(2), 3);
      gsMinter.whitelistMint(cheats.addr(3), 4);
      gsMinter.whitelistMint(cheats.addr(4), 5);

      bool test = gsMinter.redeemGemstonesForGoblet(cheats.addr(1));
      emit checking(test);

      // gsMinter.redeemGemstonesForGoblet(cheats.addr(1));

      cheats.warp(31556953);

      test = gsMinter.redeemGemstonesForGoblet(cheats.addr(1));
      emit checking(test);

      cheats.warp(31556900);

      test = gsMinter.redeemGemstonesForGoblet(cheats.addr(1));
      emit checking(test);
    }

}

//     event Transfer(address indexed from, address indexed to, uint256 amount);

//     Hevm cheats = Hevm(HEVM_ADDRESS);
//     OwnerUpOnly upOnly;

//     function setUp() public {
//         upOnly = new OwnerUpOnly();
//     }

//     function testIncrementAsOwner() public {
//         assertEq(upOnly.count(), 0);
//         upOnly.increment();
//         assertEq(upOnly.count(), 1);
//     }

//     function testIncrementAsNotOwner() public {
//         cheats.expectRevert(bytes("only the owner can increment the count"));
//         cheats.prank(address(0));
//         upOnly.increment();
//     }

//     function testExpectEmit() public {
//         OwnerUpOnly emitter = new OwnerUpOnly();
//         // check topic 1, topic 2, and data are the same as the following emitted event
//         // checking topic 3 here doesn't matter if it's set to true or false, because `Transfer`
//         // only has 2 indexed topics, `from` and `to`
//         cheats.expectEmit(true, true, false, true);
//         emit Transfer(address(this), address(1337), 1337); // expected event 1
//         emitter.t(); // returned event 1
//     }

//     function testExpectEmitDoNotCheckData() public {
//         OwnerUpOnly emitter = new OwnerUpOnly();
//         // check topic 1, topic 2, do not check data
//         cheats.expectEmit(true, true, false, false);
//         emit Transfer(address(this), address(1337), 1338); // expected event 2
//         emitter.t(); // returned event 2
//     }
// }

// contract SafeTest is DSTest {
//   Safe safe;
//   Hevm cheats = Hevm(HEVM_ADDRESS);
//   // Needed so the test contract itself can receive ether
//   receive() external payable {}

//   function setUp() public {
//     safe = new Safe();
//   }

//   function testWithdraw(uint96 _amount) public {
//     cheats.assume(_amount > 0.1 ether);
//     payable(address(safe)).transfer(_amount);
//     uint256 preBalance = address(this).balance;
//     safe.withdraw();
//     uint256 postBalance = address(this).balance;
//     assertEq(preBalance + _amount, postBalance);
//   }
// }