use HDFC_Bank;

SET SQL_SAFE_UPDATES = 0;

-- Phase 2 (DDL, DML, DQL, Clauses, Constraints and Operators)

-- Table 1: Customers

-- Add a new column to track customer status
ALTER TABLE Customers
ADD COLUMN Status ENUM('Active', 'Inactive') DEFAULT 'Active';

-- Update customer's city if they moved
UPDATE Customers
SET City = 'Thane', State = 'Maharashtra'
WHERE Customer_ID = 1 AND City = 'Mumbai';

-- Delete customers who are inactive and not updated in last 30 years
DELETE FROM Customers
WHERE Status = 'Inactive' AND DOB <= DATE_SUB(CURDATE(), INTERVAL 30 YEAR);

-- Select all active customers in Mumbai or Pune with pincode less than 411050
SELECT *
FROM Customers
WHERE (City = 'Mumbai' OR City = 'Pune') AND Pincode < '411050' AND Status = 'Active';

-- Select female customers above 25 years
SELECT Full_Name, City, Mobile_Number
FROM Customers
WHERE Gender = 'Female' AND DOB <= DATE_SUB(CURDATE(), INTERVAL 25 YEAR) AND Status = 'Active';

-- Select customers whose names start with 'A' or 'M' and city is not Bangalore
SELECT Full_Name, City
FROM Customers
WHERE (Full_Name LIKE 'A%' OR Full_Name LIKE 'M%') AND City <> 'Bangalore';

-- Increase pincode by 1 for all customers in Maharashtra (demonstrates operator usage)
UPDATE Customers
SET Pincode = CAST(Pincode AS UNSIGNED) + 1
WHERE State = 'Maharashtra';

-- Rename column Customer_Email to Email
ALTER TABLE Customers
RENAME COLUMN Customer_Email TO Email;

-- Select all customers whose DOB is between 1990-01-01 and 2000-12-31
SELECT Full_Name, DOB, City
FROM Customers
WHERE DOB BETWEEN '1990-01-01' AND '2000-12-31';

-- Select customers whose Mobile_Number is in a specific list (IN operator)
SELECT Full_Name, Mobile_Number
FROM Customers
WHERE Mobile_Number IN ('9876543210', '9123456780');

-- Set Status to Inactive for customers whose email is NULL
UPDATE Customers
SET Status = 'Inactive'
WHERE Email IS NULL;

-- Delete customer whose ID is highest (using subquery)
DELETE FROM Customers
WHERE Customer_ID = (SELECT MAX(Customer_ID) FROM Customers);

-- Select customers whose name contains 'Sharma' and DOB not in 1995
SELECT Full_Name, DOB
FROM Customers
WHERE Full_Name LIKE '%Sharma%' AND DOB <> '1995-01-01';

-- Select all active male customers in Mumbai or Pune using OR & AND operators
SELECT Full_Name, City
FROM Customers
WHERE Gender = 'Male' AND Status = 'Active' AND (City = 'Mumbai' OR City = 'Pune');

-- Add a constraint to ensure Pincode starts with 4 for Maharashtra customers
ALTER TABLE Customers
ADD CONSTRAINT chk_pincode_mh CHECK (State <> 'Maharashtra' OR Pincode LIKE '4%');

-- Update multiple customers: Set state to 'Karnataka' if city is Bangalore
UPDATE Customers
SET State = 'Karnataka'
WHERE City = 'Bangalore';

-- Select top 5 youngest customers (ORDER BY and LIMIT)
SELECT Full_Name, DOB
FROM Customers
ORDER BY DOB DESC
LIMIT 5;

-- Select customers whose email is NOT NULL and pincode >= 500000
SELECT Full_Name, Email, Pincode
FROM Customers
WHERE Email IS NOT NULL AND Pincode >= '500000';

-- Update multiple rows: Append '-IN' to Mobile_Number for all inactive customers
UPDATE Customers
SET Mobile_Number = CONCAT(Mobile_Number, '-IN')
WHERE Status = 'Inactive';

-- Select customers who are Active and DOB is less than 1990 or name contains 'R'
SELECT Full_Name, DOB, Status
FROM Customers
WHERE Status = 'Active' AND (DOB < '1990-01-01' OR Full_Name LIKE '%R%');



-- Table 2: Branches

-- Add a new column to track branch capacity
ALTER TABLE Branches
ADD COLUMN Capacity INT DEFAULT 100;

-- Increase capacity by 50 for branches in metro cities
UPDATE Branches
SET Capacity = Capacity + 50
WHERE City IN ('Mumbai', 'Pune', 'Bangalore', 'Hyderabad', 'Kolkata');

-- Rename a branch
ALTER TABLE Branches
RENAME TO Bank_Branches;

-- Delete branches with zero capacity
DELETE FROM Bank_Branches
WHERE Capacity = 0;

-- Select all branches in Maharashtra and capacity greater than 150
SELECT Branch_Name, City, Capacity
FROM Bank_Branches
WHERE State = 'Maharashtra' AND Capacity > 150;

-- Select branches not in metro cities using NOT IN operator
SELECT Branch_Name, City
FROM Bank_Branches
WHERE City NOT IN ('Mumbai', 'Pune', 'Bangalore', 'Hyderabad', 'Kolkata');

-- Update IFSC_Code for all branches where city name contains 'Pune'
UPDATE Bank_Branches
SET IFSC_Code = CONCAT('HDFC', RIGHT(Pincode, 4))
WHERE City LIKE '%Pune%';

-- Select branches where capacity between 120 and 200
SELECT Branch_Name, Capacity
FROM Bank_Branches
WHERE Capacity BETWEEN 120 AND 200;

-- Select branches where name starts with 'HDFC' OR city ends with 'abad'
SELECT Branch_Name, City
FROM Bank_Branches
WHERE Branch_Name LIKE 'HDFC%' OR City LIKE '%abad';

-- Set capacity to 0 where branch type is Rural
UPDATE Bank_Branches
SET Capacity = 0
WHERE Branch_Type = 'Rural';

-- Select branches where IFSC_Code is not null and capacity > 100
SELECT Branch_Name, IFSC_Code, Capacity
FROM Bank_Branches
WHERE IFSC_Code IS NOT NULL AND Capacity > 100;

-- Select branches in Maharashtra with capacity greater than average capacity
SELECT Branch_Name, Capacity
FROM Bank_Branches
WHERE Capacity > (SELECT AVG(Capacity) FROM Bank_Branches WHERE State='Maharashtra');

-- Update branch type to 'Metro' if city in list
UPDATE Bank_Branches
SET Branch_Type = 'Metro'
WHERE City IN ('Mumbai', 'Pune', 'Bangalore', 'Hyderabad', 'Kolkata');

-- Delete branches where name contains 'Old' or capacity less than 50
DELETE FROM Bank_Branches
WHERE Branch_Name LIKE '%Old%' OR Capacity < 50;

-- Select branches with city name length greater than 6
SELECT Branch_Name, City
FROM Bank_Branches
WHERE CHAR_LENGTH(City) > 6;

-- Increment capacity by 10% for all operational branches
UPDATE Bank_Branches
SET Capacity = Capacity * 1.10
WHERE Capacity > 0;

-- Select branches where Pincode starts with '4' and capacity >= 100
SELECT Branch_Name, City, Pincode
FROM Bank_Branches
WHERE Pincode LIKE '4%' AND Capacity >= 100;

-- Set Capacity to NULL for inactive branches
UPDATE Bank_Branches
SET Capacity = NULL
WHERE Capacity = 0;

-- Select branches with city containing 'a' and IFSC_Code ending with '001'
SELECT Branch_Name, City, IFSC_Code
FROM Bank_Branches
WHERE City LIKE '%a%' AND IFSC_Code LIKE '%001';

-- Select branches whose capacity modulo 50 = 0
SELECT Branch_Name, Capacity
FROM Bank_Branches
WHERE MOD(Capacity, 50) = 0;


-- Table 3: Accounts
 
-- Add a column to track account manager for each account
ALTER TABLE Accounts
ADD COLUMN Account_Manager VARCHAR(50);

-- Update account manager for high balance accounts
UPDATE Accounts
SET Account_Manager = 'Ravi Sharma'
WHERE Balance > 300000;

-- Rename column Nominee_Name to Nominee
ALTER TABLE Accounts
CHANGE COLUMN Nominee_Name Nominee VARCHAR(100);

-- Delete accounts that are closed and have balance 0
DELETE FROM Accounts
WHERE Status = 'Closed' AND Balance = 0;

-- Select all active savings accounts with balance above 100000
SELECT Account_ID, Customer_ID, Balance, Account_Type
FROM Accounts
WHERE Account_Type = 'Savings' AND Status = 'Active' AND Balance > 100000;

-- Select accounts with balance between 50000 and 200000 or type is 'Salary'
SELECT Account_ID, Customer_ID, Balance, Account_Type
FROM Accounts
WHERE (Balance BETWEEN 50000 AND 200000) OR Account_Type = 'Salary';

-- Update status to 'Inactive' for accounts not accessed since 2022-01-01
UPDATE Accounts
SET Status = 'Inactive'
WHERE Opening_Date < '2022-01-01';

-- Select accounts where Account_Number starts with '8' and Balance > 100000
SELECT Account_ID, Account_Number, Balance
FROM Accounts
WHERE Account_Number LIKE '8%' AND Balance > 100000;

-- Increment balance by 5% for all NRI accounts
UPDATE Accounts
SET Balance = Balance * 1.05
WHERE Account_Type = 'NRI';

-- Select accounts that are Active and have Balance not equal to 0
SELECT Account_ID, Customer_ID, Balance
FROM Accounts
WHERE Status = 'Active' AND Balance <> 0;

-- Assign default Account_Manager 'Unassigned' where it is NULL
UPDATE Accounts
SET Account_Manager = 'Unassigned'
WHERE Account_Manager IS NULL;

-- Select accounts whose Balance modulo 2 is 0 (even balances) and type is Savings
SELECT Account_ID, Customer_ID, Balance
FROM Accounts
WHERE MOD(Balance, 2) = 0 AND Account_Type = 'Savings';

-- Update Account_Type to 'Current' for accounts with balance less than 50000
UPDATE Accounts
SET Account_Type = 'Current'
WHERE Balance < 50000;

-- Select accounts opened after 2023-01-01 and Balance greater than average balance
SELECT Account_ID, Customer_ID, Balance
FROM Accounts
WHERE Opening_Date > '2023-01-01' AND Balance > (SELECT AVG(Balance) FROM Accounts);

-- Select accounts where IFSC_Code contains 'HDFC0' and status is Active
SELECT Account_ID, Account_Number, IFSC_Code
FROM Accounts
WHERE IFSC_Code LIKE 'HDFC0%' AND Status = 'Active';

-- Update Balance by subtracting 1000 from all Salary accounts
UPDATE Accounts
SET Balance = Balance - 1000
WHERE Account_Type = 'Salary';

-- Select accounts where Balance + 5000 > 200000
SELECT Account_ID, Balance
FROM Accounts
WHERE Balance + 5000 > 200000;

-- Select accounts where Customer_ID is not in Branch 3
SELECT Account_ID, Customer_ID, Branch_ID
FROM Accounts
WHERE Branch_ID <> 3;

-- Update Status to 'Closed' for accounts with balance less than 10000
UPDATE Accounts
SET Status = 'Closed'
WHERE Balance < 10000;

-- Select all Fixed Deposit accounts with Balance between 200000 and 400000
SELECT Account_ID, Balance, Account_Type
FROM Accounts
WHERE Account_Type = 'Fixed Deposit' AND Balance BETWEEN 200000 AND 400000;


-- Table 4: Transactions

-- Add a column to track transaction status
ALTER TABLE Transactions
ADD COLUMN Transaction_Status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending';

