// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.2 <0.9.0;

contract BookShelf {

    struct Book {
        string title;
        string author;
        bool completed;
    }

    //Books in the shelf
    Book[] public books;

    event BookRead(
        address indexed _user,
        string _message,
        string _title
    );

    function add(string memory _title, string memory _author) public {
        books.push(Book(_title, _author, false));
    }

    function get(uint _index) 
        public 
        view 
        returns (string memory title, string memory author, bool completed)
    {
        Book storage book = books[_index];
        return (book.title, book.author, book.completed);
    }

    function complete(uint _index) public {
        Book storage book = books[_index];
        book.completed = true;
        emit BookRead(msg.sender, "Book has been read",book.title);
    }

    uint public count = 0;
    receive() external payable {
        // Receive ether from someone
        count++;
    }

    function checkBalance() public view returns (uint) {
        return address(this).balance;
    }

    event Log(string message);

    function transfer(address payable _to) public payable {
        (bool sent, ) = _to.call{ value: msg.value }("");
        require(sent, "Failed!");
        emit Log("Sent!");
    }
}