-- HDFC_Bank SQL Queries 
-- Author: Edwin Sunny
-- Scenario: HDFC Bank Database Project
-- Covers: 
-- DDL (10), DML (10), DQL (10), Clauses (10), Constraints (10), Joins (10), Subqueries (10), Functions (10),
-- Views & CTE (10), Stored Procedures (5), Window Functions (5), Transactions (5), Triggers (5).

use HDFC_Bank;

/* ========================
   1) DDL QUERIES (10) 
   ======================== */

-- 1.1 Create Audit_Log table
CREATE TABLE Audit_Log (
  Audit_ID INT PRIMARY KEY AUTO_INCREMENT,
  Table_Name VARCHAR(100),
  Action_Type ENUM('INSERT','UPDATE','DELETE','DDL'),
  Action_By VARCHAR(100),
  Action_Time DATETIME DEFAULT CURRENT_TIMESTAMP,
  Details TEXT
);

-- 1.2 Add UNIQUE constraint on Branches.IFSC_Code
ALTER TABLE Branches
ADD CONSTRAINT uq_branches_ifsc UNIQUE (IFSC_Code);

-- 1.3 Add Middle_Name column to Customers
ALTER TABLE Customers
ADD COLUMN Middle_Name VARCHAR(50);

-- 1.4 Create index on Accounts.Balance
CREATE INDEX idx_accounts_balance ON Accounts(Balance);

-- 1.5 Create Account_Status_History table
CREATE TABLE Account_Status_History (
  ASH_ID INT PRIMARY KEY AUTO_INCREMENT,
  Account_ID INT NOT NULL,
  Old_Status VARCHAR(20),
  New_Status VARCHAR(20),
  Changed_On DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);

-- 1.6 Add Collateral_Details column to Loans
ALTER TABLE Loans
ADD COLUMN Collateral_Details TEXT;

-- 1.7 Drop Temp_Imports table if exists
DROP TABLE IF EXISTS Temp_Imports;