-- Update Transaction_Status to 'Completed' for transactions before 2025-01-01
UPDATE Transactions
SET Transaction_Status = 'Completed'
WHERE Transaction_Date < '2025-01-01';

-- Rename column Reference_No to Transaction_Ref
ALTER TABLE Transactions
CHANGE COLUMN Reference_No Transaction_Ref VARCHAR(20);

-- Delete transactions with Amount = 0
DELETE FROM Transactions
WHERE Amount = 0;

-- Select all debit transactions above 50000
SELECT Transaction_ID, Account_ID, Amount, Transaction_Type
FROM Transactions
WHERE Transaction_Type = 'Debit' AND Amount > 50000;

-- Select transactions via NEFT or RTGS with amount between 10000 and 50000
SELECT Transaction_ID, Account_ID, Amount, Mode
FROM Transactions
WHERE (Mode = 'NEFT' OR Mode = 'RTGS') AND Amount BETWEEN 10000 AND 50000;

-- Update Amount by adding 100 to all Cash transactions
UPDATE Transactions
SET Amount = Amount + 100
WHERE Mode = 'Cash';

-- Select transactions with Balance_After greater than 200000 and Mode not UPI
SELECT Transaction_ID, Account_ID, Balance_After, Mode
FROM Transactions
WHERE Balance_After > 200000 AND Mode <> 'UPI';

-- Increment Balance_After by 5% for all Credit transactions
UPDATE Transactions
SET Balance_After = Balance_After * 1.05
WHERE Transaction_Type = 'Credit';

-- Select transactions where Description contains 'Debit'
SELECT Transaction_ID, Description
FROM Transactions
WHERE Description LIKE '%Debit%';

-- Update Transaction_Status to 'Failed' for Debit transactions with Amount > 100000
UPDATE Transactions
SET Transaction_Status = 'Failed'
WHERE Transaction_Type = 'Debit' AND Amount > 100000;

-- Select transactions for Account_IDs in (1, 5, 10) and Mode = 'IMPS'
SELECT Transaction_ID, Account_ID, Mode, Amount
FROM Transactions
WHERE Account_ID IN (1,5,10) AND Mode = 'IMPS';

-- Update Amount by subtracting 50 from all UPI transactions
UPDATE Transactions
SET Amount = Amount - 50
WHERE Mode = 'UPI';

-- Select transactions where Transaction_Date is after 2024-01-01 and Amount > average amount
SELECT Transaction_ID, Amount, Transaction_Date
FROM Transactions
WHERE Transaction_Date > '2024-01-01' 
AND Amount > (SELECT AVG(Amount) FROM Transactions);

-- Select Credit transactions where Balance_After modulo 2 = 0 (even balances)
SELECT Transaction_ID, Account_ID, Balance_After
FROM Transactions
WHERE Transaction_Type = 'Credit' AND MOD(Balance_After, 2) = 0;

-- Update Mode to 'Cheque' for transactions with Amount < 5000
UPDATE Transactions
SET Mode = 'Cheque'
WHERE Amount < 5000;

-- Select all transactions where Balance_After + 10000 > 400000
SELECT Transaction_ID, Balance_After
FROM Transactions
WHERE Balance_After + 10000 > 400000;

-- Select transactions not from Branch_ID 2 or 5
SELECT Transaction_ID, Branch_ID
FROM Transactions
WHERE Branch_ID NOT IN (2,5);

-- Update Transaction_Status to 'Completed' for all transactions with Amount <= 50000
UPDATE Transactions
SET Transaction_Status = 'Completed'
WHERE Amount <= 50000;

-- Select all transactions of type Debit and Mode in ('Cash', 'Cheque')
SELECT Transaction_ID, Transaction_Type, Mode, Amount
FROM Transactions
WHERE Transaction_Type = 'Debit' AND Mode IN ('Cash', 'Cheque');


-- Table 5: Employees

-- Add a new column to track Employee Grade
ALTER TABLE Employees
ADD COLUMN Employee_Grade ENUM('A', 'B', 'C') DEFAULT 'B';

-- Update Employee_Grade based on Salary
UPDATE Employees
SET Employee_Grade = CASE 
    WHEN Salary >= 90000 THEN 'A'
    WHEN Salary >= 50000 THEN 'B'
    ELSE 'C'
END;

-- Rename column Contact_Number to Phone
ALTER TABLE Employees
CHANGE COLUMN Contact_Number Phone CHAR(10);

-- Delete records of retired employees
DELETE FROM Employees
WHERE Status = 'Retired';

-- Select all active employees earning more than 50000
SELECT Employee_ID, First_Name, Last_Name, Salary
FROM Employees
WHERE Status = 'Active' AND Salary > 50000;

-- Select employees from Branch_ID 1 or 2 with Salary between 35000 and 60000
SELECT Employee_ID, First_Name, Branch_ID, Salary
FROM Employees
WHERE Branch_ID IN (1,2) AND Salary BETWEEN 35000 AND 60000;

-- Update Salary by increasing 10% for all Managers
UPDATE Employees
SET Salary = Salary * 1.10
WHERE Position = 'Manager';

-- Select employees whose email contains 'hdfcbank' and salary > 40000
SELECT Employee_ID, Email, Salary
FROM Employees
WHERE Email LIKE '%hdfcbank%' AND Salary > 40000;

-- Update Status to 'Resigned' for employees with DOJ before 2015-01-01
UPDATE Employees
SET Status = 'Resigned'
WHERE DOJ < '2015-01-01';

-- Select employees whose last name starts with 'J' and Salary < 40000
SELECT Employee_ID, Last_Name, Salary
FROM Employees
WHERE Last_Name LIKE 'J%' AND Salary < 40000;

-- Increment Salary by 2000 for IT Support staff
UPDATE Employees
SET Salary = Salary + 2000
WHERE Position = 'IT Support';

-- Select employees from Branch_ID not equal to 3
SELECT Employee_ID, Branch_ID
FROM Employees
WHERE Branch_ID <> 3;

-- Update Employee_Grade to 'A' for employees earning > 95000
UPDATE Employees
SET Employee_Grade = 'A'
WHERE Salary > 95000;

-- Select employees with Salary modulo 2 = 0 (even salaries)
SELECT Employee_ID, Salary
FROM Employees
WHERE MOD(Salary,2) = 0;

-- Select employees whose status is either Active or Resigned
SELECT Employee_ID, Status
FROM Employees
WHERE Status IN ('Active','Resigned');

-- Update Employee_Grade to 'C' for employees with Salary < 40000
UPDATE Employees
SET Employee_Grade = 'C'
WHERE Salary < 40000;

-- Select employees whose first name ends with 'a'
SELECT Employee_ID, First_Name
FROM Employees
WHERE First_Name LIKE '%a';

-- Select employees whose salary plus 5000 is greater than 60000
SELECT Employee_ID, Salary
FROM Employees
WHERE Salary + 5000 > 60000;

-- Delete employees with Salary < 35000
DELETE FROM Employees
WHERE Salary < 35000;

-- Select employees whose Branch_ID is 4 and Position in ('Manager','Loan Officer')
SELECT Employee_ID, Branch_ID, Position, Salary
FROM Employees
WHERE Branch_ID = 4 AND Position IN ('Manager','Loan Officer');


-- Table 6: Loans

-- Add a new column to track Loan_Priority
ALTER TABLE Loans
ADD COLUMN Loan_Priority ENUM('High','Medium','Low') DEFAULT 'Medium';

-- Update Loan_Priority based on Amount
UPDATE Loans
SET Loan_Priority = CASE
    WHEN Amount >= 3000000 THEN 'High'
    WHEN Amount >= 1000000 THEN 'Medium'
    ELSE 'Low'
END;

-- Rename column Duration_Years to Term_Years
ALTER TABLE Loans
CHANGE COLUMN Duration_Years Term_Years INT;

-- Delete loans that are Rejected
DELETE FROM Loans
WHERE Status = 'Rejected';

-- Select all Approved loans with Amount > 1000000
SELECT Loan_ID, Customer_ID, Loan_Type, Amount, Status
FROM Loans
WHERE Status = 'Approved' AND Amount > 1000000;

-- Select loans from Branch_ID 1 or 3 with Interest_Rate between 8 and 10
SELECT Loan_ID, Branch_ID, Amount, Interest_Rate
FROM Loans
WHERE Branch_ID IN (1,3) AND Interest_Rate BETWEEN 8 AND 10;

-- Update EMI_Amount by increasing 5% for all Personal loans
UPDATE Loans
SET EMI_Amount = EMI_Amount * 1.05
WHERE Loan_Type = 'Personal';

-- Select loans whose Loan_Type is Education or Business and Amount < 1000000
SELECT Loan_ID, Loan_Type, Amount
FROM Loans
WHERE Loan_Type IN ('Education','Business') AND Amount < 1000000;

-- Update Status to 'Closed' for loans started before 2020-01-01
UPDATE Loans
SET Status = 'Closed'
WHERE Start_Date < '2020-01-01';

-- Select loans where Amount modulo 50000 = 0
SELECT Loan_ID, Amount
FROM Loans
WHERE MOD(Amount,50000) = 0;

-- Update Loan_Priority to 'High' for loans with Amount > 2500000
UPDATE Loans
SET Loan_Priority = 'High'
WHERE Amount > 2500000;

-- Select loans whose Status is either Approved or Pending
SELECT Loan_ID, Status
FROM Loans
WHERE Status IN ('Approved','Pending');

-- Increment Amount by 10000 for Car loans
UPDATE Loans
SET Amount = Amount + 10000
WHERE Loan_Type = 'Car';

-- Select loans with Term_Years > 10 and Interest_Rate < 9.5
SELECT Loan_ID, Term_Years, Interest_Rate
FROM Loans
WHERE Term_Years > 10 AND Interest_Rate < 9.5;

-- Delete loans whose Status is Pending and Amount < 600000
DELETE FROM Loans
WHERE Status = 'Pending' AND Amount < 600000;

-- Select loans where Start_Date is in 2020
SELECT Loan_ID, Start_Date
FROM Loans
WHERE YEAR(Start_Date) = 2020;

-- Update EMI_Amount to EMI_Amount + 500 for loans with Loan_Type 'Business'
UPDATE Loans
SET EMI_Amount = EMI_Amount + 500
WHERE Loan_Type = 'Business';

-- Select loans where Amount + EMI_Amount > 3000000
SELECT Loan_ID, Amount, EMI_Amount
FROM Loans
WHERE Amount + EMI_Amount > 3000000;

-- Select loans whose Customer_ID is not equal to 5 and Status is Approved
SELECT Loan_ID, Customer_ID, Status
FROM Loans
WHERE Customer_ID <> 5 AND Status = 'Approved';

-- Select loans from Branch_ID 2 with Loan_Type in ('Car','Education') and Amount > 800000
SELECT Loan_ID, Branch_ID, Loan_Type, Amount
FROM Loans
WHERE Branch_ID = 2 AND Loan_Type IN ('Car','Education') AND Amount > 800000;


-- Table 7: Cards

-- Add a new column to track Card_Priority
ALTER TABLE Cards
ADD COLUMN Card_Priority ENUM('High','Medium','Low') DEFAULT 'Medium';

-- Update Card_Priority based on Card_Limit
UPDATE Cards
SET Card_Priority = CASE
    WHEN Card_Limit >= 200000 THEN 'High'
    WHEN Card_Limit >= 100000 THEN 'Medium'
    ELSE 'Low'
END;

-- Rename column CVV to CVV_Code
ALTER TABLE Cards
CHANGE COLUMN CVV CVV_Code CHAR(3);

-- Delete all Expired cards
DELETE FROM Cards
WHERE Status = 'Expired';

