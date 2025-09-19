
use HDFC_Bank;

-- Phase 4 Views, Cursors, Stored Procedures, Window Functions, DCL/TCL, Triggers

-- Table 1:

-- 1. View: Customer full name with age
CREATE VIEW vw_customer_age AS
SELECT Customer_ID, CONCAT(First_Name, ' ', Last_Name) AS Full_Name,
       TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age, Gender
FROM Customers;

-- 2. View: Gmail users only
CREATE VIEW vw_gmail_users AS
SELECT Customer_ID, Full_Name, Email
FROM vw_customer_age
WHERE Email LIKE '%@gmail.com';

-- 3. Window fn: Rank customers by age
SELECT Customer_ID, Full_Name, Age,
       RANK() OVER (ORDER BY Age DESC) AS AgeRank
FROM vw_customer_age;

-- 4. Window fn: Row number by gender
SELECT Customer_ID, Full_Name, Gender, DOB,
       ROW_NUMBER() OVER (PARTITION BY Gender ORDER BY DOB ASC) AS RowNum
FROM vw_customer_age;

-- 5. Proc: Get customer by Aadhaar
DELIMITER $$
CREATE PROCEDURE GetCustomerByAadhaar(IN aadhaar CHAR(12))
BEGIN
  SELECT * FROM Customers WHERE Aadhaar_Number = aadhaar;
END$$
DELIMITER ;

-- 6. Proc: Count customers by gender
DELIMITER $$
CREATE PROCEDURE CountByGender()
BEGIN
  SELECT Gender, COUNT(*) AS Total FROM Customers GROUP BY Gender;
END$$
DELIMITER ;

-- 7. Cursor: List senior citizens
DELIMITER $$
CREATE PROCEDURE ListSeniorCitizens()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cname VARCHAR(100);
  DECLARE cur CURSOR FOR
    SELECT CONCAT(First_Name,' ',Last_Name)
    FROM Customers
    WHERE TIMESTAMPDIFF(YEAR, DOB, CURDATE()) > 60;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cname;
    IF done THEN LEAVE read_loop; END IF;
    SELECT cname AS SeniorCitizen;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. Trigger: Log email updates
CREATE TABLE Customer_Email_Log (
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Customer_ID INT,
  Old_Email VARCHAR(100),
  New_Email VARCHAR(100),
  Change_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_email_update
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
  IF OLD.Email <> NEW.Email THEN
    INSERT INTO Customer_Email_Log (Customer_ID, Old_Email, New_Email)
    VALUES (OLD.Customer_ID, OLD.Email, NEW.Email);
  END IF;
END$$
DELIMITER ;

-- 9. Trigger: Prevent duplicate Aadhaar
DELIMITER $$
CREATE TRIGGER trg_check_aadhaar
BEFORE INSERT ON Customers
FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM Customers WHERE Aadhaar_Number = NEW.Aadhaar_Number) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate Aadhaar not allowed';
  END IF;
END$$
DELIMITER ;

-- 10. Window fn: Customers with cumulative count by DOB
SELECT Customer_ID, Full_Name, DOB,
       COUNT(*) OVER (ORDER BY DOB) AS RunningTotal
FROM vw_customer_age;

-- 11. View: Customers from addresses with 'Nagar'
CREATE VIEW vw_nagar_customers AS
SELECT * FROM Customers WHERE Address LIKE '%Nagar%';

-- 12. Proc: Update mobile by PAN
DELIMITER $$
CREATE PROCEDURE UpdateMobile(IN pan CHAR(10), IN newMobile CHAR(10))
BEGIN
  UPDATE Customers SET Mobile_Number = newMobile WHERE PAN_Number = pan;
END$$
DELIMITER ;

-- 13. Cursor: Loop male customers
DELIMITER $$
CREATE PROCEDURE ListMales()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cname VARCHAR(100);
  DECLARE cur CURSOR FOR 
    SELECT CONCAT(First_Name,' ',Last_Name) FROM Customers WHERE Gender='Male';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;
  loop1: LOOP
    FETCH cur INTO cname;
    IF done THEN LEAVE loop1; END IF;
    SELECT cname AS MaleCustomer;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 14. DCL: Create user
CREATE USER 'analyst'@'localhost' IDENTIFIED BY 'Password@123';

-- 15. DCL: Grant and revoke
GRANT SELECT ON Customers TO 'analyst'@'localhost';
REVOKE UPDATE ON Customers FROM 'analyst'@'localhost';

-- 16. TCL: Insert with rollback
START TRANSACTION;
INSERT INTO Customers (First_Name, Last_Name, Gender, DOB, Aadhaar_Number, PAN_Number, Mobile_Number, Email, Address)
VALUES ('Test','User','Male','1990-01-01','111122223333','AAAAA1111A','9999999999','test@demo.com','Test Address');
ROLLBACK;

-- 17. TCL: Insert with commit
START TRANSACTION;
INSERT INTO Customers (First_Name, Last_Name, Gender, DOB, Aadhaar_Number, PAN_Number, Mobile_Number, Email, Address)
VALUES ('Commit','User','Female','1995-05-05','222233334444','BBBBB2222B','8888888888','commit@demo.com','Commit Address');
COMMIT;

-- 18. Window fn: Gender-wise average age
SELECT Gender, AVG(Age) OVER (PARTITION BY Gender) AS AvgAge
FROM vw_customer_age;

-- 19. View: PAN and Aadhaar only
CREATE VIEW vw_identity AS
SELECT Customer_ID, PAN_Number, Aadhaar_Number FROM Customers;

-- 20. Proc: Search by partial name
DELIMITER $$
CREATE PROCEDURE SearchCustomer(IN keyword VARCHAR(50))
BEGIN
  SELECT * FROM Customers
  WHERE First_Name LIKE CONCAT('%',keyword,'%')
     OR Last_Name LIKE CONCAT('%',keyword,'%');
END$$
DELIMITER ;



-- Table 2:

-- 1. view of branch with full address
CREATE VIEW vw_branch_address AS
SELECT Branch_ID, Branch_Name, CONCAT(Branch_Address, ', ', City, ', ', State, ' - ', Pincode) AS Full_Address
FROM Branches;

-- 2. view of metro city branches
CREATE VIEW vw_metro_branches AS
SELECT Branch_ID, Branch_Name, City FROM Branches
WHERE City IN ('Mumbai', 'Delhi', 'Bengaluru', 'Chennai', 'Kolkata');

-- 3. rank branches by opening year
SELECT Branch_ID, Branch_Name, Established_Year,
       RANK() OVER (ORDER BY Established_Year ASC) AS Open_Rank
FROM Branches;

-- 4. dense rank branches by manager id
SELECT Branch_ID, Branch_Name, Manager_ID,
       DENSE_RANK() OVER (ORDER BY Manager_ID) AS Manager_Rank
FROM Branches;

-- 5. procedure to fetch branch by ifsc
DELIMITER $$
CREATE PROCEDURE GetBranchByIFSC(IN ifsc CHAR(11))
BEGIN
  SELECT * FROM Branches WHERE IFSC_Code = ifsc;
END$$
DELIMITER ;

-- 6. procedure to count branches per state
DELIMITER $$
CREATE PROCEDURE CountBranchesByState()
BEGIN
  SELECT State, COUNT(*) AS Total_Branches FROM Branches GROUP BY State;
END$$
DELIMITER ;

-- 7. cursor to list all branch names in Maharashtra
DELIMITER $$
CREATE PROCEDURE ListMHBranches()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE bname VARCHAR(100);
  DECLARE cur CURSOR FOR SELECT Branch_Name FROM Branches WHERE State='Maharashtra';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO bname;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT bname AS BranchName;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to log manager changes
CREATE TABLE Branch_Manager_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Branch_ID INT,
  Old_Manager INT,
  New_Manager INT,
  Change_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_manager_update
BEFORE UPDATE ON Branches
FOR EACH ROW
BEGIN
  IF OLD.Manager_ID <> NEW.Manager_ID THEN
    INSERT INTO Branch_Manager_Log(Branch_ID, Old_Manager, New_Manager)
    VALUES (OLD.Branch_ID, OLD.Manager_ID, NEW.Manager_ID);
  END IF;
END$$
DELIMITER ;

-- 9. trigger to prevent duplicate IFSC
DELIMITER $$
CREATE TRIGGER trg_check_ifsc
BEFORE INSERT ON Branches
FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM Branches WHERE IFSC_Code = NEW.IFSC_Code) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate IFSC not allowed';
  END IF;
END$$
DELIMITER ;

-- 10. user creation
CREATE USER 'branchuser'@'localhost' IDENTIFIED BY 'password123';

-- 11. grant select on branches
GRANT SELECT ON Branches TO 'branchuser'@'localhost';

-- 12. revoke select from branches
REVOKE SELECT ON Branches FROM 'branchuser'@'localhost';

-- 13. commit transaction
START TRANSACTION;
UPDATE Branches SET Branch_Phone='0221234567' WHERE Branch_ID=201;
COMMIT;

-- 14. rollback transaction
START TRANSACTION;
UPDATE Branches SET Branch_Phone='9999999999' WHERE Branch_ID=202;
ROLLBACK;

-- 15. top 3 oldest branches
SELECT Branch_ID, Branch_Name, Established_Year
FROM Branches
ORDER BY Established_Year ASC LIMIT 3;

-- 16. branches per city with row_number
SELECT Branch_ID, Branch_Name, City,
       ROW_NUMBER() OVER (PARTITION BY City ORDER BY Branch_Name) AS RowNum
FROM Branches;

-- 17. view of ifsc codes with branch names
CREATE VIEW vw_branch_ifsc AS
SELECT Branch_Name, IFSC_Code FROM Branches;

-- 18. procedure to get branches by state name
DELIMITER $$
CREATE PROCEDURE GetBranchesByState(IN st VARCHAR(50))
BEGIN
  SELECT Branch_ID, Branch_Name, City FROM Branches WHERE State = st;
END$$
DELIMITER ;

-- 19. cursor to display all ifsc codes
DELIMITER $$
CREATE PROCEDURE ListIFSC()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE code CHAR(11);
  DECLARE cur CURSOR FOR SELECT IFSC_Code FROM Branches;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO code;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT code AS IFSC;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count branches in each state using window function
SELECT State, COUNT(*) OVER(PARTITION BY State) AS State_Count, Branch_Name
FROM Branches;


-- Table 3:

-- 1. view of accounts with masked account number
CREATE VIEW vw_account_masked AS
SELECT Account_ID, Customer_ID, Branch_ID, Account_Type,
       CONCAT('XXXXXX', RIGHT(Account_Number, 4)) AS Masked_Acc_No,
       Balance, Status
FROM Accounts;

-- 2. view of active accounts only
CREATE VIEW vw_active_accounts AS
SELECT Account_ID, Account_Type, Balance, IFSC_Code
FROM Accounts
WHERE Status = 'Active';

-- 3. rank accounts by balance
SELECT Account_ID, Account_Type, Balance,
       RANK() OVER (ORDER BY Balance DESC) AS Balance_Rank
FROM Accounts;

-- 4. row number partition by account type
SELECT Account_ID, Account_Type, Balance,
       ROW_NUMBER() OVER (PARTITION BY Account_Type ORDER BY Balance DESC) AS RowNum
FROM Accounts;

-- 5. procedure to fetch account by number
DELIMITER $$
CREATE PROCEDURE GetAccountByNumber(IN acc CHAR(14))
BEGIN
  SELECT * FROM Accounts WHERE Account_Number = acc;
END$$
DELIMITER ;

-- 6. procedure to count accounts per type
DELIMITER $$
CREATE PROCEDURE CountAccountsByType()
BEGIN
  SELECT Account_Type, COUNT(*) AS Total FROM Accounts GROUP BY Account_Type;
END$$
DELIMITER ;

-- 7. cursor to list all closed accounts
DELIMITER $$
CREATE PROCEDURE ListClosedAccounts()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE acc CHAR(14);
  DECLARE cur CURSOR FOR SELECT Account_Number FROM Accounts WHERE Status='Closed';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO acc;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT acc AS ClosedAccount;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to log balance updates
CREATE TABLE Account_Balance_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Account_ID INT,
  Old_Balance DECIMAL(12,2),
  New_Balance DECIMAL(12,2),
  Change_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_balance_update
BEFORE UPDATE ON Accounts
FOR EACH ROW
BEGIN
  IF OLD.Balance <> NEW.Balance THEN
    INSERT INTO Account_Balance_Log(Account_ID, Old_Balance, New_Balance)
    VALUES (OLD.Account_ID, OLD.Balance, NEW.Balance);
  END IF;
END$$
DELIMITER ;

-- 9. trigger to prevent negative balance
DELIMITER $$
CREATE TRIGGER trg_check_balance
BEFORE UPDATE ON Accounts
FOR EACH ROW
BEGIN
  IF NEW.Balance < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Balance cannot be negative';
  END IF;
END$$
DELIMITER ;

-- 10. user creation
CREATE USER 'accuser'@'localhost' IDENTIFIED BY 'password123';

-- 11. grant select on accounts
GRANT SELECT ON Accounts TO 'accuser'@'localhost';

-- 12. revoke select on accounts
REVOKE SELECT ON Accounts FROM 'accuser'@'localhost';

-- 13. commit transaction
START TRANSACTION;
UPDATE Accounts SET Balance = Balance + 5000 WHERE Account_ID=301;
COMMIT;

-- 14. rollback transaction
START TRANSACTION;
UPDATE Accounts SET Balance = Balance - 10000 WHERE Account_ID=302;
ROLLBACK;

-- 15. top 5 highest balances
SELECT Account_ID, Account_Type, Balance
FROM Accounts
ORDER BY Balance DESC LIMIT 5;

-- 16. count accounts in each status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, Account_ID
FROM Accounts;

-- 17. view of nominee details
CREATE VIEW vw_account_nominee AS
SELECT Account_ID, Account_Type, Nominee_Name FROM Accounts;

-- 18. procedure to get accounts by branch
DELIMITER $$
CREATE PROCEDURE GetAccountsByBranch(IN bid INT)
BEGIN
  SELECT Account_ID, Account_Type, Balance FROM Accounts WHERE Branch_ID = bid;
END$$
DELIMITER ;

-- 19. cursor to display all IFSC codes
DELIMITER $$
CREATE PROCEDURE ListAccountIFSC()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE code CHAR(11);
  DECLARE cur CURSOR FOR SELECT IFSC_Code FROM Accounts;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO code;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT code AS IFSC;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. accounts opened in last 2 years
SELECT Account_ID, Account_Number, Opening_Date
FROM Accounts
WHERE Opening_Date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);


-- Table 4:

