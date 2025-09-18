use HDFC_Bank;

-- Phase 3 (Alias, Joins, Functions, Subqueries, User-defined functions)


-- Table 1:

-- 1. Display full names of customers with an alias for better readability
SELECT CONCAT(c.First_Name, ' ', c.Last_Name) AS Full_Name, c.Gender
FROM Customers c;

-- 2. Find all customers who are older than the average age of all customers
SELECT CONCAT(First_Name, ' ', Last_Name) AS Full_Name, TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age
FROM Customers
WHERE TIMESTAMPDIFF(YEAR, DOB, CURDATE()) > (
    SELECT AVG(TIMESTAMPDIFF(YEAR, DOB, CURDATE())) FROM Customers
);

-- 3. Show the youngest and oldest customer using aggregate MIN and MAX on DOB
SELECT MIN(DOB) AS Oldest_DOB, MAX(DOB) AS Youngest_DOB
FROM Customers;

-- 4. List customers whose Aadhaar ends with '3' and PAN starts with 'A'
SELECT First_Name, Last_Name, Aadhaar_Number, PAN_Number
FROM Customers
WHERE Aadhaar_Number LIKE '%3'
  AND PAN_Number LIKE 'A%';

-- 5. Categorize customers into 'Minor', 'Adult', 'Senior' using CASE expression
SELECT CONCAT(First_Name, ' ', Last_Name) AS Full_Name,
       CASE 
           WHEN TIMESTAMPDIFF(YEAR, DOB, CURDATE()) < 18 THEN 'Minor'
           WHEN TIMESTAMPDIFF(YEAR, DOB, CURDATE()) BETWEEN 18 AND 60 THEN 'Adult'
           ELSE 'Senior'
       END AS Age_Group
FROM Customers;

-- 6. Find customers having the same last name as any other customer (self join)
SELECT DISTINCT c1.Last_Name, c1.First_Name, c2.First_Name AS Other_Customer
FROM Customers c1
JOIN Customers c2 ON c1.Last_Name = c2.Last_Name AND c1.Customer_ID <> c2.Customer_ID;

-- 7. Display first 5 characters of PAN and mask the rest
SELECT PAN_Number, CONCAT(LEFT(PAN_Number, 5), '*****') AS Masked_PAN
FROM Customers;

-- 8. Count number of male, female, and other customers
SELECT Gender, COUNT(*) AS Total_Customers
FROM Customers
GROUP BY Gender;

-- 9. Extract customers living in cities whose address contains 'Nagar'
SELECT First_Name, Last_Name, Address
FROM Customers
WHERE Address LIKE '%Nagar%';

-- 10. Find customers born in the month of May
SELECT First_Name, Last_Name, DOB
FROM Customers
WHERE MONTH(DOB) = 5;

-- 11. Rank customers by age in descending order
SELECT CONCAT(First_Name, ' ', Last_Name) AS Full_Name,
       TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age,
       RANK() OVER (ORDER BY DOB ASC) AS Age_Rank
FROM Customers;

-- 12. Find customers whose email domain is 'gmail.com'
SELECT First_Name, Last_Name, Email
FROM Customers
WHERE Email LIKE '%@gmail.com';

-- 13. Find customers whose phone number starts with '7' or '9'
SELECT First_Name, Last_Name, Mobile_Number
FROM Customers
WHERE Mobile_Number LIKE '7%' OR Mobile_Number LIKE '9%';

-- 14. List top 3 oldest customers
SELECT CONCAT(First_Name, ' ', Last_Name) AS Full_Name, DOB
FROM Customers
ORDER BY DOB ASC
LIMIT 3;

-- 15. Get customers whose Aadhaar number is not exactly 12 digits (data validation)
SELECT First_Name, Last_Name, Aadhaar_Number
FROM Customers
WHERE LENGTH(Aadhaar_Number) <> 12;

-- 16. Subquery: Find customers who share their birth year with at least 2 others
SELECT First_Name, Last_Name, YEAR(DOB) AS Birth_Year
FROM Customers
WHERE YEAR(DOB) IN (
    SELECT YEAR(DOB) FROM Customers
    GROUP BY YEAR(DOB)
    HAVING COUNT(*) >= 3
);

-- 17. Control flow: Label Aadhaar verification status based on length
SELECT First_Name, Last_Name,
       CASE WHEN LENGTH(Aadhaar_Number) = 12 THEN 'Valid Aadhaar'
            ELSE 'Invalid Aadhaar'
       END AS Aadhaar_Status
FROM Customers;

-- 18. Create and use a user-defined function to calculate customer age
DELIMITER //
CREATE FUNCTION GetAge(birthdate DATE) RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, birthdate, CURDATE());
END //
DELIMITER ;

SELECT First_Name, Last_Name, GetAge(DOB) AS Age
FROM Customers;

-- 19. Find customers living in the same city (approx by extracting city name as substring)
SELECT c1.First_Name, c1.Last_Name, c2.First_Name AS Other_Name, c2.Last_Name AS Other_Last
FROM Customers c1
JOIN Customers c2 ON SUBSTRING_INDEX(c1.Address, ',', -1) = SUBSTRING_INDEX(c2.Address, ',', -1)
AND c1.Customer_ID <> c2.Customer_ID;

-- 20. Find customers who do not have an email ID registered
SELECT First_Name, Last_Name, Mobile_Number
FROM Customers
WHERE Email IS NULL OR Email = '';


-- Table 2:

-- 1. Display branch names with their IFSC code using alias for readability
SELECT b.Branch_Name AS Branch, b.IFSC_Code AS IFSC
FROM Branches b;

-- 2. Find branches that share the same Branch_Name but are in different cities
SELECT b1.Branch_Name, b1.City AS City1, b2.City AS City2
FROM Branches b1
JOIN Branches b2 ON b1.Branch_Name = b2.Branch_Name 
AND b1.City <> b2.City;

-- 3. Show branches where the manager's first name and last name are reversed in two branches (self join with string functions)
SELECT b1.Manager_Name AS Manager1, b2.Manager_Name AS Manager2
FROM Branches b1
JOIN Branches b2 
  ON REVERSE(SUBSTRING_INDEX(b1.Manager_Name, ' ', 1)) = REVERSE(SUBSTRING_INDEX(b2.Manager_Name, ' ', -1))
 AND b1.Branch_ID <> b2.Branch_ID;

-- 4. Count total branches in each state
SELECT State, COUNT(*) AS Total_Branches
FROM Branches
GROUP BY State;

-- 5. Find branches where pincode is not exactly 6 digits (data quality check)
SELECT Branch_Name, Pincode
FROM Branches
WHERE LENGTH(Pincode) <> 6;

-- 6. Display manager names in uppercase along with branch city
SELECT UPPER(Manager_Name) AS Manager, City
FROM Branches;

-- 7. Show first 3 characters of IFSC code as bank identifier
SELECT IFSC_Code, LEFT(IFSC_Code, 3) AS Bank_Code
FROM Branches;

-- 8. Find branches located in cities ending with 'pur'
SELECT Branch_Name, City
FROM Branches
WHERE City LIKE '%pur';

-- 9. Rank branches by city name alphabetically
SELECT Branch_Name, City,
       RANK() OVER (ORDER BY City ASC) AS City_Rank
FROM Branches;

-- 10. Find managers who manage more than one branch
SELECT Manager_Name, COUNT(*) AS Branch_Count
FROM Branches
GROUP BY Manager_Name
HAVING COUNT(*) > 1;

-- 11. Subquery: List branches located in states where total branches > 2
SELECT Branch_Name, State
FROM Branches
WHERE State IN (
    SELECT State
    FROM Branches
    GROUP BY State
    HAVING COUNT(*) > 2
);

-- 12. Find branches with contact numbers starting with '9'
SELECT Branch_Name, Contact_Number
FROM Branches
WHERE Contact_Number LIKE '9%';

-- 13. Find the branch with the smallest MICR code numerically
SELECT Branch_Name, MICR_Code
FROM Branches
ORDER BY CAST(MICR_Code AS UNSIGNED) ASC
LIMIT 1;

-- 14. Display branches grouped by city with average MICR code value
SELECT City, AVG(CAST(MICR_Code AS UNSIGNED)) AS Avg_MICR
FROM Branches
GROUP BY City;

-- 15. Control flow: Categorize branches based on state zone (North, South, East, West)
SELECT Branch_Name, State,
       CASE 
         WHEN State IN ('Punjab', 'Haryana', 'Uttarakhand') THEN 'North Zone'
         WHEN State IN ('Tamil Nadu', 'Kerala', 'Karnataka') THEN 'South Zone'
         WHEN State IN ('West Bengal', 'Odisha', 'Bihar') THEN 'East Zone'
         ELSE 'Other Zone'
       END AS Zone
FROM Branches;

-- 16. Find duplicate branch names but with different IFSC codes
SELECT Branch_Name, COUNT(DISTINCT IFSC_Code) AS IFSC_Count
FROM Branches
GROUP BY Branch_Name
HAVING COUNT(DISTINCT IFSC_Code) > 1;

-- 17. List branches where manager name length is greater than 12 characters
SELECT Branch_Name, Manager_Name, LENGTH(Manager_Name) AS Name_Length
FROM Branches
WHERE LENGTH(Manager_Name) > 12;

-- 18. Create and use a user-defined function to extract state code from IFSC (characters 5–6)
DELIMITER //
CREATE FUNCTION GetStateCode(ifsc CHAR(11)) RETURNS CHAR(2)
DETERMINISTIC
BEGIN
    RETURN SUBSTRING(ifsc, 6, 2);
END //
DELIMITER ;

SELECT Branch_Name, IFSC_Code, GetStateCode(IFSC_Code) AS State_Code
FROM Branches;

-- 19. Find all branches in the same city but with different managers
SELECT b1.City, b1.Branch_Name AS Branch1, b2.Branch_Name AS Branch2,
       b1.Manager_Name AS Manager1, b2.Manager_Name AS Manager2
FROM Branches b1
JOIN Branches b2 ON b1.City = b2.City AND b1.Manager_Name <> b2.Manager_Name
AND b1.Branch_ID < b2.Branch_ID;

-- 20. Subquery: Find cities that host both 'Delhi HQ' and 'Kolkata Hub' branches
SELECT DISTINCT City
FROM Branches
WHERE City IN (
   SELECT City FROM Branches WHERE Branch_Name = 'Delhi HQ'
)
AND City IN (
   SELECT City FROM Branches WHERE Branch_Name = 'Kolkata Hub'
);



-- Table 3:

-- 1. Show all accounts with alias for columns to make report more readable
SELECT Account_Number AS Acc_No, Balance AS Current_Balance, Status AS Acc_Status
FROM Accounts;

-- 2. Find customers with accounts having balance more than average balance using subquery
SELECT Customer_ID, Account_Number, Balance
FROM Accounts a
WHERE Balance > (SELECT AVG(Balance) FROM Accounts);

-- 3. Get all active savings accounts along with branch info using inner join
SELECT a.Account_Number, a.Balance, b.Branch_Name
FROM Accounts a
INNER JOIN Branches b ON a.Branch_ID = b.Branch_ID
WHERE a.Account_Type = 'Savings' AND a.Status = 'Active';

-- 4. Show all accounts and their branch names using left join
SELECT a.Account_Number, b.Branch_Name
FROM Accounts a
LEFT JOIN Branches b ON a.Branch_ID = b.Branch_ID;

-- 5. Show all branches and their accounts using right join
SELECT a.Account_Number, b.Branch_Name
FROM Accounts a
RIGHT JOIN Branches b ON a.Branch_ID = b.Branch_ID;

-- 6. Full join equivalent to list accounts with branch names
SELECT a.Account_Number, b.Branch_Name
FROM Accounts a LEFT JOIN Branches b ON a.Branch_ID = b.Branch_ID
UNION
SELECT a.Account_Number, b.Branch_Name
FROM Accounts a RIGHT JOIN Branches b ON a.Branch_ID = b.Branch_ID;

-- 7. Left exclusive join to find accounts that do not have matching branch
SELECT a.Account_Number, a.Branch_ID
FROM Accounts a
LEFT JOIN Branches b ON a.Branch_ID = b.Branch_ID
WHERE b.Branch_ID IS NULL;

-- 8. Right exclusive join to find branches with no accounts
SELECT b.Branch_ID, b.Branch_Name
FROM Accounts a
RIGHT JOIN Branches b ON a.Branch_ID = b.Branch_ID
WHERE a.Account_ID IS NULL;

-- 9. Find total deposits grouped by account type
SELECT Account_Type, SUM(Balance) AS Total_Deposits
FROM Accounts
GROUP BY Account_Type;

-- 10. Find the highest balance account and display nominee name
SELECT Account_Number, Nominee_Name, Balance
FROM Accounts
ORDER BY Balance DESC
LIMIT 1;

-- 11. Get month-wise account openings using date function
SELECT MONTHNAME(Opening_Date) AS Month_Opened, COUNT(*) AS No_Of_Accounts
FROM Accounts
GROUP BY MONTHNAME(Opening_Date);

-- 12. Show accounts where IFSC code starts with HDFC0C using string function
SELECT Account_Number, IFSC_Code
FROM Accounts
WHERE IFSC_Code LIKE 'HDFC0C%';

-- 13. Round balances to nearest thousand for financial reporting
SELECT Account_Number, ROUND(Balance, -3) AS Rounded_Balance
FROM Accounts;

-- 14. Show accounts with low balance using control flow function CASE
SELECT Account_Number, Balance,
       CASE 
           WHEN Balance < 50000 THEN 'Low Balance'
           WHEN Balance BETWEEN 50000 AND 200000 THEN 'Medium Balance'
           ELSE 'High Balance'
       END AS Balance_Category
FROM Accounts;

-- 15. Count number of active accounts using aggregate function
SELECT COUNT(*) AS Active_Accounts
FROM Accounts
WHERE Status = 'Active';

-- 16. Find accounts opened in last 2 years using date functions
SELECT Account_Number, Opening_Date
FROM Accounts
WHERE Opening_Date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- 17. Display nominee names in uppercase using string function
SELECT Account_Number, UPPER(Nominee_Name) AS Nominee
FROM Accounts;

-- 18. Get average balance per branch using group by and aggregate function
SELECT Branch_ID, AVG(Balance) AS Avg_Balance
FROM Accounts
GROUP BY Branch_ID;

-- 19. User defined function to mask account number except last 4 digits
-- Example: 12345678901234 → **********1234
DELIMITER //
CREATE FUNCTION MaskAccountNumber(acc CHAR(14))
RETURNS CHAR(14)
DETERMINISTIC
BEGIN
   RETURN CONCAT('**********', RIGHT(acc, 4));