-- Select all Active credit cards with Card_Limit > 150000
SELECT Card_ID, Customer_ID, Card_Type, Card_Limit, Status
FROM Cards
WHERE Status = 'Active' AND Card_Type = 'Credit' AND Card_Limit > 150000
ORDER BY Card_Limit DESC;

-- Select cards whose Branch_ID is 1 or 3 and Status is not Blocked
SELECT Card_ID, Branch_ID, Status
FROM Cards
WHERE Branch_ID IN (1,3) AND Status <> 'Blocked';

-- Update Status to 'Blocked' for cards whose Expiry_Date is before today
UPDATE Cards
SET Status = 'Blocked'
WHERE Expiry_Date < CURDATE();

-- Select cards with Card_Type Credit or Debit and Card_Limit between 100000 and 250000
SELECT Card_ID, Card_Type, Card_Limit
FROM Cards
WHERE Card_Type IN ('Credit','Debit') AND Card_Limit BETWEEN 100000 AND 250000;

-- Update Card_Limit to Card_Limit + 5000 for all Credit cards
UPDATE Cards
SET Card_Limit = Card_Limit + 5000
WHERE Card_Type = 'Credit';

-- Select cards where MOD(Card_ID,2) = 0 (even Card_IDs)
SELECT Card_ID, Customer_ID
FROM Cards
WHERE MOD(Card_ID,2) = 0;

-- Update Card_Priority to 'High' for cards with Card_Limit > 200000
UPDATE Cards
SET Card_Priority = 'High'
WHERE Card_Limit > 200000;

-- Select cards whose Status is Active or Blocked and Branch_ID = 5
SELECT Card_ID, Status, Branch_ID
FROM Cards
WHERE Status IN ('Active','Blocked') AND Branch_ID = 5;

-- Increment Card_Limit by 10000 for cards issued before 2022-01-01
UPDATE Cards
SET Card_Limit = Card_Limit + 10000
WHERE Issue_Date < '2022-01-01';

-- Select cards where YEAR(Expiry_Date) = 2027 and Card_Type = 'Debit'
SELECT Card_ID, Card_Type, Expiry_Date
FROM Cards
WHERE YEAR(Expiry_Date) = 2027 AND Card_Type = 'Debit';

-- Delete all cards with Card_Limit less than 75000
DELETE FROM Cards
WHERE Card_Limit < 75000;

-- Select cards where Card_Limit + 5000 > 200000
SELECT Card_ID, Card_Limit
FROM Cards
WHERE Card_Limit + 5000 > 200000;

-- Update Status to 'Expired' for cards whose Expiry_Date < CURDATE() and Card_Type = 'Credit'
UPDATE Cards
SET Status = 'Expired'
WHERE Expiry_Date < CURDATE() AND Card_Type = 'Credit';

-- Select cards whose Customer_ID <> 3 and Status = 'Active'
SELECT Card_ID, Customer_ID, Status
FROM Cards
WHERE Customer_ID <> 3 AND Status = 'Active';

-- Select cards from Branch_ID 2 with Card_Type in ('Credit','Debit') and Card_Limit > 100000
SELECT Card_ID, Branch_ID, Card_Type, Card_Limit
FROM Cards
WHERE Branch_ID = 2 AND Card_Type IN ('Credit','Debit') AND Card_Limit > 100000;

-- Select cards using multiple clauses: Status Active, Card_Type Credit, Card_Limit > 150000, Expiry_Date after 2026-01-01
SELECT Card_ID, Customer_ID, Card_Type, Card_Limit, Expiry_Date
FROM Cards
WHERE Status = 'Active' AND Card_Type = 'Credit' AND Card_Limit > 150000 AND Expiry_Date > '2026-01-01'
ORDER BY Expiry_Date ASC;


-- Table 8: ATM's

-- Add a new column to track ATM_Priority
ALTER TABLE ATMs
ADD COLUMN ATM_Priority ENUM('High','Medium','Low') DEFAULT 'Medium';

-- Update ATM_Priority based on Cash_Available
UPDATE ATMs
SET ATM_Priority = CASE
    WHEN Cash_Available >= 2000000 THEN 'High'
    WHEN Cash_Available >= 1500000 THEN 'Medium'
    ELSE 'Low'
END;

-- Delete ATMs that are Out of Service and Cash_Available = 0
DELETE FROM ATMs
WHERE Status = 'Out of Service' AND Cash_Available = 0;

-- Select all Operational ATMs in Maharashtra ordered by Cash_Available descending
SELECT ATM_ID, Location, City, Cash_Available
FROM ATMs
WHERE Status = 'Operational' AND State = 'Maharashtra'
ORDER BY Cash_Available DESC;

-- Select ATM count per City using GROUP BY and HAVING
SELECT City, COUNT(*) AS Total_ATMs
FROM ATMs
GROUP BY City
HAVING COUNT(*) > 3;

-- Select ATMs installed after 2020-01-01 with Cash_Available > 2000000 and limit results
SELECT ATM_ID, Location, Installed_Date, Cash_Available
FROM ATMs
WHERE Installed_Date > '2020-01-01' AND Cash_Available > 2000000
ORDER BY Cash_Available DESC
LIMIT 5;

-- Update Status to 'Under Maintenance' for ATMs with Cash_Available < 100000
UPDATE ATMs
SET Status = 'Under Maintenance'
WHERE Cash_Available < 100000;

-- Select ATMs grouped by State with SUM of Cash_Available, only States with total cash > 7000000
SELECT State, SUM(Cash_Available) AS Total_Cash
FROM ATMs
GROUP BY State
HAVING SUM(Cash_Available) > 7000000
ORDER BY Total_Cash DESC;

-- Select ATMs in Bangalore with Type 'On-site' or 'Off-site' and Cash_Available > 1500000
SELECT ATM_ID, Location, Type, Cash_Available
FROM ATMs
WHERE City = 'Bangalore' AND Type IN ('On-site','Off-site') AND Cash_Available > 1500000
ORDER BY Cash_Available ASC;

-- Increment Cash_Available by 50000 for Operational ATMs in Pune
UPDATE ATMs
SET Cash_Available = Cash_Available + 50000
WHERE Status = 'Operational' AND City = 'Pune';

-- Select ATMs where MOD(ATM_ID,2) = 0 (even ATMs) and Status = 'Operational'
SELECT ATM_ID, Location, Cash_Available
FROM ATMs
WHERE MOD(ATM_ID,2) = 0 AND Status = 'Operational';

-- Select top 3 ATMs with highest Cash_Available using ORDER BY and LIMIT
SELECT ATM_ID, Location, Cash_Available
FROM ATMs
ORDER BY Cash_Available DESC
LIMIT 3;

-- Delete ATMs where Installed_Date < '2017-01-01'
DELETE FROM ATMs
WHERE Installed_Date < '2017-01-01';

-- Select ATM count per Type and State with HAVING more than 3 ATMs
SELECT State, Type, COUNT(*) AS Total_ATMs
FROM ATMs
GROUP BY State, Type
HAVING COUNT(*) > 3;

-- Select ATMs in Hyderabad with Cash_Available between 1700000 and 2000000
SELECT ATM_ID, Location, Cash_Available
FROM ATMs
WHERE City = 'Hyderabad' AND Cash_Available BETWEEN 1700000 AND 2000000
ORDER BY Cash_Available DESC;

-- Update ATM_Priority to 'High' where Cash_Available > 2200000
UPDATE ATMs
SET ATM_Priority = 'High'
WHERE Cash_Available > 2200000;

-- Select ATMs where City is not Mumbai and Status = 'Operational'
SELECT ATM_ID, City, Status
FROM ATMs
WHERE City <> 'Mumbai' AND Status = 'Operational';

-- Select sum and avg of Cash_Available per City, only Cities with avg > 2000000
SELECT City, SUM(Cash_Available) AS Total_Cash, AVG(Cash_Available) AS Avg_Cash
FROM ATMs
GROUP BY City
HAVING AVG(Cash_Available) > 2000000
ORDER BY Total_Cash DESC;

-- Update Status to 'Out of Service' for ATMs with Cash_Available = 0
UPDATE ATMs
SET Status = 'Out of Service'
WHERE Cash_Available = 0;

-- Select ATMs installed between 2018-01-01 and 2022-12-31, limit 5 results
SELECT ATM_ID, Location, Installed_Date
FROM ATMs
WHERE Installed_Date BETWEEN '2018-01-01' AND '2022-12-31'
ORDER BY Installed_Date ASC
LIMIT 5;



-- Table 9: Cheques

-- 1. Select all pending cheques ordered by Amount descending
SELECT Cheque_ID, Cheque_Number, Payee_Name, Amount, Status
FROM Cheques
WHERE Status = 'Pending'
ORDER BY Amount DESC;

-- 2. Count cheques per Status using GROUP BY and HAVING
SELECT Status, COUNT(*) AS Total_Cheques
FROM Cheques
GROUP BY Status
HAVING COUNT(*) > 5;

-- 3. Select cheques with Amount between 5000 and 50000, limit 5 results
SELECT Cheque_ID, Payee_Name, Amount
FROM Cheques
WHERE Amount BETWEEN 5000 AND 50000
ORDER BY Amount ASC
LIMIT 5;

-- 4. Update Status to 'Bounced' for cheques above 500000
UPDATE Cheques
SET Status = 'Bounced'
WHERE Amount > 500000;

-- 5. Delete cheques with Status = 'Cleared' and Amount < 1000
DELETE FROM Cheques
WHERE Status = 'Cleared' AND Amount < 1000;

-- 6. Select total and average cheque amount per Branch_ID, only branches with total > 100000
SELECT Branch_ID, SUM(Amount) AS Total_Amount, AVG(Amount) AS Avg_Amount
FROM Cheques
GROUP BY Branch_ID
HAVING SUM(Amount) > 100000
ORDER BY Total_Amount DESC;

-- 7. Select top 3 highest value cheques
SELECT Cheque_ID, Payee_Name, Amount
FROM Cheques
ORDER BY Amount DESC
LIMIT 3;

-- 8. Select cheques where Payee_Name contains 'Bank' or 'Insurance'
SELECT Cheque_ID, Payee_Name, Amount
FROM Cheques
WHERE Payee_Name LIKE '%Bank%' OR Payee_Name LIKE '%Insurance%'
ORDER BY Amount DESC;

-- 9. Update Remarks for Pending cheques to 'Follow-up Required'
UPDATE Cheques
SET Remarks = 'Follow-up Required'
WHERE Status = 'Pending';

-- 10. Select cheques issued after 2024-05-10 and Amount < 10000
SELECT Cheque_ID, Cheque_Number, Issue_Date, Amount
FROM Cheques
WHERE Issue_Date > '2024-05-10' AND Amount < 10000
ORDER BY Issue_Date ASC;

-- 11. Count of cleared cheques per Branch_ID, only branches with more than 2 cleared cheques
SELECT Branch_ID, COUNT(*) AS Cleared_Cheques
FROM Cheques
WHERE Status = 'Cleared'
GROUP BY Branch_ID
HAVING COUNT(*) > 2
ORDER BY Cleared_Cheques DESC;

-- 12. Select cheques where MOD(Cheque_ID,2) = 0 (even numbered cheques)
SELECT Cheque_ID, Cheque_Number, Amount, Status
FROM Cheques
WHERE MOD(Cheque_ID,2) = 0
ORDER BY Cheque_ID;

-- 13. Select cheques with Status not in ('Cleared', 'Bounced')
SELECT Cheque_ID, Cheque_Number, Payee_Name, Status
FROM Cheques
WHERE Status NOT IN ('Cleared','Bounced');