-- 1.8 Create Tags and Transaction_Tags tables
CREATE TABLE Tags (
  Tag_ID INT PRIMARY KEY AUTO_INCREMENT,
  Tag_Name VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE Transaction_Tags (
  Transaction_ID INT NOT NULL,
  Tag_ID INT NOT NULL,
  PRIMARY KEY (Transaction_ID, Tag_ID),
  FOREIGN KEY (Transaction_ID) REFERENCES Transactions(Transaction_ID),
  FOREIGN KEY (Tag_ID) REFERENCES Tags(Tag_ID)
);

-- 1.9 Modify Last_Updated column in Credit_Scores
ALTER TABLE Credit_Scores
MODIFY Last_Updated DATE NOT NULL DEFAULT CURRENT_DATE;

-- 1.10 Create Monthly_Statements table
CREATE TABLE Monthly_Statements (
  Statement_ID INT PRIMARY KEY AUTO_INCREMENT,
  Account_ID INT NOT NULL,
  Snapshot_Date DATE NOT NULL,
  Opening_Balance DECIMAL(12,2),
  Closing_Balance DECIMAL(12,2),
  Total_Credits DECIMAL(12,2),
  Total_Debits DECIMAL(12,2),
  FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);

/* ========================
   2) DML QUERIES (10)
   ======================== */

-- 2.1 Insert a new customer
INSERT INTO Customers (First_Name, Middle_Name, Last_Name, Gender, DOB, Aadhaar_Number, PAN_Number, Mobile_Number, Email, Address)
VALUES ('Arnav', NULL, 'Kumar', 'Male', '1995-11-12', '111122223333', 'ABCPR1234L', '9876501234', 'arnav.kumar@example.com', '12, MG Road, Pune-411001');

-- 2.2 Insert two new branches
INSERT INTO Branches (Branch_Name, IFSC_Code, MICR_Code, Address, City, State, Pincode, Contact_Number, Manager_Name)
VALUES
('Pune Branch', 'HDFC0PUNE01', '123456789', '45, FC Road, Pune', 'Pune', 'Maharashtra', '411001', '0201234567', 'Ramesh Patil'),
('Hyderabad Branch', 'HDFC0HYD02', '987654321', '10, Banjara Hills', 'Hyderabad', 'Telangana', '500034', '0407654321', 'Sita Reddy');

-- 2.3 Update account balance
UPDATE Accounts
SET Balance = Balance + 15000.00
WHERE Account_ID = 3;

-- 2.4 Block card after suspicious activity
UPDATE Cards
SET Status = 'Blocked'
WHERE Card_ID = 9;

-- 2.5 Delete inactive beneficiary
DELETE FROM Beneficiaries
WHERE Beneficiary_ID = 3 AND Status = 'Inactive';

-- 2.6 Insert a debit transaction
INSERT INTO Transactions (Account_ID, Transaction_Type, Amount, Transaction_Date, Mode, Description, Balance_After, Reference_No, Branch_ID)
VALUES (5, 'Debit', 2500.00, NOW(), 'UPI', 'Bill payment', (SELECT Balance - 2500.00 FROM Accounts WHERE Account_ID = 5), 'REF-BILL-001', 1);

-- 2.7 Update IFSC for accounts in branch 2
UPDATE Accounts
SET IFSC_Code = 'HDFC0NEWIFC'
WHERE Branch_ID = 2;

-- 2.8 Insert service request
INSERT INTO Service_Requests (Customer_ID, Request_Type, Request_Date, Status, Handled_By, Priority, Branch_ID, Remarks)
VALUES (1, 'Account Statement', CURRENT_DATE, 'Pending', NULL, 'Low', 1, 'Customer requested last 6 months statement');

-- 2.9 Approve loan and set EMI
UPDATE Loans
SET Status = 'Approved', EMI_Amount = 10600.00
WHERE Loan_ID = 3;

-- 2.10 Update locker status to Vacant
UPDATE Lockers
SET Status = 'Vacant', Last_Accessed = NULL
WHERE Locker_ID = 11;

/* ========================
   3) DQL QUERIES (10)
   ======================== */

-- 3.1 Active accounts with balance > 100k
SELECT Account_ID, Customer_ID, Balance
FROM Accounts
WHERE Status = 'Active' AND Balance > 100000
ORDER BY Balance DESC;

-- 3.2 Customers per city
SELECT b.City, COUNT(DISTINCT a.Customer_ID) AS Customer_Count
FROM Accounts a
JOIN Branches b ON a.Branch_ID = b.Branch_ID
GROUP BY b.City
ORDER BY Customer_Count DESC;

-- 3.3 FD amount per branch
SELECT fd.Branch_ID, SUM(fd.Deposit_Amount) AS Total_FD
FROM Fixed_Deposits fd
GROUP BY fd.Branch_ID;

-- 3.4 Last 10 transactions
SELECT * FROM Transactions
ORDER BY Transaction_Date DESC
LIMIT 10;

-- 3.5 Top employees by salary
SELECT Employee_ID, First_Name, Last_Name, Salary
FROM Employees
ORDER BY Salary DESC;

-- 3.6 Loan counts by status
SELECT Status, COUNT(*) AS CountLoans
FROM Loans
GROUP BY Status;

-- 3.7 Average balance by account type
SELECT Account_Type, AVG(Balance) AS Avg_Balance
FROM Accounts
GROUP BY Account_Type;

-- 3.8 Customers without active accounts
SELECT c.Customer_ID, c.First_Name, c.Last_Name
FROM Customers c
LEFT JOIN Accounts a ON c.Customer_ID = a.Customer_ID AND a.Status = 'Active'
WHERE a.Account_ID IS NULL;

-- 3.9 Branches with no ATMs
SELECT b.Branch_ID, b.Branch_Name
FROM Branches b
LEFT JOIN ATMs atm ON b.Branch_ID = atm.Branch_ID AND atm.Status = 'Operational'
GROUP BY b.Branch_ID, b.Branch_Name
HAVING COUNT(atm.ATM_ID) = 0;

-- 3.10 Number of cards per customer
SELECT c.Customer_ID, c.First_Name, c.Last_Name, COUNT(cd.Card_ID) AS Cards_Count
FROM Customers c
LEFT JOIN Cards cd ON c.Customer_ID = cd.Customer_ID
GROUP BY c.Customer_ID, c.First_Name, c.Last_Name
ORDER BY Cards_Count DESC;

/* ========================
   4) CLAUSES & OPERATORS (10)
   ======================== */

-- 4.1 Accounts opened in 2021–22
SELECT Account_ID, Opening_Date
FROM Accounts
WHERE Opening_Date BETWEEN '2021-01-01' AND '2022-12-31';

-- 4.2 Customers with last name starting 'Ch'
SELECT Customer_ID, First_Name, Last_Name
FROM Customers
WHERE Last_Name LIKE 'Ch%';

-- 4.3 Accounts in branches 1,2,3
SELECT Account_ID, Branch_ID
FROM Accounts
WHERE Branch_ID IN (1,2,3);

-- 4.4 Accounts inactive or not closed
SELECT Account_ID, Status
FROM Accounts
WHERE Status = 'Inactive' OR NOT (Status = 'Closed');

-- 4.5 Accounts balance > ANY in branch 5
SELECT Account_ID, Balance
FROM Accounts
WHERE Balance > ANY (SELECT Balance FROM Accounts WHERE Branch_ID = 5);

-- 4.6 Accounts balance > ALL in branch 2
SELECT Account_ID, Balance
FROM Accounts
WHERE Balance > ALL (SELECT Balance FROM Accounts WHERE Branch_ID = 2);

-- 4.7 Mobile starting 98 AND PAN starts A/B
SELECT Customer_ID, First_Name, PAN_Number, Mobile_Number
FROM Customers
WHERE Mobile_Number LIKE '98%' AND (PAN_Number LIKE 'A%' OR PAN_Number LIKE 'B%');

-- 4.8 Pending unassigned service requests
SELECT Request_ID, Request_Type
FROM Service_Requests
WHERE Status = 'Pending' AND Handled_By IS NULL;

-- 4.9 Customers with FD > 5 lakh
SELECT c.Customer_ID, c.First_Name
FROM Customers c
WHERE EXISTS (SELECT 1 FROM Fixed_Deposits fd WHERE fd.Customer_ID = c.Customer_ID AND fd.Deposit_Amount > 500000);

-- 4.10 Customers with gmail accounts
SELECT Customer_ID, Email
FROM Customers
WHERE Email LIKE '%@gmail.com';

/* ========================
   5) CONSTRAINTS & CASCADES (10)
   ======================== */

-- 5.1 Create Customer_Addresses with ON DELETE CASCADE
CREATE TABLE Customer_Addresses (
  Addr_ID INT PRIMARY KEY AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  Address_Line TEXT,
  City VARCHAR(50),
  State VARCHAR(50),
  Pincode CHAR(6),
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE CASCADE
);

-- 5.2 Add FK Accounts.IFSC_Code -> Branches.IFSC_Code
ALTER TABLE Accounts
ADD CONSTRAINT fk_accounts_ifsc FOREIGN KEY (IFSC_Code) REFERENCES Branches(IFSC_Code)
ON UPDATE CASCADE ON DELETE SET NULL;

-- 5.3 Add check constraint on Cheques amount
ALTER TABLE Cheques
ADD CONSTRAINT chk_cheques_amount CHECK (Amount > 0);

-- 5.4 Unique Customer+Account_Type
ALTER TABLE Accounts
ADD CONSTRAINT uq_customer_accounttype UNIQUE (Customer_ID, Account_Type);

-- 5.5 Add Manager_ID in Employees with FK
ALTER TABLE Employees
ADD COLUMN Manager_ID INT NULL,
ADD CONSTRAINT fk_employees_manager FOREIGN KEY (Manager_ID) REFERENCES Employees(Employee_ID) ON DELETE SET NULL;

-- 5.6 Create Card_Transactions ON DELETE CASCADE
CREATE TABLE Card_Transactions (
  CT_ID INT PRIMARY KEY AUTO_INCREMENT,
  Card_ID INT NOT NULL,
  Transaction_Date DATETIME,
  Amount DECIMAL(10,2),
  Merchant VARCHAR(100),
  FOREIGN KEY (Card_ID) REFERENCES Cards(Card_ID) ON DELETE CASCADE
);

-- 5.7 Make Status NOT NULL default Pending in UPI_Transactions
ALTER TABLE UPI_Transactions
MODIFY COLUMN Status VARCHAR(20) NOT NULL DEFAULT 'Pending';

-- 5.8 Composite PK already ensures unique Transaction-Tag pairs
-- (Handled in DDL)

-- 5.9 Add cascade delete for Monthly_Statements
ALTER TABLE Monthly_Statements
ADD CONSTRAINT fk_monthly_account FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID) ON DELETE CASCADE;

