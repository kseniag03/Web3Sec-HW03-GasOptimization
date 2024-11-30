// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./Interfaces.sol";

import "forge-std/console.sol";

contract ArrayLength is IArrayLength {
    uint256[] public myArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    function callFor() public view {
        for (uint256 i; i < myArray.length; i++) {
            i++;
        }
    }
}

/* случай редких вызовов callFor()
contract ArrayLengthOptimized is IArrayLength {
    uint256[] public myArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    function callFor() external view {
        uint256 len = myArray.length;
        for (uint256 i; i < len; i++) {
            i++;
        }
    }
}
*/

/* проигрыш в деплое, зато функция меньше потребляет
contract ArrayLengthOptimized is IArrayLength {
    uint256[] public myArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    uint256 internal immutable myArrayLen = myArray.length;

    function callFor() external view {
        for (uint256 i; i < myArrayLen; i++) {
            i++;
        }
    }
}
*/

// главная цель: уменьшить стоимость выполнения функций смарт-контракта
// а функция ничего полезного не делает, её результаты пропадают в небытии
// массив можно заюзать извне, поэтому его оставляем
contract ArrayLengthOptimized is IArrayLength {
    uint256[] public myArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    function callFor() external view {}
}