-- 1. view of debit transactions only
CREATE VIEW vw_debit_transactions AS
SELECT Transaction_ID, Account_ID, Amount, Transaction_Date, Mode
FROM Transactions
WHERE Transaction_Type = 'Debit';

-- 2. view of high-value credits
CREATE VIEW vw_high_value_credits AS
SELECT Transaction_ID, Account_ID, Amount, Transaction_Date
FROM Transactions
WHERE Transaction_Type = 'Credit' AND Amount > 50000;

-- 3. rank transactions by amount
SELECT Transaction_ID, Account_ID, Amount,
       RANK() OVER (ORDER BY Amount DESC) AS RankByAmount
FROM Transactions;

-- 4. running balance for each account
SELECT Account_ID, Transaction_ID, Amount,
       SUM(CASE WHEN Transaction_Type='Credit' THEN Amount ELSE -Amount END)
       OVER (PARTITION BY Account_ID ORDER BY Transaction_Date) AS Running_Balance
FROM Transactions;

-- 5. procedure to fetch transactions by account
DELIMITER $$
CREATE PROCEDURE GetTransactionsByAccount(IN accid INT)
BEGIN
  SELECT * FROM Transactions WHERE Account_ID = accid;
END$$
DELIMITER ;

-- 6. procedure to get total debits and credits
DELIMITER $$
CREATE PROCEDURE GetDebitCreditSummary()
BEGIN
  SELECT Transaction_Type, SUM(Amount) AS Total
  FROM Transactions
  GROUP BY Transaction_Type;
END$$
DELIMITER ;

-- 7. cursor to list NEFT transactions
DELIMITER $$
CREATE PROCEDURE ListNEFTTransactions()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE tid INT;
  DECLARE cur CURSOR FOR SELECT Transaction_ID FROM Transactions WHERE Mode='NEFT';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO tid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT tid AS NEFT_Transaction;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to update account balance after transaction
DELIMITER $$
CREATE TRIGGER trg_update_balance
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
  IF NEW.Transaction_Type = 'Credit' THEN
    UPDATE Accounts SET Balance = Balance + NEW.Amount WHERE Account_ID = NEW.Account_ID;
  ELSE
    UPDATE Accounts SET Balance = Balance - NEW.Amount WHERE Account_ID = NEW.Account_ID;
  END IF;
END$$
DELIMITER ;

-- 9. trigger to prevent debit exceeding balance
DELIMITER $$
CREATE TRIGGER trg_prevent_overdraft
BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
  DECLARE curr_balance DECIMAL(12,2);
  SELECT Balance INTO curr_balance FROM Accounts WHERE Account_ID = NEW.Account_ID;
  IF NEW.Transaction_Type='Debit' AND NEW.Amount > curr_balance THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Insufficient Balance';
  END IF;
END$$
DELIMITER ;

-- 10. create user
CREATE USER 'txnuser'@'localhost' IDENTIFIED BY 'password123';

-- 11. grant select on transactions
GRANT SELECT ON Transactions TO 'txnuser'@'localhost';

-- 12. revoke select on transactions
REVOKE SELECT ON Transactions FROM 'txnuser'@'localhost';

-- 13. commit example
START TRANSACTION;
INSERT INTO Transactions (Account_ID, Transaction_Type, Amount, Transaction_Date, Mode, Description, Balance_After, Reference_No, Branch_ID)
VALUES (3, 'Credit', 10000, NOW(), 'Cash', 'Test commit txn', 422236.59, 'COMMIT001', 2);
COMMIT;

-- 14. rollback example
START TRANSACTION;
INSERT INTO Transactions (Account_ID, Transaction_Type, Amount, Transaction_Date, Mode, Description, Balance_After, Reference_No, Branch_ID)
VALUES (3, 'Debit', 20000, NOW(), 'Cash', 'Test rollback txn', 402236.59, 'ROLLB001', 2);
ROLLBACK;

-- 15. top 5 largest debits
SELECT Transaction_ID, Account_ID, Amount, Transaction_Date
FROM Transactions
WHERE Transaction_Type='Debit'
ORDER BY Amount DESC LIMIT 5;

-- 16. monthly total transaction amount
SELECT YEAR(Transaction_Date) AS Yr, MONTH(Transaction_Date) AS Mn,
       SUM(Amount) AS Monthly_Total
FROM Transactions
GROUP BY Yr, Mn;

-- 17. view transactions with account and branch
CREATE VIEW vw_txn_with_details AS
SELECT t.Transaction_ID, t.Transaction_Type, t.Amount, a.Account_Type, b.Branch_Name
FROM Transactions t
JOIN Accounts a ON t.Account_ID = a.Account_ID
JOIN Branches b ON t.Branch_ID = b.Branch_ID;

-- 18. procedure to get transactions by branch
DELIMITER $$
CREATE PROCEDURE GetTransactionsByBranch(IN bid INT)
BEGIN
  SELECT Transaction_ID, Account_ID, Amount, Transaction_Date
  FROM Transactions
  WHERE Branch_ID = bid;
END$$
DELIMITER ;

-- 19. cursor to display all transaction reference numbers
DELIMITER $$
CREATE PROCEDURE ListReferenceNumbers()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE ref VARCHAR(20);
  DECLARE cur CURSOR FOR SELECT Reference_No FROM Transactions;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO ref;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT ref AS RefNo;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. transactions in the last 6 months
SELECT Transaction_ID, Account_ID, Amount, Transaction_Date
FROM Transactions
WHERE Transaction_Date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);



-- Table 5:

-- 1. view of active employees
CREATE VIEW vw_active_employees AS
SELECT Employee_ID, First_Name, Last_Name, Position, Salary, DOJ
FROM Employees
WHERE Status = 'Active';

-- 2. view of high-salary employees (> 70,000)
CREATE VIEW vw_high_salary_employees AS
SELECT Employee_ID, First_Name, Last_Name, Position, Salary
FROM Employees
WHERE Salary > 70000;

-- 3. rank employees by salary
SELECT Employee_ID, First_Name, Last_Name, Salary,
       RANK() OVER (ORDER BY Salary DESC) AS RankBySalary
FROM Employees;

-- 4. running total salary by branch
SELECT Branch_ID, Employee_ID, First_Name, Salary,
       SUM(Salary) OVER (PARTITION BY Branch_ID ORDER BY DOJ) AS Running_Salary
FROM Employees;

-- 5. procedure to fetch employees by branch
DELIMITER $$
CREATE PROCEDURE GetEmployeesByBranch(IN bid INT)
BEGIN
  SELECT * FROM Employees WHERE Branch_ID = bid;
END$$
DELIMITER ;

-- 6. procedure to get salary summary by position
DELIMITER $$
CREATE PROCEDURE GetSalarySummary()
BEGIN
  SELECT Position, SUM(Salary) AS Total_Salary, AVG(Salary) AS Avg_Salary
  FROM Employees
  GROUP BY Position;
END$$
DELIMITER ;

-- 7. cursor to list Managers
DELIMITER $$
CREATE PROCEDURE ListManagers()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE eid INT;
  DECLARE cur CURSOR FOR SELECT Employee_ID FROM Employees WHERE Position='Manager';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO eid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT eid AS Manager_ID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to set default status for new employees
DELIMITER $$
CREATE TRIGGER trg_default_status
BEFORE INSERT ON Employees
FOR EACH ROW
BEGIN
  IF NEW.Status IS NULL THEN
    SET NEW.Status = 'Active';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to prevent salary below 10,000
DELIMITER $$
CREATE TRIGGER trg_min_salary
BEFORE INSERT ON Employees
FOR EACH ROW
BEGIN
  IF NEW.Salary < 10000 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Salary below minimum allowed';
  END IF;
END$$
DELIMITER ;

-- 10. create user
CREATE USER 'empuser'@'localhost' IDENTIFIED BY 'password123';

-- 11. grant select on employees
GRANT SELECT ON Employees TO 'empuser'@'localhost';

-- 12. revoke select on employees
REVOKE SELECT ON Employees FROM 'empuser'@'localhost';

-- 13. commit example
START TRANSACTION;
INSERT INTO Employees (First_Name, Last_Name, Branch_ID, Position, DOJ, Salary, Email, Contact_Number, Status)
VALUES ('Test', 'Commit', 1, 'Clerk', '2025-01-01', 30000.00, 'test.commit@hdfcbank.com', '9999999990', 'Active');
COMMIT;

-- 14. rollback example
START TRANSACTION;
INSERT INTO Employees (First_Name, Last_Name, Branch_ID, Position, DOJ, Salary, Email, Contact_Number, Status)
VALUES ('Test', 'Rollback', 2, 'Cashier', '2025-01-01', 28000.00, 'test.rollback@hdfcbank.com', '9999999991', 'Active');
ROLLBACK;

-- 15. top 5 highest paid employees
SELECT Employee_ID, First_Name, Last_Name, Position, Salary
FROM Employees
ORDER BY Salary DESC LIMIT 5;

-- 16. yearly new hires
SELECT YEAR(DOJ) AS Year, COUNT(*) AS Hires
FROM Employees
GROUP BY Year;

-- 17. view employees with branch details
CREATE VIEW vw_emp_with_branch AS
SELECT e.Employee_ID, e.First_Name, e.Last_Name, e.Position, b.Branch_Name
FROM Employees e
JOIN Branches b ON e.Branch_ID = b.Branch_ID;

-- 18. procedure to get employees by position
DELIMITER $$
CREATE PROCEDURE GetEmployeesByPosition(IN pos VARCHAR(50))
BEGIN
  SELECT Employee_ID, First_Name, Last_Name, Salary
  FROM Employees
  WHERE Position = pos;
END$$
DELIMITER ;

-- 19. cursor to display all employee emails
DELIMITER $$
CREATE PROCEDURE ListEmployeeEmails()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE em VARCHAR(100);
  DECLARE cur CURSOR FOR SELECT Email FROM Employees;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO em;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT em AS Employee_Email;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. employees joined in last 2 years
SELECT Employee_ID, First_Name, Last_Name, DOJ, Position
FROM Employees
WHERE DOJ >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);



-- Table 6:

-- 1. view of approved loans
CREATE VIEW vw_approved_loans AS
SELECT Loan_ID, Customer_ID, Loan_Type, Amount, Status
FROM Loans
WHERE Status='Approved';

-- 2. view of high-value loans (Amount > 20 lakh)
CREATE VIEW vw_high_value_loans AS
SELECT Loan_ID, Customer_ID, Loan_Type, Amount
FROM Loans
WHERE Amount > 2000000;

-- 3. rank loans by amount
SELECT Loan_ID, Customer_ID, Amount,
       RANK() OVER (ORDER BY Amount DESC) AS Loan_Rank
FROM Loans;

-- 4. dense rank loans by interest rate
SELECT Loan_ID, Customer_ID, Interest_Rate,
       DENSE_RANK() OVER (ORDER BY Interest_Rate DESC) AS Interest_Rank
FROM Loans;

-- 5. procedure to fetch loans by customer
DELIMITER $$
CREATE PROCEDURE GetLoansByCustomer(IN cid INT)
BEGIN
  SELECT * FROM Loans WHERE Customer_ID = cid;
END$$
DELIMITER ;

-- 6. procedure to count loans by type
DELIMITER $$
CREATE PROCEDURE CountLoansByType()
BEGIN
  SELECT Loan_Type, COUNT(*) AS Total_Loans FROM Loans GROUP BY Loan_Type;
END$$
DELIMITER ;

-- 7. cursor to list all pending loans
DELIMITER $$
CREATE PROCEDURE ListPendingLoans()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE lid INT;
  DECLARE cur CURSOR FOR SELECT Loan_ID FROM Loans WHERE Status='Pending';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO lid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT lid AS PendingLoanID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to prevent negative EMI
DELIMITER $$
CREATE TRIGGER trg_check_emi
BEFORE INSERT ON Loans
FOR EACH ROW
BEGIN
  IF NEW.EMI_Amount < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='EMI cannot be negative';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to update loan status to Closed if EMI = 0
DELIMITER $$
CREATE TRIGGER trg_auto_close_loan
BEFORE UPDATE ON Loans
FOR EACH ROW
BEGIN
  IF NEW.EMI_Amount = 0 THEN
    SET NEW.Status='Closed';
  END IF;
END$$
DELIMITER ;

-- 10. create user
CREATE USER 'loanuser'@'localhost' IDENTIFIED BY 'password123';

-- 11. grant select on loans
GRANT SELECT ON Loans TO 'loanuser'@'localhost';

-- 12. revoke select from loans
REVOKE SELECT ON Loans FROM 'loanuser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Loans SET EMI_Amount=25000 WHERE Loan_ID=1;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Loans SET EMI_Amount=0 WHERE Loan_ID=2;
ROLLBACK;

-- 15. top 5 largest loans
SELECT Loan_ID, Customer_ID, Amount
FROM Loans
ORDER BY Amount DESC LIMIT 5;

-- 16. loans per type with row_number
SELECT Loan_ID, Loan_Type, Amount,
       ROW_NUMBER() OVER (PARTITION BY Loan_Type ORDER BY Amount DESC) AS RowNum
FROM Loans;

-- 17. view of loans with branch info
CREATE VIEW vw_loans_branch AS
SELECT l.Loan_ID, l.Loan_Type, l.Amount, b.Branch_Name
FROM Loans l
JOIN Branches b ON l.Branch_ID = b.Branch_ID;

-- 18. procedure to get loans by branch
DELIMITER $$
CREATE PROCEDURE GetLoansByBranch(IN bid INT)
BEGIN
  SELECT Loan_ID, Customer_ID, Amount, Status
  FROM Loans
  WHERE Branch_ID = bid;
END$$
DELIMITER ;

-- 19. cursor to display all loan types
DELIMITER $$
CREATE PROCEDURE ListLoanTypes()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE ltype ENUM('Home','Personal','Car','Education','Business');
  DECLARE cur CURSOR FOR SELECT DISTINCT Loan_Type FROM Loans;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO ltype;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT ltype AS LoanType;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count loans per status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, Loan_ID
FROM Loans;


-- Table 7:

-- 1. view of active cards
CREATE VIEW vw_active_cards AS
SELECT Card_ID, Customer_ID, Card_Type, Card_Number, Status
FROM Cards
WHERE Status='Active';

-- 2. view of credit cards with high limit (>150000)
CREATE VIEW vw_high_limit_credit AS
SELECT Card_ID, Customer_ID, Card_Number, Card_Limit
FROM Cards
WHERE Card_Type='Credit' AND Card_Limit > 150000;

-- 3. rank cards by limit
SELECT Card_ID, Customer_ID, Card_Limit,
       RANK() OVER (ORDER BY Card_Limit DESC) AS Limit_Rank