-- 5.10 Temporarily disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;
-- perform bulk inserts here
SET FOREIGN_KEY_CHECKS = 1;

/* ========================
   6) JOINS (10)
   ======================== */

-- 6.1 Inner join Customers–Accounts
SELECT c.Customer_ID, c.First_Name, a.Account_ID, a.Balance
FROM Customers c
INNER JOIN Accounts a ON c.Customer_ID = a.Customer_ID;

-- 6.2 Accounts with last txn (LEFT JOIN)
SELECT a.Account_ID, a.Balance, t.Transaction_Date, t.Amount
FROM Accounts a
LEFT JOIN Transactions t ON a.Account_ID = t.Account_ID
  AND t.Transaction_Date = (SELECT MAX(Transaction_Date) FROM Transactions t2 WHERE t2.Account_ID = a.Account_ID);

-- 6.3 RIGHT JOIN Branches–Accounts
SELECT b.Branch_ID, b.Branch_Name, a.Account_ID
FROM Accounts a
RIGHT JOIN Branches b ON a.Branch_ID = b.Branch_ID;

-- 6.4 FULL JOIN simulated Customers–Online_Banking
SELECT c.Customer_ID, c.First_Name, ob.Username
FROM Customers c
LEFT JOIN Online_Banking ob ON c.Customer_ID = ob.Customer_ID
UNION
SELECT c.Customer_ID, c.First_Name, ob.Username
FROM Online_Banking ob
LEFT JOIN Customers c ON c.Customer_ID = ob.Customer_ID;