-- 14. Select total cheque amount per Status, only for Status having total amount > 100000
SELECT Status, SUM(Amount) AS Total_Amount
FROM Cheques
GROUP BY Status
HAVING SUM(Amount) > 100000;

-- 15. Select top 5 cheques with lowest Amount
SELECT Cheque_ID, Payee_Name, Amount
FROM Cheques
ORDER BY Amount ASC
LIMIT 5;

-- 16. Update Status to 'Cleared' for Pending cheques with Amount < 10000
UPDATE Cheques
SET Status = 'Cleared'
WHERE Status = 'Pending' AND Amount < 10000;

-- 17. Select cheques where Payee_Name starts with 'A' and Amount > 5000
SELECT Cheque_ID, Payee_Name, Amount
FROM Cheques
WHERE Payee_Name LIKE 'A%' AND Amount > 5000
ORDER BY Amount DESC;

-- 18. Delete cheques with Amount = 999 (testing specific small amounts)
DELETE FROM Cheques
WHERE Amount = 999;

-- 19. Select cheques grouped by Branch_ID and Status, only branches with more than 2 pending cheques
SELECT Branch_ID, Status, COUNT(*) AS Total
FROM Cheques
GROUP BY Branch_ID, Status
HAVING Status = 'Pending' AND COUNT(*) > 2
ORDER BY Total DESC;

-- 20. Select cheques with IFSC_Code ending with '0005'
SELECT Cheque_ID, Cheque_Number, IFSC_Code
FROM Cheques
WHERE IFSC_Code LIKE '%0005';


-- Table 10: Fixed_Deposits

-- Select all active FDs with deposit amount greater than 500000
SELECT FD_ID, Customer_ID, Deposit_Amount, Status
FROM Fixed_Deposits
WHERE Status = 'Active' AND Deposit_Amount > 500000;

-- Select FDs maturing in the next 6 months
SELECT FD_ID, Customer_ID, Maturity_Date
FROM Fixed_Deposits
WHERE Maturity_Date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 6 MONTH);

-- Select top 5 highest deposit amounts
SELECT FD_ID, Customer_ID, Deposit_Amount
FROM Fixed_Deposits
ORDER BY Deposit_Amount DESC
LIMIT 5;

-- Select FDs where Deposit_Amount is in a specific set
SELECT FD_ID, Customer_ID, Deposit_Amount
FROM Fixed_Deposits
WHERE Deposit_Amount IN (150000, 250000, 300000);

-- Select FDs with Duration_Months = 12 and Status Active, ordered by Start_Date
SELECT FD_ID, Customer_ID, Deposit_Amount, Duration_Months, Start_Date
FROM Fixed_Deposits
WHERE Duration_Months = 12 AND Status = 'Active'
ORDER BY Start_Date ASC;

-- Select FDs where Nominee_Name starts with 'N'
SELECT FD_ID, Customer_ID, Nominee_Name
FROM Fixed_Deposits
WHERE Nominee_Name LIKE 'N%';

-- Select FDs grouped by Branch_ID having more than one FD with Duration_Months > 12
SELECT Branch_ID, Duration_Months, FD_ID, Customer_ID, Deposit_Amount
FROM Fixed_Deposits
GROUP BY Branch_ID, Duration_Months, FD_ID, Customer_ID, Deposit_Amount
HAVING Duration_Months > 12;

-- Update Status to 'Matured' for FDs whose Maturity_Date has passed
UPDATE Fixed_Deposits
SET Status = 'Matured'
WHERE Maturity_Date < CURDATE();

-- Update Interest_Rate to 7.5 for FDs with Deposit_Amount > 800000
UPDATE Fixed_Deposits
SET Interest_Rate = 7.5
WHERE Deposit_Amount > 800000;

-- Delete FDs which are Closed
DELETE FROM Fixed_Deposits
WHERE Status = 'Closed';

-- Alter table to add a new column for FD Type
ALTER TABLE Fixed_Deposits
ADD COLUMN FD_Type ENUM('Regular', 'Senior Citizen', 'Tax Saver') DEFAULT 'Regular';

-- Alter table to modify Deposit_Amount precision
ALTER TABLE Fixed_Deposits
MODIFY Deposit_Amount DECIMAL(14,2);

-- Select FDs using a subquery to filter by top 3 deposit amounts
SELECT FD_ID, Customer_ID, Deposit_Amount
FROM Fixed_Deposits
WHERE Deposit_Amount >= (SELECT Deposit_Amount 
                         FROM Fixed_Deposits 
                         ORDER BY Deposit_Amount DESC 
                         LIMIT 1 OFFSET 2);

-- Select FDs where Deposit_Amount between 200000 and 500000
SELECT FD_ID, Customer_ID, Deposit_Amount
FROM Fixed_Deposits
WHERE Deposit_Amount BETWEEN 200000 AND 500000;



-- Table 11: Online_Banking

-- Select all active users who logged in today
SELECT Login_ID, Username, Last_Login, Login_Status
FROM Online_Banking
WHERE Login_Status = 'Active' AND DATE(Last_Login) = CURDATE();

-- Update blocked users to active if they logged in within last 7 days
UPDATE Online_Banking
SET Login_Status = 'Active'
WHERE Login_Status = 'Blocked' AND Last_Login >= DATE_SUB(NOW(), INTERVAL 7 DAY);

-- Select users whose username contains '2025'
SELECT Login_ID, Customer_ID, Username
FROM Online_Banking
WHERE Username LIKE '%2025%';

-- Delete users who never logged in (Last_Login IS NULL)
DELETE FROM Online_Banking
WHERE Last_Login IS NULL;

-- Select users by specific IP addresses
SELECT Login_ID, Username, IP_Address
FROM Online_Banking
WHERE IP_Address IN ('49.205.134.21', '117.203.20.11', '103.25.124.8');

-- Select users grouped by Login_Status and having more than 2 users in each group
SELECT Login_Status, COUNT(*) AS Users_Count
FROM Online_Banking
GROUP BY Login_Status
HAVING COUNT(*) > 2;

-- Select top 5 most recent logins
SELECT Login_ID, Username, Last_Login
FROM Online_Banking
ORDER BY Last_Login DESC
LIMIT 5;

-- Alter table to add a column for Device_Type
ALTER TABLE Online_Banking
ADD COLUMN Device_Type VARCHAR(50);

-- Select users whose Last_Login is between two dates
SELECT Login_ID, Username, Last_Login
FROM Online_Banking
WHERE Last_Login BETWEEN '2025-06-01' AND '2025-06-10';

-- Update Password_Hash for users from a specific device
UPDATE Online_Banking
SET Password_Hash = 'new_hash_pass'
WHERE Registered_Device LIKE '%Android%';

-- Select users with Security_Question containing 'pet'
SELECT Login_ID, Username, Security_Question
FROM Online_Banking
WHERE Security_Question LIKE '%pet%';

-- Delete users with blocked status and no login in last 30 days
DELETE FROM Online_Banking
WHERE Login_Status = 'Blocked' AND Last_Login < DATE_SUB(NOW(), INTERVAL 30 DAY);

-- Select users where Customer_ID is in a subquery of Customers with FD > 500000
SELECT Login_ID, Username, Customer_ID
FROM Online_Banking
WHERE Customer_ID IN (SELECT Customer_ID FROM Fixed_Deposits WHERE Deposit_Amount > 500000);

-- Update Login_Status to Blocked for users with suspicious IP
UPDATE Online_Banking
SET Login_Status = 'Blocked'
WHERE IP_Address IN ('103.57.83.13', '59.96.128.7');

-- Select users ordered by Username alphabetically
SELECT Login_ID, Username, Last_Login
FROM Online_Banking
ORDER BY Username ASC;

-- Alter table to modify Password_Hash column length
ALTER TABLE Online_Banking
MODIFY Password_Hash VARCHAR(512);

-- Select users with Registered_Device containing 'Windows'
SELECT Login_ID, Username, Registered_Device
FROM Online_Banking
WHERE Registered_Device LIKE '%Windows%';

-- Select active users with last login in last 10 days
SELECT Login_ID, Username, Last_Login
FROM Online_Banking
WHERE Login_Status = 'Active' AND Last_Login >= DATE_SUB(NOW(), INTERVAL 10 DAY);

-- Delete users whose Security_Answer_Hash is NULL
DELETE FROM Online_Banking
WHERE Security_Answer_Hash IS NULL;

-- Select all blocked users
SELECT Login_ID, Username, Login_Status
FROM Online_Banking
WHERE Login_Status = 'Blocked';


-- Table 12: Beneficiaries

-- Select beneficiaries with account number modulo 2 = 0 (arithmetic + comparison)
SELECT Beneficiary_ID, Name, Account_Number
FROM Beneficiaries
WHERE Account_Number % 2 = 0;

-- Update a numeric column using assignment operator (simulated using arithmetic)
UPDATE Beneficiaries
SET Account_Number = Account_Number + 1000
WHERE Bank_Name = 'HDFC Bank';

-- Select beneficiaries whose Account_Number > 5021101100500000 AND Status = 'Active' (comparison + logical)
SELECT Beneficiary_ID, Name, Account_Number, Status
FROM Beneficiaries
WHERE Account_Number > 5021101100500000 AND Status = 'Active';

-- Delete beneficiaries whose Name starts with 'A' OR are inactive (logical + LIKE)
DELETE FROM Beneficiaries
WHERE Name LIKE 'A%' OR Status = 'Inactive';

-- Select beneficiaries whose IFSC starts with 'HDFC' AND Account_Number between two values
SELECT Beneficiary_ID, Name, IFSC_Code, Account_Number
FROM Beneficiaries
WHERE IFSC_Code LIKE 'HDFC%' AND Account_Number BETWEEN 5021101100100000 AND 5021101100999999;

-- Select beneficiaries using NOT logical operator
SELECT Beneficiary_ID, Name, Status
FROM Beneficiaries
WHERE NOT Status = 'Inactive';

-- Select internal beneficiaries whose Account_Number bitwise AND with 1 is 0
SELECT Beneficiary_ID, Name, Account_Number
FROM Beneficiaries
WHERE Type = 'Internal' AND (Account_Number & 1) = 0;

-- Alter table to add a numeric column to demonstrate arithmetic operations
ALTER TABLE Beneficiaries
ADD COLUMN Bonus INT DEFAULT 100;

-- Update Bonus using arithmetic operators
UPDATE Beneficiaries
SET Bonus = Bonus * 2 + 50
WHERE Status = 'Active';

-- Select beneficiaries whose Account_Number is in a subquery (IN operator)
SELECT Beneficiary_ID, Name
FROM Beneficiaries
WHERE Account_Number IN (
    SELECT Account_Number
    FROM Beneficiaries
    WHERE Bank_Name = 'ICICI Bank'
);

-- Select top 3 beneficiaries ordered by Added_Date, using LIMIT
SELECT Beneficiary_ID, Name, Added_Date
FROM Beneficiaries
ORDER BY Added_Date DESC
LIMIT 3;

-- Update Type using CASE (logical + assignment)
UPDATE Beneficiaries
SET Type = CASE 
             WHEN Bank_Name = 'HDFC Bank' THEN 'Internal'
             ELSE 'External'
           END
WHERE Status = 'Active';

-- Select beneficiaries where Account_Number > 5021101100500000 XOR Bonus > 200 (logical XOR)
SELECT Beneficiary_ID, Name, Account_Number, Bonus
FROM Beneficiaries
WHERE (Account_Number > 5021101100500000) XOR (Bonus > 200);

-- Delete beneficiaries whose Account_Number modulo 3 = 0 (arithmetic)
DELETE FROM Beneficiaries
WHERE Account_Number % 3 = 0;


-- Update a numeric column using assignment operator (simulated using arithmetic)
UPDATE Beneficiaries
SET Account_Number = Account_Number + 1000
WHERE Bank_Name = 'HDFC Bank';