FROM Cards;

-- 4. dense rank by expiry date
SELECT Card_ID, Customer_ID, Expiry_Date,
       DENSE_RANK() OVER (ORDER BY Expiry_Date ASC) AS Expiry_Rank
FROM Cards;

-- 5. procedure to fetch cards by customer
DELIMITER $$
CREATE PROCEDURE GetCardsByCustomer(IN cid INT)
BEGIN
  SELECT * FROM Cards WHERE Customer_ID = cid;
END$$
DELIMITER ;

-- 6. procedure to count cards by type
DELIMITER $$
CREATE PROCEDURE CountCardsByType()
BEGIN
  SELECT Card_Type, COUNT(*) AS Total_Cards FROM Cards GROUP BY Card_Type;
END$$
DELIMITER ;

-- 7. cursor to list all blocked cards
DELIMITER $$
CREATE PROCEDURE ListBlockedCards()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cid INT;
  DECLARE cur CURSOR FOR SELECT Card_ID FROM Cards WHERE Status='Blocked';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT cid AS BlockedCardID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to prevent duplicate card numbers
DELIMITER $$
CREATE TRIGGER trg_check_card_number
BEFORE INSERT ON Cards
FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM Cards WHERE Card_Number = NEW.Card_Number) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Duplicate Card Number not allowed';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to auto-block expired cards
DELIMITER $$
CREATE TRIGGER trg_auto_block_expired
BEFORE UPDATE ON Cards
FOR EACH ROW
BEGIN
  IF NEW.Expiry_Date < CURDATE() THEN
    SET NEW.Status='Expired';
  END IF;
END$$
DELIMITER ;

-- 10. create user
CREATE USER 'carduser'@'localhost' IDENTIFIED BY 'password123';

-- 11. grant select on cards
GRANT SELECT ON Cards TO 'carduser'@'localhost';

-- 12. revoke select from cards
REVOKE SELECT ON Cards FROM 'carduser'@'localhost';

-- 13. commit example
START TRANSACTION;
UPDATE Cards SET Card_Limit=220000 WHERE Card_ID=1;
COMMIT;

-- 14. rollback example
START TRANSACTION;
UPDATE Cards SET Card_Limit=50000 WHERE Card_ID=2;
ROLLBACK;

-- 15. top 5 cards with highest limit
SELECT Card_ID, Customer_ID, Card_Limit
FROM Cards
ORDER BY Card_Limit DESC LIMIT 5;

-- 16. cards per branch with row_number
SELECT Card_ID, Branch_ID, Card_Type,
       ROW_NUMBER() OVER (PARTITION BY Branch_ID ORDER BY Card_ID) AS RowNum
FROM Cards;

-- 17. view of cards with customer and branch info
CREATE VIEW vw_cards_details AS
SELECT c.Card_ID, c.Card_Type, c.Card_Number, b.Branch_Name
FROM Cards c
JOIN Branches b ON c.Branch_ID = b.Branch_ID;

-- 18. procedure to get cards by branch
DELIMITER $$
CREATE PROCEDURE GetCardsByBranch(IN bid INT)
BEGIN
  SELECT Card_ID, Customer_ID, Card_Type, Status
  FROM Cards
  WHERE Branch_ID = bid;
END$$
DELIMITER ;

-- 19. cursor to display all card types
DELIMITER $$
CREATE PROCEDURE ListCardTypes()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE ctype ENUM('Debit','Credit');
  DECLARE cur CURSOR FOR SELECT DISTINCT Card_Type FROM Cards;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO ctype;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT ctype AS CardType;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count cards per status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, Card_ID
FROM Cards;


-- Table 8:

-- 1. view of operational ATMs
CREATE VIEW vw_operational_atms AS
SELECT ATM_ID, Branch_ID, Location, Status
FROM ATMs
WHERE Status='Operational';

-- 2. view of on-site ATMs with cash > 2000000
CREATE VIEW vw_high_cash_onsite AS
SELECT ATM_ID, Branch_ID, Cash_Available
FROM ATMs
WHERE Type='On-site' AND Cash_Available > 2000000;

-- 3. rank ATMs by cash available
SELECT ATM_ID, Branch_ID, Cash_Available,
       RANK() OVER (ORDER BY Cash_Available DESC) AS Cash_Rank
FROM ATMs;

-- 4. dense rank ATMs by installed date
SELECT ATM_ID, Branch_ID, Installed_Date,
       DENSE_RANK() OVER (ORDER BY Installed_Date ASC) AS Install_Rank
FROM ATMs;

-- 5. procedure to fetch ATMs by city
DELIMITER $$
CREATE PROCEDURE GetATMsByCity(IN ccity VARCHAR(50))
BEGIN
  SELECT * FROM ATMs WHERE City = ccity;
END$$
DELIMITER ;

-- 6. procedure to count ATMs per state
DELIMITER $$
CREATE PROCEDURE CountATMsByState()
BEGIN
  SELECT State, COUNT(*) AS Total_ATMs FROM ATMs GROUP BY State;
END$$
DELIMITER ;

-- 7. cursor to list all ATMs under maintenance
DELIMITER $$
CREATE PROCEDURE ListMaintenanceATMs()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE aid INT;
  DECLARE cur CURSOR FOR SELECT ATM_ID FROM ATMs WHERE Status='Under Maintenance';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO aid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT aid AS ATM_Under_Maintenance;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to prevent duplicate ATM location in same branch
DELIMITER $$
CREATE TRIGGER trg_check_atm_location
BEFORE INSERT ON ATMs
FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM ATMs WHERE Branch_ID = NEW.Branch_ID AND Location = NEW.Location) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Duplicate ATM location in the same branch not allowed';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to set cash to 0 if ATM is out of service
DELIMITER $$
CREATE TRIGGER trg_cash_zero
BEFORE UPDATE ON ATMs
FOR EACH ROW
BEGIN
  IF NEW.Status='Out of Service' THEN
    SET NEW.Cash_Available=0;
  END IF;
END$$
DELIMITER ;

-- 10. create user
CREATE USER 'atmuser'@'localhost' IDENTIFIED BY 'password123';

-- 11. grant select on ATMs
GRANT SELECT ON ATMs TO 'atmuser'@'localhost';

-- 12. revoke select from ATMs
REVOKE SELECT ON ATMs FROM 'atmuser'@'localhost';

-- 13. commit example
START TRANSACTION;
UPDATE ATMs SET Cash_Available=2600000 WHERE ATM_ID=1;
COMMIT;

-- 14. rollback example
START TRANSACTION;
UPDATE ATMs SET Cash_Available=100000 WHERE ATM_ID=2;
ROLLBACK;

-- 15. top 5 ATMs with highest cash
SELECT ATM_ID, Branch_ID, Cash_Available
FROM ATMs
ORDER BY Cash_Available DESC LIMIT 5;

-- 16. ATMs per branch with row_number
SELECT ATM_ID, Branch_ID, Type,
       ROW_NUMBER() OVER (PARTITION BY Branch_ID ORDER BY ATM_ID) AS RowNum
FROM ATMs;

-- 17. view of ATMs with branch and city info
CREATE VIEW vw_atm_details AS
SELECT a.ATM_ID, a.Location, a.Status, b.Branch_Name, a.City
FROM ATMs a
JOIN Branches b ON a.Branch_ID = b.Branch_ID;

-- 18. procedure to get ATMs by branch
DELIMITER $$
CREATE PROCEDURE GetATMsByBranch(IN bid INT)
BEGIN
  SELECT ATM_ID, Location, Status FROM ATMs WHERE Branch_ID = bid;
END$$
DELIMITER ;

-- 19. cursor to display all ATM types
DELIMITER $$
CREATE PROCEDURE ListATMTypes()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE atype ENUM('On-site','Off-site');
  DECLARE cur CURSOR FOR SELECT DISTINCT Type FROM ATMs;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO atype;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT atype AS ATMType;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count ATMs per status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, ATM_ID
FROM ATMs;



-- Table 9:

-- 1. view of cleared cheques
CREATE VIEW vw_cleared_cheques AS
SELECT Cheque_ID, Account_ID, Amount, Status
FROM Cheques
WHERE Status='Cleared';

-- 2. view of high-value cheques (>50000)
CREATE VIEW vw_high_value_cheques AS
SELECT Cheque_ID, Account_ID, Amount, Payee_Name
FROM Cheques
WHERE Amount > 50000;

-- 3. rank cheques by amount
SELECT Cheque_ID, Account_ID, Amount,
       RANK() OVER (ORDER BY Amount DESC) AS Amount_Rank
FROM Cheques;

-- 4. dense rank cheques by issue date
SELECT Cheque_ID, Account_ID, Issue_Date,
       DENSE_RANK() OVER (ORDER BY Issue_Date ASC) AS Issue_Rank
FROM Cheques;

-- 5. procedure to fetch cheques by account
DELIMITER $$
CREATE PROCEDURE GetChequesByAccount(IN accid INT)
BEGIN
  SELECT * FROM Cheques WHERE Account_ID = accid;
END$$
DELIMITER ;

-- 6. procedure to count cheques per status
DELIMITER $$
CREATE PROCEDURE CountChequesByStatus()
BEGIN
  SELECT Status, COUNT(*) AS Total_Cheques FROM Cheques GROUP BY Status;
END$$
DELIMITER ;

-- 7. cursor to list all bounced cheques
DELIMITER $$
CREATE PROCEDURE ListBouncedCheques()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cid INT;
  DECLARE cur CURSOR FOR SELECT Cheque_ID FROM Cheques WHERE Status='Bounced';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT cid AS BouncedCheque;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to prevent duplicate cheque numbers
DELIMITER $$
CREATE TRIGGER trg_check_cheque_number
BEFORE INSERT ON Cheques
FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM Cheques WHERE Cheque_Number = NEW.Cheque_Number) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Duplicate Cheque Number not allowed';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to auto-set remarks if amount > 100000
DELIMITER $$
CREATE TRIGGER trg_high_value_remark
BEFORE INSERT ON Cheques
FOR EACH ROW
BEGIN
  IF NEW.Amount > 100000 THEN
    SET NEW.Remarks = CONCAT('High Value Payment to ', NEW.Payee_Name);
  END IF;
END$$
DELIMITER ;

-- 10. create user
CREATE USER 'chequeuser'@'localhost' IDENTIFIED BY 'password123';

-- 11. grant select on Cheques
GRANT SELECT ON Cheques TO 'chequeuser'@'localhost';

-- 12. revoke select from Cheques
REVOKE SELECT ON Cheques FROM 'chequeuser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Cheques SET Status='Cleared' WHERE Cheque_ID=2;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Cheques SET Status='Bounced' WHERE Cheque_ID=3;
ROLLBACK;

-- 15. top 5 highest amount cheques
SELECT Cheque_ID, Account_ID, Amount, Payee_Name
FROM Cheques
ORDER BY Amount DESC LIMIT 5;

-- 16. cheques per account with row_number
SELECT Cheque_ID, Account_ID, Status,
       ROW_NUMBER() OVER (PARTITION BY Account_ID ORDER BY Issue_Date) AS RowNum
FROM Cheques;

-- 17. view of cheque with branch and account
CREATE VIEW vw_cheque_details AS
SELECT c.Cheque_ID, c.Amount, c.Status, a.Account_Type, b.Branch_Name
FROM Cheques c
JOIN Accounts a ON c.Account_ID = a.Account_ID
JOIN Branches b ON c.Branch_ID = b.Branch_ID;

-- 18. procedure to get cheques by branch
DELIMITER $$
CREATE PROCEDURE GetChequesByBranch(IN bid INT)
BEGIN
  SELECT Cheque_ID, Account_ID, Amount, Status FROM Cheques WHERE Branch_ID = bid;
END$$
DELIMITER ;

-- 19. cursor to display all cheque payee names
DELIMITER $$
CREATE PROCEDURE ListChequePayees()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE pname VARCHAR(100);
  DECLARE cur CURSOR FOR SELECT Payee_Name FROM Cheques;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO pname;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT pname AS Payee;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count cheques per status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, Cheque_ID
FROM Cheques;



-- Table 10:

-- 1. view of active fixed deposits
CREATE VIEW vw_active_fds AS
SELECT FD_ID, Customer_ID, Deposit_Amount, Status
FROM Fixed_Deposits
WHERE Status='Active';

-- 2. view of matured fixed deposits
CREATE VIEW vw_matured_fds AS
SELECT FD_ID, Customer_ID, Deposit_Amount, Maturity_Date
FROM Fixed_Deposits
WHERE Status='Matured';

-- 3. rank FDs by deposit amount
SELECT FD_ID, Customer_ID, Deposit_Amount,
       RANK() OVER (ORDER BY Deposit_Amount DESC) AS Deposit_Rank
FROM Fixed_Deposits;

-- 4. dense rank FDs by start date
SELECT FD_ID, Customer_ID, Start_Date,
       DENSE_RANK() OVER (ORDER BY Start_Date ASC) AS Start_Rank
FROM Fixed_Deposits;

-- 5. procedure to fetch FDs by customer
DELIMITER $$
CREATE PROCEDURE GetFDsByCustomer(IN custid INT)
BEGIN
  SELECT * FROM Fixed_Deposits WHERE Customer_ID = custid;
END$$
DELIMITER ;

-- 6. procedure to count FDs per status
DELIMITER $$
CREATE PROCEDURE CountFDsByStatus()
BEGIN
  SELECT Status, COUNT(*) AS Total_FDs FROM Fixed_Deposits GROUP BY Status;
END$$
DELIMITER ;

-- 7. cursor to list all active FDs
DELIMITER $$
CREATE PROCEDURE ListActiveFDs()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE fid INT;
  DECLARE cur CURSOR FOR SELECT FD_ID FROM Fixed_Deposits WHERE Status='Active';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO fid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT fid AS ActiveFD;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to prevent duplicate FD IDs is handled by primary key automatically

-- 9. trigger to auto-set nominee if NULL
DELIMITER $$
CREATE TRIGGER trg_set_nominee
BEFORE INSERT ON Fixed_Deposits
FOR EACH ROW
BEGIN
  IF NEW.Nominee_Name IS NULL THEN
    SET NEW.Nominee_Name = 'Not Assigned';
  END IF;
END$$
DELIMITER ;

-- 10. create user
CREATE USER 'fduser'@'localhost' IDENTIFIED BY 'password123';

-- 11. grant select on Fixed_Deposits
GRANT SELECT ON Fixed_Deposits TO 'fduser'@'localhost';

-- 12. revoke select from Fixed_Deposits
REVOKE SELECT ON Fixed_Deposits FROM 'fduser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Fixed_Deposits SET Status='Matured' WHERE FD_ID=2;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Fixed_Deposits SET Status='Closed' WHERE FD_ID=3;
ROLLBACK;