-- 6.5 Self join Employees (managers)
SELECT e.Employee_ID AS Emp_ID, e.First_Name AS EmpName, m.Employee_ID AS Manager_ID, m.First_Name AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.Manager_ID = m.Employee_ID;

-- 6.6 Multi-table join Loans–Customers–Branches
SELECT l.Loan_ID, l.Amount, l.Status, c.First_Name, b.Branch_Name
FROM Loans l
JOIN Customers c ON l.Customer_ID = c.Customer_ID
JOIN Branches b ON l.Branch_ID = b.Branch_ID;

-- 6.7 Join Cards–Accounts
SELECT cd.Card_ID, cd.Card_Type, a.Account_ID
FROM Cards cd
JOIN Accounts a ON cd.Customer_ID = a.Customer_ID;

-- 6.8 Safe deposit visits with lockers & employees
SELECT sv.Visit_ID, sv.Visit_Date, l.Locker_ID, e.First_Name AS Verified_By
FROM Safe_Deposit_Visits sv
JOIN Lockers l ON sv.Locker_ID = l.Locker_ID
LEFT JOIN Employees e ON sv.Verified_By_Employee = e.Employee_ID;

-- 6.9 Bill payments with customer names
SELECT bp.Bill_ID, bp.Biller_Name, bp.Amount, c.First_Name, c.Last_Name
FROM Bill_Payments bp
JOIN Accounts a ON bp.Account_ID = a.Account_ID
JOIN Customers c ON a.Customer_ID = c.Customer_ID;

-- 6.10 UPI transactions with sender/receiver
SELECT u.UPI_ID, u.Amount, s.First_Name AS Sender, r.First_Name AS Receiver
FROM UPI_Transactions u
LEFT JOIN Accounts sa ON u.Linked_Account_ID = sa.Account_ID
LEFT JOIN Customers s ON sa.Customer_ID = s.Customer_ID
LEFT JOIN Accounts ra ON u.Receiver_VPA = ra.Account_Number
LEFT JOIN Customers r ON ra.Customer_ID = r.Customer_ID;

/* ========================
   7) SUBQUERIES (10)
   ======================== */

-- 7.1 Customer with max balance
SELECT c.Customer_ID, c.First_Name
FROM Customers c
WHERE c.Customer_ID = (
  SELECT a.Customer_ID FROM Accounts a ORDER BY a.Balance DESC LIMIT 1
);

-- 7.2 Accounts above branch average
SELECT a.Account_ID, a.Balance
FROM Accounts a
WHERE a.Balance > (
  SELECT AVG(a2.Balance) FROM Accounts a2 WHERE a2.Branch_ID = a.Branch_ID
);

-- 7.3 Accounts with last transaction date
SELECT a.Account_ID,
  (SELECT MAX(t.Transaction_Date) FROM Transactions t WHERE t.Account_ID = a.Account_ID) AS Last_Transaction
