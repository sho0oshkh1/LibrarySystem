## 1- Introducrion

This project aims to develop a streamlined system for borrowing books from a library. Through effective database design, we seek to optimize the borrowing process, ensuring efficient transactions for patrons.


## 2- App Statement

Design a library system for borrowing books.



## 3- Features list

- Add new books to the library system with details such as title, author, category, publisher, etc.
- View a list of all available books in the library.
- Update book information (e.g., title, author, category) if needed.
- Add new customers to the system with details like name, phone number, etc.
- View a list of all registered customers.
- Update customer information (e.g., name, phone number) if needed.
- Allow a customer to borrow one or more books.
- Display the current status of each book (available or borrowed).
- We can delete a customer or a book.


## 4- Database Schema

**Books:**
|     Column    |     Type      |
| ------------- | ------------- |
|   BookNo(PK)  |     uuid      |
|      Name     | text (String) |
|     Author     | text (String) |
|    Category   | text (String) |
|    Publisher  | text (String) |
|   IsBorrowed  |    boolean    |

**Customers:**
|     Column    |     Type      |
| ------------- | ------------- |
|     ID(PK)    |     uuid      |
|      Name     | text (String) |
|   PhoneNumber | text (String)      |



**Borrowing Books:**
|     Column    |     Type      |
| ------------- | ------------- |
|     ID(PK)    |     uuid      |
|   Book Id(FK) |      uuid      |
| CustomerId(FK) |   uuid      |



**The relations between the Customer and Books tabels:**

- The Customer can borrow many Books.

- The Book can be borrowed by one Customer .