-- 15. top 5 largest deposits
SELECT FD_ID, Customer_ID, Deposit_Amount
FROM Fixed_Deposits
ORDER BY Deposit_Amount DESC LIMIT 5;

-- 16. FDs per branch with row_number
SELECT FD_ID, Branch_ID, Status,
       ROW_NUMBER() OVER (PARTITION BY Branch_ID ORDER BY Deposit_Amount DESC) AS RowNum
FROM Fixed_Deposits;

-- 17. view of FDs with customer and branch info
CREATE VIEW vw_fd_details AS
SELECT f.FD_ID, f.Deposit_Amount, f.Status, c.Customer_Name, b.Branch_Name
FROM Fixed_Deposits f
JOIN Customers c ON f.Customer_ID = c.Customer_ID
JOIN Branches b ON f.Branch_ID = b.Branch_ID;

-- 18. procedure to get FDs by branch
DELIMITER $$
CREATE PROCEDURE GetFDsByBranch(IN bid INT)
BEGIN
  SELECT FD_ID, Customer_ID, Deposit_Amount, Status FROM Fixed_Deposits WHERE Branch_ID = bid;
END$$
DELIMITER ;

-- 19. cursor to display all FD nominees
DELIMITER $$
CREATE PROCEDURE ListFDNominees()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE nname VARCHAR(100);
  DECLARE cur CURSOR FOR SELECT Nominee_Name FROM Fixed_Deposits;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO nname;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT nname AS Nominee;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count FDs per status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, FD_ID
FROM Fixed_Deposits;



-- Table 11:

-- 1. view of active online banking users
CREATE VIEW vw_active_users AS
SELECT Login_ID, Customer_ID, Username, Login_Status
FROM Online_Banking
WHERE Login_Status='Active';

-- 2. view of blocked online banking users
CREATE VIEW vw_blocked_users AS
SELECT Login_ID, Customer_ID, Username, Last_Login
FROM Online_Banking
WHERE Login_Status='Blocked';

-- 3. rank users by last login date
SELECT Login_ID, Username, Last_Login,
       RANK() OVER (ORDER BY Last_Login DESC) AS Login_Rank
FROM Online_Banking;

-- 4. dense rank users by customer ID
SELECT Login_ID, Username, Customer_ID,
       DENSE_RANK() OVER (ORDER BY Customer_ID) AS Customer_Rank
FROM Online_Banking;

-- 5. procedure to fetch user by username
DELIMITER $$
CREATE PROCEDURE GetUserByUsername(IN uname VARCHAR(50))
BEGIN
  SELECT * FROM Online_Banking WHERE Username = uname;
END$$
DELIMITER ;

-- 6. procedure to count users by login status
DELIMITER $$
CREATE PROCEDURE CountUsersByStatus()
BEGIN
  SELECT Login_Status, COUNT(*) AS Total_Users FROM Online_Banking GROUP BY Login_Status;
END$$
DELIMITER ;

-- 7. cursor to list all active usernames
DELIMITER $$
CREATE PROCEDURE ListActiveUsers()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE uname VARCHAR(50);
  DECLARE cur CURSOR FOR SELECT Username FROM Online_Banking WHERE Login_Status='Active';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO uname;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT uname AS ActiveUser;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to log login status change
CREATE TABLE User_Login_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Login_ID INT,
  Old_Status ENUM('Active','Blocked'),
  New_Status ENUM('Active','Blocked'),
  Change_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_login_status_update
BEFORE UPDATE ON Online_Banking
FOR EACH ROW
BEGIN
  IF OLD.Login_Status <> NEW.Login_Status THEN
    INSERT INTO User_Login_Log(Login_ID, Old_Status, New_Status)
    VALUES (OLD.Login_ID, OLD.Login_Status, NEW.Login_Status);
  END IF;
END$$
DELIMITER ;

-- 9. trigger to auto-set security question if NULL
DELIMITER $$
CREATE TRIGGER trg_set_security_question
BEFORE INSERT ON Online_Banking
FOR EACH ROW
BEGIN
  IF NEW.Security_Question IS NULL THEN
    SET NEW.Security_Question = 'Default Question';
  END IF;
END$$
DELIMITER ;

-- 10. create user
CREATE USER 'onlineuser'@'localhost' IDENTIFIED BY 'password123';

-- 11. grant select on Online_Banking
GRANT SELECT ON Online_Banking TO 'onlineuser'@'localhost';

-- 12. revoke select from Online_Banking
REVOKE SELECT ON Online_Banking FROM 'onlineuser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Online_Banking SET Login_Status='Blocked' WHERE Login_ID=2;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Online_Banking SET Login_Status='Active' WHERE Login_ID=3;
ROLLBACK;

-- 15. top 5 most recent logins
SELECT Login_ID, Username, Last_Login
FROM Online_Banking
ORDER BY Last_Login DESC LIMIT 5;

-- 16. users per status with row_number
SELECT Login_ID, Username, Login_Status,
       ROW_NUMBER() OVER (PARTITION BY Login_Status ORDER BY Last_Login DESC) AS RowNum
FROM Online_Banking;

-- 17. view of usernames with customer names
CREATE VIEW vw_user_customer AS
SELECT o.Login_ID, o.Username, c.Customer_Name
FROM Online_Banking o
JOIN Customers c ON o.Customer_ID = c.Customer_ID;

-- 18. procedure to get users by status
DELIMITER $$
CREATE PROCEDURE GetUsersByStatus(IN stat ENUM('Active','Blocked'))
BEGIN
  SELECT Login_ID, Username, Last_Login FROM Online_Banking WHERE Login_Status = stat;
END$$
DELIMITER ;

-- 19. cursor to display all registered devices
DELIMITER $$
CREATE PROCEDURE ListRegisteredDevices()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE device VARCHAR(100);
  DECLARE cur CURSOR FOR SELECT Registered_Device FROM Online_Banking;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO device;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT device AS Device;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count users by login status using window function
SELECT Login_Status, COUNT(*) OVER(PARTITION BY Login_Status) AS Status_Count, Username
FROM Online_Banking;



-- Table 12:

-- 1. view of active beneficiaries
CREATE VIEW vw_active_beneficiaries AS
SELECT Beneficiary_ID, Customer_ID, Name, Status
FROM Beneficiaries
WHERE Status='Active';

-- 2. view of inactive beneficiaries
CREATE VIEW vw_inactive_beneficiaries AS
SELECT Beneficiary_ID, Customer_ID, Name, Status
FROM Beneficiaries
WHERE Status='Inactive';

-- 3. rank beneficiaries by added date
SELECT Beneficiary_ID, Name, Added_Date,
       RANK() OVER (ORDER BY Added_Date DESC) AS Added_Rank
FROM Beneficiaries;

-- 4. dense rank by customer ID
SELECT Beneficiary_ID, Name, Customer_ID,
       DENSE_RANK() OVER (ORDER BY Customer_ID) AS Customer_Rank
FROM Beneficiaries;

-- 5. procedure to fetch beneficiary by name
DELIMITER $$
CREATE PROCEDURE GetBeneficiaryByName(IN bname VARCHAR(100))
BEGIN
  SELECT * FROM Beneficiaries WHERE Name = bname;
END$$
DELIMITER ;

-- 6. procedure to count beneficiaries by type
DELIMITER $$
CREATE PROCEDURE CountBeneficiariesByType()
BEGIN
  SELECT Type, COUNT(*) AS Total_Beneficiaries FROM Beneficiaries GROUP BY Type;
END$$
DELIMITER ;

-- 7. cursor to list all active beneficiary names
DELIMITER $$
CREATE PROCEDURE ListActiveBeneficiaries()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE bname VARCHAR(100);
  DECLARE cur CURSOR FOR SELECT Name FROM Beneficiaries WHERE Status='Active';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO bname;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT bname AS ActiveBeneficiary;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to log beneficiary status change
CREATE TABLE Beneficiary_Status_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Beneficiary_ID INT,
  Old_Status ENUM('Active','Inactive'),
  New_Status ENUM('Active','Inactive'),
  Change_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_beneficiary_status_update
BEFORE UPDATE ON Beneficiaries
FOR EACH ROW
BEGIN
  IF OLD.Status <> NEW.Status THEN
    INSERT INTO Beneficiary_Status_Log(Beneficiary_ID, Old_Status, New_Status)
    VALUES (OLD.Beneficiary_ID, OLD.Status, NEW.Status);
  END IF;
END$$
DELIMITER ;

-- 9. trigger to auto-set nickname if NULL
DELIMITER $$
CREATE TRIGGER trg_set_beneficiary_nickname
BEFORE INSERT ON Beneficiaries
FOR EACH ROW
BEGIN
  IF NEW.Nickname IS NULL THEN
    SET NEW.Nickname = CONCAT('Beneficiary_', NEW.Beneficiary_ID);
  END IF;
END$$
DELIMITER ;

-- 10. create a new user
CREATE USER 'beneficiaryuser'@'localhost' IDENTIFIED BY 'password456';

-- 11. grant select on Beneficiaries
GRANT SELECT ON Beneficiaries TO 'beneficiaryuser'@'localhost';

-- 12. revoke select on Beneficiaries
REVOKE SELECT ON Beneficiaries FROM 'beneficiaryuser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Beneficiaries SET Status='Inactive' WHERE Beneficiary_ID=2;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Beneficiaries SET Status='Active' WHERE Beneficiary_ID=3;
ROLLBACK;

-- 15. top 5 recently added beneficiaries
SELECT Beneficiary_ID, Name, Added_Date
FROM Beneficiaries
ORDER BY Added_Date DESC LIMIT 5;

-- 16. row_number partitioned by type
SELECT Beneficiary_ID, Name, Type,
       ROW_NUMBER() OVER (PARTITION BY Type ORDER BY Added_Date DESC) AS RowNum
FROM Beneficiaries;

-- 17. view of beneficiaries with customer names
CREATE VIEW vw_beneficiary_customer AS
SELECT b.Beneficiary_ID, b.Name, c.Customer_Name, b.Type
FROM Beneficiaries b
JOIN Customers c ON b.Customer_ID = c.Customer_ID;

-- 18. procedure to get beneficiaries by status
DELIMITER $$
CREATE PROCEDURE GetBeneficiariesByStatus(IN stat ENUM('Active','Inactive'))
BEGIN
  SELECT Beneficiary_ID, Name, Added_Date FROM Beneficiaries WHERE Status = stat;
END$$
DELIMITER ;

-- 19. cursor to display all bank names
DELIMITER $$
CREATE PROCEDURE ListBeneficiaryBanks()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE bankname VARCHAR(100);
  DECLARE cur CURSOR FOR SELECT DISTINCT Bank_Name FROM Beneficiaries;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO bankname;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT bankname AS Bank;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count beneficiaries by status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, Name
FROM Beneficiaries;


-- Table 13:

-- 1. view of all allocated lockers
CREATE VIEW vw_allocated_lockers AS
SELECT Locker_ID, Customer_ID, Branch_ID, Locker_Size, Status
FROM Lockers
WHERE Status='Allocated';

-- 2. view of vacant lockers
CREATE VIEW vw_vacant_lockers AS
SELECT Locker_ID, Customer_ID, Branch_ID, Locker_Size, Status
FROM Lockers
WHERE Status='Vacant';

-- 3. rank lockers by allocation date
SELECT Locker_ID, Customer_ID, Allocation_Date,
       RANK() OVER (ORDER BY Allocation_Date DESC) AS Allocation_Rank
FROM Lockers;

-- 4. dense rank by locker size
SELECT Locker_ID, Customer_ID, Locker_Size,
       DENSE_RANK() OVER (ORDER BY Locker_Size) AS Size_Rank
FROM Lockers;

-- 5. procedure to fetch locker by customer
DELIMITER $$
CREATE PROCEDURE GetLockerByCustomer(IN custID INT)
BEGIN
  SELECT * FROM Lockers WHERE Customer_ID = custID;
END$$
DELIMITER ;

-- 6. procedure to count lockers by size
DELIMITER $$
CREATE PROCEDURE CountLockersBySize()
BEGIN
  SELECT Locker_Size, COUNT(*) AS Total_Lockers FROM Lockers GROUP BY Locker_Size;
END$$
DELIMITER ;

-- 7. cursor to list all active allocated lockers
DELIMITER $$
CREATE PROCEDURE ListAllocatedLockers()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE lid INT;
  DECLARE cur CURSOR FOR SELECT Locker_ID FROM Lockers WHERE Status='Allocated';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO lid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT lid AS AllocatedLockerID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to log status changes
CREATE TABLE Locker_Status_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Locker_ID INT,
  Old_Status ENUM('Allocated','Vacant'),
  New_Status ENUM('Allocated','Vacant'),
  Change_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_locker_status_update
BEFORE UPDATE ON Lockers
FOR EACH ROW
BEGIN
  IF OLD.Status <> NEW.Status THEN
    INSERT INTO Locker_Status_Log(Locker_ID, Old_Status, New_Status)
    VALUES (OLD.Locker_ID, OLD.Status, NEW.Status);
  END IF;
END$$
DELIMITER ;

-- 9. trigger to auto-generate access code if NULL
DELIMITER $$
CREATE TRIGGER trg_set_access_code
BEFORE INSERT ON Lockers
FOR EACH ROW
BEGIN
  IF NEW.Access_Code IS NULL THEN
    SET NEW.Access_Code = CONCAT(CHAR(FLOOR(RAND()*26)+65),
                                 CHAR(FLOOR(RAND()*26)+65),
                                 FLOOR(RAND()*10),
                                 FLOOR(RAND()*10),
                                 CHAR(FLOOR(RAND()*26)+65),
                                 CHAR(FLOOR(RAND()*26)+65));
  END IF;
END$$
DELIMITER ;

-- 10. create new user for locker table
CREATE USER 'lockeruser'@'localhost' IDENTIFIED BY 'lockerpass';

-- 11. grant select on Lockers
GRANT SELECT ON Lockers TO 'lockeruser'@'localhost';

-- 12. revoke select on Lockers
REVOKE SELECT ON Lockers FROM 'lockeruser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Lockers SET Status='Vacant' WHERE Locker_ID=1;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Lockers SET Status='Allocated' WHERE Locker_ID=2;
ROLLBACK;

-- 15. top 5 latest allocated lockers
SELECT Locker_ID, Customer_ID, Allocation_Date
FROM Lockers
WHERE Status='Allocated'
ORDER BY Allocation_Date DESC
LIMIT 5;

