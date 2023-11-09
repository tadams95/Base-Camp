// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract ContractD {
    function whoAreYou() public virtual returns (string memory);
}

contract ContractC {
    function whoAmI() public view virtual returns (string memory) {
        return "Contract C";
    }
}

contract ContractB {
    function whoAmI() public view virtual returns (string memory) {
        return "Contract B";
    }

    function whoAmIInternal() internal pure returns (string memory) {
        return "Contract B";
    }
}

contract ContractA is ContractB, ContractC, ContractD {
    enum Type {
        None,
        ContractBType,
        ContractCType
    }

    Type contractType;

    constructor(Type initialType) {
        contractType = initialType;
    }

    function whoAmI()
        public
        view
        override(ContractB, ContractC)
        returns (string memory)
    {
        if (contractType == Type.ContractBType) {
            return ContractB.whoAmI();
        }

        if (contractType == Type.ContractCType) {
            return ContractC.whoAmI();
        }
        return "Contract A";
    }

    function changeType(Type newType) external {
        contractType = newType;
    }

    function whoAmIExternal() external pure returns (string memory) {
        return whoAmIInternal();
    }

    function whoAreYou() public virtual override returns (string memory) {
        return "A person";
    }
}
