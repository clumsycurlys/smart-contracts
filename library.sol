// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OnlineLibrary {
    // Struct to represent a book with its title, author, and available copies
    struct Book {
        string title;
        string author;
        uint copies;
    }

    // Array to store all books in the library
    Book[] public books;

    // Mapping to keep track of which user borrowed which book (user address => (book title => boolean))
    mapping(address => mapping(string => bool)) public borrowedBooks;

    // Owner (librarian) of the contract
    address public owner;

    // Modifier to restrict some functions to the owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    // Event to signal when a new book is added
    event BookAdded(string title, string author, uint copies);

    // Event to signal when a book is borrowed
    event BookBorrowed(address borrower, string title);

    // Event to signal when a book is returned
    event BookReturned(address borrower, string title);

    // Constructor to set the contract deployer as the owner (librarian)
    constructor() {
        owner = msg.sender;

        // Adding 10 books to the library upon contract deployment
        addBook("The Great Gatsby", "F. Scott Fitzgerald", 5);
        addBook("1984", "George Orwell", 4);
        addBook("To Kill a Mockingbird", "Harper Lee", 3);
        addBook("Pride and Prejudice", "Jane Austen", 6);
        addBook("The Catcher in the Rye", "J.D. Salinger", 4);
        addBook("The Hobbit", "J.R.R. Tolkien", 2);
        addBook("Moby Dick", "Herman Melville", 1);
        addBook("War and Peace", "Leo Tolstoy", 5);
        addBook("Crime and Punishment", "Fyodor Dostoevsky", 3);
        addBook("The Odyssey", "Homer", 4);
    }

    // Function to add a new book to the library (only the owner can do this)
    function addBook(string memory _title, string memory _author, uint _copies) public onlyOwner {
        books.push(Book(_title, _author, _copies));
        emit BookAdded(_title, _author, _copies);
    }

    // Function to borrow a book by its title
    function borrowBook(string memory _title) public {
        uint bookIndex = findBookIndexByTitle(_title);
        require(bookIndex != type(uint).max, "Book not found");
        require(books[bookIndex].copies > 0, "No copies available for this book");
        require(!borrowedBooks[msg.sender][_title], "You already borrowed this book");

        // Decrease the available copies and mark the book as borrowed
        books[bookIndex].copies -= 1;
        borrowedBooks[msg.sender][_title] = true;

        emit BookBorrowed(msg.sender, _title);
    }

    // Function to return a book by its title
    function returnBook(string memory _title) public {
        uint bookIndex = findBookIndexByTitle(_title);
        require(bookIndex != type(uint).max, "Book not found");
        require(borrowedBooks[msg.sender][_title], "You did not borrow this book");

        // Increase the available copies and mark the book as returned
        books[bookIndex].copies += 1;
        borrowedBooks[msg.sender][_title] = false;

        emit BookReturned(msg.sender, _title);
    }

    // Function to get the details of a book by its title
    function getBookDetails(string memory _title) public view returns (string memory, string memory, uint) {
        uint bookIndex = findBookIndexByTitle(_title);
        require(bookIndex != type(uint).max, "Book not found");
        Book memory book = books[bookIndex];
        return (book.title, book.author, book.copies);
    }

    // Function to get the total number of books in the library
    function getTotalBooks() public view returns (uint) {
        return books.length;
    }

    // Function to get a list of all available books in the library
    function getAvailableBooks() public view returns (string[] memory) {
        uint availableCount = 0;
        for (uint i = 0; i < books.length; i++) {
            if (books[i].copies > 0) {
                availableCount++;
            }
        }

        string[] memory availableBooks = new string[](availableCount);
        uint index = 0;
        for (uint i = 0; i < books.length; i++) {
            if (books[i].copies > 0) {
                availableBooks[index] = books[i].title;
                index++;
            }
        }

        return availableBooks;
    }

    // Internal function to find the index of a book by its title
    function findBookIndexByTitle(string memory _title) internal view returns (uint) {
        for (uint i = 0; i < books.length; i++) {
            if (keccak256(abi.encodePacked(books[i].title)) == keccak256(abi.encodePacked(_title))) {
                return i;
            }
        }
        return type(uint).max;  // Return a max value if book is not found
    }
}