-- 16. row_number partitioned by branch
SELECT Locker_ID, Branch_ID, Locker_Size,
       ROW_NUMBER() OVER (PARTITION BY Branch_ID ORDER BY Allocation_Date DESC) AS RowNum
FROM Lockers;

-- 17. view of lockers with customer names
CREATE VIEW vw_locker_customer AS
SELECT l.Locker_ID, l.Locker_Size, l.Status, c.Customer_Name
FROM Lockers l
JOIN Customers c ON l.Customer_ID = c.Customer_ID;

-- 18. procedure to get lockers by size
DELIMITER $$
CREATE PROCEDURE GetLockersBySize(IN lsize ENUM('Small','Medium','Large'))
BEGIN
  SELECT Locker_ID, Customer_ID, Branch_ID, Status
  FROM Lockers
  WHERE Locker_Size = lsize;
END$$
DELIMITER ;

-- 19. cursor to display all branch IDs having lockers
DELIMITER $$
CREATE PROCEDURE ListLockerBranches()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE bid INT;
  DECLARE cur CURSOR FOR SELECT DISTINCT Branch_ID FROM Lockers;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO bid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT bid AS BranchID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count lockers by status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, Locker_ID
FROM Lockers;



-- Table 14:

-- 1. view of all open complaints
CREATE VIEW vw_open_complaints AS
SELECT Complaint_ID, Customer_ID, Complaint_Type, Status
FROM Complaints
WHERE Status='Open';

-- 2. view of resolved complaints
CREATE VIEW vw_resolved_complaints AS
SELECT Complaint_ID, Customer_ID, Complaint_Type, Status, Resolution_Date
FROM Complaints
WHERE Status='Resolved';

-- 3. rank complaints by date
SELECT Complaint_ID, Customer_ID, Complaint_Date,
       RANK() OVER (ORDER BY Complaint_Date DESC) AS Complaint_Rank
FROM Complaints;

-- 4. dense rank complaints by type
SELECT Complaint_ID, Complaint_Type,
       DENSE_RANK() OVER (ORDER BY Complaint_Type) AS Type_Rank
FROM Complaints;

-- 5. procedure to get complaints by customer
DELIMITER $$
CREATE PROCEDURE GetComplaintsByCustomer(IN custID INT)
BEGIN
  SELECT * FROM Complaints WHERE Customer_ID = custID;
END$$
DELIMITER ;

-- 6. procedure to count complaints by status
DELIMITER $$
CREATE PROCEDURE CountComplaintsByStatus()
BEGIN
  SELECT Status, COUNT(*) AS Total_Complaints FROM Complaints GROUP BY Status;
END$$
DELIMITER ;

-- 7. cursor to list unresolved complaints
DELIMITER $$
CREATE PROCEDURE ListUnresolvedComplaints()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cid INT;
  DECLARE cur CURSOR FOR SELECT Complaint_ID FROM Complaints WHERE Status <> 'Resolved';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT cid AS UnresolvedComplaintID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to auto-update status when resolution date is set
DELIMITER $$
CREATE TRIGGER trg_update_complaint_status
BEFORE UPDATE ON Complaints
FOR EACH ROW
BEGIN
  IF NEW.Resolution_Date IS NOT NULL THEN
    SET NEW.Status = 'Resolved';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to log feedback ratings
CREATE TABLE Complaint_Feedback_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Complaint_ID INT,
  Feedback_Rating INT,
  Log_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_feedback_log
AFTER UPDATE ON Complaints
FOR EACH ROW
BEGIN
  IF NEW.Feedback_Rating IS NOT NULL AND OLD.Feedback_Rating IS NULL THEN
    INSERT INTO Complaint_Feedback_Log(Complaint_ID, Feedback_Rating)
    VALUES (NEW.Complaint_ID, NEW.Feedback_Rating);
  END IF;
END$$
DELIMITER ;

-- 10. create new user for complaint table
CREATE USER 'complaintuser'@'localhost' IDENTIFIED BY 'complaintpass';

-- 11. grant select on Complaints
GRANT SELECT ON Complaints TO 'complaintuser'@'localhost';

-- 12. revoke select on Complaints
REVOKE SELECT ON Complaints FROM 'complaintuser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Complaints SET Status='In Progress' WHERE Complaint_ID=4;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Complaints SET Status='Resolved' WHERE Complaint_ID=5;
ROLLBACK;

-- 15. top 5 recent complaints
SELECT Complaint_ID, Customer_ID, Complaint_Date
FROM Complaints
ORDER BY Complaint_Date DESC
LIMIT 5;

-- 16. row_number partitioned by complaint type
SELECT Complaint_ID, Complaint_Type,
       ROW_NUMBER() OVER (PARTITION BY Complaint_Type ORDER BY Complaint_Date DESC) AS RowNum
FROM Complaints;

-- 17. view of complaints with employee names
CREATE VIEW vw_complaints_employee AS
SELECT c.Complaint_ID, c.Complaint_Type, c.Status, e.Employee_Name AS Assigned_To
FROM Complaints c
LEFT JOIN Employees e ON c.Assigned_To_Employee = e.Employee_ID;

-- 18. procedure to get complaints by type
DELIMITER $$
CREATE PROCEDURE GetComplaintsByType(IN ctype ENUM('ATM','NetBanking','Card','Branch','Loan','Other'))
BEGIN
  SELECT Complaint_ID, Customer_ID, Status FROM Complaints WHERE Complaint_Type = ctype;
END$$
DELIMITER ;

-- 19. cursor to display all assigned employees with complaints
DELIMITER $$
CREATE PROCEDURE ListEmployeesWithComplaints()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE eid INT;
  DECLARE cur CURSOR FOR SELECT DISTINCT Assigned_To_Employee FROM Complaints WHERE Assigned_To_Employee IS NOT NULL;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO eid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT eid AS EmployeeID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count complaints by status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, Complaint_ID
FROM Complaints;



-- Table 15:

-- 1. view of active insurance policies
CREATE VIEW vw_active_policies AS
SELECT Policy_ID, Customer_ID, Policy_Type, Status
FROM Insurance_Policies
WHERE Status='Active';

-- 2. view of claimed insurance policies
CREATE VIEW vw_claimed_policies AS
SELECT Policy_ID, Customer_ID, Policy_Type, Status, End_Date
FROM Insurance_Policies
WHERE Status='Claimed';

-- 3. rank policies by premium amount
SELECT Policy_ID, Customer_ID, Premium_Amount,
       RANK() OVER (ORDER BY Premium_Amount DESC) AS Premium_Rank
FROM Insurance_Policies;

-- 4. dense rank policies by type
SELECT Policy_ID, Policy_Type,
       DENSE_RANK() OVER (ORDER BY Policy_Type) AS Type_Rank
FROM Insurance_Policies;

-- 5. procedure to get policies by customer
DELIMITER $$
CREATE PROCEDURE GetPoliciesByCustomer(IN custID INT)
BEGIN
  SELECT * FROM Insurance_Policies WHERE Customer_ID = custID;
END$$
DELIMITER ;

-- 6. procedure to count policies by status
DELIMITER $$
CREATE PROCEDURE CountPoliciesByStatus()
BEGIN
  SELECT Status, COUNT(*) AS Total_Policies FROM Insurance_Policies GROUP BY Status;
END$$
DELIMITER ;

-- 7. cursor to list lapsed policies
DELIMITER $$
CREATE PROCEDURE ListLapsedPolicies()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE pid INT;
  DECLARE cur CURSOR FOR SELECT Policy_ID FROM Insurance_Policies WHERE Status='Lapsed';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO pid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT pid AS LapsedPolicyID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to auto-update status to claimed if end_date passed
DELIMITER $$
CREATE TRIGGER trg_update_policy_status
BEFORE UPDATE ON Insurance_Policies
FOR EACH ROW
BEGIN
  IF NEW.End_Date <= CURDATE() THEN
    SET NEW.Status = 'Claimed';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to log policy updates
CREATE TABLE Policy_Update_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Policy_ID INT,
  Old_Status ENUM('Active','Lapsed','Claimed'),
  New_Status ENUM('Active','Lapsed','Claimed'),
  Log_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_policy_log
AFTER UPDATE ON Insurance_Policies
FOR EACH ROW
BEGIN
  IF OLD.Status <> NEW.Status THEN
    INSERT INTO Policy_Update_Log(Policy_ID, Old_Status, New_Status)
    VALUES (NEW.Policy_ID, OLD.Status, NEW.Status);
  END IF;
END$$
DELIMITER ;

-- 10. create new user for insurance table
CREATE USER 'insuranceuser'@'localhost' IDENTIFIED BY 'insurepass';

-- 11. grant select on Insurance_Policies
GRANT SELECT ON Insurance_Policies TO 'insuranceuser'@'localhost';

-- 12. revoke select on Insurance_Policies
REVOKE SELECT ON Insurance_Policies FROM 'insuranceuser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Insurance_Policies SET Status='Lapsed' WHERE Policy_ID=6;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Insurance_Policies SET Status='Claimed' WHERE Policy_ID=4;
ROLLBACK;

-- 15. top 5 highest premium policies
SELECT Policy_ID, Customer_ID, Premium_Amount
FROM Insurance_Policies
ORDER BY Premium_Amount DESC
LIMIT 5;

-- 16. row_number partitioned by policy type
SELECT Policy_ID, Policy_Type,
       ROW_NUMBER() OVER (PARTITION BY Policy_Type ORDER BY Premium_Amount DESC) AS RowNum
FROM Insurance_Policies;

-- 17. view of policies with customer names
CREATE VIEW vw_policies_customer AS
SELECT p.Policy_ID, p.Policy_Type, p.Status, c.Customer_Name
FROM Insurance_Policies p
JOIN Customers c ON p.Customer_ID = c.Customer_ID;

-- 18. procedure to get policies by type
DELIMITER $$
CREATE PROCEDURE GetPoliciesByType(IN ptype ENUM('Life','Health','Vehicle','Travel'))
BEGIN
  SELECT Policy_ID, Customer_ID, Status FROM Insurance_Policies WHERE Policy_Type = ptype;
END$$
DELIMITER ;

-- 19. cursor to display all customers having active policies
DELIMITER $$
CREATE PROCEDURE ListCustomersWithActivePolicies()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cid INT;
  DECLARE cur CURSOR FOR SELECT DISTINCT Customer_ID FROM Insurance_Policies WHERE Status='Active';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT cid AS ActivePolicyCustomerID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count policies by status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, Policy_ID
FROM Insurance_Policies;



-- Table 16:

-- 1. view of active RDs
CREATE VIEW vw_active_rds AS
SELECT RD_ID, Customer_ID, Account_ID, Status
FROM Recurring_Deposits
WHERE Status='Active';

-- 2. view of matured RDs
CREATE VIEW vw_matured_rds AS
SELECT RD_ID, Customer_ID, Account_ID, Status, Maturity_Date
FROM Recurring_Deposits
WHERE Status='Matured';

-- 3. rank RDs by total deposit
SELECT RD_ID, Customer_ID, Total_Deposit,
       RANK() OVER (ORDER BY Total_Deposit DESC) AS Deposit_Rank
FROM Recurring_Deposits;

-- 4. dense rank RDs by interest rate
SELECT RD_ID, Interest_Rate,
       DENSE_RANK() OVER (ORDER BY Interest_Rate DESC) AS Rate_Rank
FROM Recurring_Deposits;

-- 5. procedure to get RDs by customer
DELIMITER $$
CREATE PROCEDURE GetRDsByCustomer(IN custID INT)
BEGIN
  SELECT * FROM Recurring_Deposits WHERE Customer_ID = custID;
END$$
DELIMITER ;

-- 6. procedure to count RDs by status
DELIMITER $$
CREATE PROCEDURE CountRDsByStatus()
BEGIN
  SELECT Status, COUNT(*) AS Total_RDs FROM Recurring_Deposits GROUP BY Status;
END$$
DELIMITER ;

-- 7. cursor to list closed RDs
DELIMITER $$
CREATE PROCEDURE ListClosedRDs()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE rid INT;
  DECLARE cur CURSOR FOR SELECT RD_ID FROM Recurring_Deposits WHERE Status='Closed';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO rid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT rid AS ClosedRD_ID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to auto-update status to matured if maturity_date passed
DELIMITER $$
CREATE TRIGGER trg_update_rd_status
BEFORE UPDATE ON Recurring_Deposits
FOR EACH ROW
BEGIN
  IF NEW.Maturity_Date <= CURDATE() THEN
    SET NEW.Status = 'Matured';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to log RD updates
CREATE TABLE RD_Update_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  RD_ID INT,
  Old_Status ENUM('Active','Matured','Closed'),
  New_Status ENUM('Active','Matured','Closed'),
  Log_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_rd_log
AFTER UPDATE ON Recurring_Deposits
FOR EACH ROW
BEGIN
  IF OLD.Status <> NEW.Status THEN
    INSERT INTO RD_Update_Log(RD_ID, Old_Status, New_Status)
    VALUES (NEW.RD_ID, OLD.Status, NEW.Status);
  END IF;
END$$
DELIMITER ;

-- 10. create user for RD table
CREATE USER 'rduser'@'localhost' IDENTIFIED BY 'rdpass';

-- 11. grant select on Recurring_Deposits
GRANT SELECT ON Recurring_Deposits TO 'rduser'@'localhost';

-- 12. revoke select on Recurring_Deposits
REVOKE SELECT ON Recurring_Deposits FROM 'rduser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Recurring_Deposits SET Status='Closed' WHERE RD_ID=4;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Recurring_Deposits SET Status='Matured' WHERE RD_ID=2;
ROLLBACK;

-- 15. top 5 highest total deposit RDs
SELECT RD_ID, Customer_ID, Total_Deposit
FROM Recurring_Deposits
ORDER BY Total_Deposit DESC
LIMIT 5;

-- 16. row_number partitioned by status
SELECT RD_ID, Status,
       ROW_NUMBER() OVER (PARTITION BY Status ORDER BY Total_Deposit DESC) AS RowNum
FROM Recurring_Deposits;

-- 17. view of RDs with customer names
CREATE VIEW vw_rds_customer AS
SELECT r.RD_ID, r.Status, r.Total_Deposit, c.Customer_Name
FROM Recurring_Deposits r
JOIN Customers c ON r.Customer_ID = c.Customer_ID;

-- 18. procedure to get RDs by status
DELIMITER $$
CREATE PROCEDURE GetRDsByStatus(IN rstatus ENUM('Active','Matured','Closed'))
BEGIN
  SELECT RD_ID, Customer_ID, Total_Deposit FROM Recurring_Deposits WHERE Status = rstatus;
END$$
DELIMITER ;