END //
DELIMITER ;

-- Use the user defined function
SELECT Account_Number, MaskAccountNumber(Account_Number) AS Masked_Account
FROM Accounts;

-- 20. User defined function to calculate years since account opening
DELIMITER //
CREATE FUNCTION YearsSinceOpening(open_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
   RETURN TIMESTAMPDIFF(YEAR, open_date, CURDATE());
END //
DELIMITER ;

-- Use the function
SELECT Account_Number, Opening_Date, YearsSinceOpening(Opening_Date) AS Years_Active
FROM Accounts;


-- Table -4:

-- 1. Show transaction details with simpler column names using aliases
SELECT Transaction_ID AS Txn_ID, Amount AS Txn_Amount, Mode AS Payment_Mode
FROM Transactions;

-- 2. Find transactions above the average amount using subquery
SELECT Transaction_ID, Amount, Mode
FROM Transactions t
WHERE Amount > (SELECT AVG(Amount) FROM Transactions);

-- 3. Show all debit transactions with corresponding account numbers using inner join
SELECT t.Transaction_ID, a.Account_Number, t.Amount, t.Transaction_Date
FROM Transactions t
INNER JOIN Accounts a ON t.Account_ID = a.Account_ID
WHERE t.Transaction_Type = 'Debit';

-- 4. List all transactions with account numbers, even if account info is missing using left join
SELECT t.Transaction_ID, a.Account_Number, t.Amount
FROM Transactions t
LEFT JOIN Accounts a ON t.Account_ID = a.Account_ID;

-- 5. Show accounts and their transactions, including accounts with no transactions using right join
SELECT a.Account_Number, t.Transaction_ID, t.Amount
FROM Transactions t
RIGHT JOIN Accounts a ON t.Account_ID = a.Account_ID;

-- 6. Full join equivalent to show all accounts and transactions
SELECT a.Account_Number, t.Transaction_ID, t.Amount
FROM Accounts a LEFT JOIN Transactions t ON a.Account_ID = t.Account_ID
UNION
SELECT a.Account_Number, t.Transaction_ID, t.Amount
FROM Accounts a RIGHT JOIN Transactions t ON a.Account_ID = t.Account_ID;

-- 7. Left exclusive join to find transactions that do not have any matching account
SELECT t.Transaction_ID, t.Amount, t.Account_ID
FROM Transactions t
LEFT JOIN Accounts a ON t.Account_ID = a.Account_ID
WHERE a.Account_ID IS NULL;

-- 8. Right exclusive join to find accounts with no transactions
SELECT a.Account_ID, a.Account_Number
FROM Accounts a
RIGHT JOIN Transactions t ON a.Account_ID = t.Account_ID
WHERE t.Transaction_ID IS NULL;

-- 9. Find total credited and debited amounts using group by
SELECT Transaction_Type, SUM(Amount) AS Total_Amount
FROM Transactions
GROUP BY Transaction_Type;

-- 10. Find the highest transaction amount and its reference number
SELECT Transaction_ID, Reference_No, Amount
FROM Transactions
ORDER BY Amount DESC
LIMIT 1;

-- 11. Get day-wise total transactions using date function
SELECT DATE(Transaction_Date) AS Txn_Date, COUNT(*) AS Total_Transactions
FROM Transactions
GROUP BY DATE(Transaction_Date);

-- 12. Show all transactions where reference number starts with J using string function
SELECT Transaction_ID, Reference_No, Amount
FROM Transactions
WHERE Reference_No LIKE 'J%';

-- 13. Round all transaction amounts to nearest hundred for reporting
SELECT Transaction_ID, ROUND(Amount, -2) AS Rounded_Amount
FROM Transactions;

-- 14. Categorize transactions based on amount using control flow
SELECT Transaction_ID, Amount,
       CASE
           WHEN Amount < 20000 THEN 'Small'
           WHEN Amount BETWEEN 20000 AND 60000 THEN 'Medium'
           ELSE 'Large'
       END AS Txn_Size
FROM Transactions;

-- 15. Count number of transactions done via each payment mode
SELECT Mode, COUNT(*) AS No_Of_Txns
FROM Transactions
GROUP BY Mode;

-- 16. Find transactions done in last 6 months using date functions
SELECT Transaction_ID, Amount, Transaction_Date
FROM Transactions
WHERE Transaction_Date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- 17. Display description of each transaction in uppercase using string function
SELECT Transaction_ID, UPPER(Description) AS Txn_Description
FROM Transactions;

-- 18. Find average transaction amount per branch
SELECT Branch_ID, AVG(Amount) AS Avg_Txn_Amount
FROM Transactions
GROUP BY Branch_ID;

-- 19. User defined function to mask reference number except last 4 characters
DELIMITER //
CREATE FUNCTION MaskReference(ref_no VARCHAR(20))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
   RETURN CONCAT('********', RIGHT(ref_no, 4));
END //
DELIMITER ;

-- Use the function
SELECT Transaction_ID, Reference_No, MaskReference(Reference_No) AS Masked_Ref
FROM Transactions;

-- 20. User defined function to calculate how many days ago a transaction happened
DELIMITER //
CREATE FUNCTION DaysSinceTxn(txn_date DATETIME)
RETURNS INT
DETERMINISTIC
BEGIN
   RETURN DATEDIFF(CURDATE(), DATE(txn_date));
END //
DELIMITER ;

-- Use the function
SELECT Transaction_ID, Transaction_Date, DaysSinceTxn(Transaction_Date) AS Days_Ago
FROM Transactions;


-- Table 5:

-- 1. Show employee full names with alias and format
SELECT CONCAT(e.First_Name, ' ', e.Last_Name) AS Full_Name, e.Position 
FROM Employees e;

-- 2. Find employees with salary above average salary using subquery
SELECT e.First_Name, e.Last_Name, e.Salary 
FROM Employees e
WHERE e.Salary > (SELECT AVG(Salary) FROM Employees);

-- 3. Find each branch and number of employees using INNER JOIN with Branches
SELECT b.Branch_Name, COUNT(e.Employee_ID) AS Total_Employees
FROM Employees e
INNER JOIN Branches b ON e.Branch_ID = b.Branch_ID
GROUP BY b.Branch_Name;

-- 4. List employees who have not been assigned to any branch using LEFT JOIN
SELECT e.First_Name, e.Last_Name, e.Branch_ID 
FROM Employees e
LEFT JOIN Branches b ON e.Branch_ID = b.Branch_ID
WHERE b.Branch_ID IS NULL;

-- 5. Find all branches with no employees using RIGHT JOIN
SELECT b.Branch_Name, e.Employee_ID 
FROM Employees e
RIGHT JOIN Branches b ON e.Branch_ID = b.Branch_ID
WHERE e.Employee_ID IS NULL;

-- 6. Simulate FULL OUTER JOIN (UNION of LEFT and RIGHT) between Employees and Branches
SELECT e.Employee_ID, e.First_Name, b.Branch_Name
FROM Employees e
LEFT JOIN Branches b ON e.Branch_ID = b.Branch_ID
UNION
SELECT e.Employee_ID, e.First_Name, b.Branch_Name
FROM Employees e
RIGHT JOIN Branches b ON e.Branch_ID = b.Branch_ID;

-- 7. Left exclusive join (employees whose branch does not exist in Branches)
SELECT e.Employee_ID, e.First_Name
FROM Employees e
LEFT JOIN Branches b ON e.Branch_ID = b.Branch_ID
WHERE b.Branch_ID IS NULL;

-- 8. Right exclusive join (branches without employees)
SELECT b.Branch_ID, b.Branch_Name
FROM Employees e
RIGHT JOIN Branches b ON e.Branch_ID = b.Branch_ID
WHERE e.Employee_ID IS NULL;

-- 9. Find employees who joined in the last 5 years using date function
SELECT e.First_Name, e.Last_Name, e.DOJ
FROM Employees e
WHERE e.DOJ >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 10. Get salary with tax deduction (10%) using numeric function ROUND
SELECT e.First_Name, e.Last_Name, e.Salary, 
       ROUND(e.Salary * 0.90, 2) AS Salary_After_Tax
FROM Employees e;

-- 11. Display employees and length of their email address using string function
SELECT e.First_Name, e.Last_Name, LENGTH(e.Email) AS Email_Length
FROM Employees e;

-- 12. Show employees with formatted DOJ (Month name and Year)
SELECT e.First_Name, e.Last_Name, DATE_FORMAT(e.DOJ, '%M %Y') AS Joining_Month
FROM Employees e;

-- 13. Find employees categorized as High/Medium/Low earners using CASE control flow
SELECT e.First_Name, e.Last_Name, e.Salary,
       CASE
         WHEN e.Salary > 80000 THEN 'High Earner'
         WHEN e.Salary BETWEEN 50000 AND 80000 THEN 'Medium Earner'
         ELSE 'Low Earner'
       END AS Salary_Category
FROM Employees e;

-- 14. Find top 3 highest paid employees using ORDER BY and LIMIT
SELECT e.First_Name, e.Last_Name, e.Salary
FROM Employees e
ORDER BY e.Salary DESC
LIMIT 3;

-- 15. Find branch with maximum number of employees using subquery
SELECT b.Branch_Name
FROM Branches b
WHERE b.Branch_ID = (
  SELECT e.Branch_ID 
  FROM Employees e
  GROUP BY e.Branch_ID
  ORDER BY COUNT(*) DESC
  LIMIT 1
);

-- 16. Find employees whose salary is above branch average using correlated subquery
SELECT e.First_Name, e.Last_Name, e.Branch_ID, e.Salary
FROM Employees e
WHERE e.Salary > (
  SELECT AVG(Salary) 
  FROM Employees 
  WHERE Branch_ID = e.Branch_ID
);

-- 17. Create a user-defined function to calculate annual bonus (10% of salary)
DELIMITER //
CREATE FUNCTION AnnualBonus(salary DECIMAL(10,2)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  RETURN salary * 0.10;
END //
DELIMITER ;

-- 18. Use user-defined function to calculate bonus for employees
SELECT e.First_Name, e.Last_Name, e.Salary, AnnualBonus(e.Salary) AS Bonus
FROM Employees e;

-- 19. Find employees whose name contains 'a' and show in uppercase using string function
SELECT UPPER(e.First_Name) AS FirstName_Upper, UPPER(e.Last_Name) AS LastName_Upper
FROM Employees e
WHERE e.First_Name LIKE '%a%';

-- 20. Find employees grouped by joining year and count them
SELECT YEAR(e.DOJ) AS Joining_Year, COUNT(*) AS Total_Joined
FROM Employees e
GROUP BY YEAR(e.DOJ)
ORDER BY Joining_Year;



-- Table 6:

-- 1. Retrieve all details of loans
SELECT * FROM Loans;

-- 2. Retrieve loans where loan amount is greater than the average loan amount
SELECT * FROM Loans
WHERE Loan_Amount > (SELECT AVG(Loan_Amount) FROM Loans);

-- 3. Retrieve customer name and loan amount using alias for better readability
SELECT Customer_Name AS Borrower, Loan_Amount AS Amount
FROM Loans;

-- 4. Retrieve loan details along with customer name by joining Loans and Customers table
SELECT L.Loan_ID, L.Loan_Amount, C.Customer_Name
FROM Loans L
JOIN Customers C ON L.Customer_ID = C.Customer_ID;

-- 5. Retrieve loan details along with branch name
SELECT L.Loan_ID, L.Loan_Amount, B.Branch_Name
FROM Loans L
JOIN Branches B ON L.Branch_ID = B.Branch_ID;

-- 6. Retrieve all loans and their repayment transactions
SELECT L.Loan_ID, L.Loan_Amount, T.Transaction_ID, T.Amount
FROM Loans L
JOIN Transactions T ON L.Loan_ID = T.Loan_ID;

-- 7. Retrieve loans and their linked account numbers
SELECT L.Loan_ID, L.Loan_Amount, A.Account_Number
FROM Loans L
JOIN Accounts A ON L.Customer_ID = A.Customer_ID;

-- 8. Retrieve loans with their corresponding fixed deposits
SELECT L.Loan_ID, L.Loan_Amount, F.FD_Amount
FROM Loans L
JOIN Fixed_Deposits F ON L.Customer_ID = F.Customer_ID;

-- 9. Retrieve the total loan amount issued by the bank
SELECT SUM(Loan_Amount) AS Total_Loan_Amount
FROM Loans;

-- 10. Retrieve the average loan amount taken by customers
SELECT AVG(Loan_Amount) AS Average_Loan_Amount
FROM Loans;

-- 11. Retrieve loans issued in the current year
SELECT * FROM Loans
WHERE YEAR(Issue_Date) = YEAR(CURDATE());

-- 12. Retrieve the first three characters of each loan type
SELECT Loan_ID, LEFT(Loan_Type, 3) AS Loan_Type_Code
FROM Loans;

-- 13. Retrieve loan amount rounded to nearest thousand
SELECT Loan_ID, ROUND(Loan_Amount, -3) AS Rounded_Loan_Amount
FROM Loans;

-- 14. Retrieve loan ID and check if the loan amount is high or low
SELECT Loan_ID,
    CASE 
        WHEN Loan_Amount > 500000 THEN 'High Loan'
        ELSE 'Low Loan'
    END AS Loan_Status
FROM Loans;

-- 15. Retrieve the maximum and minimum loan amounts issued
SELECT MAX(Loan_Amount) AS Highest_Loan, MIN(Loan_Amount) AS Smallest_Loan
FROM Loans;

-- 16. Retrieve loans along with the month they were issued
SELECT Loan_ID, Loan_Amount, MONTHNAME(Issue_Date) AS Issue_Month
FROM Loans;

-- 17. Retrieve loan types in uppercase format
SELECT Loan_ID, UPPER(Loan_Type) AS Loan_Type_Upper
FROM Loans;

-- 18. Retrieve the number of loans issued to each branch
SELECT Branch_ID, COUNT(*) AS Total_Loans
FROM Loans
GROUP BY Branch_ID;

-- 19. Create a user defined function to calculate annual interest for each loan
DELIMITER //
CREATE FUNCTION CalculateAnnualInterest(principal DECIMAL(10,2), rate DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE interest DECIMAL(10,2);
    SET interest = (principal * rate) / 100;
    RETURN interest;
END //
DELIMITER ;

-- Use the function to calculate interest for each loan
SELECT Loan_ID, CalculateAnnualInterest(Loan_Amount, Interest_Rate) AS Annual_Interest
FROM Loans;

-- 20. Create a user defined function to check loan risk category based on amount
DELIMITER //
CREATE FUNCTION LoanRiskCategory(amount DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(20);
    IF amount > 1000000 THEN
        SET category = 'High Risk';
    ELSEIF amount BETWEEN 500000 AND 1000000 THEN
        SET category = 'Medium Risk';
    ELSE
        SET category = 'Low Risk';
    END IF;
    RETURN category;
END //
DELIMITER ;

-- Use the function to display loan risk category
SELECT Loan_ID, Loan_Amount, LoanRiskCategory(Loan_Amount) AS Risk_Level
FROM Loans;


-- Table 7:

-- 1. Get all active credit cards along with their limits
SELECT Card_ID, Card_Number, Card_Limit
FROM Cards
WHERE Status = 'Active' AND Card_Type = 'Credit';

-- 2. Find customers who have both debit and credit cards
SELECT Customer_ID
FROM Cards
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Card_Type) = 2;

-- 3. Show customer names along with their card type and status
SELECT c.Customer_Name, cr.Card_Type, cr.Status
FROM Customers c
INNER JOIN Cards cr ON c.Customer_ID = cr.Customer_ID;

-- 4. List all customers who don’t have a card assigned
SELECT c.Customer_Name
FROM Customers c
LEFT JOIN Cards cr ON c.Customer_ID = cr.Customer_ID
WHERE cr.Card_ID IS NULL;

-- 5. Show all blocked cards and their branch names
SELECT cr.Card_Number, b.Branch_Name
FROM Cards cr
INNER JOIN Branches b ON cr.Branch_ID = b.Branch_ID
WHERE cr.Status = 'Blocked';

-- 6. Display all expired cards with their customer name and branch
SELECT c.Customer_Name, cr.Card_Number, b.Branch_Name
FROM Cards cr
INNER JOIN Customers c ON cr.Customer_ID = c.Customer_ID
INNER JOIN Branches b ON cr.Branch_ID = b.Branch_ID
WHERE cr.Status = 'Expired';

-- 7. Show customers who only have debit cards
SELECT DISTINCT c.Customer_Name
FROM Customers c
INNER JOIN Cards cr ON c.Customer_ID = cr.Customer_ID
WHERE cr.Card_Type = 'Debit'
AND c.Customer_ID NOT IN (
  SELECT Customer_ID FROM Cards WHERE Card_Type = 'Credit'
);

-- 8. Show customers who only have credit cards
SELECT DISTINCT c.Customer_Name
FROM Customers c
INNER JOIN Cards cr ON c.Customer_ID = cr.Customer_ID
WHERE cr.Card_Type = 'Credit'
AND c.Customer_ID NOT IN (
  SELECT Customer_ID FROM Cards WHERE Card_Type = 'Debit'
);

-- 9. Find the maximum card limit for each branch
SELECT Branch_ID, MAX(Card_Limit) AS Max_Limit
FROM Cards
WHERE Card_Type = 'Credit'
GROUP BY Branch_ID;

-- 10. Calculate average credit card limit across all branches
SELECT AVG(Card_Limit) AS Avg_Credit_Limit
FROM Cards
WHERE Card_Type = 'Credit';

-- 11. Find cards that will expire within the next 1 year
SELECT Card_Number, Expiry_Date
FROM Cards
WHERE Expiry_Date <= DATE_ADD(CURDATE(), INTERVAL 1 YEAR);

-- 12. Mask the card numbers by only showing the last 4 digits
SELECT CONCAT('XXXX-XXXX-XXXX-', RIGHT(Card_Number, 4)) AS Masked_Card
FROM Cards;

-- 13. Calculate total number of years since each card was issued
SELECT Card_ID, TIMESTAMPDIFF(YEAR, Issue_Date, CURDATE()) AS Years_Since_Issued
FROM Cards;

-- 14. Show card status message based on card type and status
SELECT Card_ID,
       CASE 
         WHEN Status = 'Active' AND Card_Type = 'Credit' THEN 'Credit card is ready for use'
         WHEN Status = 'Active' AND Card_Type = 'Debit' THEN 'Debit card is ready for use'
         WHEN Status = 'Blocked' THEN 'Card is blocked'
         WHEN Status = 'Expired' THEN 'Card expired, renewal required'
         ELSE 'Unknown status'
       END AS Status_Message
FROM Cards;

-- 15. Count how many cards are active, blocked, and expired
SELECT Status, COUNT(*) AS Total_Cards
FROM Cards
GROUP BY Status;

-- 16. Find cards that were issued more than 5 years ago
SELECT Card_ID, Card_Number, Issue_Date
FROM Cards
WHERE Issue_Date < DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 17. Display customer names in uppercase with their card number
SELECT UPPER(c.Customer_Name) AS Customer_Name, cr.Card_Number
FROM Customers c
INNER JOIN Cards cr ON c.Customer_ID = cr.Customer_ID;

-- 18. Show the total card limit assigned per customer across all credit cards
SELECT Customer_ID, SUM(Card_Limit) AS Total_Limit
FROM Cards
WHERE Card_Type = 'Credit'
GROUP BY Customer_ID;

-- 19. Create a user defined function to calculate remaining validity in years for a card
DELIMITER //
CREATE FUNCTION CardValidityYears(expiry DATE)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE years_left INT;
  SET years_left = TIMESTAMPDIFF(YEAR, CURDATE(), expiry);
  RETURN years_left;
END //
DELIMITER ;

-- Use the function to show validity left for each active card
SELECT Card_ID, Card_Number, CardValidityYears(Expiry_Date) AS Years_Left
FROM Cards
WHERE Status = 'Active';

-- 20. Create a user defined function to categorize card limits
DELIMITER //
CREATE FUNCTION CardLimitCategory(limit_value DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
  DECLARE category VARCHAR(20);
  IF limit_value < 100000 THEN
    SET category = 'Low Limit';
  ELSEIF limit_value BETWEEN 100000 AND 200000 THEN
    SET category = 'Medium Limit';
  ELSE
    SET category = 'High Limit';
  END IF;
  RETURN category;
END //
DELIMITER ;

-- Use the function to categorize credit cards
SELECT Card_ID, Card_Number, Card_Limit, CardLimitCategory(Card_Limit) AS Limit_Category
FROM Cards
WHERE Card_Type = 'Credit';



-- Table 8:

-- 1. Get all operational ATMs in Mumbai
SELECT ATM_ID, Location, Cash_Available
FROM ATMs
WHERE City = 'Mumbai' AND Status = 'Operational';

-- 2. Find cities where there are both on-site and off-site ATMs
SELECT City
FROM ATMs
GROUP BY City
HAVING COUNT(DISTINCT Type) = 2;

-- 3. Show ATM locations with their branch names
SELECT a.Location, b.Branch_Name
FROM ATMs a
INNER JOIN Branches b ON a.Branch_ID = b.Branch_ID;

-- 4. Find all branches that do not have any ATMs
SELECT b.Branch_Name
FROM Branches b
LEFT JOIN ATMs a ON b.Branch_ID = a.Branch_ID
WHERE a.ATM_ID IS NULL;

-- 5. Show all ATMs that are out of service with their city and branch
SELECT a.ATM_ID, a.City, b.Branch_Name
FROM ATMs a
INNER JOIN Branches b ON a.Branch_ID = b.Branch_ID
WHERE a.Status = 'Out of Service';

-- 6. List under maintenance ATMs and their installation year
SELECT a.ATM_ID, a.Location, YEAR(a.Installed_Date) AS Install_Year
FROM ATMs a
WHERE a.Status = 'Under Maintenance';

-- 7. Show cities that only have on-site ATMs
SELECT DISTINCT City
FROM ATMs a
WHERE Type = 'On-site'
AND City NOT IN (SELECT City FROM ATMs WHERE Type = 'Off-site');

-- 8. Show cities that only have off-site ATMs
SELECT DISTINCT City
FROM ATMs a
WHERE Type = 'Off-site'
AND City NOT IN (SELECT City FROM ATMs WHERE Type = 'On-site');

-- 9. Find the maximum cash available in each city
SELECT City, MAX(Cash_Available) AS Max_Cash
FROM ATMs
GROUP BY City;

-- 10. Calculate the average cash available across all operational ATMs
SELECT AVG(Cash_Available) AS Avg_Cash
FROM ATMs
WHERE Status = 'Operational';

-- 11. Find ATMs that were installed more than 5 years ago
SELECT ATM_ID, Location, Installed_Date
FROM ATMs
WHERE Installed_Date < DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 12. Display ATM locations with city names in uppercase
SELECT UPPER(City) AS City_Name, Location
FROM ATMs;

-- 13. Calculate the number of years each ATM has been in operation
SELECT ATM_ID, TIMESTAMPDIFF(YEAR, Installed_Date, CURDATE()) AS Years_Operational
FROM ATMs;

-- 14. Show cash availability status messages based on balance
SELECT ATM_ID, 
       CASE 
         WHEN Cash_Available = 0 THEN 'ATM empty or out of service'
         WHEN Cash_Available BETWEEN 1 AND 1000000 THEN 'Low cash level'
         WHEN Cash_Available BETWEEN 1000001 AND 2000000 THEN 'Moderate cash level'
         ELSE 'High cash level'
       END AS Cash_Status
FROM ATMs;

-- 15. Count the number of ATMs in each status category
SELECT Status, COUNT(*) AS Total_ATMs
FROM ATMs
GROUP BY Status;

-- 16. Show ATMs installed in the last 2 years
SELECT ATM_ID, Location, Installed_Date
FROM ATMs
WHERE Installed_Date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- 17. Mask ATM IDs by showing only last 3 digits
SELECT CONCAT('ATM-', RIGHT(ATM_ID, 3)) AS Masked_ATM
FROM ATMs;

-- 18. Show the total cash available per branch across all ATMs
SELECT Branch_ID, SUM(Cash_Available) AS Total_Cash
FROM ATMs
GROUP BY Branch_ID;

-- 19. Create a user defined function to calculate ATM age in years
DELIMITER //
CREATE FUNCTION ATMAge(install_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE age INT;
  SET age = TIMESTAMPDIFF(YEAR, install_date, CURDATE());
  RETURN age;
END //
DELIMITER ;

-- Use the function to show ATM age
SELECT ATM_ID, Location, ATMAge(Installed_Date) AS ATM_Age
FROM ATMs;

-- 20. Create a user defined function to classify ATMs based on cash available
DELIMITER //
CREATE FUNCTION ATMCashCategory(cash DECIMAL(12,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
  DECLARE category VARCHAR(20);
  IF cash = 0 THEN
    SET category = 'Empty';
  ELSEIF cash < 1000000 THEN
    SET category = 'Low Cash';
  ELSEIF cash BETWEEN 1000000 AND 2000000 THEN
    SET category = 'Moderate Cash';
  ELSE
    SET category = 'High Cash';
  END IF;
  RETURN category;
END //
DELIMITER ;

-- Use the function to categorize ATMs
SELECT ATM_ID, Location, Cash_Available, ATMCashCategory(Cash_Available) AS Cash_Category
FROM ATMs;



-- Table 9:

-- 1. Retrieve all cheque details with shorter column names for easier readability
SELECT Cheque_ID AS ID, Cheque_Number AS ChqNo, Payee_Name AS Payee, Amount AS Amt, Status 
FROM Cheques;

-- 2. Find all cheques that have an amount higher than the average cheque amount
SELECT Cheque_Number, Payee_Name, Amount
FROM Cheques
WHERE Amount > (SELECT AVG(Amount) FROM Cheques);

-- 3. Display cheque details along with corresponding account holder’s name using INNER JOIN
SELECT c.Cheque_Number, c.Payee_Name, c.Amount, a.Account_Holder_Name
FROM Cheques c
INNER JOIN Accounts a ON c.Account_ID = a.Account_ID;

-- 4. Show all cheques along with branch names using LEFT JOIN
SELECT c.Cheque_Number, c.Payee_Name, b.Branch_Name
FROM Cheques c
LEFT JOIN Branches b ON c.Branch_ID = b.Branch_ID;

-- 5. Find all branches that do not have any cheques issued (RIGHT EXCLUSIVE JOIN)
SELECT b.Branch_Name
FROM Branches b
LEFT JOIN Cheques c ON b.Branch_ID = c.Branch_ID
WHERE c.Branch_ID IS NULL;

-- 6. List cheque number, payee, and status using RIGHT JOIN to ensure all accounts are covered
SELECT a.Account_Holder_Name, c.Cheque_Number, c.Status
FROM Accounts a
RIGHT JOIN Cheques c ON a.Account_ID = c.Account_ID;

-- 7. Get details of highest value cheque issued by each branch using correlated subquery
SELECT Cheque_Number, Payee_Name, Amount, Branch_ID
FROM Cheques c1
WHERE Amount = (
    SELECT MAX(Amount) FROM Cheques c2 WHERE c2.Branch_ID = c1.Branch_ID
);

-- 8. Show cheque details where cheque amount is more than all pending cheques of the same branch
SELECT Cheque_Number, Payee_Name, Amount, Branch_ID
FROM Cheques c1
WHERE Amount > ALL (
    SELECT Amount FROM Cheques c2 
    WHERE c2.Branch_ID = c1.Branch_ID AND c2.Status = 'Pending'
);

-- 9. Find the total cheque amount issued from each branch
SELECT Branch_ID, SUM(Amount) AS Total_Issued
FROM Cheques
GROUP BY Branch_ID;

-- 10. Calculate the average cheque amount issued to each payee
SELECT Payee_Name, AVG(Amount) AS Avg_Amt
FROM Cheques
GROUP BY Payee_Name;

-- 11. Display all cheques issued in the month of May 2024
SELECT Cheque_Number, Payee_Name, Issue_Date, Amount
FROM Cheques
WHERE MONTH(Issue_Date) = 5 AND YEAR(Issue_Date) = 2024;

-- 12. Show cheque number, payee, and length of payee name using a string function
SELECT Cheque_Number, Payee_Name, LENGTH(Payee_Name) AS Name_Length
FROM Cheques;

-- 13. Find cheque number and round off the amount to nearest thousand
SELECT Cheque_Number, Amount, ROUND(Amount, -3) AS Rounded_Amount
FROM Cheques;

-- 14. Classify cheques into categories based on amount
SELECT Cheque_Number, Amount,
       CASE 
         WHEN Amount < 5000 THEN 'Small'
         WHEN Amount BETWEEN 5000 AND 50000 THEN 'Medium'
         ELSE 'Large'
       END AS Cheque_Category
FROM Cheques;

-- 15. Find the maximum cheque amount for each cheque status
SELECT Status, MAX(Amount) AS Max_Amt
FROM Cheques
GROUP BY Status;

-- 16. Retrieve cheque details along with the day of the week on which it was issued
SELECT Cheque_Number, Payee_Name, DAYNAME(Issue_Date) AS Issue_Day, Amount
FROM Cheques;

-- 17. Display payee names in uppercase for all pending cheques
SELECT Cheque_Number, UPPER(Payee_Name) AS Payee, Amount, Status
FROM Cheques
WHERE Status = 'Pending';

-- 18. Find the total number of cheques cleared in each branch
SELECT Branch_ID, COUNT(*) AS Cleared_Count
FROM Cheques
WHERE Status = 'Cleared'
GROUP BY Branch_ID;

-- 19. Create a user-defined function to calculate service charge of 1% on cheque amount
DELIMITER //
CREATE FUNCTION CalculateServiceCharge(chqAmt DECIMAL(12,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
   RETURN chqAmt * 0.01;
END //
DELIMITER ;

-- Use the above function to display cheque amounts along with calculated service charge
SELECT Cheque_Number, Amount, CalculateServiceCharge(Amount) AS Service_Charge
FROM Cheques;

-- 20. Create a user-defined function to check if a cheque is high value (above 1 lakh)
DELIMITER //
CREATE FUNCTION IsHighValueCheque(chqAmt DECIMAL(12,2))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
   RETURN IF(chqAmt > 100000, 'Yes', 'No');
END //
DELIMITER ;

-- Use the above function to flag cheques
SELECT Cheque_Number, Payee_Name, Amount, IsHighValueCheque(Amount) AS High_Value
FROM Cheques;



-- Table 10:

-- 1. Retrieve all fixed deposit details with short aliases for easy readability
SELECT FD_ID AS FDNo, Customer_ID AS CustID, Deposit_Amount AS Amount, Status
FROM Fixed_Deposits;

-- 2. Find all fixed deposits where the amount is higher than the average deposit amount
SELECT FD_ID, Customer_ID, Deposit_Amount
FROM Fixed_Deposits
WHERE Deposit_Amount > (SELECT AVG(Deposit_Amount) FROM Fixed_Deposits);

-- 3. Show fixed deposits with customer name and branch name using INNER JOIN
SELECT f.FD_ID, f.Deposit_Amount, c.Customer_Name, b.Branch_Name
FROM Fixed_Deposits f
INNER JOIN Customers c ON f.Customer_ID = c.Customer_ID
INNER JOIN Branches b ON f.Branch_ID = b.Branch_ID;

-- 4. List all fixed deposits including branch info even if no deposits exist (LEFT JOIN)
SELECT b.Branch_Name, f.FD_ID, f.Deposit_Amount
FROM Branches b
LEFT JOIN Fixed_Deposits f ON b.Branch_ID = f.Branch_ID;

-- 5. Show branches with no fixed deposits (LEFT EXCLUSIVE JOIN)
SELECT b.Branch_Name
FROM Branches b
LEFT JOIN Fixed_Deposits f ON b.Branch_ID = f.Branch_ID
WHERE f.FD_ID IS NULL;

-- 6. Retrieve fixed deposits along with customer info ensuring all deposits are listed (RIGHT JOIN)
SELECT c.Customer_Name, f.FD_ID, f.Deposit_Amount, f.Status
FROM Customers c
RIGHT JOIN Fixed_Deposits f ON c.Customer_ID = f.Customer_ID;

-- 7. Display the highest deposit in each branch using a correlated subquery
SELECT FD_ID, Customer_ID, Deposit_Amount, Branch_ID
FROM Fixed_Deposits f1
WHERE Deposit_Amount = (
    SELECT MAX(Deposit_Amount) FROM Fixed_Deposits f2 WHERE f2.Branch_ID = f1.Branch_ID
);

-- 8. Find deposits greater than all deposits by the same customer using ALL subquery
SELECT FD_ID, Customer_ID, Deposit_Amount
FROM Fixed_Deposits f1
WHERE Deposit_Amount > ALL (
    SELECT Deposit_Amount FROM Fixed_Deposits f2 
    WHERE f2.Customer_ID = f1.Customer_ID AND f2.FD_ID != f1.FD_ID
);

-- 9. Find total deposit amount per branch
SELECT Branch_ID, SUM(Deposit_Amount) AS Total_Deposits
FROM Fixed_Deposits
GROUP BY Branch_ID;

-- 10. Calculate average deposit amount per customer
SELECT Customer_ID, AVG(Deposit_Amount) AS Avg_Deposit
FROM Fixed_Deposits
GROUP BY Customer_ID;

-- 11. List all fixed deposits starting in the year 2023
SELECT FD_ID, Customer_ID, Start_Date, Deposit_Amount
FROM Fixed_Deposits
WHERE YEAR(Start_Date) = 2023;

-- 12. Show customer name length and deposit amount using string function
SELECT Customer_ID, LENGTH(Nominee_Name) AS Nominee_Name_Length, Deposit_Amount
FROM Fixed_Deposits;

-- 13. Round deposit amounts to nearest thousand
SELECT FD_ID, Deposit_Amount, ROUND(Deposit_Amount, -3) AS Rounded_Amount
FROM Fixed_Deposits;

-- 14. Categorize deposits based on amount
SELECT FD_ID, Deposit_Amount,
       CASE 
         WHEN Deposit_Amount < 200000 THEN 'Small'
         WHEN Deposit_Amount BETWEEN 200000 AND 500000 THEN 'Medium'
         ELSE 'Large'
       END AS Deposit_Category
FROM Fixed_Deposits;

-- 15. Find the maximum deposit amount for each status
SELECT Status, MAX(Deposit_Amount) AS Max_Deposit
FROM Fixed_Deposits
GROUP BY Status;

-- 16. Show FD details along with month of maturity
SELECT FD_ID, Deposit_Amount, MONTH(Maturity_Date) AS Maturity_Month
FROM Fixed_Deposits;

-- 17. Display all nominee names in uppercase
SELECT FD_ID, Nominee_Name, UPPER(Nominee_Name) AS Nominee_Upper
FROM Fixed_Deposits;

-- 18. Count number of active FDs in each branch
SELECT Branch_ID, COUNT(*) AS Active_FD_Count
FROM Fixed_Deposits
WHERE Status = 'Active'
GROUP BY Branch_ID;

-- 19. User-defined function to calculate interest earned on a FD
DELIMITER //
CREATE FUNCTION CalculateFDInterest(depAmt DECIMAL(12,2), rate DECIMAL(4,2), months INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
   RETURN (depAmt * rate * months) / (100 * 12);
END //
DELIMITER ;

-- Use the function to display interest for all FDs
SELECT FD_ID, Deposit_Amount, CalculateFDInterest(Deposit_Amount, Interest_Rate, Duration_Months) AS Interest_Earned
FROM Fixed_Deposits;

-- 20. User-defined function to flag high value deposits (above 5 lakh)
DELIMITER //
CREATE FUNCTION IsHighValueFD(depAmt DECIMAL(12,2))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
   RETURN IF(depAmt > 500000, 'Yes', 'No');
END //
DELIMITER ;

-- Use the function to flag deposits
SELECT FD_ID, Customer_ID, Deposit_Amount, IsHighValueFD(Deposit_Amount) AS High_Value
FROM Fixed_Deposits;



-- Table 11:

-- 1. Retrieve all online banking records
SELECT * FROM Online_Banking;

-- 2. Retrieve users who have never logged in
SELECT * FROM Online_Banking
WHERE Last_Login IS NULL;

-- 3. Retrieve usernames along with customer names
SELECT o.Username, c.Customer_Name
FROM Online_Banking o
JOIN Customers c ON o.Customer_ID = c.Customer_ID;

-- 4. Retrieve users along with their branch names and cities
SELECT o.Username, c.Customer_Name, b.Branch_Name, b.City
FROM Online_Banking o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
JOIN Branches b ON c.Branch_ID = b.Branch_ID;

-- 5. Retrieve users with the number of cheques issued by them
SELECT o.Username,
       (SELECT COUNT(*) 
        FROM Cheques ch 
        JOIN Accounts a ON ch.Account_ID = a.Account_ID 
        WHERE a.Customer_ID = o.Customer_ID) AS Total_Cheques
FROM Online_Banking o;

-- 6. Retrieve users with their linked account numbers
SELECT o.Username, a.Account_Number
FROM Online_Banking o
JOIN Accounts a ON o.Customer_ID = a.Customer_ID;

-- 7. Retrieve users with the total amount of their cheques
SELECT o.Username,
       (SELECT SUM(Amount) 
        FROM Cheques ch 
        JOIN Accounts a ON ch.Account_ID = a.Account_ID 
        WHERE a.Customer_ID = o.Customer_ID) AS Total_Cheque_Amount
FROM Online_Banking o;

-- 8. Retrieve usernames and branch names for users who logged in today
SELECT o.Username, b.Branch_Name
FROM Online_Banking o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
JOIN Branches b ON c.Branch_ID = b.Branch_ID
WHERE DATE(o.Last_Login) = CURDATE();

-- 9. Retrieve the total number of users per login status
SELECT Login_Status, COUNT(*) AS Total_Users
FROM Online_Banking
GROUP BY Login_Status;

-- 10. Retrieve the most recent login for each user
SELECT Username, MAX(Last_Login) AS Last_Active
FROM Online_Banking
GROUP BY Username;

-- 11. Retrieve users who logged in this month
SELECT Username, Last_Login
FROM Online_Banking
WHERE MONTH(Last_Login) = MONTH(CURDATE()) AND YEAR(Last_Login) = YEAR(CURDATE());

-- 12. Retrieve usernames in uppercase
SELECT Username, UPPER(Username) AS Username_Upper
FROM Online_Banking;

-- 13. Retrieve number of users per registered device
SELECT Registered_Device, COUNT(*) AS Users_Count
FROM Online_Banking
GROUP BY Registered_Device;

-- 14. Retrieve usernames with login status message
SELECT Username,
       CASE WHEN Login_Status='Blocked' THEN 'Access Denied' ELSE 'Active User' END AS Status_Message
FROM Online_Banking;

-- 15. Retrieve the first login of each user
SELECT Username, MIN(Last_Login) AS First_Login
FROM Online_Banking
GROUP BY Username;

-- 16. Retrieve users who logged in more than once today
SELECT Username, COUNT(*) AS Login_Count
FROM Online_Banking
WHERE DATE(Last_Login) = CURDATE()
GROUP BY Username
HAVING COUNT(*) > 1;

-- 17. Retrieve first 5 characters of usernames
SELECT Username, LEFT(Username,5) AS Short_Username
FROM Online_Banking;

-- 18. Retrieve users with their total loans amount
SELECT o.Username,
       (SELECT SUM(Loan_Amount)
        FROM Loans l
        WHERE l.Customer_ID = o.Customer_ID) AS Total_Loan_Amount
FROM Online_Banking o;

-- 19. Create a user-defined function to mask IP addresses
DELIMITER //
CREATE FUNCTION Mask_IP(ip VARCHAR(45))
RETURNS VARCHAR(45)
DETERMINISTIC
BEGIN
    RETURN CONCAT(SUBSTRING_INDEX(ip, '.', 2), '.xxx.xxx');
END //
DELIMITER ;

-- Use the function to display masked IP addresses
SELECT Username, Mask_IP(IP_Address) AS Masked_IP
FROM Online_Banking;

-- 20. Create a user-defined function to check login risk based on last login date
DELIMITER //
CREATE FUNCTION LoginRisk(last_login DATETIME)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE risk_level VARCHAR(20);
    IF DATEDIFF(NOW(), last_login) > 30 THEN
        SET risk_level = 'High Risk';
    ELSEIF DATEDIFF(NOW(), last_login) BETWEEN 15 AND 30 THEN
        SET risk_level = 'Medium Risk';
    ELSE
        SET risk_level = 'Low Risk';
    END IF;
    RETURN risk_level;
END //
DELIMITER ;

-- Use the function to display login risk for each user
SELECT Username, Last_Login, LoginRisk(Last_Login) AS Risk_Level
FROM Online_Banking;



-- Table 12:

-- 1. Retrieve all beneficiary details
SELECT * FROM Beneficiaries;

-- 2. Retrieve beneficiaries added in the last 7 days
SELECT * FROM Beneficiaries
WHERE Added_Date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY);

-- 3. Retrieve beneficiary name along with customer name
SELECT b.Name AS Beneficiary, c.Customer_Name
FROM Beneficiaries b
JOIN Customers c ON b.Customer_ID = c.Customer_ID;

-- 4. Retrieve beneficiaries along with their account numbers and bank names
SELECT b.Name, b.Account_Number, b.Bank_Name
FROM Beneficiaries b
JOIN Customers c ON b.Customer_ID = c.Customer_ID;

-- 5. Retrieve beneficiaries with the total number of cheques issued to their account
SELECT b.Name,
       (SELECT COUNT(*) 
        FROM Cheques ch 
        WHERE ch.Account_ID = b.Account_Number) AS Total_Cheques
FROM Beneficiaries b;

-- 6. Retrieve beneficiaries along with branch name of their linked customer
SELECT b.Name, br.Branch_Name
FROM Beneficiaries b
JOIN Customers c ON b.Customer_ID = c.Customer_ID
JOIN Branches br ON c.Branch_ID = br.Branch_ID;

-- 7. Retrieve beneficiaries whose account has cheques amounting to more than 50000
SELECT b.Name,
       (SELECT SUM(Amount) 
        FROM Cheques ch 
        WHERE ch.Account_ID = b.Account_Number) AS Total_Cheque_Amount
FROM Beneficiaries b
HAVING Total_Cheque_Amount > 50000;

-- 8. Retrieve internal beneficiaries only
SELECT Name, Account_Number, Type
FROM Beneficiaries
WHERE Type = 'Internal';

-- 9. Retrieve total beneficiaries added per customer
SELECT Customer_ID, COUNT(*) AS Total_Beneficiaries
FROM Beneficiaries
GROUP BY Customer_ID;

-- 10. Retrieve number of active and inactive beneficiaries
SELECT Status, COUNT(*) AS Count
FROM Beneficiaries
GROUP BY Status;

-- 11. Retrieve beneficiaries added this month
SELECT * FROM Beneficiaries
WHERE MONTH(Added_Date) = MONTH(CURDATE()) AND YEAR(Added_Date) = YEAR(CURDATE());

-- 12. Retrieve first 4 characters of beneficiary nicknames
SELECT Nickname, LEFT(Nickname, 4) AS Short_Nickname
FROM Beneficiaries;

-- 13. Retrieve account numbers ending with '56'
SELECT Name, Account_Number
FROM Beneficiaries
WHERE Account_Number LIKE '%56';

-- 14. Retrieve beneficiaries with a message based on status
SELECT Name,
       CASE WHEN Status='Active' THEN 'Can transact' ELSE 'Blocked' END AS Status_Message
FROM Beneficiaries;

-- 15. Retrieve the earliest added beneficiary
SELECT Name, MIN(Added_Date) AS First_Added
FROM Beneficiaries;

-- 16. Retrieve beneficiaries added on weekends
SELECT Name, Added_Date
FROM Beneficiaries
WHERE DAYOFWEEK(Added_Date) IN (1,7);

-- 17. Retrieve beneficiary names in uppercase
SELECT Name, UPPER(Name) AS Name_Upper
FROM Beneficiaries;

-- 18. Retrieve beneficiaries with their total loans (if any) of linked customer
SELECT b.Name,
       (SELECT SUM(Loan_Amount) 
        FROM Loans l
        WHERE l.Customer_ID = b.Customer_ID) AS Total_Loan_Amount
FROM Beneficiaries b;

-- 19. Create a user-defined function to mask account numbers
DELIMITER //
CREATE FUNCTION Mask_Account(acc BIGINT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    RETURN CONCAT('XXXXXX', RIGHT(acc,4));
END //
DELIMITER ;

-- Use the function to display masked account numbers
SELECT Name, Mask_Account(Account_Number) AS Masked_Account
FROM Beneficiaries;

-- 20. Create a user-defined function to check beneficiary type risk
DELIMITER //
CREATE FUNCTION BeneficiaryRisk(type ENUM('Internal','External'))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE risk VARCHAR(20);
    IF type='External' THEN
        SET risk='Higher Risk';
    ELSE
        SET risk='Lower Risk';
    END IF;
    RETURN risk;
END //
DELIMITER ;

-- Use the function to display risk level
SELECT Name, Type, BeneficiaryRisk(Type) AS Risk_Level
FROM Beneficiaries;



-- Table 13:

-- 1. Retrieve all details of lockers
SELECT * FROM Lockers;

-- 2. Retrieve lockers where rent amount is greater than the average rent
SELECT * FROM Lockers
WHERE Rent_Amount > (SELECT AVG(Rent_Amount) FROM Lockers);

-- 3. Retrieve locker ID and rent using aliases
SELECT Locker_ID AS ID, Rent_Amount AS Rent
FROM Lockers;

-- 4. Retrieve locker details along with branch name
SELECT L.Locker_ID, L.Locker_Size, B.Branch_Name
FROM Lockers L
JOIN Branches B ON L.Branch_ID = B.Branch_ID;

-- 5. Retrieve locker details along with customer name
SELECT L.Locker_ID, L.Locker_Size, C.Customer_Name
FROM Lockers L
JOIN Customers C ON L.Customer_ID = C.Customer_ID;

-- 6. Retrieve lockers along with customer and branch details
SELECT L.Locker_ID, L.Locker_Size, C.Customer_Name, B.Branch_Name
FROM Lockers L
JOIN Customers C ON L.Customer_ID = C.Customer_ID
JOIN Branches B ON L.Branch_ID = B.Branch_ID;

-- 7. Retrieve lockers with allocation date and corresponding branch city
SELECT L.Locker_ID, L.Allocation_Date, B.City
FROM Lockers L
JOIN Branches B ON L.Branch_ID = B.Branch_ID;

-- 8. Retrieve lockers along with customer accounts (via Accounts table)
SELECT L.Locker_ID, L.Locker_Size, A.Account_Number
FROM Lockers L
JOIN Accounts A ON L.Customer_ID = A.Customer_ID;

-- 9. Retrieve total rent amount of all lockers
SELECT SUM(Rent_Amount) AS Total_Rent
FROM Lockers;

-- 10. Retrieve average rent amount
SELECT AVG(Rent_Amount) AS Average_Rent
FROM Lockers;

-- 11. Retrieve lockers allocated this year
SELECT * FROM Lockers
WHERE YEAR(Allocation_Date) = YEAR(CURDATE());

-- 12. Retrieve first three letters of locker size
SELECT Locker_ID, LEFT(Locker_Size, 3) AS Size_Code
FROM Lockers;

-- 13. Retrieve rent rounded to nearest hundred
SELECT Locker_ID, ROUND(Rent_Amount, -2) AS Rounded_Rent
FROM Lockers;

-- 14. Retrieve locker status based on rent amount
SELECT Locker_ID,
    CASE
        WHEN Rent_Amount > 3000 THEN 'Premium Locker'
        ELSE 'Standard Locker'
    END AS Rent_Category
FROM Lockers;

-- 15. Retrieve maximum and minimum locker rent
SELECT MAX(Rent_Amount) AS Max_Rent, MIN(Rent_Amount) AS Min_Rent
FROM Lockers;

-- 16. Retrieve lockers along with month of allocation
SELECT Locker_ID, Locker_Size, MONTHNAME(Allocation_Date) AS Alloc_Month
FROM Lockers;

-- 17. Retrieve locker size in uppercase
SELECT Locker_ID, UPPER(Locker_Size) AS Locker_Size_Upper
FROM Lockers;

-- 18. Retrieve number of lockers allocated per branch
SELECT Branch_ID, COUNT(*) AS Total_Lockers
FROM Lockers
GROUP BY Branch_ID;

-- 19. Create a user defined function to calculate total rent for a locker duration
DELIMITER //
CREATE FUNCTION CalculateLockerRent(rent DECIMAL(10,2), months INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SET total = rent * months;
    RETURN total;
END //
DELIMITER ;

-- Use the function to calculate total rent for each locker (assuming 36 months duration)
SELECT Locker_ID, CalculateLockerRent(Rent_Amount, 36) AS Total_Rent_36Months
FROM Lockers;

-- 20. Create a user defined function to classify locker size
DELIMITER //
CREATE FUNCTION LockerSizeCategory(size ENUM('Small','Medium','Large'))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(20);
    IF size = 'Small' THEN
        SET category = 'Compact';
    ELSEIF size = 'Medium' THEN
        SET category = 'Standard';
    ELSE
        SET category = 'Spacious';
    END IF;
    RETURN category;
END //
DELIMITER ;

-- Use the function to display locker size category
SELECT Locker_ID, Locker_Size, LockerSizeCategory(Locker_Size) AS Size_Category
FROM Lockers;



-- Table 14:

-- 1. Retrieve all complaints
SELECT * FROM Complaints;

-- 2. Retrieve complaints assigned to employees whose ID is greater than 3
SELECT * FROM Complaints
WHERE Assigned_To_Employee > 3;

-- 3. Retrieve complaint ID and status using aliases
SELECT Complaint_ID AS ID, Status AS Current_Status
FROM Complaints;

-- 4. Retrieve complaint details along with customer name
SELECT C.Complaint_ID, C.Complaint_Type, CU.Customer_Name
FROM Complaints C
JOIN Customers CU ON C.Customer_ID = CU.Customer_ID;

-- 5. Retrieve complaint details along with employee name
SELECT C.Complaint_ID, C.Complaint_Type, E.Employee_Name
FROM Complaints C
JOIN Employees E ON C.Assigned_To_Employee = E.Employee_ID;

-- 6. Retrieve complaint ID, customer name, and assigned employee
SELECT C.Complaint_ID, CU.Customer_Name, E.Employee_Name
FROM Complaints C
JOIN Customers CU ON C.Customer_ID = CU.Customer_ID
JOIN Employees E ON C.Assigned_To_Employee = E.Employee_ID;

-- 7. Retrieve complaints along with feedback ratings and customer names
SELECT C.Complaint_ID, C.Feedback_Rating, CU.Customer_Name
FROM Complaints C
JOIN Customers CU ON C.Customer_ID = CU.Customer_ID;

-- 8. Retrieve complaints assigned to employees in a certain department (using JOIN with Employees)
SELECT C.Complaint_ID, C.Complaint_Type, E.Employee_Name, E.Department
FROM Complaints C
JOIN Employees E ON C.Assigned_To_Employee = E.Employee_ID;

-- 9. Retrieve total number of complaints
SELECT COUNT(*) AS Total_Complaints
FROM Complaints;

-- 10. Retrieve average feedback rating
SELECT AVG(Feedback_Rating) AS Average_Rating
FROM Complaints
WHERE Feedback_Rating IS NOT NULL;

-- 11. Retrieve complaints registered this month
SELECT * FROM Complaints
WHERE MONTH(Complaint_Date) = MONTH(CURDATE()) AND YEAR(Complaint_Date) = YEAR(CURDATE());

-- 12. Retrieve first three letters of complaint type
SELECT Complaint_ID, LEFT(Complaint_Type, 3) AS Type_Code
FROM Complaints;

-- 13. Retrieve feedback rating rounded to nearest integer
SELECT Complaint_ID, ROUND(Feedback_Rating) AS Rounded_Rating
FROM Complaints;

-- 14. Categorize complaints based on feedback rating
SELECT Complaint_ID,
    CASE
        WHEN Feedback_Rating >= 4 THEN 'Good'
        WHEN Feedback_Rating BETWEEN 2 AND 3 THEN 'Average'
        ELSE 'Poor'
    END AS Feedback_Category
FROM Complaints;

-- 15. Retrieve maximum and minimum feedback rating
SELECT MAX(Feedback_Rating) AS Max_Rating, MIN(Feedback_Rating) AS Min_Rating
FROM Complaints;

-- 16. Retrieve complaints along with month of complaint
SELECT Complaint_ID, Complaint_Type, MONTHNAME(Complaint_Date) AS Complaint_Month
FROM Complaints;

-- 17. Retrieve complaint type in uppercase
SELECT Complaint_ID, UPPER(Complaint_Type) AS Complaint_Type_Upper
FROM Complaints;

-- 18. Retrieve number of complaints per complaint type
SELECT Complaint_Type, COUNT(*) AS Total_Complaints
FROM Complaints
GROUP BY Complaint_Type;

-- 19. Create a user defined function to calculate complaint resolution days
DELIMITER //
CREATE FUNCTION ResolutionDays(start_date DATE, end_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE days INT;
    IF end_date IS NOT NULL THEN
        SET days = DATEDIFF(end_date, start_date);
    ELSE
        SET days = NULL;
    END IF;
    RETURN days;
END //
DELIMITER ;

-- Use the function to calculate resolution days for each complaint
SELECT Complaint_ID, Complaint_Date, Resolution_Date, ResolutionDays(Complaint_Date, Resolution_Date) AS Days_To_Resolve
FROM Complaints;

-- 20. Create a user defined function to check if a complaint is resolved
DELIMITER //
CREATE FUNCTION IsResolved(status ENUM('Open', 'Resolved', 'In Progress'))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(10);
    IF status = 'Resolved' THEN
        SET result = 'Yes';
    ELSE
        SET result = 'No';
    END IF;
    RETURN result;
END //
DELIMITER ;

-- Use the function to display resolved status
SELECT Complaint_ID, Status, IsResolved(Status) AS Resolved
FROM Complaints;


-- Table 15:

-- 1. Retrieve policies along with start and end dates for each customer
SELECT C.Customer_Name, I.Policy_Number, I.Start_Date, I.End_Date
FROM Insurance_Policies I
JOIN Customers C ON I.Customer_ID = C.Customer_ID;

-- 2. Retrieve policies with premium amount greater than the average
SELECT * FROM Insurance_Policies
WHERE Premium_Amount > (SELECT AVG(Premium_Amount) FROM Insurance_Policies);

-- 3. Retrieve policy ID and type using aliases
SELECT Policy_ID AS ID, Policy_Type AS Type
FROM Insurance_Policies;

-- 4. Count of policies per type
SELECT Policy_Type, COUNT(*) AS Total_Policies
FROM Insurance_Policies
GROUP BY Policy_Type;

-- 5. Retrieve active policies and customer names
SELECT I.Policy_ID, I.Policy_Type, I.Status, C.Customer_Name
FROM Insurance_Policies I
JOIN Customers C ON I.Customer_ID = C.Customer_ID
WHERE I.Status = 'Active';

-- 6. Retrieve first 3 letters of each policy type
SELECT Policy_ID, LEFT(Policy_Type, 3) AS Policy_Code
FROM Insurance_Policies;

-- 7. Maximum and minimum premium amounts
SELECT MAX(Premium_Amount) AS Max_Premium, MIN(Premium_Amount) AS Min_Premium
FROM Insurance_Policies;

-- 8. Retrieve policies along with customer and nominee details
SELECT I.Policy_ID, C.Customer_Name, I.Nominee_Name
FROM Insurance_Policies I
JOIN Customers C ON I.Customer_ID = C.Customer_ID;

-- 9. Retrieve policies along with total premium amount per customer
SELECT C.Customer_Name, SUM(I.Premium_Amount) AS Total_Premium
FROM Insurance_Policies I
JOIN Customers C ON I.Customer_ID = C.Customer_ID
GROUP BY C.Customer_Name;

-- 10. Retrieve all insurance policies
SELECT * FROM Insurance_Policies;

-- 11. Retrieve policies that started this year
SELECT * FROM Insurance_Policies
WHERE YEAR(Start_Date) = YEAR(CURDATE());

-- 12. Retrieve policy type in uppercase
SELECT Policy_ID, UPPER(Policy_Type) AS Policy_Type_Upper
FROM Insurance_Policies;

-- 13. Retrieve premium amount rounded to nearest hundred
SELECT Policy_ID, ROUND(Premium_Amount, -2) AS Rounded_Premium
FROM Insurance_Policies;

-- 14. Categorize policies based on premium amount
SELECT Policy_ID,
    CASE
        WHEN Premium_Amount > 10000 THEN 'High Premium'
        WHEN Premium_Amount BETWEEN 5000 AND 10000 THEN 'Medium Premium'
        ELSE 'Low Premium'
    END AS Premium_Category
FROM Insurance_Policies;

-- 15. Average premium amount across all policies
SELECT AVG(Premium_Amount) AS Average_Premium
FROM Insurance_Policies;

-- 16. Retrieve policies along with start month
SELECT Policy_ID, Policy_Type, MONTHNAME(Start_Date) AS Start_Month
FROM Insurance_Policies;

-- 17. Retrieve policies along with customer name
SELECT I.Policy_ID, I.Policy_Type, C.Customer_Name
FROM Insurance_Policies I
JOIN Customers C ON I.Customer_ID = C.Customer_ID;

-- 18. Total premium amount for all policies
SELECT SUM(Premium_Amount) AS Total_Premium_Amount
FROM Insurance_Policies;

-- 19. User defined function to calculate policy duration in days
DELIMITER //
CREATE FUNCTION PolicyDuration(start_date DATE, end_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE duration INT;
    SET duration = DATEDIFF(end_date, start_date);
    RETURN duration;
END //
DELIMITER ;

-- Use the function to calculate duration for each policy
SELECT Policy_ID, Start_Date, End_Date, PolicyDuration(Start_Date, End_Date) AS Duration_Days
FROM Insurance_Policies;

-- 20. User defined function to check if policy is active
DELIMITER //
CREATE FUNCTION IsPolicyActive(status ENUM('Active', 'Lapsed', 'Claimed'))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(10);
    IF status = 'Active' THEN
        SET result = 'Yes';
    ELSE
        SET result = 'No';
    END IF;
    RETURN result;
END //
DELIMITER ;

-- Use the function to display active status
SELECT Policy_ID, Status, IsPolicyActive(Status) AS Active_Status
FROM Insurance_Policies;



-- Table 16:

-- 1. Retrieve all recurring deposit details
SELECT * FROM Recurring_Deposits;

-- 2. Retrieve deposits where Total_Deposit is greater than the average deposit
SELECT * FROM Recurring_Deposits
WHERE Total_Deposit > (SELECT AVG(Total_Deposit) FROM Recurring_Deposits);

-- 3. Retrieve RD_ID and Total_Deposit using alias names
SELECT RD_ID AS Deposit_ID, Total_Deposit AS Amount
FROM Recurring_Deposits;

-- 4. Retrieve deposits along with customer names
SELECT RD.RD_ID, RD.Total_Deposit, C.Customer_Name
FROM Recurring_Deposits RD
JOIN Customers C ON RD.Customer_ID = C.Customer_ID;

-- 5. Retrieve deposits with account numbers
SELECT RD.RD_ID, RD.Monthly_Installment, A.Account_Number
FROM Recurring_Deposits RD
JOIN Accounts A ON RD.Account_ID = A.Account_ID;

-- 6. Retrieve deposits with customer and account details
SELECT RD.RD_ID, RD.Total_Deposit, C.Customer_Name, A.Account_Number
FROM Recurring_Deposits RD
JOIN Customers C ON RD.Customer_ID = C.Customer_ID
JOIN Accounts A ON RD.Account_ID = A.Account_ID;

-- 7. Retrieve deposits and months left to maturity
SELECT RD_ID, DATEDIFF(Maturity_Date, CURDATE())/30 AS Months_Left
FROM Recurring_Deposits;

-- 8. Retrieve total deposits per status
SELECT Status, SUM(Total_Deposit) AS Total_By_Status
FROM Recurring_Deposits
GROUP BY Status;

-- 9. Retrieve maximum and minimum monthly installments
SELECT MAX(Monthly_Installment) AS Max_Installment, MIN(Monthly_Installment) AS Min_Installment
FROM Recurring_Deposits;

-- 10. Retrieve sum of all total deposits
SELECT SUM(Total_Deposit) AS Total_Deposits
FROM Recurring_Deposits;

-- 11. Retrieve deposits started this year
SELECT * FROM Recurring_Deposits
WHERE YEAR(Start_Date) = YEAR(CURDATE());

-- 12. Retrieve first 3 characters of nominee names
SELECT RD_ID, LEFT(Nominee_Name, 3) AS Nominee_Code
FROM Recurring_Deposits;

-- 13. Retrieve Monthly_Installment rounded to nearest hundred
SELECT RD_ID, ROUND(Monthly_Installment, -2) AS Rounded_Installment
FROM Recurring_Deposits;

-- 14. Categorize deposits as High or Low based on Total_Deposit
SELECT RD_ID,
    CASE 
        WHEN Total_Deposit > 80000 THEN 'High Deposit'
        ELSE 'Low Deposit'
    END AS Deposit_Category
FROM Recurring_Deposits;

-- 15. Retrieve average Total_Deposit
SELECT AVG(Total_Deposit) AS Average_Deposit
FROM Recurring_Deposits;

-- 16. Retrieve month name from Start_Date
SELECT RD_ID, MONTHNAME(Start_Date) AS Start_Month
FROM Recurring_Deposits;

-- 17. Convert Status to uppercase
SELECT RD_ID, UPPER(Status) AS Status_Upper
FROM Recurring_Deposits;

-- 18. Count of deposits per customer
SELECT Customer_ID, COUNT(*) AS Total_RD
FROM Recurring_Deposits
GROUP BY Customer_ID;

-- 19. User-defined function to calculate maturity interest
DELIMITER //
CREATE FUNCTION RDInterest(principal DECIMAL(10,2), rate DECIMAL(5,2), years INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE interest DECIMAL(10,2);
    SET interest = (principal * rate * years)/100;
    RETURN interest;
END //
DELIMITER ;

-- Use the function to calculate interest
SELECT RD_ID, RDInterest(Total_Deposit, Interest_Rate, TIMESTAMPDIFF(YEAR, Start_Date, Maturity_Date)) AS Maturity_Interest
FROM Recurring_Deposits;

-- 20. User-defined function to check RD status
DELIMITER //
CREATE FUNCTION RDStatusChecker(rstatus ENUM('Active', 'Matured', 'Closed'))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE st VARCHAR(20);
    IF rstatus = 'Active' THEN
        SET st = 'Ongoing';
    ELSEIF rstatus = 'Matured' THEN
        SET st = 'Completed';
    ELSE
        SET st = 'Closed';
    END IF;
    RETURN st;
END //
DELIMITER ;

-- Use the function to display RD status
SELECT RD_ID, Total_Deposit, RDStatusChecker(Status) AS RD_Current_Status
FROM Recurring_Deposits;



-- Table 17:

-- 1. Retrieve all KYC document details
SELECT * FROM KYC_Documents;

-- 2. Retrieve KYCs verified by employee 2
SELECT * FROM KYC_Documents
WHERE Verified_By = 2;

-- 3. Retrieve KYC_ID and Aadhaar_Number using alias
SELECT KYC_ID AS Document_ID, Aadhaar_Number AS Aadhaar
FROM KYC_Documents;

-- 4. Retrieve KYC details with customer names
SELECT K.KYC_ID, K.PAN_Number, C.Customer_Name
FROM KYC_Documents K
JOIN Customers C ON K.Customer_ID = C.Customer_ID;

-- 5. Count KYCs per Verified_Status
SELECT Verified_Status, COUNT(*) AS Total_KYC
FROM KYC_Documents
GROUP BY Verified_Status;

-- 6. Retrieve KYC IDs submitted in 2023
SELECT * FROM KYC_Documents
WHERE YEAR(Submission_Date) = 2023;

-- 7. Retrieve first 4 characters of PAN_Number
SELECT KYC_ID, LEFT(PAN_Number, 4) AS PAN_Prefix
FROM KYC_Documents;

-- 8. Retrieve KYCs with their assigned employee name
SELECT K.KYC_ID, K.Verified_Status, E.Employee_Name
FROM KYC_Documents K
JOIN Employees E ON K.Verified_By = E.Employee_ID;

-- 9. Retrieve the number of KYCs verified by each employee
SELECT Verified_By, COUNT(*) AS Verified_Count
FROM KYC_Documents
WHERE Verified_By IS NOT NULL
GROUP BY Verified_By;

-- 10. Retrieve KYCs with remarks containing 'Verified'
SELECT * FROM KYC_Documents
WHERE Remarks LIKE '%Verified%';

-- 11. Retrieve PAN_Number in uppercase
SELECT KYC_ID, UPPER(PAN_Number) AS PAN_Upper
FROM KYC_Documents;

-- 12. Retrieve the most recent submission date
SELECT MAX(Submission_Date) AS Latest_Submission
FROM KYC_Documents;

-- 13. Retrieve KYCs with address proof as 'Aadhaar Card'
SELECT KYC_ID, Customer_ID, Address_Proof
FROM KYC_Documents
WHERE Address_Proof = 'Aadhaar Card';

-- 14. Categorize KYCs based on Verified_Status
SELECT KYC_ID,
    CASE 
        WHEN Verified_Status = 'Verified' THEN 'OK'
        WHEN Verified_Status = 'Pending' THEN 'Check'
        ELSE 'Reject'
    END AS KYC_Status
FROM KYC_Documents;

-- 15. Subquery: Retrieve KYCs submitted after the earliest submission date
SELECT * FROM KYC_Documents
WHERE Submission_Date > (SELECT MIN(Submission_Date) FROM KYC_Documents);

-- 16. Numeric function: Retrieve KYC_ID and length of remarks
SELECT KYC_ID, LENGTH(Remarks) AS Remarks_Length
FROM KYC_Documents;

-- 17. Retrieve KYCs along with customer and employee names
SELECT K.KYC_ID, C.Customer_Name, E.Employee_Name
FROM KYC_Documents K
LEFT JOIN Customers C ON K.Customer_ID = C.Customer_ID
LEFT JOIN Employees E ON K.Verified_By = E.Employee_ID;

-- 18. Retrieve KYCs submitted in last 60 days
SELECT * FROM KYC_Documents
WHERE Submission_Date >= DATE_SUB(CURDATE(), INTERVAL 60 DAY);

-- 19. User-defined function to interpret Verified_Status
DELIMITER //
CREATE FUNCTION KYCStatusInterpret(status ENUM('Verified','Pending','Rejected'))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE s VARCHAR(20);
    IF status = 'Verified' THEN
        SET s = 'Approved';
    ELSEIF status = 'Pending' THEN
        SET s = 'Under Review';
    ELSE
        SET s = 'Declined';
    END IF;
    RETURN s;
END //
DELIMITER ;



-- Table 18:


-- 1. Retrieve all account statements
SELECT * FROM Account_Statements;

-- 2. Retrieve statements with closing balance above 20000
SELECT * FROM Account_Statements
WHERE Closing_Balance > 20000;

-- 3. Alias example: show statement ID and total credits
SELECT Statement_ID AS Stmt_ID, Total_Credits AS Credits
FROM Account_Statements;

-- 4. Join with Accounts to get customer ID
SELECT A.Statement_ID, Ac.Customer_ID, A.Total_Credits
FROM Account_Statements A
JOIN Accounts Ac ON A.Account_ID = Ac.Account_ID;

-- 5. Count statements per format type
SELECT Format, COUNT(*) AS Total_Statements
FROM Account_Statements
GROUP BY Format;

-- 6. Retrieve statements generated in July 2024
SELECT * FROM Account_Statements
WHERE MONTH(Generated_On) = 7 AND YEAR(Generated_On) = 2024;

-- 7. String function: first 3 letters of format
SELECT Statement_ID, LEFT(Format, 3) AS Format_Short
FROM Account_Statements;

-- 8. Join to show statements with customer name
SELECT S.Statement_ID, S.Total_Debits, C.Customer_Name
FROM Account_Statements S
JOIN Accounts A ON S.Account_ID = A.Account_ID
JOIN Customers C ON A.Customer_ID = C.Customer_ID;

-- 9. Aggregate function: sum of total debits per account
SELECT Account_ID, SUM(Total_Debits) AS Sum_Debits
FROM Account_Statements
GROUP BY Account_ID;

-- 10. Retrieve statements with closing balance less than credits
SELECT * FROM Account_Statements
WHERE Closing_Balance < Total_Credits;

-- 11. Date function: show month of generated statement
SELECT Statement_ID, MONTH(Generated_On) AS Generated_Month
FROM Account_Statements;

-- 12. Most recent generated statement date
SELECT MAX(Generated_On) AS Latest_Statement
FROM Account_Statements;

-- 13. Numeric function: difference between credits and debits
SELECT Statement_ID, (Total_Credits - Total_Debits) AS Net_Amount
FROM Account_Statements;

-- 14. Control flow: categorize statements by closing balance
SELECT Statement_ID,
  CASE 
    WHEN Closing_Balance >= 20000 THEN 'High'
    WHEN Closing_Balance >= 10000 THEN 'Medium'
    ELSE 'Low'
  END AS Balance_Category
FROM Account_Statements;

-- 15. Subquery: statements with credits above average
SELECT * FROM Account_Statements
WHERE Total_Credits > (SELECT AVG(Total_Credits) FROM Account_Statements);

-- 16. Date range filter: statements for June 2024
SELECT * FROM Account_Statements
WHERE Start_Date >= '2024-06-01' AND End_Date <= '2024-06-30';

-- 17. Join with Accounts to show customer and closing balance
SELECT S.Statement_ID, Ac.Customer_ID, S.Closing_Balance
FROM Account_Statements S
JOIN Accounts Ac ON S.Account_ID = Ac.Account_ID;

-- 18. Statements failed in generation
SELECT * FROM Account_Statements
WHERE Status = 'Failed';

-- 19. User-defined function: interpret statement status
DELIMITER //
CREATE FUNCTION StatementStatusInterpret(stat ENUM('Generated','Failed'))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
  IF stat = 'Generated' THEN
    RETURN 'Success';
  ELSE
    RETURN 'Error';
  END IF;
END //
DELIMITER ;



-- Table 19:

-- 1. Retrieve all feedback
SELECT * FROM Customer_Feedback;

-- 2. Feedback with rating 5
SELECT * FROM Customer_Feedback
WHERE Rating = 5;

-- 3. Alias example: Feedback ID and rating
SELECT Feedback_ID AS FB_ID, Rating AS Score
FROM Customer_Feedback;

-- 4. Join with Customers to show customer name
SELECT F.Feedback_ID, F.Rating, C.Customer_Name
FROM Customer_Feedback F
JOIN Customers C ON F.Customer_ID = C.Customer_ID;

-- 5. Aggregate function: average rating per channel
SELECT Channel, AVG(Rating) AS Avg_Rating
FROM Customer_Feedback
GROUP BY Channel;

-- 6. Date function: month of feedback
SELECT Feedback_ID, MONTH(Feedback_Date) AS Feedback_Month
FROM Customer_Feedback;

-- 7. String function: first 3 letters of channel
SELECT Feedback_ID, LEFT(Channel, 3) AS Channel_Short
FROM Customer_Feedback;

-- 8. Join with Employees to show handled by name
SELECT F.Feedback_ID, F.Response_Status, E.Employee_Name
FROM Customer_Feedback F
JOIN Employees E ON F.Handled_By = E.Employee_ID;

-- 9. Aggregate: count feedback per status
SELECT Response_Status, COUNT(*) AS Total_Feedback
FROM Customer_Feedback
GROUP BY Response_Status;

-- 10. Feedback with comments containing 'ATM'
SELECT * FROM Customer_Feedback
WHERE Comments LIKE '%ATM%';

-- 11. Date function: filter feedback in January 2023
SELECT * FROM Customer_Feedback
WHERE MONTH(Feedback_Date) = 1 AND YEAR(Feedback_Date) = 2023;

-- 12. Most recent feedback date
SELECT MAX(Feedback_Date) AS Latest_Feedback
FROM Customer_Feedback;

-- 13. Numeric function: increment rating by 1 (capped at 5)
SELECT Feedback_ID, LEAST(Rating + 1, 5) AS Incremented_Rating
FROM Customer_Feedback;

-- 14. Control flow: categorize feedback as Positive/Neutral/Negative
SELECT Feedback_ID,
  CASE
    WHEN Rating >= 4 THEN 'Positive'
    WHEN Rating = 3 THEN 'Neutral'
    ELSE 'Negative'
  END AS Feedback_Type
FROM Customer_Feedback;

-- 15. Subquery: feedback with rating above average
SELECT * FROM Customer_Feedback
WHERE Rating > (SELECT AVG(Rating) FROM Customer_Feedback);

-- 16. Date range: feedback from March to May 2023
SELECT * FROM Customer_Feedback
WHERE Feedback_Date BETWEEN '2023-03-01' AND '2023-05-31';

-- 17. Join to get customer and handled employee
SELECT F.Feedback_ID, C.Customer_Name, E.Employee_Name AS Handled_By
FROM Customer_Feedback F
JOIN Customers C ON F.Customer_ID = C.Customer_ID
LEFT JOIN Employees E ON F.Handled_By = E.Employee_ID;

-- 18. Feedback still pending
SELECT * FROM Customer_Feedback
WHERE Response_Status = 'Pending';

-- 19. User-defined function to interpret feedback status
DELIMITER //
CREATE FUNCTION FeedbackStatusText(stat ENUM('Pending','Acknowledged','Resolved'))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
  IF stat = 'Pending' THEN
    RETURN 'Waiting';
  ELSEIF stat = 'Acknowledged' THEN
    RETURN 'In Progress';
  ELSE
    RETURN 'Completed';
  END IF;
END //
DELIMITER ;



-- Table 20:

-- 1. Retrieve all bill payments
SELECT * FROM Bill_Payments;

-- 2. Retrieve bills where amount is greater than the average amount
SELECT * FROM Bill_Payments
WHERE Amount > (SELECT AVG(Amount) FROM Bill_Payments);

-- 3. Retrieve Bill_ID and Amount using aliases
SELECT Bill_ID AS ID, Amount AS Payment_Amount
FROM Bill_Payments;

-- 4. Retrieve bill details along with account number
SELECT B.Bill_ID, B.Biller_Name, A.Account_Number
FROM Bill_Payments B
JOIN Accounts A ON B.Account_ID = A.Account_ID;

-- 5. Retrieve bill details along with customer name
SELECT B.Bill_ID, B.Biller_Name, C.Customer_Name
FROM Bill_Payments B
JOIN Accounts A ON B.Account_ID = A.Account_ID
JOIN Customers C ON A.Customer_ID = C.Customer_ID;

-- 6. Retrieve bills along with account and customer details
SELECT B.Bill_ID, B.Biller_Name, A.Account_Number, C.Customer_Name
FROM Bill_Payments B
JOIN Accounts A ON B.Account_ID = A.Account_ID
JOIN Customers C ON A.Customer_ID = C.Customer_ID;

-- 7. Retrieve bills paid via 'UPI'
SELECT * FROM Bill_Payments
WHERE Mode = 'UPI';

-- 8. Retrieve total amount paid by each account
SELECT Account_ID, SUM(Amount) AS Total_Paid
FROM Bill_Payments
GROUP BY Account_ID;

-- 9. Retrieve average amount per category
SELECT Category, AVG(Amount) AS Avg_Amount
FROM Bill_Payments
GROUP BY Category;

-- 10. Retrieve bills paid in June 2024
SELECT * FROM Bill_Payments
WHERE Payment_Date BETWEEN '2024-06-01' AND '2024-06-30';

-- 11. Retrieve bills along with reference number starting with 'BILLREF10'
SELECT * FROM Bill_Payments
WHERE Reference_No LIKE 'BILLREF10%';

-- 12. Retrieve bills sorted by amount descending
SELECT * FROM Bill_Payments
ORDER BY Amount DESC;

-- 13. Count of bills per status
SELECT Status, COUNT(*) AS Count_Per_Status
FROM Bill_Payments
GROUP BY Status;

-- 14. Retrieve bills where amount > 1000
SELECT * FROM Bill_Payments
WHERE Amount > 1000;

-- 15. Retrieve minimum and maximum payment amounts
SELECT MIN(Amount) AS Min_Amount, MAX(Amount) AS Max_Amount
FROM Bill_Payments;

-- 16. Retrieve total successful payments
SELECT COUNT(*) AS Successful_Count
FROM Bill_Payments
WHERE Status = 'Successful';

-- 17. Retrieve total amount per category where payments were successful
SELECT Category, SUM(Amount) AS Total_Successful
FROM Bill_Payments
WHERE Status = 'Successful'
GROUP BY Category;

-- 18. Create a user-defined function to calculate bill after GST (18%)
DELIMITER //
CREATE FUNCTION CalculateBillWithGST(amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN amount * 1.18;
END //
DELIMITER ;

-- Use the function to calculate GST-inclusive amount for all bills
SELECT Bill_ID, Amount, CalculateBillWithGST(Amount) AS Amount_With_GST
FROM Bill_Payments;

-- 19. Create a user-defined function to classify bills based on amount
DELIMITER //
CREATE FUNCTION BillCategory(amount DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(20);
    IF amount < 500 THEN
        SET category = 'Low';
    ELSEIF amount BETWEEN 500 AND 1000 THEN
        SET category = 'Medium';
    ELSE
        SET category = 'High';
    END IF;
    RETURN category;
END //
DELIMITER ;

-- Use the function to display bill category
SELECT Bill_ID, Amount, BillCategory(Amount) AS Category
FROM Bill_Payments;

-- 20. Retrieve total bill amount per account and status
SELECT Account_ID, Status, SUM(Amount) AS Total_Amount
FROM Bill_Payments
GROUP BY Account_ID, Status;



-- Table 21:

-- 1. Retrieve all safe deposit visits
SELECT * FROM Safe_Deposit_Visits;

-- 2. Retrieve visits for a specific customer (Customer_ID = 1)
SELECT * FROM Safe_Deposit_Visits
WHERE Customer_ID = 1;

-- 3. Retrieve visits along with locker size
SELECT V.Visit_ID, V.Visit_Date, L.Locker_Size
FROM Safe_Deposit_Visits V
JOIN Lockers L ON V.Locker_ID = L.Locker_ID;

-- 4. Retrieve visits along with customer name
SELECT V.Visit_ID, V.Visit_Date, C.Customer_Name
FROM Safe_Deposit_Visits V
JOIN Customers C ON V.Customer_ID = C.Customer_ID;

-- 5. Retrieve visits along with employee who verified
SELECT V.Visit_ID, V.Visit_Date, E.Employee_Name AS Verified_By
FROM Safe_Deposit_Visits V
JOIN Employees E ON V.Verified_By_Employee = E.Employee_ID;

-- 6. Retrieve visits with duration (in minutes)
SELECT Visit_ID, Visit_Date, TIMESTAMPDIFF(MINUTE, Time_In, Time_Out) AS Duration_Minutes
FROM Safe_Deposit_Visits;

-- 7. Retrieve visits longer than 30 minutes
SELECT Visit_ID, Visit_Date, TIMESTAMPDIFF(MINUTE, Time_In, Time_Out) AS Duration_Minutes
FROM Safe_Deposit_Visits
WHERE TIMESTAMPDIFF(MINUTE, Time_In, Time_Out) > 30;

-- 8. Count of visits per customer
SELECT Customer_ID, COUNT(*) AS Total_Visits
FROM Safe_Deposit_Visits
GROUP BY Customer_ID;

-- 9. Count of visits per locker
SELECT Locker_ID, COUNT(*) AS Total_Visits
FROM Safe_Deposit_Visits
GROUP BY Locker_ID;

-- 10. Retrieve visits in June 2024
SELECT * FROM Safe_Deposit_Visits
WHERE Visit_Date BETWEEN '2024-06-01' AND '2024-06-30';

-- 11. Retrieve visits sorted by visit date
SELECT * FROM Safe_Deposit_Visits
ORDER BY Visit_Date ASC;

-- 12. Retrieve purpose and comments for each visit
SELECT Visit_ID, Purpose, Comments
FROM Safe_Deposit_Visits;

-- 13. Retrieve visits where purpose contains 'Jewellery'
SELECT * FROM Safe_Deposit_Visits
WHERE Purpose LIKE '%Jewellery%';

-- 14. Retrieve maximum and minimum visit duration
SELECT MAX(TIMESTAMPDIFF(MINUTE, Time_In, Time_Out)) AS Max_Duration,
       MIN(TIMESTAMPDIFF(MINUTE, Time_In, Time_Out)) AS Min_Duration
FROM Safe_Deposit_Visits;

-- 15. Retrieve visits with Time_In before 12:00 PM
SELECT * FROM Safe_Deposit_Visits
WHERE Time_In < '12:00:00';

-- 16. Count of visits verified by each employee
SELECT Verified_By_Employee, COUNT(*) AS Total_Verified
FROM Safe_Deposit_Visits
GROUP BY Verified_By_Employee;

-- 17. Retrieve visits along with locker and customer details
SELECT V.Visit_ID, V.Visit_Date, L.Locker_Size, C.Customer_Name
FROM Safe_Deposit_Visits V
JOIN Lockers L ON V.Locker_ID = L.Locker_ID
JOIN Customers C ON V.Customer_ID = C.Customer_ID;

-- 18. Create a user-defined function to calculate visit duration in minutes
DELIMITER //
CREATE FUNCTION VisitDurationMin(time_in TIME, time_out TIME)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(MINUTE, time_in, time_out);
END //
DELIMITER ;

-- Use the function to get duration for all visits
SELECT Visit_ID, Visit_Date, VisitDurationMin(Time_In, Time_Out) AS Duration_Minutes
FROM Safe_Deposit_Visits;

-- 19. Create a user-defined function to classify visit duration
DELIMITER //
CREATE FUNCTION VisitCategory(duration_minutes INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(20);
    IF duration_minutes <= 15 THEN
        SET category = 'Short';
    ELSEIF duration_minutes <= 30 THEN
        SET category = 'Medium';
    ELSE
        SET category = 'Long';
    END IF;
    RETURN category;
END //
DELIMITER ;

-- Use the function to classify visits
SELECT Visit_ID, VisitDurationMin(Time_In, Time_Out) AS Duration_Minutes,
       VisitCategory(VisitDurationMin(Time_In, Time_Out)) AS Duration_Type
FROM Safe_Deposit_Visits;

-- 20. Retrieve total visits per purpose
SELECT Purpose, COUNT(*) AS Total_Visits
FROM Safe_Deposit_Visits
GROUP BY Purpose;



-- Table 22:

-- 1. Retrieve all mobile banking records
SELECT * FROM Mobile_Banking;

-- 2. Retrieve active mobile banking users
SELECT * FROM Mobile_Banking
WHERE App_Status = 'Active';

-- 3. Retrieve mobile banking records for a specific customer (Customer_ID = 1)
SELECT * FROM Mobile_Banking
WHERE Customer_ID = 1;

-- 4. Retrieve customer name along with device model
SELECT MB.MB_ID, C.Customer_Name, MB.Device_Model
FROM Mobile_Banking MB
JOIN Customers C ON MB.Customer_ID = C.Customer_ID;

-- 5. Retrieve mobile banking records with last login after July 12, 2024
SELECT * FROM Mobile_Banking
WHERE Last_Login > '2024-07-12';

-- 6. Retrieve Android users
SELECT * FROM Mobile_Banking
WHERE OS_Type = 'Android';

-- 7. Retrieve iOS users
SELECT * FROM Mobile_Banking
WHERE OS_Type = 'iOS';

-- 8. Count of mobile banking users per OS type
SELECT OS_Type, COUNT(*) AS Total_Users
FROM Mobile_Banking
GROUP BY OS_Type;

-- 9. Count of active and inactive users
SELECT App_Status, COUNT(*) AS Total_Users
FROM Mobile_Banking
GROUP BY App_Status;

-- 10. Retrieve users with both OTP and Biometric enabled
SELECT * FROM Mobile_Banking
WHERE OTP_Enabled = TRUE AND Biometric_Enabled = TRUE;

-- 11. Retrieve users with only OTP enabled
SELECT * FROM Mobile_Banking
WHERE OTP_Enabled = TRUE AND Biometric_Enabled = FALSE;

-- 12. Retrieve users who have not logged in for more than 2 days
SELECT * FROM Mobile_Banking
WHERE Last_Login < NOW() - INTERVAL 2 DAY;

-- 13. Retrieve the latest login for each user
SELECT Customer_ID, MAX(Last_Login) AS Latest_Login
FROM Mobile_Banking
GROUP BY Customer_ID;

-- 14. Retrieve mobile banking users with specific app version 'v4.5.1'
SELECT * FROM Mobile_Banking
WHERE App_Version = 'v4.5.1';

-- 15. Retrieve mobile banking users along with customer name and last login
SELECT MB.MB_ID, C.Customer_Name, MB.Last_Login
FROM Mobile_Banking MB
JOIN Customers C ON MB.Customer_ID = C.Customer_ID;

-- 16. Create a user-defined function to check if a user is active
DELIMITER //
CREATE FUNCTION IsActive(status ENUM('Active','Inactive'))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF status = 'Active' THEN
        RETURN 'Yes';
    ELSE
        RETURN 'No';
    END IF;
END //
DELIMITER ;

-- Use the function to display active status
SELECT MB_ID, App_Status, IsActive(App_Status) AS Active_Status
FROM Mobile_Banking;

-- 17. Create a user-defined function to classify OS type
DELIMITER //
CREATE FUNCTION OSCategory(os ENUM('Android','iOS'))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF os = 'Android' THEN
        RETURN 'Google OS';
    ELSE
        RETURN 'Apple OS';
    END IF;
END //
DELIMITER ;

-- Use the function to classify users by OS
SELECT MB_ID, Device_Model, OS_Type, OSCategory(OS_Type) AS OS_Category
FROM Mobile_Banking;

-- 18. Retrieve users sorted by last login date
SELECT * FROM Mobile_Banking
ORDER BY Last_Login DESC;

-- 19. Count of users with biometric enabled
SELECT COUNT(*) AS Biometric_Enabled_Users
FROM Mobile_Banking
WHERE Biometric_Enabled = TRUE;

-- 20. Retrieve users along with customer name and mobile number
SELECT MB.MB_ID, C.Customer_Name, MB.Registered_Mobile
FROM Mobile_Banking MB
JOIN Customers C ON MB.Customer_ID = C.Customer_ID;



-- Table 23:

-- 1. Retrieve all UPI transactions
SELECT * FROM UPI_Transactions;

-- 2. Retrieve successful transactions
SELECT * FROM UPI_Transactions
WHERE Status = 'Success';

-- 3. Retrieve transactions above 1000 INR
SELECT * FROM UPI_Transactions
WHERE Amount > 1000;

-- 4. Retrieve transaction details along with linked account number (INNER JOIN)
SELECT U.UPI_ID, U.Sender_VPA, U.Receiver_VPA, A.Account_Number
FROM UPI_Transactions U
INNER JOIN Accounts A ON U.Linked_Account_ID = A.Account_ID;

-- 5. Retrieve transaction along with customer name of linked account (LEFT JOIN)
SELECT U.UPI_ID, C.Customer_Name, U.Amount, U.Status
FROM UPI_Transactions U
LEFT JOIN Accounts A ON U.Linked_Account_ID = A.Account_ID
LEFT JOIN Customers C ON A.Customer_ID = C.Customer_ID;

-- 6. Retrieve transactions where sender VPA belongs to YBL bank
SELECT * FROM UPI_Transactions
WHERE Sender_VPA LIKE '%@ybl';

-- 7. Count transactions by status
SELECT Status, COUNT(*) AS Total_Transactions
FROM UPI_Transactions
GROUP BY Status;

-- 8. Count transactions by bank
SELECT Bank_Name, COUNT(*) AS Total_Transactions
FROM UPI_Transactions
GROUP BY Bank_Name;

-- 9. Retrieve transactions in a specific date range
SELECT * FROM UPI_Transactions
WHERE Transaction_Date BETWEEN '2024-07-11' AND '2024-07-12';

-- 10. Retrieve top 5 highest transactions
SELECT * FROM UPI_Transactions
ORDER BY Amount DESC
LIMIT 5;

-- 11. Retrieve transactions along with customer name for INNER JOIN example
SELECT U.UPI_ID, C.Customer_Name, U.Amount, U.Status
FROM UPI_Transactions U
INNER JOIN Accounts A ON U.Linked_Account_ID = A.Account_ID
INNER JOIN Customers C ON A.Customer_ID = C.Customer_ID;

-- 12. Retrieve all accounts even if they have no UPI transaction (RIGHT JOIN)
SELECT A.Account_ID, C.Customer_Name, U.UPI_ID, U.Amount
FROM Accounts A
RIGHT JOIN UPI_Transactions U ON A.Account_ID = U.Linked_Account_ID
LEFT JOIN Customers C ON A.Customer_ID = C.Customer_ID;

-- 13. Retrieve transactions along with total amount sent per bank
SELECT Bank_Name, SUM(Amount) AS Total_Amount
FROM UPI_Transactions
WHERE Transaction_Type = 'Send'
GROUP BY Bank_Name;

-- 14. Retrieve transactions along with customer info using FULL OUTER JOIN simulation (MySQL workaround)
SELECT A.Account_ID, C.Customer_Name, U.UPI_ID, U.Amount
FROM Accounts A
LEFT JOIN UPI_Transactions U ON A.Account_ID = U.Linked_Account_ID
LEFT JOIN Customers C ON A.Customer_ID = C.Customer_ID
UNION
SELECT A.Account_ID, C.Customer_Name, U.UPI_ID, U.Amount
FROM Accounts A
RIGHT JOIN UPI_Transactions U ON A.Account_ID = U.Linked_Account_ID
RIGHT JOIN Customers C ON A.Customer_ID = C.Customer_ID;

-- 15. Create a user-defined function to categorize transactions
DELIMITER //
CREATE FUNCTION TransactionCategory(amount DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(20);
    IF amount < 500 THEN
        SET category = 'Small';
    ELSEIF amount BETWEEN 500 AND 2000 THEN
        SET category = 'Medium';
    ELSE
        SET category = 'Large';
    END IF;
    RETURN category;
END //
DELIMITER ;

-- Use the function to categorize each transaction
SELECT UPI_ID, Amount, TransactionCategory(Amount) AS Transaction_Category
FROM UPI_Transactions;

-- 16. Retrieve failed transactions along with linked account number
SELECT U.UPI_ID, U.Amount, U.Status, A.Account_Number
FROM UPI_Transactions U
LEFT JOIN Accounts A ON U.Linked_Account_ID = A.Account_ID
WHERE U.Status = 'Failed';

-- 17. Retrieve transactions along with month and year of transaction
SELECT UPI_ID, Amount, MONTH(Transaction_Date) AS Trans_Month, YEAR(Transaction_Date) AS Trans_Year
FROM UPI_Transactions;

-- 18. Retrieve total amount sent and received by each account
SELECT Linked_Account_ID,
       SUM(CASE WHEN Transaction_Type='Send' THEN Amount ELSE 0 END) AS Total_Sent,
       SUM(CASE WHEN Transaction_Type='Receive' THEN Amount ELSE 0 END) AS Total_Received
FROM UPI_Transactions
GROUP BY Linked_Account_ID;

-- 19. Retrieve transactions where receiver VPA contains 'upi' (pattern matching)
SELECT * FROM UPI_Transactions
WHERE Receiver_VPA LIKE '%@upi';

-- 20. Retrieve transactions along with customer name and account number using INNER JOIN and alias
SELECT U.UPI_ID, C.Customer_Name, A.Account_Number, U.Amount, U.Status
FROM UPI_Transactions U
INNER JOIN Accounts A ON U.Linked_Account_ID = A.Account_ID
INNER JOIN Customers C ON A.Customer_ID = C.Customer_ID;



-- Table 24:

-- 1. Retrieve all service requests
SELECT * FROM Service_Requests;

-- 2. Retrieve all pending service requests
SELECT * FROM Service_Requests
WHERE Status = 'Pending';

-- 3. Retrieve high-priority requests
SELECT * FROM Service_Requests
WHERE Priority = 'High';

-- 4. Retrieve requests along with customer name (INNER JOIN)
SELECT S.Request_ID, S.Request_Type, C.Customer_Name, S.Status
FROM Service_Requests S
INNER JOIN Customers C ON S.Customer_ID = C.Customer_ID;

-- 5. Retrieve requests along with employee handling the request (LEFT JOIN)
SELECT S.Request_ID, S.Request_Type, E.Employee_Name AS Handled_By, S.Status
FROM Service_Requests S
LEFT JOIN Employees E ON S.Handled_By = E.Employee_ID;

-- 6. Retrieve requests along with branch name (INNER JOIN)
SELECT S.Request_ID, S.Request_Type, B.Branch_Name, S.Status
FROM Service_Requests S
INNER JOIN Branches B ON S.Branch_ID = B.Branch_ID;

-- 7. Retrieve requests for a specific branch
SELECT * FROM Service_Requests
WHERE Branch_ID = 2;

-- 8. Count requests by status
SELECT Status, COUNT(*) AS Total_Requests
FROM Service_Requests
GROUP BY Status;

-- 9. Count requests by request type
SELECT Request_Type, COUNT(*) AS Total_Requests
FROM Service_Requests
GROUP BY Request_Type;

-- 10. Retrieve requests with customer and employee info (LEFT JOIN)
SELECT S.Request_ID, C.Customer_Name, E.Employee_Name, S.Request_Type, S.Status
FROM Service_Requests S
LEFT JOIN Customers C ON S.Customer_ID = C.Customer_ID
LEFT JOIN Employees E ON S.Handled_By = E.Employee_ID;

-- 11. Retrieve requests completed this month
SELECT * FROM Service_Requests
WHERE MONTH(Completion_Date) = MONTH(CURDATE())
  AND YEAR(Completion_Date) = YEAR(CURDATE());

-- 12. Retrieve first 3 letters of request type
SELECT Request_ID, LEFT(Request_Type, 3) AS Request_Code
FROM Service_Requests;

-- 13. Retrieve requests sorted by priority
SELECT * FROM Service_Requests
ORDER BY 
    CASE Priority
        WHEN 'High' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Low' THEN 3
    END;

-- 14. Retrieve requests along with customer and branch info using INNER JOIN
SELECT S.Request_ID, C.Customer_Name, B.Branch_Name, S.Request_Type, S.Status
FROM Service_Requests S
INNER JOIN Customers C ON S.Customer_ID = C.Customer_ID
INNER JOIN Branches B ON S.Branch_ID = B.Branch_ID;

-- 15. Retrieve requests with handling time (days between request and completion)
SELECT Request_ID, Request_Type, DATEDIFF(Completion_Date, Request_Date) AS Handling_Days
FROM Service_Requests
WHERE Completion_Date IS NOT NULL;

-- 16. Create a user-defined function to categorize requests by priority
DELIMITER //
CREATE FUNCTION RequestPriorityCategory(priority ENUM('Low','Medium','High'))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(20);
    IF priority = 'Low' THEN
        SET category = 'Non-Urgent';
    ELSEIF priority = 'Medium' THEN
        SET category = 'Standard';
    ELSE
        SET category = 'Urgent';
    END IF;
    RETURN category;
END //
DELIMITER ;

-- Use the function to categorize each request
SELECT Request_ID, Priority, RequestPriorityCategory(Priority) AS Priority_Category
FROM Service_Requests;

-- 17. Retrieve requests along with employee and customer info using LEFT JOIN
SELECT S.Request_ID, C.Customer_Name, E.Employee_Name AS Handled_By, S.Status, S.Priority
FROM Service_Requests S
LEFT JOIN Customers C ON S.Customer_ID = C.Customer_ID
LEFT JOIN Employees E ON S.Handled_By = E.Employee_ID;

-- 18. Retrieve number of requests handled per employee
SELECT Handled_By, COUNT(*) AS Requests_Handled
FROM Service_Requests
WHERE Handled_By IS NOT NULL
GROUP BY Handled_By;

-- 19. Retrieve requests that are still in process or pending
SELECT * FROM Service_Requests
WHERE Status IN ('Pending', 'In Process');

-- 20. Retrieve requests along with month and year of request
SELECT Request_ID, Request_Type, MONTH(Request_Date) AS Req_Month, YEAR(Request_Date) AS Req_Year
FROM Service_Requests;



-- Table 25:

-- 1. Retrieve all credit scores
SELECT * FROM Credit_Scores;

-- 2. Retrieve customers with Excellent credit score status
SELECT * FROM Credit_Scores
WHERE Score_Status = 'Excellent';

-- 3. Retrieve customers eligible for loans
SELECT * FROM Credit_Scores
WHERE Loan_Eligibility = TRUE;

-- 4. Retrieve customer name along with their credit score (INNER JOIN)
SELECT C.Customer_Name, CS.Credit_Score, CS.Score_Status
FROM Credit_Scores CS
INNER JOIN Customers C ON CS.Customer_ID = C.Customer_ID;

-- 5. Retrieve credit score with PAN number alias
SELECT Customer_ID, PAN_Number AS PAN, Credit_Score AS Score
FROM Credit_Scores;

-- 6. Retrieve top 5 highest credit scores
SELECT * FROM Credit_Scores
ORDER BY Credit_Score DESC
LIMIT 5;

-- 7. Retrieve average credit score
SELECT AVG(Credit_Score) AS Avg_Credit_Score
FROM Credit_Scores;

-- 8. Retrieve credit scores along with bank account info using LEFT JOIN
SELECT CS.Customer_ID, CS.Credit_Score, A.Account_Number
FROM Credit_Scores CS
LEFT JOIN Accounts A ON CS.Customer_ID = A.Customer_ID;

-- 9. Count of customers by score status
SELECT Score_Status, COUNT(*) AS Total_Customers
FROM Credit_Scores
GROUP BY Score_Status;

-- 10. Count of customers by score provider
SELECT Score_Provider, COUNT(*) AS Total_Customers
FROM Credit_Scores
GROUP BY Score_Provider;

-- 11. Retrieve customers with high credit utilization (>50%)
SELECT * FROM Credit_Scores
WHERE Credit_Utilization_Percentage > 50;

-- 12. Retrieve last updated date and calculate days since last update
SELECT Customer_ID, Last_Updated, DATEDIFF(CURDATE(), Last_Updated) AS Days_Since_Update
FROM Credit_Scores;

-- 13. Retrieve customers along with score provider and sort by score descending
SELECT Customer_ID, Score_Provider, Credit_Score
FROM Credit_Scores
ORDER BY Credit_Score DESC;

-- 14. Retrieve customers along with name and PAN using INNER JOIN
SELECT C.Customer_Name, CS.PAN_Number, CS.Credit_Score, CS.Score_Status
FROM Credit_Scores CS
INNER JOIN Customers C ON CS.Customer_ID = C.Customer_ID;

-- 15. Retrieve minimum and maximum credit scores
SELECT MIN(Credit_Score) AS Min_Score, MAX(Credit_Score) AS Max_Score
FROM Credit_Scores;

-- 16. Create a user-defined function to classify credit scores
DELIMITER //
CREATE FUNCTION CreditScoreCategory(score INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(20);
    IF score >= 800 THEN
        SET category = 'Excellent';
    ELSEIF score >= 700 THEN
        SET category = 'Good';
    ELSEIF score >= 600 THEN
        SET category = 'Average';
    ELSE
        SET category = 'Poor';
    END IF;
    RETURN category;
END //
DELIMITER ;

-- Use the function to classify each credit score
SELECT Customer_ID, Credit_Score, CreditScoreCategory(Credit_Score) AS Score_Category
FROM Credit_Scores;

-- 17. Retrieve customers with remarks containing 'loan'
SELECT * FROM Credit_Scores
WHERE Remarks LIKE '%loan%';

-- 18. Retrieve customers with Loan_Eligibility = TRUE along with their name (INNER JOIN)
SELECT C.Customer_Name, CS.Credit_Score, CS.Loan_Eligibility
FROM Credit_Scores CS
INNER JOIN Customers C ON CS.Customer_ID = C.Customer_ID
WHERE CS.Loan_Eligibility = TRUE;

-- 19. Retrieve customers with utilization percentage between 20% and 40%
SELECT * FROM Credit_Scores
WHERE Credit_Utilization_Percentage BETWEEN 20 AND 40;

-- 20. Retrieve customers along with score provider and order by utilization ascending
SELECT Customer_ID, Score_Provider, Credit_Utilization_Percentage
FROM Credit_Scores
ORDER BY Credit_Utilization_Percentage ASC;