-- Select beneficiaries whose Account_Number > 5021101100500000 AND Status = 'Active' (comparison + logical)
SELECT Beneficiary_ID, Name, Account_Number, Status
FROM Beneficiaries
WHERE Account_Number > 5021101100500000 AND Status = 'Active';

-- Delete beneficiaries whose Name starts with 'A' OR are inactive (logical + LIKE)
DELETE FROM Beneficiaries
WHERE Name LIKE 'A%' OR Status = 'Inactive';

-- Select beneficiaries whose IFSC starts with 'HDFC' AND Account_Number between two values
SELECT Beneficiary_ID, Name, IFSC_Code, Account_Number
FROM Beneficiaries
WHERE IFSC_Code LIKE 'HDFC%' AND Account_Number BETWEEN 5021101100100000 AND 5021101100999999;


-- Table 13: Lockers

-- Select all allocated lockers with rent more than 3000
SELECT Locker_ID, Customer_ID, Locker_Size, Rent_Amount
FROM Lockers
WHERE Status = 'Allocated' AND Rent_Amount > 3000;

-- Update rent amount for medium lockers
UPDATE Lockers
SET Rent_Amount = Rent_Amount + 500
WHERE Locker_Size = 'Medium';

-- Delete all vacant lockers
DELETE FROM Lockers
WHERE Status = 'Vacant';

-- Select lockers accessed in June 2025
SELECT Locker_ID, Customer_ID, Last_Accessed
FROM Lockers
WHERE Last_Accessed BETWEEN '2025-06-01' AND '2025-06-30';

-- Select top 5 most expensive large lockers
SELECT Locker_ID, Customer_ID, Rent_Amount
FROM Lockers
WHERE Locker_Size = 'Large'
ORDER BY Rent_Amount DESC
LIMIT 5;

-- Add a new column Bonus with default value
ALTER TABLE Lockers
ADD COLUMN Bonus DECIMAL(10,2) DEFAULT 100;

-- Update bonus as 10% of rent for large lockers
UPDATE Lockers
SET Bonus = Rent_Amount * 0.1
WHERE Locker_Size = 'Large';

-- Select lockers with even Locker_ID
SELECT Locker_ID, Customer_ID
FROM Lockers
WHERE (Locker_ID & 1) = 0;

-- Update locker size based on rent
UPDATE Lockers
SET Locker_Size = CASE
                    WHEN Rent_Amount > 4000 THEN 'Large'
                    WHEN Rent_Amount BETWEEN 2500 AND 4000 THEN 'Medium'
                    ELSE 'Small'
                  END;

-- Select lockers grouped by size having rent more than 2000
SELECT Locker_Size, AVG(Rent_Amount) AS Avg_Rent
FROM Lockers
GROUP BY Locker_Size
HAVING AVG(Rent_Amount) > 2000;

-- Select lockers sorted by last accessed descending
SELECT Locker_ID, Customer_ID, Last_Accessed
FROM Lockers
ORDER BY Last_Accessed DESC
LIMIT 10;

-- Update status of expired lockers
UPDATE Lockers
SET Status = 'Vacant'
WHERE Expiry_Date < CURDATE();

-- Delete lockers with bonus less than 200
DELETE FROM Lockers
WHERE Bonus < 200;

-- Select lockers with rent between 1500 and 3000
SELECT Locker_ID, Customer_ID, Rent_Amount
FROM Lockers
WHERE Rent_Amount BETWEEN 1500 AND 3000;

-- Alter table to add a new column for floor number
ALTER TABLE Lockers
ADD COLUMN Floor INT DEFAULT 1;

-- Select lockers that were accessed today
SELECT Locker_ID, Customer_ID, Last_Accessed
FROM Lockers
WHERE DATE(Last_Accessed) = CURDATE();

-- Update rent for small lockers using arithmetic operator
UPDATE Lockers
SET Rent_Amount = Rent_Amount + 200
WHERE Locker_Size = 'Small';

-- Select lockers with allocated status and rent above 2500
SELECT Locker_ID, Customer_ID, Rent_Amount
FROM Lockers
WHERE Status = 'Allocated' AND Rent_Amount > 2500
ORDER BY Rent_Amount ASC;

-- Delete lockers allocated before 2023
DELETE FROM Lockers
WHERE Allocation_Date < '2023-01-01';

-- Select lockers with rent above average
SELECT Locker_ID, Customer_ID, Rent_Amount
FROM Lockers
WHERE Rent_Amount > (SELECT AVG(Rent_Amount) FROM Lockers);



-- Table 14: Complaints

-- Select all open complaints
SELECT * FROM Complaints
WHERE Status = 'Open';

-- Update complaint status to Resolved for Loan type
UPDATE Complaints
SET Status = 'Resolved', Resolution_Date = CURDATE()
WHERE Complaint_Type = 'Loan' AND Status != 'Resolved';

-- Delete complaints with feedback rating 2
DELETE FROM Complaints
WHERE Feedback_Rating = 2;

-- Alter table to add priority column
ALTER TABLE Complaints
ADD COLUMN Priority ENUM('High', 'Medium', 'Low') DEFAULT 'Medium';

-- Select complaints assigned to employee 4
SELECT Complaint_ID, Customer_ID, Status, Assigned_To_Employee
FROM Complaints
WHERE Assigned_To_Employee = 4;

-- Update feedback rating by increasing 1 for resolved complaints
UPDATE Complaints
SET Feedback_Rating = Feedback_Rating + 1
WHERE Status = 'Resolved' AND Feedback_Rating IS NOT NULL;

-- Select complaints of type ATM or Card
SELECT * FROM Complaints
WHERE Complaint_Type = 'ATM' OR Complaint_Type = 'Card';

-- Delete complaints older than June 10, 2025
DELETE FROM Complaints
WHERE Complaint_Date < '2025-06-10';

-- Select complaints without assigned employee
SELECT Complaint_ID, Complaint_Type, Status
FROM Complaints
WHERE Assigned_To_Employee IS NULL;

-- Update complaint description using concatenation
UPDATE Complaints
SET Description = CONCAT(Description, ' - Followed up by support.')
WHERE Status = 'In Progress';

-- Select complaints resolved in last 5 days
SELECT Complaint_ID, Status, Resolution_Date
FROM Complaints
WHERE Resolution_Date >= DATE_SUB(CURDATE(), INTERVAL 5 DAY);

-- Alter table to add column for escalation flag
ALTER TABLE Complaints
ADD COLUMN Escalated BOOLEAN DEFAULT FALSE;

-- Select complaints with feedback rating above 3 and status Resolved
SELECT Complaint_ID, Customer_ID, Feedback_Rating
FROM Complaints
WHERE Feedback_Rating > 3 AND Status = 'Resolved';

-- Update complaint type to Other if description contains 'email'
UPDATE Complaints
SET Complaint_Type = 'Other'
WHERE Description LIKE '%email%';

-- Select complaints assigned to employees 2 or 3 and in progress
SELECT Complaint_ID, Customer_ID, Assigned_To_Employee
FROM Complaints
WHERE (Assigned_To_Employee = 2 OR Assigned_To_Employee = 3) AND Status = 'In Progress';

-- Delete complaints with NULL Feedback_Rating
DELETE FROM Complaints
WHERE Feedback_Rating IS NULL;

-- Update feedback rating to 5 for complaints resolved today
UPDATE Complaints
SET Feedback_Rating = 5
WHERE Status = 'Resolved' AND Resolution_Date = CURDATE();

-- Select complaints not resolved yet
SELECT * FROM Complaints
WHERE Status != 'Resolved';

-- Select complaints of type ATM, Card, or NetBanking with feedback >= 4
SELECT Complaint_ID, Complaint_Type, Feedback_Rating
FROM Complaints
WHERE Complaint_Type IN ('ATM', 'Card', 'NetBanking') AND Feedback_Rating >= 4;

-- Update priority to High for complaints older than 7 days and still open
UPDATE Complaints
SET Priority = 'High'
WHERE Status = 'Open' AND Complaint_Date < DATE_SUB(CURDATE(), INTERVAL 7 DAY);


-- Table 15: Insurance_Policies

-- Select all active insurance policies
SELECT * FROM Insurance_Policies
WHERE Status = 'Active';

-- Update premium amount by 10% for all Life policies
UPDATE Insurance_Policies
SET Premium_Amount = Premium_Amount * 1.10
WHERE Policy_Type = 'Life';

-- Delete policies that are Claimed and End_Date passed
DELETE FROM Insurance_Policies
WHERE Status = 'Claimed' AND End_Date < CURDATE();

-- Alter table to add a column for Policy_Term in years
ALTER TABLE Insurance_Policies
ADD COLUMN Policy_Term INT;

-- Select policies ending in next 30 days
SELECT Policy_ID, Customer_ID, End_Date
FROM Insurance_Policies
WHERE End_Date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

-- Update status to Lapsed for policies past End_Date
UPDATE Insurance_Policies
SET Status = 'Lapsed'
WHERE End_Date < CURDATE() AND Status = 'Active';

-- Select policies with Premium_Amount greater than 9000
SELECT Policy_ID, Policy_Type, Premium_Amount
FROM Insurance_Policies
WHERE Premium_Amount > 9000;

-- Delete policies with NULL Nominee_Name
DELETE FROM Insurance_Policies
WHERE Nominee_Name IS NULL;

-- Select Vehicle and Travel policies
SELECT * FROM Insurance_Policies
WHERE Policy_Type IN ('Vehicle', 'Travel');

-- Update Policy_Provider name to uppercase
UPDATE Insurance_Policies
SET Policy_Provider = UPPER(Policy_Provider);

-- Select policies with premium between 4000 and 10000
SELECT Policy_ID, Premium_Amount
FROM Insurance_Policies
WHERE Premium_Amount BETWEEN 4000 AND 10000;

-- Alter table to add column for Renewal_Status
ALTER TABLE Insurance_Policies
ADD COLUMN Renewal_Status ENUM('Pending', 'Completed') DEFAULT 'Pending';

-- Select policies that are Active and Start_Date before 2023-01-01
SELECT Policy_ID, Policy_Type, Status
FROM Insurance_Policies
WHERE Status = 'Active' AND Start_Date < '2023-01-01';

-- Update Premium_Amount by adding 500 for Health policies
UPDATE Insurance_Policies
SET Premium_Amount = Premium_Amount + 500
WHERE Policy_Type = 'Health';

-- Select Life policies with Premium_Amount > 12000
SELECT * FROM Insurance_Policies
WHERE Policy_Type = 'Life' AND Premium_Amount > 12000;

-- Delete policies with Status = 'Lapsed' and Premium_Amount < 8000
DELETE FROM Insurance_Policies
WHERE Status = 'Lapsed' AND Premium_Amount < 8000;

-- Update Status to Claimed for Travel policies ending today
UPDATE Insurance_Policies
SET Status = 'Claimed'
WHERE Policy_Type = 'Travel' AND End_Date = CURDATE();

-- Select Health policies with premium less than 9000 or status Lapsed
SELECT Policy_ID, Policy_Type, Premium_Amount, Status
FROM Insurance_Policies
WHERE Premium_Amount < 9000 OR Status = 'Lapsed';

-- Update Policy_Term based on Start_Date and End_Date
UPDATE Insurance_Policies
SET Policy_Term = TIMESTAMPDIFF(YEAR, Start_Date, End_Date);

-- Select all policies where Status is Active and Premium_Amount > 10000
SELECT Policy_ID, Policy_Type, Premium_Amount
FROM Insurance_Policies
WHERE Status = 'Active' AND Premium_Amount > 10000;



-- Table 16: Recurring_Deposits