-- 19. cursor to display all customers having active RDs
DELIMITER $$
CREATE PROCEDURE ListCustomersWithActiveRDs()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cid INT;
  DECLARE cur CURSOR FOR SELECT DISTINCT Customer_ID FROM Recurring_Deposits WHERE Status='Active';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT cid AS ActiveRDCustomerID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count RDs by status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, RD_ID
FROM Recurring_Deposits;



-- Table 17:

-- 1. view of verified KYC documents
CREATE VIEW vw_verified_kyc AS
SELECT KYC_ID, Customer_ID, Verified_Status
FROM KYC_Documents
WHERE Verified_Status='Verified';

-- 2. view of pending KYC documents
CREATE VIEW vw_pending_kyc AS
SELECT KYC_ID, Customer_ID, Verified_Status, Submission_Date
FROM KYC_Documents
WHERE Verified_Status='Pending';

-- 3. rank KYC documents by submission date
SELECT KYC_ID, Customer_ID, Submission_Date,
       RANK() OVER (ORDER BY Submission_Date ASC) AS Submission_Rank
FROM KYC_Documents;

-- 4. dense rank KYC by Verified_Status
SELECT KYC_ID, Verified_Status,
       DENSE_RANK() OVER (ORDER BY Verified_Status ASC) AS Status_Rank
FROM KYC_Documents;

-- 5. procedure to get KYC by customer
DELIMITER $$
CREATE PROCEDURE GetKYCByCustomer(IN custID INT)
BEGIN
  SELECT * FROM KYC_Documents WHERE Customer_ID = custID;
END$$
DELIMITER ;

-- 6. procedure to count KYC by status
DELIMITER $$
CREATE PROCEDURE CountKYCByStatus()
BEGIN
  SELECT Verified_Status, COUNT(*) AS Total_KYC FROM KYC_Documents GROUP BY Verified_Status;
END$$
DELIMITER ;

-- 7. cursor to list rejected KYC documents
DELIMITER $$
CREATE PROCEDURE ListRejectedKYC()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE kid INT;
  DECLARE cur CURSOR FOR SELECT KYC_ID FROM KYC_Documents WHERE Verified_Status='Rejected';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO kid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT kid AS RejectedKYC_ID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to auto-update status if submission date older than 90 days
DELIMITER $$
CREATE TRIGGER trg_pending_check
BEFORE UPDATE ON KYC_Documents
FOR EACH ROW
BEGIN
  IF NEW.Verified_Status='Pending' AND NEW.Submission_Date < DATE_SUB(CURDATE(), INTERVAL 90 DAY) THEN
    SET NEW.Verified_Status='Rejected';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to log KYC updates
CREATE TABLE KYC_Update_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  KYC_ID INT,
  Old_Status ENUM('Verified','Pending','Rejected'),
  New_Status ENUM('Verified','Pending','Rejected'),
  Log_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_kyc_log
AFTER UPDATE ON KYC_Documents
FOR EACH ROW
BEGIN
  IF OLD.Verified_Status <> NEW.Verified_Status THEN
    INSERT INTO KYC_Update_Log(KYC_ID, Old_Status, New_Status)
    VALUES (NEW.KYC_ID, OLD.Verified_Status, NEW.Verified_Status);
  END IF;
END$$
DELIMITER ;

-- 10. create user for KYC table
CREATE USER 'kycuser'@'localhost' IDENTIFIED BY 'kycpass';

-- 11. grant select on KYC_Documents
GRANT SELECT ON KYC_Documents TO 'kycuser'@'localhost';

-- 12. revoke select on KYC_Documents
REVOKE SELECT ON KYC_Documents FROM 'kycuser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE KYC_Documents SET Verified_Status='Verified' WHERE KYC_ID=3;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE KYC_Documents SET Verified_Status='Rejected' WHERE KYC_ID=16;
ROLLBACK;

-- 15. top 5 latest KYC submissions
SELECT KYC_ID, Customer_ID, Submission_Date
FROM KYC_Documents
ORDER BY Submission_Date DESC
LIMIT 5;

-- 16. row_number partitioned by Verified_Status
SELECT KYC_ID, Verified_Status,
       ROW_NUMBER() OVER (PARTITION BY Verified_Status ORDER BY Submission_Date DESC) AS RowNum
FROM KYC_Documents;

-- 17. view of KYC documents with employee who verified
CREATE VIEW vw_kyc_employee AS
SELECT k.KYC_ID, k.Customer_ID, k.Verified_Status, e.Employee_Name AS Verified_By
FROM KYC_Documents k
LEFT JOIN Employees e ON k.Verified_By = e.Employee_ID;

-- 18. procedure to get KYC by status
DELIMITER $$
CREATE PROCEDURE GetKYCByStatus(IN kstatus ENUM('Verified','Pending','Rejected'))
BEGIN
  SELECT KYC_ID, Customer_ID, Submission_Date FROM KYC_Documents WHERE Verified_Status = kstatus;
END$$
DELIMITER ;

-- 19. cursor to display all customers with pending KYC
DELIMITER $$
CREATE PROCEDURE ListCustomersWithPendingKYC()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cid INT;
  DECLARE cur CURSOR FOR SELECT DISTINCT Customer_ID FROM KYC_Documents WHERE Verified_Status='Pending';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT cid AS PendingKYC_CustomerID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count KYC documents by status using window function
SELECT Verified_Status, COUNT(*) OVER(PARTITION BY Verified_Status) AS Status_Count, KYC_ID
FROM KYC_Documents;


-- Table 18:

-- 1. view of generated account statements
CREATE VIEW vw_generated_statements AS
SELECT Statement_ID, Account_ID, Status
FROM Account_Statements
WHERE Status='Generated';

-- 2. view of failed account statements
CREATE VIEW vw_failed_statements AS
SELECT Statement_ID, Account_ID, Status, Generated_On
FROM Account_Statements
WHERE Status='Failed';

-- 3. rank account statements by generated date
SELECT Statement_ID, Account_ID, Generated_On,
       RANK() OVER (ORDER BY Generated_On ASC) AS Generated_Rank
FROM Account_Statements;

-- 4. dense rank by statement format
SELECT Statement_ID, Format,
       DENSE_RANK() OVER (ORDER BY Format ASC) AS Format_Rank
FROM Account_Statements;

-- 5. procedure to get statements by account
DELIMITER $$
CREATE PROCEDURE GetStatementsByAccount(IN accID INT)
BEGIN
  SELECT * FROM Account_Statements WHERE Account_ID = accID;
END$$
DELIMITER ;

-- 6. procedure to count statements by status
DELIMITER $$
CREATE PROCEDURE CountStatementsByStatus()
BEGIN
  SELECT Status, COUNT(*) AS Total_Statements FROM Account_Statements GROUP BY Status;
END$$
DELIMITER ;

-- 7. cursor to list failed statements
DELIMITER $$
CREATE PROCEDURE ListFailedStatements()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE sid INT;
  DECLARE cur CURSOR FOR SELECT Statement_ID FROM Account_Statements WHERE Status='Failed';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO sid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT sid AS FailedStatement_ID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to auto-mark statements as Failed if total debits > total credits by 2x
DELIMITER $$
CREATE TRIGGER trg_statement_check
BEFORE UPDATE ON Account_Statements
FOR EACH ROW
BEGIN
  IF NEW.Total_Debits > 2 * NEW.Total_Credits THEN
    SET NEW.Status='Failed';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to log statement updates
CREATE TABLE Statement_Update_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Statement_ID INT,
  Old_Status ENUM('Generated','Failed'),
  New_Status ENUM('Generated','Failed'),
  Log_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_statement_log
AFTER UPDATE ON Account_Statements
FOR EACH ROW
BEGIN
  IF OLD.Status <> NEW.Status THEN
    INSERT INTO Statement_Update_Log(Statement_ID, Old_Status, New_Status)
    VALUES (NEW.Statement_ID, OLD.Status, NEW.Status);
  END IF;
END$$
DELIMITER ;

-- 10. create user for account statements table
CREATE USER 'stmtuser'@'localhost' IDENTIFIED BY 'stmtpass';

-- 11. grant select on Account_Statements
GRANT SELECT ON Account_Statements TO 'stmtuser'@'localhost';

-- 12. revoke select on Account_Statements
REVOKE SELECT ON Account_Statements FROM 'stmtuser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Account_Statements SET Status='Generated' WHERE Statement_ID=3;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Account_Statements SET Status='Failed' WHERE Statement_ID=18;
ROLLBACK;

-- 15. top 5 latest generated statements
SELECT Statement_ID, Account_ID, Generated_On
FROM Account_Statements
ORDER BY Generated_On DESC
LIMIT 5;

-- 16. row_number partitioned by Status
SELECT Statement_ID, Status,
       ROW_NUMBER() OVER (PARTITION BY Status ORDER BY Generated_On DESC) AS RowNum
FROM Account_Statements;

-- 17. view of statements with account details
CREATE VIEW vw_statement_account AS
SELECT s.Statement_ID, s.Account_ID, s.Status, a.Account_Type, a.Balance AS Current_Balance
FROM Account_Statements s
LEFT JOIN Accounts a ON s.Account_ID = a.Account_ID;

-- 18. procedure to get statements by status
DELIMITER $$
CREATE PROCEDURE GetStatementsByStatus(IN ststatus ENUM('Generated','Failed'))
BEGIN
  SELECT Statement_ID, Account_ID, Generated_On FROM Account_Statements WHERE Status = ststatus;
END$$
DELIMITER ;

-- 19. cursor to display all accounts with failed statements
DELIMITER $$
CREATE PROCEDURE ListAccountsWithFailedStatements()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE aid INT;
  DECLARE cur CURSOR FOR SELECT DISTINCT Account_ID FROM Account_Statements WHERE Status='Failed';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO aid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT aid AS Failed_Statement_AccountID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count statements by status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, Statement_ID
FROM Account_Statements;


-- Table 19:

-- 1. view of resolved feedback
CREATE VIEW vw_resolved_feedback AS
SELECT Feedback_ID, Customer_ID, Response_Status
FROM Customer_Feedback
WHERE Response_Status='Resolved';

-- 2. view of pending feedback
CREATE VIEW vw_pending_feedback AS
SELECT Feedback_ID, Customer_ID, Response_Status, Feedback_Date
FROM Customer_Feedback
WHERE Response_Status='Pending';

-- 3. rank feedback by Feedback_Date
SELECT Feedback_ID, Customer_ID, Feedback_Date,
       RANK() OVER (ORDER BY Feedback_Date ASC) AS Feedback_Rank
FROM Customer_Feedback;

-- 4. dense rank by Response_Status
SELECT Feedback_ID, Response_Status,
       DENSE_RANK() OVER (ORDER BY Response_Status ASC) AS Status_Rank
FROM Customer_Feedback;

-- 5. procedure to get feedback by customer
DELIMITER $$
CREATE PROCEDURE GetFeedbackByCustomer(IN custID INT)
BEGIN
  SELECT * FROM Customer_Feedback WHERE Customer_ID = custID;
END$$
DELIMITER ;

-- 6. procedure to count feedback by status
DELIMITER $$
CREATE PROCEDURE CountFeedbackByStatus()
BEGIN
  SELECT Response_Status, COUNT(*) AS Total_Feedback FROM Customer_Feedback GROUP BY Response_Status;
END$$
DELIMITER ;

-- 7. cursor to list pending feedback
DELIMITER $$
CREATE PROCEDURE ListPendingFeedback()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE fid INT;
  DECLARE cur CURSOR FOR SELECT Feedback_ID FROM Customer_Feedback WHERE Response_Status='Pending';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO fid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT fid AS PendingFeedback_ID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to auto-update pending feedback older than 7 days to 'Acknowledged'
DELIMITER $$
CREATE TRIGGER trg_feedback_pending_check
BEFORE UPDATE ON Customer_Feedback
FOR EACH ROW
BEGIN
  IF NEW.Response_Status='Pending' AND NEW.Feedback_Date < DATE_SUB(CURDATE(), INTERVAL 7 DAY) THEN
    SET NEW.Response_Status='Acknowledged';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to log feedback updates
CREATE TABLE Feedback_Update_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Feedback_ID INT,
  Old_Status ENUM('Pending','Acknowledged','Resolved'),
  New_Status ENUM('Pending','Acknowledged','Resolved'),
  Log_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_feedback_log
AFTER UPDATE ON Customer_Feedback
FOR EACH ROW
BEGIN
  IF OLD.Response_Status <> NEW.Response_Status THEN
    INSERT INTO Feedback_Update_Log(Feedback_ID, Old_Status, New_Status)
    VALUES (NEW.Feedback_ID, OLD.Response_Status, NEW.Response_Status);
  END IF;
END$$
DELIMITER ;

-- 10. create user for Customer_Feedback table
CREATE USER 'feedbackuser'@'localhost' IDENTIFIED BY 'feedbackpass';

-- 11. grant select on Customer_Feedback
GRANT SELECT ON Customer_Feedback TO 'feedbackuser'@'localhost';

-- 12. revoke select on Customer_Feedback
REVOKE SELECT ON Customer_Feedback FROM 'feedbackuser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Customer_Feedback SET Response_Status='Resolved' WHERE Feedback_ID=3;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Customer_Feedback SET Response_Status='Acknowledged' WHERE Feedback_ID=16;
ROLLBACK;

-- 15. top 5 latest feedbacks
SELECT Feedback_ID, Customer_ID, Feedback_Date
FROM Customer_Feedback
ORDER BY Feedback_Date DESC
LIMIT 5;

-- 16. row_number partitioned by Response_Status
SELECT Feedback_ID, Response_Status,
       ROW_NUMBER() OVER (PARTITION BY Response_Status ORDER BY Feedback_Date DESC) AS RowNum
FROM Customer_Feedback;

-- 17. view of feedback with employee handling it
CREATE VIEW vw_feedback_employee AS
SELECT f.Feedback_ID, f.Customer_ID, f.Response_Status, e.Employee_Name AS Handled_By
FROM Customer_Feedback f
LEFT JOIN Employees e ON f.Handled_By = e.Employee_ID;

-- 18. procedure to get feedback by status
DELIMITER $$
CREATE PROCEDURE GetFeedbackByStatus(IN fstatus ENUM('Pending','Acknowledged','Resolved'))
BEGIN
  SELECT Feedback_ID, Customer_ID, Feedback_Date FROM Customer_Feedback WHERE Response_Status = fstatus;
END$$
DELIMITER ;

-- 19. cursor to display all customers with pending feedback
DELIMITER $$
CREATE PROCEDURE ListCustomersWithPendingFeedback()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cid INT;
  DECLARE cur CURSOR FOR SELECT DISTINCT Customer_ID FROM Customer_Feedback WHERE Response_Status='Pending';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT cid AS PendingFeedback_CustomerID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count feedback by status using window function