FROM Accounts a;

-- 7.4 Customers with bounced cheques
SELECT DISTINCT c.Customer_ID, c.First_Name
FROM Customers c
WHERE EXISTS (
  SELECT 1 FROM Cheques ch
  JOIN Accounts a ON ch.Account_ID = a.Account_ID
  WHERE a.Customer_ID = c.Customer_ID AND ch.Status = 'Bounced'
);

-- 7.5 Employees handling requests on date
SELECT DISTINCT e.Employee_ID, e.First_Name
FROM Employees e
WHERE e.Employee_ID IN (SELECT Handled_By FROM Service_Requests WHERE Request_Date = '2024-06-08');

-- 7.6 Accounts with no transactions
SELECT a.Account_ID FROM Accounts a
WHERE NOT EXISTS (SELECT 1 FROM Transactions t WHERE t.Account_ID = a.Account_ID);

-- 7.7 Highest FD per branch
SELECT fd1.*
FROM Fixed_Deposits fd1
WHERE fd1.Deposit_Amount = (
  SELECT MAX(fd2.Deposit_Amount) FROM Fixed_Deposits fd2 WHERE fd2.Branch_ID = fd1.Branch_ID
);

-- 7.8 Customers with below average credit score
SELECT c.Customer_ID, c.First_Name, cs.Credit_Score
FROM Customers c
JOIN Credit_Scores cs ON c.Customer_ID = cs.Customer_ID
WHERE cs.Credit_Score < (SELECT AVG(cs2.Credit_Score) FROM Credit_Scores cs2);

-- 7.9 Update Loan_Eligibility
UPDATE Credit_Scores
SET Loan_Eligibility = TRUE
WHERE Credit_Score > (SELECT AVG(Credit_Score) FROM Credit_Scores);

-- 7.10 Delete old service requests
DELETE FROM Service_Requests
WHERE Status = 'Completed' AND Request_Date < DATE_SUB(CURRENT_DATE, INTERVAL 3 YEAR);

/* ========================
   8) FUNCTIONS (10)
   ======================== */

-- 8.1 Sum of FD amounts
SELECT SUM(Deposit_Amount) AS Total_FDs FROM Fixed_Deposits;

-- 8.2 Avg interest rate of approved loans
SELECT AVG(Interest_Rate) AS Avg_Interest
FROM Loans
WHERE Status = 'Approved';

-- 8.3 Count active mobile banking users
SELECT COUNT(*) AS Active_Mobile_Users
FROM Mobile_Banking
WHERE App_Status = 'Active';

-- 8.4 Max & min transaction amounts
SELECT MAX(Amount) AS Max_Transaction, MIN(Amount) AS Min_Transaction FROM Transactions;

-- 8.5 Uppercase first name + length
SELECT First_Name, UPPER(First_Name) AS First_Upper, CHAR_LENGTH(First_Name) AS Len_First
FROM Customers LIMIT 10;

-- 8.6 Full name concatenation
SELECT Customer_ID,
  CONCAT(First_Name, ' ', IFNULL(Middle_Name,''), ' ', Last_Name) AS FullName
FROM Customers;

-- 8.7 Age of customers
SELECT Customer_ID, First_Name, TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age
FROM Customers;

-- 8.8 Round average balance
SELECT ROUND(AVG(Balance),2) AS Avg_Balance_Rounded
FROM Accounts;

-- 8.9 Substring of PAN number
SELECT PAN_Number, SUBSTRING(PAN_Number,1,5) AS FirstFive
FROM Customers;

-- 8.10 Replace spaces in address
SELECT Address, REPLACE(Address,' ','_') AS ModifiedAddress
FROM Customers;

/* ========================
   9) VIEWS & CTE (10)
   ======================== */

-- 9.1 Create view Active_Customers
CREATE OR REPLACE VIEW Active_Customers AS
SELECT c.Customer_ID, c.First_Name, a.Account_ID, a.Balance
FROM Customers c
JOIN Accounts a ON c.Customer_ID = a.Customer_ID
WHERE a.Status = 'Active';

-- 9.2 Select from Active_Customers
SELECT * FROM Active_Customers;

