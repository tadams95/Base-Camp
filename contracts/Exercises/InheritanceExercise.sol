// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract employee {
    uint public idNumber;
    uint public managerId;

    constructor(uint _idNumber, uint _managerId) {
        idNumber = _idNumber;
        managerId = _managerId;
    }

    function getAnnualCost() public virtual returns (uint);
}

//inherits from employee
//constructor that sets up contract using abstract contract above
contract Salaried is employee {
    uint256 public annualSalary;

    constructor(
        uint _idNumber,
        uint _managerId,
        uint256 _annualSalary
    ) employee(_idNumber, _managerId) {
        annualSalary = _annualSalary;
    }

    function getAnnualCost() public view override returns (uint256) {
        return annualSalary;
    }
}

//inherits from employee, similar to above
contract Hourly is employee {
    uint256 public hourlyRate;

    constructor(
        uint _idNumber,
        uint _managerId,
        uint256 _hourlyRate
    ) employee(_idNumber, _managerId) {
        hourlyRate = _hourlyRate;
    }

    function getAnnualCost() public view override returns (uint256) {
        uint256 hoursInYear = 2080;
        return hourlyRate * hoursInYear;
    }
}

//public array that holds employee ids
//pushes _employeeId to array
//delete public array
contract Manager {
    uint[] employeIds;

    function addReport(uint _employeeId) public {
        employeIds.push(_employeeId);
    }

    function resetReports() public {
        delete employeIds;
    }
}

//inherits from hourly
//constructor that sets up data as used in Hourly constructor
contract Salesperson is Hourly {
    constructor(
        uint _idNumber,
        uint _managerId,
        uint256 _hourlyRate
    ) Hourly(_idNumber, _managerId, _hourlyRate) {}
}

contract EngineeringManager is Salaried, Manager {
    constructor(
        uint _idNumber,
        uint _managerId,
        uint256 _annualSalary
    ) Salaried(_idNumber, _managerId, _annualSalary) {}
}

//deploy this contract with the contract addresses of salesPerson and engineeringManager
//submit this contract address for exercise.
contract InheritanceSubmission {
    address public salesPerson;
    address public engineeringManager;

    constructor(address _salesPerson, address _engineeringManager) {
        salesPerson = _salesPerson;
        engineeringManager = _engineeringManager;
    }
}