SELECT Response_Status, COUNT(*) OVER(PARTITION BY Response_Status) AS Status_Count, Feedback_ID
FROM Customer_Feedback;



-- Table 20:

-- 1. view of successful bill payments
CREATE VIEW vw_successful_payments AS
SELECT Bill_ID, Account_ID, Status
FROM Bill_Payments
WHERE Status='Successful';

-- 2. view of pending bill payments
CREATE VIEW vw_pending_payments AS
SELECT Bill_ID, Account_ID, Status, Payment_Date
FROM Bill_Payments
WHERE Status='Pending';

-- 3. rank bill payments by Payment_Date
SELECT Bill_ID, Account_ID, Payment_Date,
       RANK() OVER (ORDER BY Payment_Date ASC) AS Payment_Rank
FROM Bill_Payments;

-- 4. dense rank by Status
SELECT Bill_ID, Status,
       DENSE_RANK() OVER (ORDER BY Status ASC) AS Status_Rank
FROM Bill_Payments;

-- 5. procedure to get payments by account
DELIMITER $$
CREATE PROCEDURE GetPaymentsByAccount(IN accID INT)
BEGIN
  SELECT * FROM Bill_Payments WHERE Account_ID = accID;
END$$
DELIMITER ;

-- 6. procedure to count payments by status
DELIMITER $$
CREATE PROCEDURE CountPaymentsByStatus()
BEGIN
  SELECT Status, COUNT(*) AS Total_Payments FROM Bill_Payments GROUP BY Status;
END$$
DELIMITER ;

-- 7. cursor to list failed payments
DELIMITER $$
CREATE PROCEDURE ListFailedPayments()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE bid INT;
  DECLARE cur CURSOR FOR SELECT Bill_ID FROM Bill_Payments WHERE Status='Failed';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO bid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT bid AS FailedPayment_ID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to auto-update pending payments older than 3 days to 'Failed'
DELIMITER $$
CREATE TRIGGER trg_pending_payment_check
BEFORE UPDATE ON Bill_Payments
FOR EACH ROW
BEGIN
  IF NEW.Status='Pending' AND NEW.Payment_Date < DATE_SUB(CURDATE(), INTERVAL 3 DAY) THEN
    SET NEW.Status='Failed';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to log payment status updates
CREATE TABLE Payment_Update_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Bill_ID INT,
  Old_Status ENUM('Successful','Failed','Pending'),
  New_Status ENUM('Successful','Failed','Pending'),
  Log_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_payment_log
AFTER UPDATE ON Bill_Payments
FOR EACH ROW
BEGIN
  IF OLD.Status <> NEW.Status THEN
    INSERT INTO Payment_Update_Log(Bill_ID, Old_Status, New_Status)
    VALUES (NEW.Bill_ID, OLD.Status, NEW.Status);
  END IF;
END$$
DELIMITER ;

-- 10. create user for Bill_Payments table
CREATE USER 'paymentuser'@'localhost' IDENTIFIED BY 'paymentpass';

-- 11. grant select on Bill_Payments
GRANT SELECT ON Bill_Payments TO 'paymentuser'@'localhost';

-- 12. revoke select on Bill_Payments
REVOKE SELECT ON Bill_Payments FROM 'paymentuser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Bill_Payments SET Status='Successful' WHERE Bill_ID=13;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Bill_Payments SET Status='Failed' WHERE Bill_ID=17;
ROLLBACK;

-- 15. top 5 latest bill payments
SELECT Bill_ID, Account_ID, Payment_Date
FROM Bill_Payments
ORDER BY Payment_Date DESC
LIMIT 5;

-- 16. row_number partitioned by Status
SELECT Bill_ID, Status,
       ROW_NUMBER() OVER (PARTITION BY Status ORDER BY Payment_Date DESC) AS RowNum
FROM Bill_Payments;

-- 17. view of bill payments with account info
CREATE VIEW vw_payment_account AS
SELECT b.Bill_ID, b.Account_ID, b.Status, a.Account_Type
FROM Bill_Payments b
LEFT JOIN Accounts a ON b.Account_ID = a.Account_ID;

-- 18. procedure to get payments by status
DELIMITER $$
CREATE PROCEDURE GetPaymentsByStatus(IN pstatus ENUM('Successful','Failed','Pending'))
BEGIN
  SELECT Bill_ID, Account_ID, Payment_Date FROM Bill_Payments WHERE Status = pstatus;
END$$
DELIMITER ;

-- 19. cursor to display all accounts with pending payments
DELIMITER $$
CREATE PROCEDURE ListAccountsWithPendingPayments()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE aid INT;
  DECLARE cur CURSOR FOR SELECT DISTINCT Account_ID FROM Bill_Payments WHERE Status='Pending';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO aid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT aid AS PendingPayment_AccountID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count payments by status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, Bill_ID
FROM Bill_Payments;



-- Table 21:

-- 1. view of all visits
CREATE VIEW vw_all_visits AS
SELECT Visit_ID, Locker_ID, Customer_ID, Visit_Date
FROM Safe_Deposit_Visits;

-- 2. view of visits by a specific customer
CREATE VIEW vw_customer_visits AS
SELECT Visit_ID, Customer_ID, Visit_Date, Purpose
FROM Safe_Deposit_Visits;

-- 3. rank visits by Visit_Date
SELECT Visit_ID, Customer_ID, Visit_Date,
       RANK() OVER (ORDER BY Visit_Date ASC) AS Visit_Rank
FROM Safe_Deposit_Visits;

-- 4. dense rank by Locker_ID
SELECT Visit_ID, Locker_ID,
       DENSE_RANK() OVER (ORDER BY Locker_ID ASC) AS Locker_Rank
FROM Safe_Deposit_Visits;

-- 5. procedure to get visits by customer
DELIMITER $$
CREATE PROCEDURE GetVisitsByCustomer(IN custID INT)
BEGIN
  SELECT * FROM Safe_Deposit_Visits WHERE Customer_ID = custID;
END$$
DELIMITER ;

-- 6. procedure to count visits by locker
DELIMITER $$
CREATE PROCEDURE CountVisitsByLocker()
BEGIN
  SELECT Locker_ID, COUNT(*) AS Total_Visits FROM Safe_Deposit_Visits GROUP BY Locker_ID;
END$$
DELIMITER ;

-- 7. cursor to list visits verified by a specific employee
DELIMITER $$
CREATE PROCEDURE ListVisitsByEmployee(IN empID INT)
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE vid INT;
  DECLARE cur CURSOR FOR SELECT Visit_ID FROM Safe_Deposit_Visits WHERE Verified_By_Employee = empID;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO vid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT vid AS VerifiedVisit_ID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to log visits after insert
CREATE TABLE Visit_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Visit_ID INT,
  Locker_ID INT,
  Customer_ID INT,
  Visit_Date DATE,
  Log_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_visit_log
AFTER INSERT ON Safe_Deposit_Visits
FOR EACH ROW
BEGIN
  INSERT INTO Visit_Log(Visit_ID, Locker_ID, Customer_ID, Visit_Date)
  VALUES (NEW.Visit_ID, NEW.Locker_ID, NEW.Customer_ID, NEW.Visit_Date);
END$$
DELIMITER ;

-- 9. create user for Safe_Deposit_Visits table
CREATE USER 'visituser'@'localhost' IDENTIFIED BY 'visitpass';

-- 10. grant select on Safe_Deposit_Visits
GRANT SELECT ON Safe_Deposit_Visits TO 'visituser'@'localhost';

-- 11. revoke select on Safe_Deposit_Visits
REVOKE SELECT ON Safe_Deposit_Visits FROM 'visituser'@'localhost';

-- 12. commit transaction example
START TRANSACTION;
UPDATE Safe_Deposit_Visits SET Comments='Routine check completed' WHERE Visit_ID=3;
COMMIT;

-- 13. rollback transaction example
START TRANSACTION;
UPDATE Safe_Deposit_Visits SET Purpose='Document Review' WHERE Visit_ID=5;
ROLLBACK;

-- 14. top 5 latest visits
SELECT Visit_ID, Customer_ID, Visit_Date
FROM Safe_Deposit_Visits
ORDER BY Visit_Date DESC
LIMIT 5;

-- 15. row_number partitioned by Locker_ID
SELECT Visit_ID, Locker_ID,
       ROW_NUMBER() OVER (PARTITION BY Locker_ID ORDER BY Visit_Date DESC) AS RowNum
FROM Safe_Deposit_Visits;

-- 16. view of visits with employee who verified
CREATE VIEW vw_visits_employee AS
SELECT v.Visit_ID, v.Customer_ID, v.Locker_ID, e.Employee_Name AS Verified_By
FROM Safe_Deposit_Visits v
LEFT JOIN Employees e ON v.Verified_By_Employee = e.Employee_ID;

-- 17. procedure to get visits by locker
DELIMITER $$
CREATE PROCEDURE GetVisitsByLocker(IN lockerID INT)
BEGIN
  SELECT * FROM Safe_Deposit_Visits WHERE Locker_ID = lockerID;
END$$
DELIMITER ;

-- 18. cursor to display all customers who visited a locker
DELIMITER $$
CREATE PROCEDURE ListCustomersByLocker(IN lockerID INT)
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cid INT;
  DECLARE cur CURSOR FOR SELECT DISTINCT Customer_ID FROM Safe_Deposit_Visits WHERE Locker_ID = lockerID;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT cid AS CustomerID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 19. count visits by locker using window function
SELECT Locker_ID, COUNT(*) OVER(PARTITION BY Locker_ID) AS Visit_Count, Visit_ID
FROM Safe_Deposit_Visits;

-- 20. view of visits for a specific date
CREATE VIEW vw_visits_by_date AS
SELECT Visit_ID, Customer_ID, Locker_ID, Visit_Date
FROM Safe_Deposit_Visits
WHERE Visit_Date = CURDATE();



-- Table 22:

-- 1. view of all mobile banking registrations
CREATE VIEW vw_all_mb AS
SELECT MB_ID, Customer_ID, Registered_Mobile, App_Status
FROM Mobile_Banking;

-- 2. view of active mobile banking users
CREATE VIEW vw_active_mb AS
SELECT MB_ID, Customer_ID, Device_Model, OS_Type
FROM Mobile_Banking
WHERE App_Status='Active';

-- 3. rank users by Last_Login
SELECT MB_ID, Customer_ID, Last_Login,
       RANK() OVER (ORDER BY Last_Login DESC) AS Login_Rank
FROM Mobile_Banking;

-- 4. dense rank by OS_Type
SELECT MB_ID, OS_Type,
       DENSE_RANK() OVER (ORDER BY OS_Type ASC) AS OS_Rank
FROM Mobile_Banking;

-- 5. procedure to get mobile banking info by customer
DELIMITER $$
CREATE PROCEDURE GetMBByCustomer(IN custID INT)
BEGIN
  SELECT * FROM Mobile_Banking WHERE Customer_ID = custID;
END$$
DELIMITER ;

-- 6. procedure to count mobile banking users by OS
DELIMITER $$
CREATE PROCEDURE CountMBByOS()
BEGIN
  SELECT OS_Type, COUNT(*) AS Total_Users FROM Mobile_Banking GROUP BY OS_Type;
END$$
DELIMITER ;

-- 7. cursor to list users with OTP enabled
DELIMITER $$
CREATE PROCEDURE ListOTPEnabledUsers()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE mbid INT;
  DECLARE cur CURSOR FOR SELECT MB_ID FROM Mobile_Banking WHERE OTP_Enabled=TRUE;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO mbid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT mbid AS OTP_Enabled_MB_ID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to log mobile banking status change
CREATE TABLE MB_Status_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  MB_ID INT,
  Old_Status ENUM('Active','Inactive'),
  New_Status ENUM('Active','Inactive'),
  Log_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_mb_status_log
AFTER UPDATE ON Mobile_Banking
FOR EACH ROW
BEGIN
  IF OLD.App_Status <> NEW.App_Status THEN
    INSERT INTO MB_Status_Log(MB_ID, Old_Status, New_Status)
    VALUES (NEW.MB_ID, OLD.App_Status, NEW.App_Status);
  END IF;
END$$
DELIMITER ;

-- 9. create user for Mobile_Banking table
CREATE USER 'mbuser'@'localhost' IDENTIFIED BY 'mbpass';

-- 10. grant select on Mobile_Banking
GRANT SELECT ON Mobile_Banking TO 'mbuser'@'localhost';

-- 11. revoke select on Mobile_Banking
REVOKE SELECT ON Mobile_Banking FROM 'mbuser'@'localhost';

-- 12. commit transaction example
START TRANSACTION;
UPDATE Mobile_Banking SET App_Status='Inactive' WHERE MB_ID=5;
COMMIT;

-- 13. rollback transaction example
START TRANSACTION;
UPDATE Mobile_Banking SET OTP_Enabled=FALSE WHERE MB_ID=7;
ROLLBACK;

-- 14. top 5 recent logins
SELECT MB_ID, Customer_ID, Last_Login
FROM Mobile_Banking
ORDER BY Last_Login DESC
LIMIT 5;

-- 15. row_number partitioned by App_Status
SELECT MB_ID, App_Status,
       ROW_NUMBER() OVER (PARTITION BY App_Status ORDER BY Last_Login DESC) AS RowNum
FROM Mobile_Banking;

-- 16. view of users with biometric enabled
CREATE VIEW vw_biometric_users AS
SELECT MB_ID, Customer_ID, Device_Model, OS_Type
FROM Mobile_Banking
WHERE Biometric_Enabled=TRUE;

-- 17. procedure to get mobile banking users by OS
DELIMITER $$
CREATE PROCEDURE GetMBByOS(IN ostype ENUM('Android','iOS'))
BEGIN
  SELECT * FROM Mobile_Banking WHERE OS_Type = ostype;
END$$
DELIMITER ;

-- 18. cursor to list inactive users
DELIMITER $$
CREATE PROCEDURE ListInactiveUsers()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE mbid INT;
  DECLARE cur CURSOR FOR SELECT MB_ID FROM Mobile_Banking WHERE App_Status='Inactive';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO mbid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT mbid AS Inactive_MB_ID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 19. count mobile banking users by status using window function
SELECT App_Status, COUNT(*) OVER(PARTITION BY App_Status) AS Status_Count, MB_ID
FROM Mobile_Banking;

-- 20. view of users last logged in today
CREATE VIEW vw_mb_today_login AS
SELECT MB_ID, Customer_ID, Last_Login
FROM Mobile_Banking
WHERE DATE(Last_Login) = CURDATE();



-- Table 23:

