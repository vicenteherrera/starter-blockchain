/*
Supply Chain Tracking

Use case: Track origin and steps of a product (e.g. food, luxury goods).
Blockchain advantage: Immutable audit trail; consumers and auditors can verify data.
Example: Each step of the supply chain records a new event on-chain using trackItem.sol.
*/

// SPDX-License-Identifier: MIT

// Open in Remix IDE online with: https://remix.ethereum.org/vicenteherrera/starter-blockchain/blob/main/examples/solidity/SupplyChain.sol

pragma solidity ^0.8.0;

contract SupplyChain {
    // Define the structure for the product
    struct Product {
        uint productId;
        string productName;
        address manufacturer;
        address retailer;
        address[] intermediaries;
        uint price;
        bool isAvailable;
    }

    // Mapping to store product details
    mapping(uint => Product) public products;
    uint public productCount;

    // Event to log product creation
    event ProductCreated(uint productId, string productName, address manufacturer, uint price);

    // Constructor
    constructor() {
        productCount = 0;
    }

    // Function to create a new product
    function createProduct(string memory _productName, uint _price) public {
        productCount++;
        products[productCount] = Product(productCount, _productName, msg.sender, address(0), new address[](0), _price, true);
        emit ProductCreated(productCount, _productName, msg.sender, _price);
    }

    // Function to sell a product from one company to another
    function transferProduct(uint _productId, address _to) public {
        require(products[_productId].isAvailable == true, "Product is not available");
        require(products[_productId].manufacturer == msg.sender || products[_productId].retailer == msg.sender || contains(products[_productId].intermediaries, msg.sender), "You are not allowed to transfer this product");

        if (products[_productId].retailer == address(0)) {
            products[_productId].retailer = _to;
        } else {
            products[_productId].intermediaries.push(products[_productId].retailer);
            products[_productId].retailer = _to;
        }
    }

    // Function to check if an address is in an array
    function contains(address[] memory _array, address _addr) private pure returns (bool) {
        for (uint i = 0; i < _array.length; i++) {
            if (_array[i] == _addr) {
                return true;
            }
        }
        return false;
    }

    // Function to get product details
    function getProductDetails(uint _productId) public view returns (uint, string memory, address, address, address[] memory, uint, bool) {
        return (
            products[_productId].productId,
            products[_productId].productName,
            products[_productId].manufacturer,
            products[_productId].retailer,
            products[_productId].intermediaries,
            products[_productId].price,
            products[_productId].isAvailable
        );
    }
}