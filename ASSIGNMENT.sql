CREATE DATABASE HMBank;
USE hmbank;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    DOB DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    address VARCHAR(255)
);
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    account_type VARCHAR(50),
    balance DECIMAL(15, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    transaction_type VARCHAR(50),
    amount DECIMAL(15, 2),
    transaction_date TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
INSERT INTO Customers (first_name, last_name, DOB, email, phone_number, address) 
VALUES 
('John', 'Doe', '1990-05-15', 'john.doe@example.com', '123-456-7890', '123 Main St'),
('Jane', 'Smith', '1985-10-20', 'jane.smith@example.com', '987-654-3210', '456 Elm St'),
('Michael', 'Johnson', '1978-03-12', 'michael.johnson@example.com', '555-123-4567', '789 Oak St'),
('Emily', 'Williams', '1995-07-08', 'emily.williams@example.com', '111-222-3333', '101 Pine St'),
('David', 'Brown', '1980-11-25', 'david.brown@example.com', '444-555-6666', '202 Maple St'),
('Sarah', 'Taylor', '1989-09-18', 'sarah.taylor@example.com', '777-888-9999', '303 Cedar St'),
('Matthew', 'Anderson', '1983-12-30', 'matthew.anderson@example.com', '333-222-1111', '404 Birch St'),
('Jessica', 'Martinez', '1992-02-14', 'jessica.martinez@example.com', '999-888-7777', '505 Walnut St'),
('Andrew', 'Garcia', '1975-06-28', 'andrew.garcia@example.com', '666-555-4444', '606 Cherry St'),
('Lauren', 'Hernandez', '1987-04-05', 'lauren.hernandez@example.com', '222-333-4444', '707 Peach St');
SELECT* FROM customers;


INSERT INTO Accounts (customer_id, account_type, balance) 
VALUES 
(1, 'savings', 5000.00),
(2, 'current', 2500.00),
(3, 'savings', 7000.00),
(4, 'savings', 3000.00),
(5, 'current', 1500.00),
(6, 'savings', 9000.00),
(7, 'current', 2000.00),
(8, 'savings', 4000.00),
(9, 'current', 3500.00),
(10, 'savings', 6000.00);
SELECT* FROM accounts;

INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date) 
VALUES 
(1, 'deposit', 1000.00, '2024-04-16 09:30:00'),
(2, 'withdrawal', 500.00, '2024-04-17 13:45:00'),
(3, 'deposit', 2000.00, '2024-04-16 10:15:00'),
(4, 'withdrawal', 1000.00, '2024-04-17 11:20:00'),
(5, 'deposit', 500.00, '2024-04-16 12:30:00'),
(6, 'withdrawal', 1500.00, '2024-04-17 14:00:00'),
(7, 'deposit', 1000.00, '2024-04-16 15:45:00'),
(8, 'withdrawal', 800.00, '2024-04-17 16:30:00'),
(9, 'deposit', 1200.00, '2024-04-16 17:15:00'),
(10, 'withdrawal', 2000.00, '2024-04-17 18:00:00');
SELECT* FROM transactions;

--------------------------------------------------------------------------------------------------------------------
SELECT 
    customers.first_name,
    customers.last_name,
    Accounts.account_type,
    customers.email
FROM Customers 
INNER JOIN 
    Accounts ON customers.customer_id = Accounts.customer_id;

---------------------------------------------------------------------------------------------------------------------------
SELECT 
    customers.first_name,
    customers.last_name,
    Transactions.transaction_id,
    Transactions.transaction_type,
    Transactions.amount,
    Transactions.transaction_date
FROM 
    Customers 
INNER JOIN 
    Accounts ON customers.customer_id = accounts.customer_id
INNER JOIN 
    Transactions ON accounts.account_id = Transactions.account_id;

-----------------------------------------------------------------------------------------------------------------------------------

UPDATE Accounts
SET balance = balance + 500
WHERE account_id = 8;

-----------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    CONCAT (first_name, ' ', last_name) AS full_names
FROM 
    Customers;

--------------------------------------------------------------------------------------------------------------------------------------------

DELETE FROM Accounts
WHERE balance = 0;

---------------------------------------------------------------------------------------------------------------------------------------------

SELECT *
FROM 
    Customers
WHERE Address = '505 Walnut St';

----------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    balance
FROM 
    Accounts
WHERE 
    account_id = 8;

------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM 
    Accounts
WHERE 
    account_type = 'current' AND balance > 1000.00;

----------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    Transactions.transaction_id,
    Transactions.transaction_type,
    Transactions.amount,
    Transactions.transaction_date
FROM 
    Transactions 
INNER JOIN 
    Accounts  ON Transactions.account_id = Accounts.account_id
WHERE 
    Accounts.account_id = 8;

------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    account_id,
    balance * 0.07 AS interest_accrued
FROM 
    Accounts
WHERE 
    account_type = 'savings';

--------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    account_id, balance
FROM Accounts
WHERE balance < 6000.00;

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT *
FROM 
    Customers
WHERE 
     address <> '789 Oak St';

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT AVG (balance) AS average_balance
FROM Accounts;

---------------------------------------------------------------------------------------------------------------------------------------------

SELECT *
FROM Accounts
ORDER BY balance DESC
LIMIT 10;

---------------------------------------------------------------------------------------------------------------------------------------------

SELECT SUM(amount) AS total_deposits
FROM Transactions
WHERE transaction_type = 'deposit'
AND DATE(transaction_date) = ' 2024-04-16';

--------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    MIN(DOB) AS oldest_customer_DOB,
    MAX(DOB) AS newest_customer_DOB
FROM Customers;