-- 1. view of all UPI transactions
CREATE VIEW vw_all_upi AS
SELECT UPI_ID, Sender_VPA, Receiver_VPA, Amount, Status
FROM UPI_Transactions;

-- 2. view of successful transactions
CREATE VIEW vw_success_upi AS
SELECT UPI_ID, Sender_VPA, Receiver_VPA, Amount
FROM UPI_Transactions
WHERE Status='Success';

-- 3. rank transactions by Transaction_Date
SELECT UPI_ID, Sender_VPA, Transaction_Date,
       RANK() OVER (ORDER BY Transaction_Date DESC) AS Date_Rank
FROM UPI_Transactions;

-- 4. dense rank by Bank_Name
SELECT UPI_ID, Bank_Name,
       DENSE_RANK() OVER (ORDER BY Bank_Name ASC) AS Bank_Rank
FROM UPI_Transactions;

-- 5. procedure to get UPI transactions by Sender_VPA
DELIMITER $$
CREATE PROCEDURE GetUPIBySender(IN senderVPA VARCHAR(50))
BEGIN
  SELECT * FROM UPI_Transactions WHERE Sender_VPA = senderVPA;
END$$
DELIMITER ;

-- 6. procedure to count UPI transactions by Status
DELIMITER $$
CREATE PROCEDURE CountUPIByStatus()
BEGIN
  SELECT Status, COUNT(*) AS Total_Transactions FROM UPI_Transactions GROUP BY Status;
END$$
DELIMITER ;

-- 7. cursor to list failed transactions
DELIMITER $$
CREATE PROCEDURE ListFailedUPI()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE uid INT;
  DECLARE cur CURSOR FOR SELECT UPI_ID FROM UPI_Transactions WHERE Status='Failed';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO uid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT uid AS Failed_UPI_ID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to update status if Transaction_Date older than 7 days and still Pending
DELIMITER $$
CREATE TRIGGER trg_pending_upi
BEFORE UPDATE ON UPI_Transactions
FOR EACH ROW
BEGIN
  IF NEW.Status='Pending' AND NEW.Transaction_Date < DATE_SUB(NOW(), INTERVAL 7 DAY) THEN
    SET NEW.Status='Failed';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to log UPI status changes
CREATE TABLE UPI_Status_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  UPI_ID INT,
  Old_Status ENUM('Success','Failed','Pending'),
  New_Status ENUM('Success','Failed','Pending'),
  Log_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_upi_log
AFTER UPDATE ON UPI_Transactions
FOR EACH ROW
BEGIN
  IF OLD.Status <> NEW.Status THEN
    INSERT INTO UPI_Status_Log(UPI_ID, Old_Status, New_Status)
    VALUES (NEW.UPI_ID, OLD.Status, NEW.Status);
  END IF;
END$$
DELIMITER ;

-- 10. create user for UPI_Transactions table
CREATE USER 'upiuser'@'localhost' IDENTIFIED BY 'upipass';

-- 11. grant select on UPI_Transactions
GRANT SELECT ON UPI_Transactions TO 'upiuser'@'localhost';

-- 12. revoke select on UPI_Transactions
REVOKE SELECT ON UPI_Transactions FROM 'upiuser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE UPI_Transactions SET Status='Success' WHERE UPI_ID=15;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE UPI_Transactions SET Status='Failed' WHERE UPI_ID=11;
ROLLBACK;

-- 15. top 5 recent UPI transactions
SELECT UPI_ID, Sender_VPA, Receiver_VPA, Transaction_Date
FROM UPI_Transactions
ORDER BY Transaction_Date DESC
LIMIT 5;

-- 16. row_number partitioned by Status
SELECT UPI_ID, Status,
       ROW_NUMBER() OVER (PARTITION BY Status ORDER BY Transaction_Date DESC) AS RowNum
FROM UPI_Transactions;

-- 17. view of UPI transactions for a particular bank
CREATE VIEW vw_hdfc_upi AS
SELECT UPI_ID, Sender_VPA, Receiver_VPA, Amount
FROM UPI_Transactions
WHERE Bank_Name='HDFC Bank';

-- 18. procedure to get UPI transactions by Bank_Name
DELIMITER $$
CREATE PROCEDURE GetUPIByBank(IN bank VARCHAR(50))
BEGIN
  SELECT * FROM UPI_Transactions WHERE Bank_Name = bank;
END$$
DELIMITER ;

-- 19. cursor to display all pending transactions
DELIMITER $$
CREATE PROCEDURE ListPendingUPI()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE uid INT;
  DECLARE cur CURSOR FOR SELECT UPI_ID FROM UPI_Transactions WHERE Status='Pending';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO uid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT uid AS Pending_UPI_ID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count UPI transactions by Status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, UPI_ID
FROM UPI_Transactions;



-- Table 24:

-- 1. view of all service requests
CREATE VIEW vw_all_requests AS
SELECT Request_ID, Customer_ID, Request_Type, Status
FROM Service_Requests;

-- 2. view of pending requests
CREATE VIEW vw_pending_requests AS
SELECT Request_ID, Customer_ID, Request_Type, Request_Date
FROM Service_Requests
WHERE Status='Pending';

-- 3. rank requests by Request_Date
SELECT Request_ID, Customer_ID, Request_Date,
       RANK() OVER (ORDER BY Request_Date ASC) AS Request_Rank
FROM Service_Requests;

-- 4. dense rank by Priority
SELECT Request_ID, Priority,
       DENSE_RANK() OVER (ORDER BY Priority DESC) AS Priority_Rank
FROM Service_Requests;

-- 5. procedure to get requests by Customer_ID
DELIMITER $$
CREATE PROCEDURE GetRequestsByCustomer(IN custID INT)
BEGIN
  SELECT * FROM Service_Requests WHERE Customer_ID = custID;
END$$
DELIMITER ;

-- 6. procedure to count requests by Status
DELIMITER $$
CREATE PROCEDURE CountRequestsByStatus()
BEGIN
  SELECT Status, COUNT(*) AS Total_Requests FROM Service_Requests GROUP BY Status;
END$$
DELIMITER ;

-- 7. cursor to list rejected requests
DELIMITER $$
CREATE PROCEDURE ListRejectedRequests()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE rid INT;
  DECLARE cur CURSOR FOR SELECT Request_ID FROM Service_Requests WHERE Status='Rejected';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO rid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT rid AS Rejected_Request_ID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to auto-update Status to Rejected if Pending older than 10 days
DELIMITER $$
CREATE TRIGGER trg_pending_request
BEFORE UPDATE ON Service_Requests
FOR EACH ROW
BEGIN
  IF NEW.Status='Pending' AND NEW.Request_Date < DATE_SUB(CURDATE(), INTERVAL 10 DAY) THEN
    SET NEW.Status='Rejected';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to log service request updates
CREATE TABLE Service_Request_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Request_ID INT,
  Old_Status ENUM('Pending','In Process','Completed','Rejected'),
  New_Status ENUM('Pending','In Process','Completed','Rejected'),
  Log_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_request_log
AFTER UPDATE ON Service_Requests
FOR EACH ROW
BEGIN
  IF OLD.Status <> NEW.Status THEN
    INSERT INTO Service_Request_Log(Request_ID, Old_Status, New_Status)
    VALUES (NEW.Request_ID, OLD.Status, NEW.Status);
  END IF;
END$$
DELIMITER ;

-- 10. create user for Service_Requests table
CREATE USER 'requestuser'@'localhost' IDENTIFIED BY 'requestpass';

-- 11. grant select on Service_Requests
GRANT SELECT ON Service_Requests TO 'requestuser'@'localhost';

-- 12. revoke select on Service_Requests
REVOKE SELECT ON Service_Requests FROM 'requestuser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Service_Requests SET Status='Completed' WHERE Request_ID=4;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Service_Requests SET Status='Rejected' WHERE Request_ID=12;
ROLLBACK;

-- 15. top 5 recent requests
SELECT Request_ID, Customer_ID, Request_Date
FROM Service_Requests
ORDER BY Request_Date DESC
LIMIT 5;

-- 16. row_number partitioned by Status
SELECT Request_ID, Status,
       ROW_NUMBER() OVER (PARTITION BY Status ORDER BY Request_Date DESC) AS RowNum
FROM Service_Requests;

-- 17. view of requests handled by a particular employee
CREATE VIEW vw_requests_by_employee AS
SELECT r.Request_ID, r.Customer_ID, r.Status, e.Employee_Name AS Handled_By_Name
FROM Service_Requests r
LEFT JOIN Employees e ON r.Handled_By = e.Employee_ID;

-- 18. procedure to get requests by Status
DELIMITER $$
CREATE PROCEDURE GetRequestsByStatus(IN rstatus ENUM('Pending','In Process','Completed','Rejected'))
BEGIN
  SELECT Request_ID, Customer_ID, Request_Type, Request_Date FROM Service_Requests WHERE Status = rstatus;
END$$
DELIMITER ;

-- 19. cursor to display all customers with pending requests
DELIMITER $$
CREATE PROCEDURE ListCustomersWithPendingRequests()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cid INT;
  DECLARE cur CURSOR FOR SELECT DISTINCT Customer_ID FROM Service_Requests WHERE Status='Pending';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT cid AS PendingRequest_CustomerID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count requests by Status using window function
SELECT Status, COUNT(*) OVER(PARTITION BY Status) AS Status_Count, Request_ID
FROM Service_Requests;



-- Table 25:

-- 1. view of all credit scores
CREATE VIEW vw_all_credit_scores AS
SELECT Score_ID, Customer_ID, PAN_Number, Credit_Score, Score_Status
FROM Credit_Scores;

-- 2. view of customers eligible for loans
CREATE VIEW vw_loan_eligible AS
SELECT Customer_ID, Credit_Score, Loan_Eligibility
FROM Credit_Scores
WHERE Loan_Eligibility = TRUE;

-- 3. rank customers by Credit_Score
SELECT Customer_ID, Credit_Score,
       RANK() OVER (ORDER BY Credit_Score DESC) AS Score_Rank
FROM Credit_Scores;

-- 4. dense rank by Score_Status
SELECT Customer_ID, Score_Status,
       DENSE_RANK() OVER (ORDER BY Credit_Score DESC) AS Status_Rank
FROM Credit_Scores;

-- 5. procedure to get credit score by Customer_ID
DELIMITER $$
CREATE PROCEDURE GetCreditScoreByCustomer(IN custID INT)
BEGIN
  SELECT * FROM Credit_Scores WHERE Customer_ID = custID;
END$$
DELIMITER ;

-- 6. procedure to count customers by Score_Status
DELIMITER $$
CREATE PROCEDURE CountByScoreStatus()
BEGIN
  SELECT Score_Status, COUNT(*) AS Total_Customers FROM Credit_Scores GROUP BY Score_Status;
END$$
DELIMITER ;

-- 7. cursor to list poor credit scores
DELIMITER $$
CREATE PROCEDURE ListPoorScores()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cid INT;
  DECLARE cur CURSOR FOR SELECT Customer_ID FROM Credit_Scores WHERE Score_Status='Poor';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT cid AS Poor_Credit_CustomerID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 8. trigger to auto-update Score_Status based on Credit_Score
DELIMITER $$
CREATE TRIGGER trg_score_status
BEFORE INSERT ON Credit_Scores
FOR EACH ROW
BEGIN
  IF NEW.Credit_Score >= 800 THEN
    SET NEW.Score_Status='Excellent';
  ELSEIF NEW.Credit_Score >= 700 THEN
    SET NEW.Score_Status='Good';
  ELSEIF NEW.Credit_Score >= 600 THEN
    SET NEW.Score_Status='Average';
  ELSE
    SET NEW.Score_Status='Poor';
  END IF;
END$$
DELIMITER ;

-- 9. trigger to log credit score updates
CREATE TABLE Credit_Score_Log(
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Score_ID INT,
  Old_Credit_Score INT,
  New_Credit_Score INT,
  Log_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_credit_log
AFTER UPDATE ON Credit_Scores
FOR EACH ROW
BEGIN
  IF OLD.Credit_Score <> NEW.Credit_Score THEN
    INSERT INTO Credit_Score_Log(Score_ID, Old_Credit_Score, New_Credit_Score)
    VALUES (NEW.Score_ID, OLD.Credit_Score, NEW.Credit_Score);
  END IF;
END$$
DELIMITER ;

-- 10. create user for Credit_Scores table
CREATE USER 'creditscoreuser'@'localhost' IDENTIFIED BY 'scorepass';

-- 11. grant select on Credit_Scores
GRANT SELECT ON Credit_Scores TO 'creditscoreuser'@'localhost';

-- 12. revoke select on Credit_Scores
REVOKE SELECT ON Credit_Scores FROM 'creditscoreuser'@'localhost';

-- 13. commit transaction example
START TRANSACTION;
UPDATE Credit_Scores SET Loan_Eligibility=TRUE WHERE Credit_Score > 750;
COMMIT;

-- 14. rollback transaction example
START TRANSACTION;
UPDATE Credit_Scores SET Loan_Eligibility=FALSE WHERE Credit_Score < 600;
ROLLBACK;

-- 15. top 5 highest credit scores
SELECT Customer_ID, Credit_Score
FROM Credit_Scores
ORDER BY Credit_Score DESC
LIMIT 5;

-- 16. row_number partitioned by Score_Status
SELECT Customer_ID, Score_Status,
       ROW_NUMBER() OVER (PARTITION BY Score_Status ORDER BY Credit_Score DESC) AS RowNum
FROM Credit_Scores;

-- 17. view of credit scores per Score_Provider
CREATE VIEW vw_score_provider AS
SELECT Score_Provider, COUNT(*) AS Total_Customers, AVG(Credit_Score) AS Avg_Score
FROM Credit_Scores
GROUP BY Score_Provider;

-- 18. procedure to get customers with high utilization
DELIMITER $$
CREATE PROCEDURE GetHighUtilization(IN threshold DECIMAL(5,2))
BEGIN
  SELECT Customer_ID, Credit_Utilization_Percentage
  FROM Credit_Scores
  WHERE Credit_Utilization_Percentage > threshold;
END$$
DELIMITER ;

-- 19. cursor to display all customers eligible for loan
DELIMITER $$
CREATE PROCEDURE ListLoanEligibleCustomers()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cid INT;
  DECLARE cur CURSOR FOR SELECT Customer_ID FROM Credit_Scores WHERE Loan_Eligibility=TRUE;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO cid;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT cid AS Loan_Eligible_CustomerID;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;

-- 20. count customers by Score_Status using window function
SELECT Score_Status, COUNT(*) OVER(PARTITION BY Score_Status) AS Status_Count, Customer_ID
FROM Credit_Scores;