-- Select all active recurring deposits
SELECT * FROM Recurring_Deposits
WHERE Status = 'Active';

-- Update Total_Deposit based on Monthly_Installment and Interest_Rate
UPDATE Recurring_Deposits
SET Total_Deposit = Monthly_Installment * 36 * (1 + Interest_Rate/100)
WHERE Status = 'Active';

-- Delete deposits that are Closed and Maturity_Date passed
DELETE FROM Recurring_Deposits
WHERE Status = 'Closed' AND Maturity_Date < CURDATE();

-- Alter table to add column for Renewal_Status
ALTER TABLE Recurring_Deposits
ADD COLUMN Renewal_Status ENUM('Pending', 'Completed') DEFAULT 'Pending';

-- Select deposits with Monthly_Installment greater than 2000
SELECT RD_ID, Customer_ID, Monthly_Installment
FROM Recurring_Deposits
WHERE Monthly_Installment > 2000;

-- Update Status to Matured for deposits past Maturity_Date
UPDATE Recurring_Deposits
SET Status = 'Matured'
WHERE Maturity_Date < CURDATE() AND Status = 'Active';

-- Select deposits with Interest_Rate >= 6.5
SELECT RD_ID, Interest_Rate
FROM Recurring_Deposits
WHERE Interest_Rate >= 6.5;

-- Delete deposits with NULL Nominee_Name
DELETE FROM Recurring_Deposits
WHERE Nominee_Name IS NULL;

-- Select deposits that are Active and Total_Deposit > 80000
SELECT * FROM Recurring_Deposits
WHERE Status = 'Active' AND Total_Deposit > 80000;

-- Update Monthly_Installment by adding 200
UPDATE Recurring_Deposits
SET Monthly_Installment = Monthly_Installment + 200
WHERE Status = 'Active';

-- Select deposits with Total_Deposit between 50000 and 90000
SELECT RD_ID, Total_Deposit
FROM Recurring_Deposits
WHERE Total_Deposit BETWEEN 50000 AND 90000;

-- Alter table to add column for Interest_Accrued
ALTER TABLE Recurring_Deposits
ADD COLUMN Interest_Accrued DECIMAL(10,2);

-- Select deposits starting in 2023
SELECT RD_ID, Start_Date
FROM Recurring_Deposits
WHERE YEAR(Start_Date) = 2023;

-- Update Interest_Rate for deposits with Total_Deposit > 90000
UPDATE Recurring_Deposits
SET Interest_Rate = Interest_Rate + 0.25
WHERE Total_Deposit > 90000;

-- Select deposits with Status Active or Monthly_Installment > 2500
SELECT RD_ID, Status, Monthly_Installment
FROM Recurring_Deposits
WHERE Status = 'Active' OR Monthly_Installment > 2500;

-- Delete deposits with Status = 'Matured' and Total_Deposit < 55000
DELETE FROM Recurring_Deposits
WHERE Status = 'Matured' AND Total_Deposit < 55000;

-- Update Status to Closed for deposits maturing today
UPDATE Recurring_Deposits
SET Status = 'Closed'
WHERE Maturity_Date = CURDATE();

-- Select deposits with Interest_Rate > 6.5 and Status Active
SELECT RD_ID, Interest_Rate, Status
FROM Recurring_Deposits
WHERE Interest_Rate > 6.5 AND Status = 'Active';

-- Update Interest_Accrued as Total_Deposit * Interest_Rate / 100
UPDATE Recurring_Deposits
SET Interest_Accrued = Total_Deposit * Interest_Rate / 100;

-- Select all deposits where Status = Active and Monthly_Installment <= 2000
SELECT RD_ID, Status, Monthly_Installment
FROM Recurring_Deposits
WHERE Status = 'Active' AND Monthly_Installment <= 2000;



-- Table 17: KYC_Documents

-- Select all verified KYC documents
SELECT * FROM KYC_Documents
WHERE Verified_Status = 'Verified';

-- Update Remarks for Pending documents
UPDATE KYC_Documents
SET Remarks = 'Pending verification'
WHERE Verified_Status = 'Pending';

-- Delete KYC documents that were Rejected before 2023
DELETE FROM KYC_Documents
WHERE Verified_Status = 'Rejected' AND YEAR(Submission_Date) < 2023;

-- Alter table to add column for Verification_Score
ALTER TABLE KYC_Documents
ADD COLUMN Verification_Score INT DEFAULT 0;

-- Select documents submitted after 2023-01-01
SELECT * FROM KYC_Documents
WHERE Submission_Date > '2023-01-01';

-- Update Verification_Score based on Verified_Status
UPDATE KYC_Documents
SET Verification_Score = CASE 
    WHEN Verified_Status = 'Verified' THEN 10
    WHEN Verified_Status = 'Pending' THEN 5
    ELSE 0
END;

-- Select documents where PAN_Number ends with 'F'
SELECT KYC_ID, PAN_Number
FROM KYC_Documents
WHERE PAN_Number LIKE '%F';

-- Delete documents with NULL Verified_By and status Pending
DELETE FROM KYC_Documents
WHERE Verified_By IS NULL AND Verified_Status = 'Pending';

-- Select documents verified by employee 5 or 4
SELECT * FROM KYC_Documents
WHERE Verified_By = 5 OR Verified_By = 4;

-- Update Verified_Status to Verified for documents submitted before 2023-03-01
UPDATE KYC_Documents
SET Verified_Status = 'Verified'
WHERE Submission_Date < '2023-03-01' AND Verified_Status = 'Pending';

-- Select documents with Remarks containing 'Approved'
SELECT KYC_ID, Remarks
FROM KYC_Documents
WHERE Remarks LIKE '%Approved%';

-- Alter table to add column Verification_Date
ALTER TABLE KYC_Documents
ADD COLUMN Verification_Date DATE;

-- Update Verification_Date to current date for Verified documents
UPDATE KYC_Documents
SET Verification_Date = CURDATE()
WHERE Verified_Status = 'Verified';

-- Select documents with Aadhaar_Number starting with '1234'
SELECT KYC_ID, Aadhaar_Number
FROM KYC_Documents
WHERE Aadhaar_Number LIKE '1234%';

-- Delete documents where Verified_Status = Rejected and Remarks like 'Mismatch%'
DELETE FROM KYC_Documents
WHERE Verified_Status = 'Rejected' AND Remarks LIKE 'Mismatch%';

-- Update Remarks to 'Verified manually' for documents verified by employee 2
UPDATE KYC_Documents
SET Remarks = 'Verified manually'
WHERE Verified_By = 2;

-- Select all Pending documents or documents submitted after 2023-05-01
SELECT * FROM KYC_Documents
WHERE Verified_Status = 'Pending' OR Submission_Date > '2023-05-01';

-- Update Verification_Score by adding 2 for all Verified documents
UPDATE KYC_Documents
SET Verification_Score = Verification_Score + 2
WHERE Verified_Status = 'Verified';

-- Select documents where Verification_Score >= 10 and Verified_Status = Verified
SELECT KYC_ID, Verification_Score
FROM KYC_Documents
WHERE Verification_Score >= 10 AND Verified_Status = 'Verified';

-- Select documents not verified and Verified_By is NULL
SELECT * FROM KYC_Documents
WHERE Verified_Status != 'Verified' AND Verified_By IS NULL;



-- Table 18: Account_Statements

-- Select statements where Closing_Balance is greater than 20000
SELECT * FROM Account_Statements
WHERE Closing_Balance > 20000;

-- Update Closing_Balance by adding 500 for PDF formatted statements
UPDATE Account_Statements
SET Closing_Balance = Closing_Balance + 500
WHERE Format = 'PDF';

-- Delete statements with Total_Debits greater than Total_Credits
DELETE FROM Account_Statements
WHERE Total_Debits > Total_Credits;

-- Select statements generated in June 2024
SELECT * FROM Account_Statements
WHERE MONTH(Generated_On) = 6 AND YEAR(Generated_On) = 2024;

-- Update Total_Credits by multiplying with 1.05 for Excel formatted statements
UPDATE Account_Statements
SET Total_Credits = Total_Credits * 1.05
WHERE Format = 'Excel';

-- Select statements where Total_Credits minus Total_Debits is less than 10000
SELECT * FROM Account_Statements
WHERE Total_Credits - Total_Debits < 10000;

-- Update Status to 'Failed' where Closing_Balance is less than 5000
UPDATE Account_Statements
SET Status = 'Failed'
WHERE Closing_Balance < 5000;

-- Select statements where Total_Credits is between 20000 and 50000
SELECT * FROM Account_Statements
WHERE Total_Credits BETWEEN 20000 AND 50000;

-- Delete statements where Status is Failed
DELETE FROM Account_Statements
WHERE Status = 'Failed';

-- Update Total_Debits by subtracting 200 for PDF statements
UPDATE Account_Statements
SET Total_Debits = Total_Debits - 200
WHERE Format = 'PDF';

-- Select statements where Closing_Balance is divisible by 5000
SELECT * FROM Account_Statements
WHERE MOD(Closing_Balance, 5000) = 0;

-- Update Closing_Balance to Total_Credits minus Total_Debits
UPDATE Account_Statements
SET Closing_Balance = Total_Credits - Total_Debits;

-- Select statements with Status Generated and Format Excel
SELECT * FROM Account_Statements
WHERE Status = 'Generated' AND Format = 'Excel';

-- Update Total_Credits by adding Total_Debits/10 for all statements
UPDATE Account_Statements
SET Total_Credits = Total_Credits + (Total_Debits / 10);

-- Select statements where Total_Debits > 20000 OR Closing_Balance < 15000
SELECT * FROM Account_Statements
WHERE Total_Debits > 20000 OR Closing_Balance < 15000;

-- Update Status to 'Generated' where Status is 'Failed' and Closing_Balance > 10000
UPDATE Account_Statements
SET Status = 'Generated'
WHERE Status = 'Failed' AND Closing_Balance > 10000;

-- Select statements where Total_Credits > Total_Debits AND Closing_Balance > 10000
SELECT * FROM Account_Statements
WHERE Total_Credits > Total_Debits AND Closing_Balance > 10000;

-- Delete statements where Closing_Balance = 5000
DELETE FROM Account_Statements
WHERE Closing_Balance = 5000;

-- Update Closing_Balance by adding 1000 to statements with Total_Credits < 25000
UPDATE Account_Statements
SET Closing_Balance = Closing_Balance + 1000
WHERE Total_Credits < 25000;

-- Select statements where Format is PDF OR Total_Credits >= 60000
SELECT * FROM Account_Statements
WHERE Format = 'PDF' OR Total_Credits >= 60000;



-- Table 19: Customer_Feedback

-- Select feedbacks where Rating is greater than 3
SELECT * FROM Customer_Feedback
WHERE Rating > 3;

-- Update Rating by adding 1 for all Pending responses
UPDATE Customer_Feedback
SET Rating = Rating + 1
WHERE Response_Status = 'Pending';

-- Delete feedbacks where Rating is less than 2
DELETE FROM Customer_Feedback
WHERE Rating < 2;

-- Select feedbacks handled by Employee_ID 3
SELECT * FROM Customer_Feedback
WHERE Handled_By = 3;

-- Update Response_Status to 'Resolved' for feedbacks older than 60 days
UPDATE Customer_Feedback
SET Response_Status = 'Resolved'
WHERE Feedback_Date < DATE_SUB(CURDATE(), INTERVAL 60 DAY);

-- Select feedbacks where Rating is between 3 and 5
SELECT * FROM Customer_Feedback
WHERE Rating BETWEEN 3 AND 5;

-- Update Comments by appending text for feedbacks via Online channel
UPDATE Customer_Feedback
SET Comments = CONCAT(Comments, ' [Follow-up done]')
WHERE Channel = 'Online';