-- 9.3 View Loan_Summary
CREATE OR REPLACE VIEW Loan_Summary AS
SELECT l.Loan_ID, l.Amount, l.Status, c.First_Name, b.Branch_Name
FROM Loans l
JOIN Customers c ON l.Customer_ID = c.Customer_ID
JOIN Branches b ON l.Branch_ID = b.Branch_ID;

-- 9.4 Accounts with balance > avg via CTE
WITH AvgBalance AS (
  SELECT AVG(Balance) AS AvgBal FROM Accounts
)
SELECT a.Account_ID, a.Balance
FROM Accounts a, AvgBalance
WHERE a.Balance > AvgBalance.AvgBal;

-- 9.5 Recursive CTE Employees hierarchy
WITH RECURSIVE EmpHierarchy AS (
  SELECT Employee_ID, First_Name, Manager_ID, 1 AS Level
  FROM Employees WHERE Manager_ID IS NULL
  UNION ALL
  SELECT e.Employee_ID, e.First_Name, e.Manager_ID, eh.Level+1
  FROM Employees e
  JOIN EmpHierarchy eh ON e.Manager_ID = eh.Employee_ID
)
SELECT * FROM EmpHierarchy;

-- 9.6 View Transactions_Above10k
CREATE OR REPLACE VIEW Transactions_Above10k AS
SELECT * FROM Transactions WHERE Amount > 10000;

-- 9.7 Join view Branch_ATM_Count
CREATE OR REPLACE VIEW Branch_ATM_Count AS
SELECT b.Branch_ID, b.Branch_Name, COUNT(a.ATM_ID) AS ATM_Count
FROM Branches b
LEFT JOIN ATMs a ON b.Branch_ID = a.Branch_ID
GROUP BY b.Branch_ID, b.Branch_Name;

-- 9.8 Drop view
DROP VIEW IF EXISTS Transactions_Above10k;

-- 9.9 Customers with no cards (CTE)
WITH Cust_Cards AS (
  SELECT c.Customer_ID, COUNT(cd.Card_ID) AS CardCount
  FROM Customers c
  LEFT JOIN Cards cd ON c.Customer_ID = cd.Customer_ID
  GROUP BY c.Customer_ID
)
SELECT * FROM Cust_Cards WHERE CardCount=0;

-- 9.10 View FD_Stats
CREATE OR REPLACE VIEW FD_Stats AS
SELECT Customer_ID, COUNT(*) AS FD_Count, SUM(Deposit_Amount) AS TotalFD
FROM Fixed_Deposits
GROUP BY Customer_ID;

/* ========================
   10) STORED PROCEDURES (5)
   ======================== */

DELIMITER $$

-- 10.1 Procedure InsertTransaction
CREATE PROCEDURE InsertTransaction (
  IN p_Account_ID INT,
  IN p_Type VARCHAR(20),
  IN p_Amount DECIMAL(10,2),
  IN p_Mode VARCHAR(20)
)
BEGIN
  INSERT INTO Transactions (Account_ID, Transaction_Type, Amount, Transaction_Date, Mode, Description, Balance_After, Reference_No, Branch_ID)
  VALUES (p_Account_ID, p_Type, p_Amount, NOW(), p_Mode, 'Auto Insert', 
          (SELECT Balance FROM Accounts WHERE Account_ID=p_Account_ID)-p_Amount,
          CONCAT('REF-',UUID()), 1);
END$$

-- 10.2 Procedure UpdateAccountBalance
CREATE PROCEDURE UpdateAccountBalance (
  IN p_Account_ID INT,
  IN p_Amount DECIMAL(10,2)
)
BEGIN
  UPDATE Accounts SET Balance=Balance+p_Amount WHERE Account_ID=p_Account_ID;
END$$

-- 10.3 Procedure DeleteBeneficiary
CREATE PROCEDURE DeleteBeneficiary (IN p_Beneficiary_ID INT)
BEGIN
  DELETE FROM Beneficiaries WHERE Beneficiary_ID=p_Beneficiary_ID;
END$$

-- 10.4 Procedure GetCustomerLoans
CREATE PROCEDURE GetCustomerLoans (IN p_Customer_ID INT)
BEGIN
  SELECT * FROM Loans WHERE Customer_ID=p_Customer_ID;
END$$