----------------------------------------------------------------------------------------------------------------------------------------------
----- OLDEST CUSTOMER
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    MIN(t.transaction_date) AS oldest_transaction_date
FROM 
    Customers c
INNER JOIN 
    Accounts a ON c.customer_id = a.customer_id
INNER JOIN 
    Transactions t ON a.account_id = t.account_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    oldest_transaction_date ASC
LIMIT 1;
------------------------------------------------------------------------------------------------------------------------------------------

-- Newest Customers
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    MAX(t.transaction_date) AS newest_transaction_date
FROM 
    Customers c
INNER JOIN 
    Accounts a ON c.customer_id = a.customer_id
INNER JOIN 
    Transactions t ON a.account_id = t.account_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    newest_transaction_date DESC
LIMIT 1;

-----------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    Transactions.*,
    Accounts.account_type
FROM Transactions 
INNER JOIN 
Accounts ON Transactions.account_id = Accounts.account_id;


---------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    Customers.*,
    Accounts.*
FROM Customers
INNER JOIN Accounts ON Customers.customer_id = Accounts.customer_id;

---------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    Transactions.*,
    Customers.*
FROM Transactions 
INNER JOIN Accounts ON Transactions.account_id = accounts.account_id
INNER JOIN Customers  ON accounts.customer_id = Customers.customer_id
WHERE accounts.account_id = 3;

-------------------------------------------------------------------------------------------------------------------------------------------


SELECT 
    customer_id,
    COUNT(*) AS num_of_accounts
FROM Accounts
GROUP BY customer_id
HAVING COUNT(*) > 1;

------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    account_id,
    SUM(CASE WHEN transaction_type = 'deposit' THEN amount ELSE -amount END) AS transaction_difference
FROM Transactions
GROUP BY account_id;

------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    t.account_id,
    AVG(a.balance) AS average_daily_balance
FROM 
    Transactions t
INNER JOIN 
    Accounts a ON t.account_id = a.account_id
WHERE 
    t.transaction_date BETWEEN '2024-04-15' AND '2024-04-18'
GROUP BY 
    t.account_id;

-----------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    a.account_type,
    SUM(a.balance) AS total_balance
FROM 
    Accounts a
GROUP BY 
    a.account_type;


SELECT * 
FROM accounts;
----------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    account_id,
    COUNT(*) AS num_of_transactions
FROM Accounts
GROUP BY account_id
ORDER BY num_of_transactions DESC;

----------------------------------------------------------------------------------------------------------------------------------------


SELECT 
   CONCAT (c.first_name, ' ', c.last_name) AS full_name, a.account_type,a.balance
FROM Customers c
     INNER JOIN Accounts a ON c. customer_id = a. customer_id
ORDER BY a.balance DESC;

-----------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_date,
    COUNT(*) AS num_of_duplicates
FROM Transactions
GROUP BY transaction_id, account_id, transaction_type, amount, transaction_date
HAVING COUNT(*) > 1;
-------------------------------------------------------------------------------------
--- THIS IS WRONG
SELECT 
    customer_id,
    first_name,
    last_name,
    (SELECT MAX(balance) FROM Accounts) AS highest_balance
FROM 
    Customers;

--- OR 

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    (SELECT MAX(a.balance) FROM Accounts a WHERE a.customer_id = c.customer_id) AS highest_balance
FROM 
    Customers c;

------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    AVG(balance) AS average_balance
FROM 
    Accounts
WHERE 
    customer_id IN (SELECT customer_id FROM Accounts GROUP BY customer_id HAVING COUNT(*) > 1);


------------------------------------------------------------------------------------------------------------------------------
SELECT 
    AVG(balance) AS average_balance
FROM 
    Accounts
WHERE 
    customer_id IN (SELECT customer_id FROM Accounts GROUP BY customer_id);

--------------------------------------------------------------------------------------------------------------------------------


SELECT 
    *
FROM 
    Accounts a
WHERE 
    EXISTS (
        SELECT 1
        FROM Transactions t
        WHERE t.account_id = a.account_id
        GROUP BY t.account_id
        HAVING AVG(amount) > (SELECT AVG(amount) FROM Transactions)
    );
    
    -------------------------------------------------------------------------------------------------------------------------------------
    
    SELECT 
    *
FROM 
    Customers c
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM Accounts a
        WHERE a.customer_id = c.customer_id
    );

---------------------------------------------------------------------------------------------------------------------------------------


SELECT 
    SUM(balance) AS total_balance_with_no_transactions
FROM 
    Accounts
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM Transactions t
        WHERE t.account_id = Accounts.account_id
    );

-----------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    *
FROM 
    Transactions t
WHERE 
    t.account_id IN (
        SELECT account_id
        FROM Accounts
        WHERE balance = (SELECT MIN(balance) FROM Accounts)
    );
-----------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    customer_id,
    COUNT(DISTINCT account_type) AS num_account_types
FROM 
    Accounts
GROUP BY 
    customer_id
HAVING 
    COUNT(DISTINCT account_type) > 1;

-----------------------------------------------------------------------------------------------------------------------------------------



SELECT 
    account_type,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Accounts) AS percentage
FROM 
    Accounts
GROUP BY 
    account_type;
    
------------------------------------------------------------------------------------------------------

SELECT 
    *
FROM 
    Transactions t
WHERE 
    EXISTS (
        SELECT 1
        FROM Accounts a
        WHERE a.customer_id = 7
        AND t.account_id = a.account_id
    );
    
    -------------------------------------------------------------------------------------------------------------------------------------
    
    
SELECT 
    account_type,
    (SELECT SUM(balance) FROM Accounts WHERE account_type = a.account_type) AS total_balance
FROM 
    Accounts a
GROUP BY 
    account_type;




