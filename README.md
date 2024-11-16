# Online Library Smart Contract

This repository contains a smart contract for an **Online Library System** written in Solidity. The smart contract allows users to borrow and return books, check available books, and view book details on the Ethereum blockchain.

## Features

- **Add Books**: Admins can add new books to the library.
- **Borrow Books**: Users can borrow a book if it is available.
- **Return Books**: Users can return borrowed books to the library.
- **Check Book Availability**: Users can check if a book is available and how many copies are remaining.
- **List Available Books**: Users can view all books available in the library.

## Contract Functions

- **addBook(string _title, uint _copies)**: Adds a new book to the library with a specified number of copies.
- **borrowBook(string _title)**: Allows a user to borrow a book by title if available.
- **returnBook(string _title)**: Allows a user to return a borrowed book.
- **getBookDetails(string _title)**: Fetches the details (title, number of copies, and availability) of a specific book.
- **getAvailableBooks()**: Lists all available books in the library.

## Technologies

- **Solidity**: The smart contract is written in Solidity, an Ethereum-compatible language.
- **Ethereum**: The contract is designed to be deployed on the Ethereum blockchain.
- **Remix IDE**: Used for development, testing, and deployment of the smart contract.

## Deployment Instructions

### Using Remix IDE

1. Open [Remix IDE](https://remix.ethereum.org).
2. Create a new Solidity file and paste the contract code.
3. Compile the contract using the **Solidity Compiler**.
4. Deploy the contract to either the **JavaScript VM**, **Rinkeby** testnet, or the **Ethereum mainnet** (you will need MetaMask for real deployments).

### Using Truffle (Optional)

You can also deploy the contract using Truffle by following these steps:

1. Initialize a Truffle project:
   ```bash
   truffle init