-- 10.5 Procedure AddServiceRequest
CREATE PROCEDURE AddServiceRequest (
  IN p_Customer_ID INT,
  IN p_Type VARCHAR(50),
  IN p_Priority VARCHAR(10)
)
BEGIN
  INSERT INTO Service_Requests (Customer_ID, Request_Type, Request_Date, Status, Priority, Branch_ID)
  VALUES (p_Customer_ID,p_Type,CURRENT_DATE,'Pending',p_Priority,1);
END$$

DELIMITER ;

/* ========================
   11) WINDOW FUNCTIONS (5)
   ======================== */

-- 11.1 Rank accounts by balance
SELECT Account_ID, Balance, RANK() OVER (ORDER BY Balance DESC) AS RankBalance
FROM Accounts;

-- 11.2 Row number in transactions
SELECT Transaction_ID, Amount, ROW_NUMBER() OVER (ORDER BY Transaction_Date DESC) AS RowNum
FROM Transactions;

-- 11.3 Lead transaction per account
SELECT Account_ID, Transaction_Date, Amount,
       LEAD(Amount) OVER (PARTITION BY Account_ID ORDER BY Transaction_Date) AS NextTxn
FROM Transactions;

-- 11.4 Lag transaction per account
SELECT Account_ID, Transaction_Date, Amount,
       LAG(Amount) OVER (PARTITION BY Account_ID ORDER BY Transaction_Date) AS PrevTxn
FROM Transactions;

-- 11.5 Dense rank loans by amount
SELECT Loan_ID, Amount, DENSE_RANK() OVER (ORDER BY Amount DESC) AS DenseRankAmt
FROM Loans;

/* ========================
   12) TRANSACTIONS (5)
   ======================== */

-- 12.1 Start transaction
START TRANSACTION;

-- 12.2 Insert txn
INSERT INTO Transactions (Account_ID, Transaction_Type, Amount, Transaction_Date, Mode, Description, Balance_After, Reference_No, Branch_ID)
VALUES (1,'Debit',5000,NOW(),'Cash','ATM Withdrawal',(SELECT Balance-5000 FROM Accounts WHERE Account_ID=1),CONCAT('ATM-',UUID()),1);

-- 12.3 Commit
COMMIT;

-- 12.4 Transaction with rollback
START TRANSACTION;
UPDATE Accounts SET Balance=Balance-2000 WHERE Account_ID=2;
ROLLBACK;

-- 12.5 Savepoint
START TRANSACTION;
UPDATE Accounts SET Balance=Balance-1000 WHERE Account_ID=3;
SAVEPOINT sp1;
UPDATE Accounts SET Balance=Balance-500 WHERE Account_ID=3;
ROLLBACK TO sp1;
COMMIT;

/* ========================
   13) TRIGGERS (5)
   ======================== */

DELIMITER $$

-- 13.1 Trigger after insert transaction
CREATE TRIGGER trg_after_insert_txn
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
  INSERT INTO Audit_Log (Table_Name,Action_Type,Action_By,Details)
  VALUES ('Transactions','INSERT','system',CONCAT('Txn ID:',NEW.Transaction_ID));
END$$

-- 13.2 Trigger before update account
CREATE TRIGGER trg_before_update_account
BEFORE UPDATE ON Accounts
FOR EACH ROW
BEGIN
  IF NEW.Balance < 0 THEN
    SET NEW.Balance=0;
  END IF;
END$$

-- 13.3 Trigger after delete beneficiary
CREATE TRIGGER trg_after_delete_beneficiary
AFTER DELETE ON Beneficiaries
FOR EACH ROW
BEGIN
  INSERT INTO Audit_Log (Table_Name,Action_Type,Action_By,Details)
  VALUES ('Beneficiaries','DELETE','system',CONCAT('Deleted Beneficiary:',OLD.Beneficiary_ID));
END$$

-- 13.4 Trigger before insert cheque
CREATE TRIGGER trg_before_insert_cheque
BEFORE INSERT ON Cheques
FOR EACH ROW
BEGIN
  IF NEW.Amount <= 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cheque amount must be > 0';
  END IF;
END$$

-- 13.5 Trigger after update loans
CREATE TRIGGER trg_after_update_loan
AFTER UPDATE ON Loans
FOR EACH ROW
BEGIN
  INSERT INTO Audit_Log (Table_Name,Action_Type,Action_By,Details)
  VALUES ('Loans','UPDATE','system',CONCAT('Loan ',NEW.Loan_ID,' updated from ',OLD.Status,' to ',NEW.Status));
END$$

DELIMITER ;