-- Select feedbacks where Response_Status is Acknowledged OR Rating = 5
SELECT * FROM Customer_Feedback
WHERE Response_Status = 'Acknowledged' OR Rating = 5;

-- Update Rating to 5 for Mobile App feedbacks with Rating less than 3
UPDATE Customer_Feedback
SET Rating = 5
WHERE Channel = 'Mobile App' AND Rating < 3;

-- Delete feedbacks where Response_Status is Pending and Rating = 1
DELETE FROM Customer_Feedback
WHERE Response_Status = 'Pending' AND Rating = 1;

-- Select feedbacks where Feedback_Date is in the first quarter of 2023
SELECT * FROM Customer_Feedback
WHERE MONTH(Feedback_Date) BETWEEN 1 AND 3 AND YEAR(Feedback_Date) = 2023;

-- Update Follow_Up_Date by adding 3 days for Pending feedbacks
UPDATE Customer_Feedback
SET Follow_Up_Date = DATE_ADD(Follow_Up_Date, INTERVAL 3 DAY)
WHERE Response_Status = 'Pending';

-- Select feedbacks with Rating greater than 3 AND Response_Status is Resolved
SELECT * FROM Customer_Feedback
WHERE Rating > 3 AND Response_Status = 'Resolved';

-- Update Rating by multiplying by 1.1 for ATM feedbacks
UPDATE Customer_Feedback
SET Rating = Rating * 1.1
WHERE Channel = 'ATM';

-- Select feedbacks where Rating is odd
SELECT * FROM Customer_Feedback
WHERE MOD(Rating, 2) = 1;

-- Update Response_Status to 'Acknowledged' where Rating = 3 OR Channel = 'Branch'
UPDATE Customer_Feedback
SET Response_Status = 'Acknowledged'
WHERE Rating = 3 OR Channel = 'Branch';

-- Delete feedbacks with Rating = 2 and Response_Status Pending
DELETE FROM Customer_Feedback
WHERE Rating = 2 AND Response_Status = 'Pending';

-- Select feedbacks handled by Employee_ID between 2 and 4
SELECT * FROM Customer_Feedback
WHERE Handled_By BETWEEN 2 AND 4;

-- Update Comments for Branch feedbacks by prepending 'Branch Review: '
UPDATE Customer_Feedback
SET Comments = CONCAT('Branch Review: ', Comments)
WHERE Channel = 'Branch';

-- Select feedbacks where Rating + 1 is greater than 4 AND Response_Status = 'Acknowledged'
SELECT * FROM Customer_Feedback
WHERE Rating + 1 > 4 AND Response_Status = 'Acknowledged';



-- Table 20: Bill_Payments

-- Select all payments greater than 1000
SELECT * FROM Bill_Payments
WHERE Amount > 1000;

-- Update Status to 'Failed' for payments where Amount > 1500
UPDATE Bill_Payments
SET Status = 'Failed'
WHERE Amount > 1500;

-- Delete payments that failed
DELETE FROM Bill_Payments
WHERE Status = 'Failed';

-- Select payments done via UPI
SELECT * FROM Bill_Payments
WHERE Mode = 'UPI';

-- Update Amount by adding 50 to Electricity bills
UPDATE Bill_Payments
SET Amount = Amount + 50
WHERE Category = 'Electricity';

-- Select payments where Amount is between 500 and 1000
SELECT * FROM Bill_Payments
WHERE Amount BETWEEN 500 AND 1000;

-- Update Status to 'Successful' for Pending payments
UPDATE Bill_Payments
SET Status = 'Successful'
WHERE Status = 'Pending';

-- Select payments for Electricity or Gas category
SELECT * FROM Bill_Payments
WHERE Category = 'Electricity' OR Category = 'Gas';

-- Update Amount by multiplying by 1.05 for Internet bills
UPDATE Bill_Payments
SET Amount = Amount * 1.05
WHERE Category = 'Internet';

-- Delete payments done via Debit Card with Amount < 400
DELETE FROM Bill_Payments
WHERE Mode = 'Debit Card' AND Amount < 400;

-- Select payments in June 2024
SELECT * FROM Bill_Payments
WHERE MONTH(Payment_Date) = 6 AND YEAR(Payment_Date) = 2024;

-- Update Reference_No by appending '-UPDATED' for all NetBanking payments
UPDATE Bill_Payments
SET Reference_No = CONCAT(Reference_No, '-UPDATED')
WHERE Mode = 'NetBanking';

-- Select payments where Amount is odd
SELECT * FROM Bill_Payments
WHERE MOD(Amount,2) <> 0;

-- Update Status to 'Pending' for Mobile category payments less than 500
UPDATE Bill_Payments
SET Status = 'Pending'
WHERE Category = 'Mobile' AND Amount < 500;

-- Select payments where Status is Successful AND Amount > 1000
SELECT * FROM Bill_Payments
WHERE Status = 'Successful' AND Amount > 1000;

-- Update Amount by subtracting 20 for Gas category bills
UPDATE Bill_Payments
SET Amount = Amount - 20
WHERE Category = 'Gas';

-- Delete payments done via Credit Card with Amount < 1000
DELETE FROM Bill_Payments
WHERE Mode = 'Credit Card' AND Amount < 1000;

-- Select payments where Amount >= 1000 AND Category is Electricity
SELECT * FROM Bill_Payments
WHERE Amount >= 1000 AND Category = 'Electricity';

-- Update Status to 'Successful' for DTH payments made via Debit Card
UPDATE Bill_Payments
SET Status = 'Successful'
WHERE Category = 'DTH' AND Mode = 'Debit Card';

-- Select payments where Amount + 50 > 1000 AND Status is Pending
SELECT * FROM Bill_Payments
WHERE Amount + 50 > 1000 AND Status = 'Pending';



-- Table 21: Safe_Deposit_Visits

-- Select all visits that happened on 2024-06-10
SELECT * FROM Safe_Deposit_Visits
WHERE Visit_Date = '2024-06-10';

-- Update Comments for Locker_ID 1
UPDATE Safe_Deposit_Visits
SET Comments = 'Checked and verified'
WHERE Locker_ID = 1;

-- Delete visits verified by Employee_ID 10
DELETE FROM Safe_Deposit_Visits
WHERE Verified_By_Employee = 10;

-- Select visits with Time_In after 12:00
SELECT * FROM Safe_Deposit_Visits
WHERE Time_In > '12:00:00';

-- Update Purpose for visits of Customer_ID 5
UPDATE Safe_Deposit_Visits
SET Purpose = 'Updated Document Storage'
WHERE Customer_ID = 5;

-- Select visits where Time_Out - Time_In > 20 minutes
SELECT *, TIMESTAMPDIFF(MINUTE, Time_In, Time_Out) AS Duration_Minutes
FROM Safe_Deposit_Visits
WHERE TIMESTAMPDIFF(MINUTE, Time_In, Time_Out) > 20;

-- Update Time_Out by adding 5 minutes for Locker_ID 2
UPDATE Safe_Deposit_Visits
SET Time_Out = ADDTIME(Time_Out, '00:05:00')
WHERE Locker_ID = 2;

-- Delete visits with Purpose containing 'Jewellery'
DELETE FROM Safe_Deposit_Visits
WHERE Purpose LIKE '%Jewellery%';

-- Select visits verified by Employee_ID 1 OR Employee_ID 2
SELECT * FROM Safe_Deposit_Visits
WHERE Verified_By_Employee = 1 OR Verified_By_Employee = 2;

-- Update Comments by appending ' - Reviewed' for all visits
UPDATE Safe_Deposit_Visits
SET Comments = CONCAT(Comments, ' - Reviewed');

-- Select visits where Visit_Date is in June 2024
SELECT * FROM Safe_Deposit_Visits
WHERE MONTH(Visit_Date) = 6 AND YEAR(Visit_Date) = 2024;

-- Update Purpose to 'Confidential Storage' where Comments contain 'Confidential'
UPDATE Safe_Deposit_Visits
SET Purpose = 'Confidential Storage'
WHERE Comments LIKE '%Confidential%';

-- Select visits where Duration is less than 20 minutes
SELECT *, TIMESTAMPDIFF(MINUTE, Time_In, Time_Out) AS Duration_Minutes
FROM Safe_Deposit_Visits
WHERE TIMESTAMPDIFF(MINUTE, Time_In, Time_Out) < 20;

-- Update Time_In by subtracting 10 minutes for Customer_ID 3
UPDATE Safe_Deposit_Visits
SET Time_In = SUBTIME(Time_In, '00:10:00')
WHERE Customer_ID = 3;

-- Select visits for Locker_ID 1 AND Customer_ID 11
SELECT * FROM Safe_Deposit_Visits
WHERE Locker_ID = 1 AND Customer_ID = 11;

-- Update Verified_By_Employee to 5 where Purpose contains 'Document'
UPDATE Safe_Deposit_Visits
SET Verified_By_Employee = 5
WHERE Purpose LIKE '%Document%';

-- Delete visits with Comments containing 'Routine'
DELETE FROM Safe_Deposit_Visits
WHERE Comments LIKE '%Routine%';

-- Select visits where Time_In is before 11:00 AND Time_Out after 11:30
SELECT * FROM Safe_Deposit_Visits
WHERE Time_In < '11:00:00' AND Time_Out > '11:30:00';

-- Update Comments by replacing 'Locker' with 'Safe Locker'
UPDATE Safe_Deposit_Visits
SET Comments = REPLACE(Comments, 'Locker', 'Safe Locker');

-- Select visits with Duration between 20 and 30 minutes
SELECT *, TIMESTAMPDIFF(MINUTE, Time_In, Time_Out) AS Duration_Minutes
FROM Safe_Deposit_Visits
WHERE TIMESTAMPDIFF(MINUTE, Time_In, Time_Out) BETWEEN 20 AND 30;


-- Table 22: Mobile_Banking

-- Select all active mobile banking users
SELECT * FROM Mobile_Banking
WHERE App_Status = 'Active';

-- Update App_Version for Customer_ID 3
UPDATE Mobile_Banking
SET App_Version = 'v4.5.2'
WHERE Customer_ID = 3;

-- Delete records of inactive users
DELETE FROM Mobile_Banking
WHERE App_Status = 'Inactive';

-- Select Android users
SELECT * FROM Mobile_Banking
WHERE OS_Type = 'Android';

-- Update OTP_Enabled to FALSE for iOS users
UPDATE Mobile_Banking
SET OTP_Enabled = FALSE
WHERE OS_Type = 'iOS';

-- Select users who have both OTP and Biometric enabled
SELECT * FROM Mobile_Banking
WHERE OTP_Enabled = TRUE AND Biometric_Enabled = TRUE;

-- Update Biometric_Enabled to TRUE for Customer_ID 7
UPDATE Mobile_Banking
SET Biometric_Enabled = TRUE
WHERE Customer_ID = 7;

-- Select iOS users with App_Version 'v4.5.2'
SELECT * FROM Mobile_Banking
WHERE OS_Type = 'iOS' AND App_Version = 'v4.5.2';

-- Select users who are Active OR have Biometric Enabled
SELECT * FROM Mobile_Banking
WHERE App_Status = 'Active' OR Biometric_Enabled = TRUE;

-- Update App_Status to 'Inactive' for customers not logged in last 7 days
UPDATE Mobile_Banking
SET App_Status = 'Inactive'
WHERE Last_Login < NOW() - INTERVAL 7 DAY;

-- Select users who are Active AND Biometric Enabled
SELECT * FROM Mobile_Banking
WHERE App_Status = 'Active' AND Biometric_Enabled = TRUE;

-- Increment App_Version minor number for all Android users
UPDATE Mobile_Banking
SET App_Version = CONCAT('v4.5.', CAST(SUBSTRING(App_Version, 6, 1) + 1 AS CHAR))
WHERE OS_Type = 'Android';

--  Select users who are Android AND last login today
SELECT * FROM Mobile_Banking
WHERE OS_Type = 'Android' AND DATE(Last_Login) = CURDATE();

-- Update OTP_Enabled to TRUE for customers with App_Status 'Inactive'
UPDATE Mobile_Banking
SET OTP_Enabled = TRUE
WHERE App_Status = 'Inactive';

-- Select users with App_Version greater than 'v4.5.1'
SELECT * FROM Mobile_Banking
WHERE App_Version > 'v4.5.1';

--  Update App_Status to 'Active' for users with Biometric Enabled
UPDATE Mobile_Banking
SET App_Status = 'Active'
WHERE Biometric_Enabled = TRUE;

--  Select iOS users OR customers with App_Status 'Inactive'
SELECT * FROM Mobile_Banking
WHERE OS_Type = 'iOS' OR App_Status = 'Inactive';

--  Select users NOT Biometric Enabled
SELECT * FROM Mobile_Banking
WHERE Biometric_Enabled = FALSE;

--  Toggle OTP_Enabled for Customer_ID 2
UPDATE Mobile_Banking
SET OTP_Enabled = NOT OTP_Enabled
WHERE Customer_ID = 2;

-- Select all users sorted by Last_Login descending
SELECT * FROM Mobile_Banking
ORDER BY Last_Login DESC;


-- Table 23: UPI_Transactions

-- Select all transactions that happened on '2024-07-12'
SELECT * FROM UPI_Transactions
WHERE DATE(Transaction_Date) = '2024-07-12';

-- Update Status to 'Success' for Reference_No 'UPIREF1015'
UPDATE UPI_Transactions
SET Status = 'Success'
WHERE Reference_No = 'UPIREF1015';

-- Delete transactions with Status 'Failed'
DELETE FROM UPI_Transactions
WHERE Status = 'Failed';

-- Select transactions with Amount greater than 1000
SELECT * FROM UPI_Transactions
WHERE Amount > 1000;

-- Update Amount by adding 50 for transactions of Bank_Name 'SBI'
UPDATE UPI_Transactions
SET Amount = Amount + 50
WHERE Bank_Name = 'SBI';

-- Select transactions where Transaction_Type is 'Send'
SELECT * FROM UPI_Transactions
WHERE Transaction_Type = 'Send';

-- Update Bank_Name to 'ICICI Bank' for transactions where Sender_VPA contains 'ybl'
UPDATE UPI_Transactions
SET Bank_Name = 'ICICI Bank'
WHERE Sender_VPA LIKE '%ybl%';

-- Delete transactions where Amount is less than 500
DELETE FROM UPI_Transactions
WHERE Amount < 500;

-- Select transactions for Linked_Account_ID 1 or 2
SELECT * FROM UPI_Transactions
WHERE Linked_Account_ID = 1 OR Linked_Account_ID = 2;

-- Update Amount by multiplying 1.1 (increase by 10%) for all 'Send' transactions
UPDATE UPI_Transactions
SET Amount = Amount * 1.1
WHERE Transaction_Type = 'Send';

-- Select transactions where Amount is between 500 and 2000
SELECT * FROM UPI_Transactions
WHERE Amount BETWEEN 500 AND 2000;

-- Update Status to 'Pending' where Amount > 5000
UPDATE UPI_Transactions
SET Status = 'Pending'
WHERE Amount > 5000;

-- Select transactions where Sender_VPA is 'rahul@ybl' AND Status is 'Success'
SELECT * FROM UPI_Transactions
WHERE Sender_VPA = 'rahul@ybl' AND Status = 'Success';

-- Update Transaction_Type to 'Receive' where Receiver_VPA contains 'hdfc'
UPDATE UPI_Transactions
SET Transaction_Type = 'Receive'
WHERE Receiver_VPA LIKE '%hdfc%';

-- Delete transactions where Bank_Name is 'Axis Bank' AND Amount < 1000
DELETE FROM UPI_Transactions
WHERE Bank_Name = 'Axis Bank' AND Amount < 1000;

-- Select transactions where Transaction_Date is in July 2024
SELECT * FROM UPI_Transactions
WHERE MONTH(Transaction_Date) = 7 AND YEAR(Transaction_Date) = 2024;

-- Update Amount by subtracting 100 for transactions with Status 'Pending'
UPDATE UPI_Transactions
SET Amount = Amount - 100
WHERE Status = 'Pending';

-- Select transactions where Status is 'Success' OR Amount > 5000
SELECT * FROM UPI_Transactions
WHERE Status = 'Success' OR Amount > 5000;

-- Update Reference_No by appending '-UPDATED' for Bank_Name 'HDFC Bank'
UPDATE UPI_Transactions
SET Reference_No = CONCAT(Reference_No, '-UPDATED')
WHERE Bank_Name = 'HDFC Bank';

-- Select transactions where Amount > 1000 AND Transaction_Type = 'Send'
SELECT * FROM UPI_Transactions
WHERE Amount > 1000 AND Transaction_Type = 'Send';


-- Table 24: Service_Requests

-- Select all requests with Status 'Pending'
SELECT * FROM Service_Requests
WHERE Status = 'Pending';

-- Update Status to 'Completed' for Request_ID 4
UPDATE Service_Requests
SET Status = 'Completed'
WHERE Request_ID = 4;

-- Delete requests with Status 'Rejected'
DELETE FROM Service_Requests
WHERE Status = 'Rejected';

-- Select requests with Priority 'High'
SELECT * FROM Service_Requests
WHERE Priority = 'High';

-- Update Handled_By to 5 for all 'Credit Card' requests
UPDATE Service_Requests
SET Handled_By = 5
WHERE Request_Type = 'Credit Card';

-- Select requests for Customer_ID 1 OR Customer_ID 2
SELECT * FROM Service_Requests
WHERE Customer_ID = 1 OR Customer_ID = 2;

-- Delete requests handled by Employee_ID 10
DELETE FROM Service_Requests
WHERE Handled_By = 10;

-- Select requests where Request_Date is in June 2024
SELECT * FROM Service_Requests
WHERE MONTH(Request_Date) = 6 AND YEAR(Request_Date) = 2024;

-- Update Priority to 'High' for Pending requests
UPDATE Service_Requests
SET Priority = 'High'
WHERE Status = 'Pending';

-- Select requests where Status is 'Completed' AND Priority is 'Medium'
SELECT * FROM Service_Requests
WHERE Status = 'Completed' AND Priority = 'Medium';

-- Update Completion_Date to '2024-06-30' where Status is 'In Process'
UPDATE Service_Requests
SET Completion_Date = '2024-06-30'
WHERE Status = 'In Process';

-- Select requests where Request_Type contains 'Cheque'
SELECT * FROM Service_Requests
WHERE Request_Type LIKE '%Cheque%';

-- Delete requests with NULL Handled_By
DELETE FROM Service_Requests
WHERE Handled_By IS NULL;

-- Select requests with Priority 'Low' OR Request_Type = 'Mobile Update'
SELECT * FROM Service_Requests
WHERE Priority = 'Low' OR Request_Type = 'Mobile Update';

-- Update Remarks by appending ' - Verified' for Status 'Completed'
UPDATE Service_Requests
SET Remarks = CONCAT(Remarks, ' - Verified')
WHERE Status = 'Completed';

-- Select requests for Branch_ID 1 AND Status 'Completed'
SELECT * FROM Service_Requests
WHERE Branch_ID = 1 AND Status = 'Completed';

-- Update Status to 'In Process' for requests with Request_Date before '2024-06-15'
UPDATE Service_Requests
SET Status = 'In Process'
WHERE Request_Date < '2024-06-15';

-- Select requests where Completion_Date is NOT NULL
SELECT * FROM Service_Requests
WHERE Completion_Date IS NOT NULL;

-- Delete requests with Priority 'Low' AND Status 'Rejected'
DELETE FROM Service_Requests
WHERE Priority = 'Low' AND Status = 'Rejected';

-- Select requests where Request_Type = 'Account Statement' AND Status != 'Rejected'
SELECT * FROM Service_Requests
WHERE Request_Type = 'Account Statement' AND Status != 'Rejected';


-- Table 25: Credit_Scores

-- Select all credit scores with Score_Status 'Excellent'
SELECT * FROM Credit_Scores
WHERE Score_Status = 'Excellent';

-- Update Loan_Eligibility to TRUE for Credit_Score > 750
UPDATE Credit_Scores
SET Loan_Eligibility = TRUE
WHERE Credit_Score > 750;

-- Delete records where Score_Status is 'Poor'
DELETE FROM Credit_Scores
WHERE Score_Status = 'Poor';

-- Select customers with Credit_Utilization_Percentage > 50
SELECT * FROM Credit_Scores
WHERE Credit_Utilization_Percentage > 50;

-- Update Remarks to append ' - Reviewed' for all Excellent scores
UPDATE Credit_Scores
SET Remarks = CONCAT(Remarks, ' - Reviewed')
WHERE Score_Status = 'Excellent';

-- Select records where Score_Provider is 'CIBIL' OR 'Experian'
SELECT * FROM Credit_Scores
WHERE Score_Provider = 'CIBIL' OR Score_Provider = 'Experian';

-- Delete records with Loan_Eligibility = FALSE AND Credit_Score < 600
DELETE FROM Credit_Scores
WHERE Loan_Eligibility = FALSE AND Credit_Score < 600;

-- Select customers updated after '2024-06-10'
SELECT * FROM Credit_Scores
WHERE Last_Updated > '2024-06-10';

-- Update Credit_Utilization_Percentage by adding 5% for Score_Status 'Average'
UPDATE Credit_Scores
SET Credit_Utilization_Percentage = Credit_Utilization_Percentage + 5
WHERE Score_Status = 'Average';

-- Select records with Credit_Score BETWEEN 700 AND 800
SELECT * FROM Credit_Scores
WHERE Credit_Score BETWEEN 700 AND 800;

-- Update Score_Status to 'Good' where Credit_Score BETWEEN 650 AND 700
UPDATE Credit_Scores
SET Score_Status = 'Good'
WHERE Credit_Score BETWEEN 650 AND 700;

-- Select records where PAN_Number starts with 'AB' using LIKE
SELECT * FROM Credit_Scores
WHERE PAN_Number LIKE 'AB%';

-- Delete records with NULL Last_Updated
DELETE FROM Credit_Scores
WHERE Last_Updated IS NULL;

-- Select customers with Loan_Eligibility TRUE AND Credit_Utilization_Percentage < 30
SELECT * FROM Credit_Scores
WHERE Loan_Eligibility = TRUE AND Credit_Utilization_Percentage < 30;

-- Update Remarks by replacing 'High' with 'Elevated' in all records
UPDATE Credit_Scores
SET Remarks = REPLACE(Remarks, 'High', 'Elevated');

-- Select records where Score_Status != 'Poor'
SELECT * FROM Credit_Scores
WHERE Score_Status != 'Poor';

-- Update Credit_Score by subtracting 10 points for Loan_Eligibility FALSE
UPDATE Credit_Scores
SET Credit_Score = Credit_Score - 10
WHERE Loan_Eligibility = FALSE;

-- Select top 5 highest Credit_Score records
SELECT * FROM Credit_Scores
ORDER BY Credit_Score DESC
LIMIT 5;

-- Delete records where Credit_Utilization_Percentage > 70
DELETE FROM Credit_Scores
WHERE Credit_Utilization_Percentage > 70;

-- Select records where Score_Provider = 'Equifax' AND Credit_Score >= 800
SELECT * FROM Credit_Scores
WHERE Score_Provider = 'Equifax' AND Credit_Score >= 800;



