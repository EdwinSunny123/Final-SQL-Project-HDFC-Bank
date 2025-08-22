-- single line comment
/*
Multi line 
comments
*/

-- --------------------------------------------------------------------Database Queries-----------------------------------------------------

-- create a database to work on it 
create database HDFC_Bank;

-- to work on it use it first 
use HDFC_Bank;

-- -------------------------------------------------------------------Database Analysis------------------------------------------------------

/*
Table-1: Customers(Customer_ID ,First_Name, Last_Name, Gender, DOB Aadhaar_Number, PAN_Number, Mobile_Number, EmailAddress )
Table-2: Branches( Branch_ID ,Branch_Name ,IFSC_Code ,MICR_Code ,Address ,City ,State, Pincode ,Contact_Number ,Manager_Name )
Table-3: Accounts (Account_ID ,Customer_ID ,Branch_ID ,Account_Type ,Account_Number ,Balance ,Opening_Date ,Status ,Nominee_Name ,IFSC_Code)
Table-4: Transactions (Transaction_ID ,Account_ID ,Transaction_Type ,Amount ,Transaction_Date ,Mode ,Description ,Balance_After ,Reference_No, Branch_ID )
Table-5: Employees (Employee_ID First_Name ,Last_Name,Branch_ID ,Position, DOJ,Salary ,Email ,Contact_Number ,Status )
Table-6: Loans (Loan_ID ,Customer_ID ,Loan_Type ,Amount, Interest_Rate ,Duration_Years ,Start_Date ,Status ,EMI_Amount ,Branch_ID)
Table-7: Cards (Card_ID, Customer_ID,Card_Type ,Card_Number ,CVV ,Expiry_Date ,Issue_Date ,Card_Limit ,Status ,Branch_ID )
Table-8: ATMs (ATM_ID ,Branch_ID ,Location ,City ,State ,Pincode ,Type ,Installed_Date ,Status ,Cash_Available)
Table-9: Cheques (Cheque_ID ,Account_ID ,Cheque_Number, Issue_Date,Payee_Name,Amount ,Status ,IFSC_Code,Branch_ID ,Remarks )
Table-10: Fixed_Deposits (FD_ID ,Customer_ID ,Branch_ID ,Deposit_Amount,Interest_Rate ,Start_Date ,Maturity_Date ,Duration_Months ,Status ,Nominee_Name )
Table-11: Online_Banking (Login_ID ,Customer_ID ,Username ,Password_Hash ,Last_Login ,Login_Status ,Security_Question ,Security_Answer_Hash ,Registered_Device ,IP_Address )
Table-12: Beneficiaries (Beneficiary_ID ,Customer_ID ,Name ,Account_Number,IFSC_Code ,Bank_Name ,Added_Date ,Type,Status ,Nickname)
Table-13: Lockers (Locker_ID ,Branch_ID ,Customer_ID ,Locker_Size ,Rent_Amount ,Allocation_Date ,Expiry_Date ,Status,Access_Code ,Last_Accessed )
Table-14: Complaints (Complaint_ID ,Customer_ID ,Complaint_Type ,Description ,Complaint_Date ,Status ,Resolution_Date ,Assigned_To_Employee ,Feedback_Rating )
Table-15: Insurance_Policies (Policy_ID ,Customer_ID ,Policy_Type ,Policy_Provider,Policy_Number ,Start_Date,End_Date ,Premium_Amount ,Status ,Nominee_Name )
Table-16: Recurring_Deposits (RD_ID , Customer_ID ,Account_ID ,Start_Date ,Maturity_Date ,Monthly_Installment ,Interest_Rate ,Total_Deposit ,Status ,Nominee_Name )
Table-17: KYC_Documents (KYC_ID ,Customer_ID ,PAN_Number ,Aadhaar_Number ,Address_Proof ,Identity_Proof ,Submission_Date ,Verified_Status ,Verified_By ,Remarks )
Table-18: Account_Statements (Statement_ID ,Account_ID,Start_Date ,End_Date ,Generated_On ,Total_Credits ,Total_Debits ,Closing_Balance ,Format ,Status )
Table-19: Customer_Feedback (Feedback_ID ,Customer_ID ,Feedback_Date ,Channel,Rating ,Comments ,Response_Status,Handled_By ,Follow_Up_Date )
Table-20: Bill_Payments (Bill_ID ,Accoun_ID, Biller_Name ,Category ,Amount ,Payment_Date ,Status,Mode ,Reference_No )
Table-21: Safe_Deposit_Visits (Visit_ID ,Locker_ID ,Visit_Date ,Time_In ,Time_Out ,Verified_By_Employee ,Purpose ,Comments )
Table-22: Mobile_Banking (MB_ID ,Registered_Mobile ,Device_Model ,OS_Type,App_Version ,Last_Login,OTP_Enabled ,Biometric_Enabled,App_Status)
Table-23: UPI_Transactions (UPI_ID, Sender_VPA Receiver_VPA ,Transaction_Date ,Amount ,Status ,Reference_No ,Bank_Name ,Transaction_Type ,Linked_Account_ID )
Table-24: Service_Requests (Request_ID ,Customer_ID ,Request_Type ,Request_Date ,Status ,Handled_By ,Completion_Date ,Priority,Branch_ID ,Remarks )
Table-25: Credit_Scores (Score_ID ,Customer_ID ,PAN_Number ,Score_Provider ,Credit_Score ,Last_Updated ,Score_Status ,Loan_Eligibility ,Credit_Utilization_Percentage ,Remarks )

*/


-- ---------------------------------------------------------------- Table Related Queries------------------------------------------------------

-- Table-1: Customers
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    DOB DATE NOT NULL,
    Aadhaar_Number CHAR(12) UNIQUE NOT NULL,
    PAN_Number CHAR(10) UNIQUE NOT NULL,
    Mobile_Number CHAR(10) NOT NULL,
    Email VARCHAR(100),
    Address TEXT NOT NULL
);


-- insert records into table-1
INSERT INTO Customers (First_Name, Last_Name, Gender, DOB, Aadhaar_Number, PAN_Number, Mobile_Number, Email, Address) VALUES
('Advik', 'Ratti', 'Other', '1991-02-03', '459710225173', 'IAMOU3700B', '7513671918', 'choudhryaniruddh@hotmail.com', '98/97, Ramanathan Marg, Warangal-465711'),
('Bhavin', 'Choudhary', 'Other', '1964-09-26', '000497238125', 'SWJAS1987N', '6842605699', 'tusharzacharia@raval-vig.com', '309, Kadakia Circle, Uluberia-698984'),
('Mishti', 'Borah', 'Other', '1987-04-04', '952397801675', 'OTAEK4818U', '4631117483', 'ruppal@hotmail.com', '04/87, Raju Zila, Berhampore-289543'),
('Vihaan', 'Bhagat', 'Other', '2005-04-04', '354723080436', 'PTANQ6326L', '4579430880', 'chokshimisha@bobal.com', '53/96, Sagar Marg, Malegaon-408919'),
('Elakshi', 'Sandal', 'Female', '1995-06-13', '803737365687', 'SDWTT1674E', '0326256938', 'lchakrabarti@gmail.com', '859, Sha Circle, Deoghar 452505'),
('Trisha', 'Bassi', 'Female', '1968-09-05', '215815810217', 'QCIUG5998Q', '4236916187', 'jvarkey@vala.com', 'H.No. 313, Sandal Street, Bilaspur 255582'),
('Riya', 'Sampath', 'Female', '1988-05-03', '513558547621', 'ZZWJI8535S', '6563951451', 'madhupbobal@raman-goda.org', '03, Gupta Nagar, Bharatpur 123886'),
('Tiya', 'Cheema', 'Female', '1974-01-22', '243604880153', 'ZCEEL1201I', '9413244032', 'ryan12@gera.com', '69, Trivedi Ganj, Amaravati 025913'),
('Kabir', 'Chacko', 'Male', '1966-09-10', '928741025528', 'QTRQJ2776L', '2124171093', 'advikabhasin@sekhon.com', '12, Mand Ganj, Giridih 865135'),
('Gokul', 'Gade', 'Male', '1994-07-08', '414664864786', 'NMZSV4796H', '4626836403', 'qsule@bansal.com', '98/610, Mannan Zila, Nashik 607247'),
('Bhamini', 'Zachariah', 'Other', '1993-03-03', '845954800061', 'PKAOW6345Q', '2884829389', 'dhruvsen@gmail.com', '74, Gole, Udupi 911669'),
('Eva', 'Sama', 'Other', '1970-01-15', '331962622893', 'IBJJZ3343M', '1035591671', 'priyanshganguly@konda-rajagopal.com', '539, Dugar Street, Agartala-456844'),
('Yuvraj ', 'Mannan', 'Male', '1980-02-05', '464861412933', 'ORVFR2882Q', '6082035795', 'contractorjivin@savant.com', '744, Som Zila, Nellore 343037'),
('Samiha', 'Walia', 'Other', '1969-07-23', '285409391705', 'APXYL3880V', '7760145487', 'kapoorkashvi@gmail.com', '505, Tella Marg, Ghaziabad-729058'),
('Heer', 'Shanker', 'Male', '1989-11-09', '083275670704', 'RZNBG4523T', '0522599589', 'nirvi85@choudhry-chahal.com', '98/83, Hari Nagar, Dehri 063697'),
('Nitara', 'Thakur', 'Female', '1988-09-09', '040838831684', 'TFPFT0441B', '6585956917', 'prisha97@bhatia-ramaswamy.com', '98, Srinivas Ganj, Nandyal 608693'),
('Vanya', 'Kar', 'Female', '2002-10-11', '764413875841', 'KYKLU9142B', '5652725711', 'hmadan@gmail.com', '391, Hora Nagar, Pondicherry-830794'),
('Bhavin', 'Bava', 'Male', '1994-11-02', '957115549522', 'HMVRO1604W', '4129049551', 'kashvigulati@hotmail.com', '38/00, Sharma Path, Khammam-794313'),
('Onkar', 'Bhagat', 'Male', '1964-11-18', '122015447426', 'YSQAK4532Z', '7556674407', 'aarush93@sodhi.biz', '895, Toor Ganj, Sikar 191195'),
('Amira', 'Venkatesh', 'Female', '1967-04-28', '645011343824', 'WUHKA4018F', '3193435070', 'kothariaaryahi@bhatt-mand.com', '18/59, Ghose Nagar, Bokaro-122672');


-- display table-1
select * from Customers;

truncate table Customers;

drop table Customers;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all customer details
SELECT * FROM Customers;

-- 2. Select only first name, last name and mobile number of female customers
SELECT First_Name, Last_Name, Mobile_Number 
FROM Customers 
WHERE Gender = 'Female';

-- 3. Select customers born after 1990
SELECT Customer_ID, First_Name, Last_Name, DOB 
FROM Customers 
WHERE DOB > '1990-01-01';

-- 4. Select customers whose last name starts with 'B'
SELECT Customer_ID, First_Name, Last_Name 
FROM Customers 
WHERE Last_Name LIKE 'B%';

-- 5. Select distinct genders available in the table
SELECT DISTINCT Gender 
FROM Customers;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add a new column for Pincode
ALTER TABLE Customers ADD COLUMN Pincode CHAR(6);

-- 2. Modify the Email column to make it NOT NULL
ALTER TABLE Customers MODIFY COLUMN Email VARCHAR(100) NOT NULL;

-- 3. Add a column for Date of Registration with default current date
ALTER TABLE Customers ADD COLUMN Date_Of_Registration DATE DEFAULT (CURRENT_DATE);

-- 4. Drop the Pincode column
ALTER TABLE Customers DROP COLUMN Pincode;

-- 5. Change column name "Mobile_Number" to "Phone_Number"
ALTER TABLE Customers CHANGE COLUMN Mobile_Number Phone_Number CHAR(10);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Customers to Bank_Customers
RENAME TABLE Customers TO Bank_Customers;

-- 2. Rename table Bank_Customers back to Customers
RENAME TABLE Bank_Customers TO Customers;

-- 3. Rename table Customers to Client_Records
RENAME TABLE Customers TO Client_Records;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update address of customer with Customer_ID = 1
UPDATE Client_Records 
SET Address = '123, New Residency, Hyderabad' 
WHERE Customer_ID = 1;

-- 2. Update phone number of customer with Aadhaar_Number = '459710225173'
UPDATE Client_Records 
SET Phone_Number = '9999999999' 
WHERE Aadhaar_Number = '459710225173';

-- 3. Update email for customer named 'Trisha'
UPDATE Client_Records 
SET Email = 'trisha.newemail@gmail.com' 
WHERE First_Name = 'Trisha';

-- 4. Update DOB for customer with PAN_Number = 'ZZWJI8535S'
UPDATE Client_Records 
SET DOB = '1990-01-01' 
WHERE PAN_Number = 'ZZWJI8535S';

SET SQL_SAFE_UPDATES = 0;
-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete customer with Customer_ID = 20
DELETE FROM Client_Records 
WHERE Customer_ID = 20;

-- 2. Delete all customers whose gender is 'Other'
DELETE FROM Client_Records 
WHERE Gender = 'Other';

-- 3. Delete customers born before 1970
DELETE FROM Client_Records 
WHERE DOB < '1970-01-01';

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show customer names and add 5 years to their year of birth
SELECT First_Name, Last_Name, YEAR(DOB) + 5 AS Adjusted_Year
FROM Customers;

-- 2. Show customers born before 1980
SELECT Customer_ID, First_Name, Last_Name, DOB
FROM Customers
WHERE YEAR(DOB) < 1980;

-- 3. Show all customers who are Female and born after 1990
SELECT First_Name, Last_Name, Gender, DOB
FROM Customers
WHERE Gender = 'Female' AND YEAR(DOB) > 1990;

-- 4. Show all customers whose email contains 'gmail'
SELECT First_Name, Last_Name, Email
FROM Customers
WHERE Email LIKE '%gmail%';

-- 5. Show all customers whose Aadhaar starts with '98'
SELECT Customer_ID, First_Name, Aadhaar_Number
FROM Customers
WHERE Aadhaar_Number LIKE '98%';

-- 6. Show all customers whose PAN is either 'IAMOU3700B' or 'SWJAS1987N'
SELECT First_Name, Last_Name, PAN_Number
FROM Customers
WHERE PAN_Number IN ('IAMOU3700B', 'SWJAS1987N');

-- 7. Show all customers born between 1985 and 1995
SELECT Customer_ID, First_Name, Last_Name, DOB
FROM Customers
WHERE DOB BETWEEN '1985-01-01' AND '1995-12-31';

-- 8. Show customer details and mark them as 'Adult' if born before 2005, else 'Minor'
SELECT First_Name, Last_Name, 
       CASE WHEN YEAR(DOB) < 2005 THEN 'Adult' ELSE 'Minor' END AS Age_Category
FROM Customers;

-- 9. Show customer full names in uppercase
SELECT UPPER(CONCAT(First_Name, ' ', Last_Name)) AS Full_Name
FROM Customers;

-- 10. Show last 3 digits of mobile numbers
SELECT First_Name, Last_Name, RIGHT(Mobile_Number, 3) AS Last_3_Digits
FROM Customers;


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all customers living in 'Nashik'
SELECT First_Name, Last_Name, Address
FROM Customers
WHERE Address LIKE '%Nashik%';

-- 2. Show unique genders available
SELECT DISTINCT Gender FROM Customers;

-- 3. Show all customers ordered by their date of birth (oldest first)
SELECT First_Name, Last_Name, DOB
FROM Customers
ORDER BY DOB ASC;

-- 4. Count how many customers are there in each gender
SELECT Gender, COUNT(*) AS Total_Customers
FROM Customers
GROUP BY Gender;

-- 5. Show genders with more than 5 customers
SELECT Gender, COUNT(*) AS Total_Customers
FROM Customers
GROUP BY Gender
HAVING COUNT(*) > 5;

-- 6. Show only first 5 customers
SELECT Customer_ID, First_Name, Last_Name
FROM Customers
LIMIT 5;

-- 7. Show customers along with their PAN and Aadhaar by joining PAN & Aadhaar as one string
SELECT First_Name, Last_Name, CONCAT(PAN_Number, ' - ', Aadhaar_Number) AS ID_Details
FROM Customers;

-- 8. Combine first and last name of customers as a single column
SELECT CONCAT(First_Name, ' ', Last_Name) AS Full_Name
FROM Customers;

-- 9. Show all customers whose year of birth is in (1964, 1988, 1994)
SELECT First_Name, Last_Name, DOB
FROM Customers
WHERE YEAR(DOB) IN (1964, 1988, 1994);

-- 10. Show all customers with an alias for their email column as "Contact_Email"
SELECT First_Name, Last_Name, Email AS Contact_Email
FROM Customers;


-- Table-2: Branches 
CREATE TABLE Branches (
    Branch_ID INT PRIMARY KEY AUTO_INCREMENT,
    Branch_Name VARCHAR(100) NOT NULL,
    IFSC_Code CHAR(11) UNIQUE NOT NULL,
    MICR_Code CHAR(9),
    Address TEXT NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Pincode CHAR(6) NOT NULL,
    Contact_Number CHAR(10),
    Manager_Name VARCHAR(100)
);

-- insert records to table-2
INSERT INTO Branches (Branch_Name, IFSC_Code, MICR_Code, Address, City, State, Pincode, Contact_Number, Manager_Name) VALUES
('Chennai Branch', 'HDFC08SK62G', '629087393', '60/067, Mannan Path, Tenali-445501', 'Silchar', 'Jharkhand', '873081', '6870541417', 'Nehmat Chokshi'),
('Kolkata Hub', 'HDFC0IYVS7K', '401498749', 'H.No. 15, Borra Circle, Vijayanagaram 330419', 'Saharsa', 'Telangana', '356653', '7072855684', 'Lakshit Contractor'),
('Mumbai Main', 'HDFC01X9TP7', '612747355', '793, Kalita Circle, Bhiwandi 601193', 'Buxar', 'Manipur', '088443', '5902480822', 'Aradhya Krishnamurthy'),
('Delhi HQ', 'HDFC0DA1ISN', '199239530', '435, Krishnan Street, Aurangabad-297503', 'Nagpur', 'Uttarakhand', '596390', '0874525790', 'Adah Bora'),
('Mumbai Main', 'HDFC03FEY0N', '158890438', '22, Bhatt Road, Proddatur 599477', 'Danapur', 'Uttar Pradesh', '295543', '8530108792', 'Saksham Soni'),
('Chennai Branch', 'HDFC0E4J0XD', '147806004', '67/36, Bhagat, Orai 655465', 'Thiruvananthapuram', 'West Bengal', '482693', '0167642188', 'Taran Chanda'),
('Chennai Branch', 'HDFC0S1QF25', '882104577', '65/841, Reddy Ganj, New Delhi 178578', 'Junagadh', 'Maharashtra', '109620', '2346661381', 'Anahi Barad'),
('Chennai Branch', 'HDFC0SQMSRZ', '490176339', '254, Verma, Arrah 789039', 'Yamunanagar', 'Odisha', '050519', '5456911174', 'Neysa Doctor'),
('Bangalore Branch', 'HDFC0I5Q1AW', '061440736', '02, Bhavsar Nagar, Ramagundam-122175', 'Saharanpur', 'Nagaland', '837395', '9324527454', 'Priyansh Khalsa'),
('Delhi HQ', 'HDFC0NQ94EZ', '582511290', '27/997, Gour, Jamalpur-789007', 'Coimbatore', 'Sikkim', '137546', '7688559500', 'Prerak Jha'),
('Delhi HQ', 'HDFC0XQ9NOB', '722286953', '10/838, Gulati Ganj, Madhyamgram 382897', 'Dehri', 'Goa', '836825', '3836326349', 'Myra Chaudhuri'),
('Chennai Branch', 'HDFC0HKG5I4', '350368243', 'H.No. 761, Setty Chowk, Bharatpur 973687', 'Panipat', 'Punjab', '178611', '1659242530', 'Renee Dugal'),
('Bangalore Branch', 'HDFC0P8C2NP', '902987067', '42/856, Sodhi Road, Mira-Bhayandar 277847', 'Dindigul', 'Nagaland', '544354', '1492828765', 'Krish Shanker'),
('Kolkata Hub', 'HDFC0WFK1XT', '136522646', '93/055, Kohli Path, Sirsa 285187', 'Chennai', 'Uttar Pradesh', '178800', '1122675911', 'Kiaan Chaudry'),
('Delhi HQ', 'HDFC09D3DSM', '384410632', '37/70, Gupta Zila, Nagercoil-312092', 'South Dumdum', 'Goa', '316643', '6301136731', 'Ritvik Sane'),
('Kolkata Hub', 'HDFC0Q3MT5I', '673532088', 'H.No. 61, Datta Path, Maheshtala 994750', 'Nagaon', 'Haryana', '846993', '2634195781', 'Jayesh Kulkarni'),
('Delhi HQ', 'HDFC0SE5Z4W', '000436069', '73/444, Mani Ganj, Sagar-215389', 'Gudivada', 'Uttarakhand', '185705', '3790607859', 'Hazel Madan'),
('Kolkata Hub', 'HDFC05UDCQ0', '268401685', '93, Bobal Zila, Udupi-655954', 'Moradabad', 'Manipur', '188183', '1531066666', 'Seher Gera'),
('Chennai Branch', 'HDFC0IN1O3E', '627125268', '05/675, Sawhney Marg, Kadapa-108522', 'Ahmednagar', 'Tamil Nadu', '354475', '1635959314', 'Saira De'),
('Bangalore Branch', 'HDFC0A2OMQC', '336680601', 'H.No. 60, Yohannan Road, Amritsar 833854', 'Bhopal', 'Sikkim', '088262', '6986369492', 'Riaan Mann');


-- display table-2
select * from Branches;

truncate table Branches;

drop table Branches;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all branch details
SELECT * FROM Branches;

-- 2. Select only Branch_Name and City for branches located in 'Goa'
SELECT Branch_Name, City 
FROM Branches 
WHERE State = 'Goa';

-- 3. Select distinct states where branches exist
SELECT DISTINCT State 
FROM Branches;

-- 4. Select branches whose IFSC code starts with 'HDFC0D'
SELECT Branch_ID, Branch_Name, IFSC_Code 
FROM Branches 
WHERE IFSC_Code LIKE 'HDFC0D%';

-- 5. Select branches in Maharashtra with manager names
SELECT Branch_Name, Manager_Name 
FROM Branches 
WHERE State = 'Maharashtra';


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add a new column for Branch_Type
ALTER TABLE Branches ADD COLUMN Branch_Type VARCHAR(50);

-- 2. Modify the Manager_Name column to NOT NULL
ALTER TABLE Branches MODIFY COLUMN Manager_Name VARCHAR(100) NOT NULL;

-- 3. Add a column for Established_Date
ALTER TABLE Branches ADD COLUMN Established_Date DATE;

-- 4. Drop the Established_Date column
ALTER TABLE Branches DROP COLUMN Established_Date;

-- 5. Change column name Contact_Number to Phone_Number
ALTER TABLE Branches CHANGE COLUMN Contact_Number Phone_Number CHAR(10);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Branches to Bank_Branches
RENAME TABLE Branches TO Bank_Branches;

-- 2. Rename table Bank_Branches back to Branches
RENAME TABLE Bank_Branches TO Branches;

-- 3. Rename table Branches to Branch_Records
RENAME TABLE Branches TO Branch_Records;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update phone number of branch with Branch_ID = 1
UPDATE Branch_Records 
SET Phone_Number = '9998887777' 
WHERE Branch_ID = 1;

-- 2. Update manager name for branch with IFSC_Code = 'HDFC0DA1ISN'
UPDATE Branch_Records 
SET Manager_Name = 'Rohan Sharma' 
WHERE IFSC_Code = 'HDFC0DA1ISN';

-- 3. Update state of branches in City = 'Chennai'
UPDATE Branch_Records 
SET State = 'Tamil Nadu' 
WHERE City = 'Chennai';

-- 4. Update Branch_Type of all branches in Sikkim
UPDATE Branch_Records 
SET Branch_Type = 'Regional Office' 
WHERE State = 'Sikkim';


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete branch with Branch_ID = 20
DELETE FROM Branch_Records 
WHERE Branch_ID = 20;

-- 2. Delete all branches located in 'Nagaland'
DELETE FROM Branch_Records 
WHERE State = 'Nagaland';

-- 3. Delete branches where Branch_Name = 'Mumbai Main'
DELETE FROM Branch_Records 
WHERE Branch_Name = 'Mumbai Main';

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show branch names and add 10 to their pincode number
SELECT Branch_Name, Pincode, CAST(Pincode AS UNSIGNED) + 10 AS Adjusted_Pincode
FROM Branches;

-- 2. Show all branches where pincode is less than 200000
SELECT Branch_ID, Branch_Name, Pincode
FROM Branches
WHERE CAST(Pincode AS UNSIGNED) < 200000;

-- 3. Show all branches that are in 'Goa' or 'Sikkim'
SELECT Branch_Name, City, State
FROM Branches
WHERE State = 'Goa' OR State = 'Sikkim';

-- 4. Show all branches whose IFSC code starts with 'HDFC0'
SELECT Branch_Name, IFSC_Code
FROM Branches
WHERE IFSC_Code LIKE 'HDFC0%';

-- 5. Show all branches where city name contains 'pur'
SELECT Branch_Name, City
FROM Branches
WHERE City LIKE '%pur%';

-- 6. Show branches where MICR code is either '629087393' or '401498749'
SELECT Branch_Name, MICR_Code
FROM Branches
WHERE MICR_Code IN ('629087393', '401498749');

-- 7. Show branches with pincodes between 100000 and 300000
SELECT Branch_Name, Pincode
FROM Branches
WHERE CAST(Pincode AS UNSIGNED) BETWEEN 100000 AND 300000;

-- 8. Show branch name along with type 'Metro' if in Chennai/Mumbai/Delhi, else 'Non-Metro'
SELECT Branch_Name, City, 
       CASE WHEN City IN ('Chennai','Mumbai','Delhi') THEN 'Metro' ELSE 'Non-Metro' END AS Branch_Type
FROM Branches;

-- 9. Show manager names in uppercase
SELECT UPPER(Manager_Name) AS Manager_Upper
FROM Branches;

-- 10. Show first 3 characters of IFSC code
SELECT Branch_Name, LEFT(IFSC_Code, 3) AS IFSC_Prefix
FROM Branches;


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all branches located in 'Nagaland'
SELECT Branch_Name, City, State
FROM Branches
WHERE State = 'Nagaland';

-- 2. Show unique branch names available
SELECT DISTINCT Branch_Name FROM Branches;

-- 3. Show all branches ordered by their pincode (ascending)
SELECT Branch_Name, City, Pincode
FROM Branches
ORDER BY CAST(Pincode AS UNSIGNED) ASC;

-- 4. Count how many branches exist in each state
SELECT State, COUNT(*) AS Total_Branches
FROM Branches
GROUP BY State;

-- 5. Show states with more than 2 branches
SELECT State, COUNT(*) AS Total_Branches
FROM Branches
GROUP BY State
HAVING COUNT(*) > 2;

-- 6. Show only first 5 branch records
SELECT Branch_ID, Branch_Name, City
FROM Branches
LIMIT 5;

-- 7. Show branch names along with their IFSC and MICR combined
SELECT Branch_Name, CONCAT(IFSC_Code, ' - ', MICR_Code) AS Bank_Codes
FROM Branches;

-- 8. Show branch full address with city and state combined
SELECT CONCAT(Address, ', ', City, ', ', State) AS Full_Address
FROM Branches;

-- 9. Show all branches located in states (Jharkhand, Goa, Manipur)
SELECT Branch_Name, State
FROM Branches
WHERE State IN ('Jharkhand','Goa','Manipur');

-- 10. Show all branches with alias for manager column as "Branch_Manager"
SELECT Branch_Name, Manager_Name AS Branch_Manager
FROM Branches;



-- Table-3 Accounts
CREATE TABLE Accounts (
    Account_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Branch_ID INT NOT NULL,
    Account_Type ENUM('Savings', 'Current', 'Salary', 'NRI', 'Fixed Deposit') NOT NULL,
    Account_Number CHAR(14) UNIQUE NOT NULL,
    Balance DECIMAL(12,2) NOT NULL,
    Opening_Date DATE NOT NULL,
    Status ENUM('Active', 'Inactive', 'Closed') DEFAULT 'Active',
    Nominee_Name VARCHAR(100),
    IFSC_Code CHAR(11),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
);

-- isnert records into table-3
INSERT INTO Accounts (Customer_ID, Branch_ID, Account_Type, Account_Number, Balance, Opening_Date, Status, Nominee_Name, IFSC_Code) VALUES
(1, 2, 'Salary', '82805596462634', 107416.67, '2020-11-21', 'Closed', 'Baiju Chopra', 'HDFC0G3DTAO'),
(2, 3, 'Salary', '29799369369484', 39361.76, '2022-12-20', 'Inactive', 'Ahana  Luthra', 'HDFC0LBV309'),
(3, 3, 'Savings', '22107552791989', 34724.9, '2022-10-05', 'Closed', 'Nakul Jain', 'HDFC0VMNMRP'),
(4, 4, 'Fixed Deposit', '06794440862018', 282242.86, '2020-09-30', 'Active', 'Diya Bassi', 'HDFC06626JT'),
(5, 3, 'Salary', '61365790926570', 191646.01, '2021-08-21', 'Active', 'Mehul Chhabra', 'HDFC0DW2TQL'),
(6, 4, 'Savings', '69888439342961', 387512.14, '2020-09-22', 'Inactive', 'Ahana  Sarna', 'HDFC0UNBC8T'),
(7, 1, 'Salary', '78519722364757', 109056.7, '2021-12-26', 'Active', 'Jivika Tella', 'HDFC00PRYG7'),
(8, 3, 'Fixed Deposit', '90157114430961', 390298.93, '2021-04-12', 'Active', 'Vedika Joshi', 'HDFC0CWZWJW'),
(9, 4, 'Savings', '42256673830415', 134722.62, '2024-02-17', 'Active', 'Saanvi Bali', 'HDFC0LX3OG0'),
(10, 5, 'Fixed Deposit', '01614554189169', 373146.84, '2023-10-27', 'Closed', 'Jivin Dua', 'HDFC0SW7EHN'),
(11, 1, 'Savings', '03042415849323', 311858.74, '2020-11-30', 'Active', 'Ryan Cheema', 'HDFC0M4E57D'),
(12, 2, 'Salary', '77221062277505', 105686.83, '2024-09-22', 'Closed', 'Khushi Kata', 'HDFC0GOXGKT'),
(13, 4, 'Savings', '23747893128169', 405330.5, '2022-04-29', 'Closed', 'Mamooty Gandhi', 'HDFC03DRKCB'),
(14, 1, 'Current', '55657606045589', 67011.05, '2020-07-28', 'Inactive', 'Ivana Wason', 'HDFC0IQYP0Q'),
(15, 2, 'Savings', '26071598387601', 277737.33, '2024-02-15', 'Closed', 'Nirvaan Sankar', 'HDFC0PN7I7Z'),
(16, 4, 'NRI', '17117775741492', 14367.01, '2022-01-03', 'Active', 'Pihu Kulkarni', 'HDFC0W132WV'),
(17, 5, 'Salary', '32905996395141', 39275.15, '2022-04-04', 'Inactive', 'Shamik Jani', 'HDFC09Q69MT'),
(18, 3, 'NRI', '28737304507680', 446267.21, '2023-01-16', 'Closed', 'Zara Gola', 'HDFC0DK9281'),
(19, 3, 'Savings', '84230373074430', 251068.32, '2024-01-14', 'Closed', 'Hridaan Rajagopal', 'HDFC0VTLILO'),
(20, 4, 'Salary', '78795373822345', 41300.94, '2024-02-26', 'Active', 'Charvi Madan', 'HDFC01PW4AA');


-- display table-3
select * from Accounts;

truncate table Accounts;

drop table Accounts;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all account details
SELECT * FROM Accounts;

-- 2. Select Account_Number, Balance and Status of Active accounts
SELECT Account_Number, Balance, Status 
FROM Accounts 
WHERE Status = 'Active';

-- 3. Select accounts with balance greater than 300000
SELECT Account_ID, Account_Number, Balance 
FROM Accounts 
WHERE Balance > 300000;

-- 4. Select distinct Account_Types available in the table
SELECT DISTINCT Account_Type 
FROM Accounts;

-- 5. Select accounts opened after 2022
SELECT Account_ID, Account_Number, Opening_Date 
FROM Accounts 
WHERE Opening_Date > '2022-01-01';


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add a column for Interest_Rate
ALTER TABLE Accounts ADD COLUMN Interest_Rate DECIMAL(5,2);

-- 2. Modify Nominee_Name column to NOT NULL
ALTER TABLE Accounts MODIFY COLUMN Nominee_Name VARCHAR(100) NOT NULL;

-- 3. Add a column Last_Transaction_Date
ALTER TABLE Accounts ADD COLUMN Last_Transaction_Date DATE;

-- 4. Drop the Last_Transaction_Date column
ALTER TABLE Accounts DROP COLUMN Last_Transaction_Date;

-- 5. Change column name Balance to Account_Balance
ALTER TABLE Accounts CHANGE COLUMN Balance Account_Balance DECIMAL(12,2);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Accounts to Bank_Accounts
RENAME TABLE Accounts TO Bank_Accounts;

-- 2. Rename table Bank_Accounts back to Accounts
RENAME TABLE Bank_Accounts TO Accounts;

-- 3. Rename table Accounts to Account_Records
RENAME TABLE Accounts TO Account_Records;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update Account_Balance for account with Account_ID = 1
UPDATE Account_Records 
SET Account_Balance = 150000.00 
WHERE Account_ID = 1;

-- 2. Update Status of account with Account_Number = '22107552791989'
UPDATE Account_Records 
SET Status = 'Active' 
WHERE Account_Number = '22107552791989';

-- 3. Update IFSC_Code of account with Account_ID = 10
UPDATE Account_Records 
SET IFSC_Code = 'HDFC0NEWIFSC' 
WHERE Account_ID = 10;

-- 4. Update Nominee_Name for all Salary accounts
UPDATE Account_Records 
SET Nominee_Name = 'Updated Nominee' 
WHERE Account_Type = 'Salary';


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete account with Account_ID = 20
DELETE FROM Account_Records 
WHERE Account_ID = 20;

-- 2. Delete all accounts where Status = 'Closed'
DELETE FROM Account_Records 
WHERE Status = 'Closed';

-- 3. Delete accounts with Account_Balance less than 50000
DELETE FROM Account_Records 
WHERE Account_Balance < 50000;


-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show account balances with 5% interest added
SELECT Account_ID, Balance, Balance * 1.05 AS Balance_With_Interest
FROM Accounts;

-- 2. Show all accounts with balance greater than 300000
SELECT Account_ID, Account_Type, Balance
FROM Accounts
WHERE Balance > 300000;

-- 3. Show accounts that are either 'Active' OR have a balance above 250000
SELECT Account_ID, Status, Balance
FROM Accounts
WHERE Status = 'Active' OR Balance > 250000;

-- 4. Show all accounts whose Account_Number starts with '28'
SELECT Account_ID, Account_Number, Customer_ID
FROM Accounts
WHERE Account_Number LIKE '28%';

-- 5. Show accounts whose nominee name contains 'Jain'
SELECT Account_ID, Nominee_Name
FROM Accounts
WHERE Nominee_Name LIKE '%Jain%';

-- 6. Show accounts with Account_ID in (2, 5, 8, 10)
SELECT Account_ID, Account_Type, Balance
FROM Accounts
WHERE Account_ID IN (2,5,8,10);

-- 7. Show accounts opened between 2021-01-01 and 2023-01-01
SELECT Account_ID, Opening_Date
FROM Accounts
WHERE Opening_Date BETWEEN '2021-01-01' AND '2023-01-01';

-- 8. Show account type as 'Deposit' if Fixed Deposit, else 'Regular'
SELECT Account_ID, Account_Type,
       CASE WHEN Account_Type = 'Fixed Deposit' THEN 'Deposit' ELSE 'Regular' END AS Account_Category
FROM Accounts;

-- 9. Show all nominee names in uppercase
SELECT UPPER(Nominee_Name) AS Nominee_Upper
FROM Accounts;

-- 10. Show last 4 digits of account number
SELECT Account_ID, RIGHT(Account_Number, 4) AS Last4_Digits
FROM Accounts;


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all accounts belonging to Branch_ID = 3
SELECT Account_ID, Customer_ID, Account_Type
FROM Accounts
WHERE Branch_ID = 3;

-- 2. Show distinct account types available
SELECT DISTINCT Account_Type FROM Accounts;

-- 3. Show accounts ordered by Balance in descending order
SELECT Account_ID, Account_Type, Balance
FROM Accounts
ORDER BY Balance DESC;

-- 4. Count how many accounts exist per Account_Type
SELECT Account_Type, COUNT(*) AS Total_Accounts
FROM Accounts
GROUP BY Account_Type;

-- 5. Show account types where average balance is greater than 200000
SELECT Account_Type, AVG(Balance) AS Avg_Balance
FROM Accounts
GROUP BY Account_Type
HAVING AVG(Balance) > 200000;

-- 6. Show top 5 accounts with highest balance
SELECT Account_ID, Balance
FROM Accounts
ORDER BY Balance DESC
LIMIT 5;

-- 7. Show all accounts with IFSC and Account_Number merged
SELECT CONCAT(IFSC_Code, '-', Account_Number) AS Account_Details
FROM Accounts;

-- 8. Show all accounts with full details: Customer_ID + Branch_ID + Balance together
SELECT CONCAT('Cust:', Customer_ID, ' | Branch:', Branch_ID, ' | Bal:', Balance) AS Full_Info
FROM Accounts;

-- 9. Show all accounts belonging to Branch_ID 2, 3, or 5
SELECT Account_ID, Branch_ID, Balance
FROM Accounts
WHERE Branch_ID IN (2,3,5);

-- 10. Show accounts with alias 'Acc_Balance' for balance column
SELECT Account_ID, Balance AS Acc_Balance
FROM Accounts;



-- Table-4 Transactions
CREATE TABLE Transactions (
    Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
    Account_ID INT NOT NULL,
    Transaction_Type ENUM('Credit', 'Debit') NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Transaction_Date DATETIME NOT NULL,
    Mode ENUM('NEFT', 'RTGS', 'IMPS', 'UPI', 'Cash', 'Cheque') NOT NULL,
    Description VARCHAR(255),
    Balance_After DECIMAL(12,2),
    Reference_No VARCHAR(20),
    Branch_ID INT,
    FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
);


-- insert records into table-4
INSERT INTO Transactions (Account_ID, Transaction_Type, Amount, Transaction_Date, Mode, Description, Balance_After, Reference_No, Branch_ID) VALUES
(4, 'Credit', 34853.96, '2023-10-01 08:50:04', 'Cheque', 'Cheque Credit transaction', 130225.92, '4WSB9AOLUCJZDJG6', 2),
(20, 'Credit', 5571.59, '2025-03-19 08:06:25', 'NEFT', 'NEFT Credit transaction', 194715.13, '3PBULQ9OVIUU3ZLK', 4),
(9, 'Debit', 30186.59, '2024-06-24 12:58:23', 'Cash', 'Cash Debit transaction', 411434.93, 'EH8UNI0Z7W4WLZO6', 5),
(5, 'Credit', 17327.1, '2025-04-24 16:31:02', 'UPI', 'UPI Credit transaction', 63605.01, '09ZKQYEOTVXW62H1', 1),
(1, 'Debit', 75679.1, '2025-05-09 17:44:55', 'IMPS', 'IMPS Debit transaction', 56623.84, 'N0ES1UQL6DO541VU', 1),
(1, 'Debit', 61441.11, '2023-11-11 21:46:54', 'RTGS', 'RTGS Debit transaction', 489376.15, '5GXNH2OMUZJHEGXR', 5),
(10, 'Credit', 94345.26, '2024-08-22 16:27:32', 'NEFT', 'NEFT Credit transaction', 229059.47, 'IIOZ2EJ4V5HHU0JO', 2),
(2, 'Credit', 59302.81, '2024-03-23 17:34:07', 'Cheque', 'Cheque Credit transaction', 285258.56, 'J69ZMZYNQK2XP6GX', 2),
(6, 'Credit', 61017.36, '2023-11-09 04:21:44', 'IMPS', 'IMPS Credit transaction', 197306.04, 'JIVW8RLHMX03CMVF', 5),
(13, 'Debit', 5078.05, '2023-08-17 21:37:36', 'UPI', 'UPI Debit transaction', 199060.77, 'RXY841MQOFK1JZZW', 4),
(16, 'Credit', 35762.89, '2025-07-13 08:18:00', 'Cash', 'Cash Credit transaction', 236976.84, 'UY807YDF62F6RZPS', 5),
(3, 'Debit', 77662.95, '2024-01-03 07:02:01', 'Cheque', 'Cheque Debit transaction', 412236.59, 'SBOM36PFBCLK0H05', 5),
(1, 'Credit', 65547.63, '2025-01-20 13:31:00', 'RTGS', 'RTGS Credit transaction', 75383.04, '7TXSJK7DX4HALHX1', 3),
(5, 'Credit', 64048.19, '2024-07-17 12:54:00', 'RTGS', 'RTGS Credit transaction', 93008.84, 'YNGWL2AHXFZCOYJX', 5),
(19, 'Debit', 31637.48, '2024-09-14 17:13:43', 'UPI', 'UPI Debit transaction', 158702.54, 'EDJ6WTFKU5F54BLO', 2),
(13, 'Credit', 78886.1, '2024-11-07 00:22:45', 'NEFT', 'NEFT Credit transaction', 152544.05, 'ZNE1CWJRQMTLF19D', 1),
(18, 'Credit', 24274.34, '2025-05-27 18:37:29', 'IMPS', 'IMPS Credit transaction', 406951.98, '6G7NTCH243JEYIWV', 5),
(7, 'Credit', 93296.35, '2024-12-29 19:04:31', 'Cheque', 'Cheque Credit transaction', 293009.3, 'EVCKD2CB8NSVAJP7', 4),
(12, 'Debit', 41123.75, '2023-11-05 14:15:36', 'NEFT', 'NEFT Debit transaction', 397660.27, 'YZY2ZQNDID66ROBG', 2),
(6, 'Credit', 65586.95, '2023-07-21 02:18:16', 'Cash', 'Cash Credit transaction', 393645.74, 'BYBUI6D0G9Z4CE1Z', 3);


-- display table-4
select * from Transactions;

truncate table Transactions;

drop table Transactions;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all transaction details
SELECT * FROM Transactions;

-- 2. Select all Debit transactions with Amount > 50000
SELECT Transaction_ID, Account_ID, Amount, Transaction_Date 
FROM Transactions 
WHERE Transaction_Type = 'Debit' AND Amount > 50000;

-- 3. Select transactions done via UPI
SELECT Transaction_ID, Account_ID, Amount, Mode, Transaction_Date 
FROM Transactions 
WHERE Mode = 'UPI';

-- 4. Select distinct transaction modes used
SELECT DISTINCT Mode 
FROM Transactions;

-- 5. Select transactions between 2024-01-01 and 2024-12-31
SELECT Transaction_ID, Account_ID, Amount, Transaction_Date 
FROM Transactions 
WHERE Transaction_Date BETWEEN '2024-01-01' AND '2024-12-31';


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add a column for Transaction_Status
ALTER TABLE Transactions ADD COLUMN Transaction_Status VARCHAR(20);

-- 2. Modify Description column to NOT NULL
ALTER TABLE Transactions MODIFY COLUMN Description VARCHAR(255) NOT NULL;

-- 3. Add a column for Charges
ALTER TABLE Transactions ADD COLUMN Charges DECIMAL(8,2);

-- 4. Drop the Charges column
ALTER TABLE Transactions DROP COLUMN Charges;

-- 5. Change column name Amount to Transaction_Amount
ALTER TABLE Transactions CHANGE COLUMN Amount Transaction_Amount DECIMAL(10,2);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Transactions to Bank_Transactions
RENAME TABLE Transactions TO Bank_Transactions;

-- 2. Rename table Bank_Transactions back to Transactions
RENAME TABLE Bank_Transactions TO Transactions;

-- 3. Rename table Transactions to Transaction_Records
RENAME TABLE Transactions TO Transaction_Records;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update Transaction_Status of all Credit transactions to 'Successful'
UPDATE Transaction_Records 
SET Transaction_Status = 'Successful' 
WHERE Transaction_Type = 'Credit';

-- 2. Update Reference_No for Transaction_ID = 5
UPDATE Transaction_Records 
SET Reference_No = 'NEWREF12345' 
WHERE Transaction_ID = 5;

-- 3. Update Transaction_Amount for Transaction_ID = 10
UPDATE Transaction_Records 
SET Transaction_Amount = 6000.00 
WHERE Transaction_ID = 10;

-- 4. Update Mode to 'UPI' for transactions done in Branch_ID = 2
UPDATE Transaction_Records 
SET Mode = 'UPI' 
WHERE Branch_ID = 2;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete transaction with Transaction_ID = 20
DELETE FROM Transaction_Records 
WHERE Transaction_ID = 20;

-- 2. Delete all transactions where Transaction_Amount < 10000
DELETE FROM Transaction_Records 
WHERE Transaction_Amount < 10000;

-- 3. Delete all transactions with Mode = 'Cheque'
DELETE FROM Transaction_Records 
WHERE Mode = 'Cheque';

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show transaction amounts with 18% GST added
SELECT Transaction_ID, Amount, Amount * 1.18 AS Amount_With_GST
FROM Transactions;

-- 2. Show all debit transactions greater than 50,000
SELECT Transaction_ID, Transaction_Type, Amount
FROM Transactions
WHERE Transaction_Type = 'Debit' AND Amount > 50000;

-- 3. Show all transactions that are either IMPS OR above 80,000
SELECT Transaction_ID, Mode, Amount
FROM Transactions
WHERE Mode = 'IMPS' OR Amount > 80000;

-- 4. Show transactions where reference number starts with 'J'
SELECT Transaction_ID, Reference_No
FROM Transactions
WHERE Reference_No LIKE 'J%';

-- 5. Show all transactions where description contains 'UPI'
SELECT Transaction_ID, Description
FROM Transactions
WHERE Description LIKE '%UPI%';

-- 6. Show transactions belonging to Account_IDs 1, 5, 10, 20
SELECT Transaction_ID, Account_ID, Amount
FROM Transactions
WHERE Account_ID IN (1,5,10,20);

-- 7. Show all transactions made between '2024-01-01' and '2024-12-31'
SELECT Transaction_ID, Transaction_Date, Amount
FROM Transactions
WHERE Transaction_Date BETWEEN '2024-01-01' AND '2024-12-31';

-- 8. Classify transaction type as 'Income' if Credit, else 'Expense'
SELECT Transaction_ID, Transaction_Type,
       CASE WHEN Transaction_Type = 'Credit' THEN 'Income' ELSE 'Expense' END AS Txn_Category
FROM Transactions;

-- 9. Show all transaction descriptions in lowercase
SELECT LOWER(Description) AS Description_Lower
FROM Transactions;

-- 10. Show the first 6 characters of Reference_No
SELECT Transaction_ID, LEFT(Reference_No, 6) AS Ref_Prefix
FROM Transactions;


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all transactions from Branch_ID = 5
SELECT Transaction_ID, Branch_ID, Amount
FROM Transactions
WHERE Branch_ID = 5;

-- 2. Show distinct transaction modes
SELECT DISTINCT Mode FROM Transactions;

-- 3. Show all transactions ordered by Amount (descending)
SELECT Transaction_ID, Amount, Transaction_Type
FROM Transactions
ORDER BY Amount DESC;

-- 4. Count how many transactions per Mode
SELECT Mode, COUNT(*) AS Total_Transactions
FROM Transactions
GROUP BY Mode;

-- 5. Show transaction types where average amount is greater than 50,000
SELECT Transaction_Type, AVG(Amount) AS Avg_Amount
FROM Transactions
GROUP BY Transaction_Type
HAVING AVG(Amount) > 50000;

-- 6. Show top 5 largest transactions
SELECT Transaction_ID, Amount
FROM Transactions
ORDER BY Amount DESC
LIMIT 5;

-- 7. Show account + reference number combined as details
SELECT CONCAT(Account_ID, '-', Reference_No) AS Account_Ref
FROM Transactions;

-- 8. Show branch-wise total credited amount
SELECT Branch_ID, SUM(Amount) AS Total_Credit
FROM Transactions
WHERE Transaction_Type = 'Credit'
GROUP BY Branch_ID;

-- 9. Show all transactions belonging to Branch_ID 1, 2, or 4
SELECT Transaction_ID, Branch_ID, Amount
FROM Transactions
WHERE Branch_ID IN (1,2,4);

-- 10. Show transaction amount with alias 'Txn_Amount'
SELECT Transaction_ID, Amount AS Txn_Amount
FROM Transactions;



-- Table-5 Employees
CREATE TABLE Employees (
  Employee_ID INT PRIMARY KEY AUTO_INCREMENT,
  First_Name VARCHAR(50) NOT NULL,
  Last_Name VARCHAR(50) NOT NULL,
  Branch_ID INT NOT NULL,
  Position VARCHAR(50) NOT NULL,
  DOJ DATE NOT NULL,
  Salary DECIMAL(10,2) NOT NULL,
  Email VARCHAR(100) UNIQUE,
  Contact_Number CHAR(10) NOT NULL,
  Status ENUM('Active', 'Resigned', 'Retired') DEFAULT 'Active',
  FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
);


-- insert records into table-5
INSERT INTO Employees (First_Name, Last_Name, Branch_ID, Position, DOJ, Salary, Email, Contact_Number, Status) VALUES
('Amit', 'Sharma', 1, 'Manager', '2015-04-12', 95000.00, 'amit.sharma@hdfcbank.com', '9876543210', 'Active'),
('Priya', 'Verma', 2, 'Clerk', '2018-06-15', 35000.00, 'priya.verma@hdfcbank.com', '9876543211', 'Active'),
('Rohan', 'Patil', 3, 'Cashier', '2017-02-20', 40000.00, 'rohan.patil@hdfcbank.com', '9876543212', 'Active'),
('Sneha', 'Nair', 4, 'Loan Officer', '2019-07-01', 50000.00, 'sneha.nair@hdfcbank.com', '9876543213', 'Active'),
('Rahul', 'Jain', 5, 'IT Support', '2016-03-18', 60000.00, 'rahul.jain@hdfcbank.com', '9876543214', 'Active'),
('Kiran', 'Mehta', 1, 'Clerk', '2020-11-10', 37000.00, 'kiran.mehta@hdfcbank.com', '9876543215', 'Active'),
('Anjali', 'Kapoor', 2, 'Manager', '2012-05-23', 100000.00, 'anjali.kapoor@hdfcbank.com', '9876543216', 'Resigned'),
('Suresh', 'Desai', 3, 'Cashier', '2014-09-14', 42000.00, 'suresh.desai@hdfcbank.com', '9876543217', 'Retired'),
('Pooja', 'Iyer', 4, 'Loan Officer', '2018-12-29', 52000.00, 'pooja.iyer@hdfcbank.com', '9876543218', 'Active'),
('Vikas', 'Rao', 5, 'Clerk', '2021-01-19', 36000.00, 'vikas.rao@hdfcbank.com', '9876543219', 'Active'),
('Nisha', 'Joshi', 1, 'IT Support', '2019-08-08', 58000.00, 'nisha.joshi@hdfcbank.com', '9876543220', 'Active'),
('Manoj', 'Kulkarni', 2, 'Cashier', '2013-10-02', 43000.00, 'manoj.kulkarni@hdfcbank.com', '9876543221', 'Retired'),
('Deepa', 'Menon', 3, 'Clerk', '2020-03-11', 35000.00, 'deepa.menon@hdfcbank.com', '9876543222', 'Active'),
('Sanjay', 'Mishra', 4, 'Manager', '2016-06-27', 97000.00, 'sanjay.mishra@hdfcbank.com', '9876543223', 'Active'),
('Bhavna', 'Singh', 5, 'Loan Officer', '2017-11-22', 51000.00, 'bhavna.singh@hdfcbank.com', '9876543224', 'Active'),
('Arun', 'Chopra', 1, 'IT Support', '2018-04-14', 61000.00, 'arun.chopra@hdfcbank.com', '9876543225', 'Active'),
('Meena', 'Reddy', 2, 'Cashier', '2015-05-17', 41000.00, 'meena.reddy@hdfcbank.com', '9876543226', 'Resigned'),
('Raj', 'Garg', 3, 'Clerk', '2019-10-03', 34000.00, 'raj.garg@hdfcbank.com', '9876543227', 'Active'),
('Swati', 'Saxena', 4, 'Manager', '2021-02-25', 98000.00, 'swati.saxena@hdfcbank.com', '9876543228', 'Active'),
('Neeraj', 'Thakur', 5, 'Loan Officer', '2016-01-30', 53000.00, 'neeraj.thakur@hdfcbank.com', '9876543229', 'Active');


-- display table-5
select * from Employees;

truncate table Employees;

drop table Employees;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all employee details
SELECT * FROM Employees;

-- 2. Select employees who are Managers
SELECT Employee_ID, First_Name, Last_Name, Position, Salary 
FROM Employees 
WHERE Position = 'Manager';

-- 3. Select employees with Salary greater than 60000
SELECT Employee_ID, First_Name, Last_Name, Salary 
FROM Employees 
WHERE Salary > 60000;

-- 4. Select distinct positions in the bank
SELECT DISTINCT Position 
FROM Employees;

-- 5. Select employees who joined after 2018
SELECT Employee_ID, First_Name, Last_Name, DOJ 
FROM Employees 
WHERE DOJ > '2018-01-01';


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add a column for Department
ALTER TABLE Employees ADD COLUMN Department VARCHAR(50);

-- 2. Modify Contact_Number to be VARCHAR(15) instead of CHAR(10)
ALTER TABLE Employees MODIFY COLUMN Contact_Number VARCHAR(15);

-- 3. Add a column for Bonus
ALTER TABLE Employees ADD COLUMN Bonus DECIMAL(10,2);

-- 4. Drop the Bonus column
ALTER TABLE Employees DROP COLUMN Bonus;

-- 5. Change column name Salary to Monthly_Salary
ALTER TABLE Employees CHANGE COLUMN Salary Monthly_Salary DECIMAL(10,2);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Employees to Bank_Employees
RENAME TABLE Employees TO Bank_Employees;

-- 2. Rename table Bank_Employees back to Employees
RENAME TABLE Bank_Employees TO Employees;

-- 3. Rename table Employees to Employee_Records
RENAME TABLE Employees TO Employee_Records;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update Monthly_Salary of Employee_ID = 1
UPDATE Employee_Records 
SET Monthly_Salary = 99000.00 
WHERE Employee_ID = 1;

-- 2. Update Status of Employee_ID = 7 to 'Active'
UPDATE Employee_Records 
SET Status = 'Active' 
WHERE Employee_ID = 7;

-- 3. Update Department for all Cashiers to 'Operations'
UPDATE Employee_Records 
SET Department = 'Operations' 
WHERE Position = 'Cashier';

-- 4. Update Contact_Number of Employee_ID = 15
UPDATE Employee_Records 
SET Contact_Number = '9123456789' 
WHERE Employee_ID = 15;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete employee with Employee_ID = 20
DELETE FROM Employee_Records 
WHERE Employee_ID = 20;

-- 2. Delete all employees who are Resigned
DELETE FROM Employee_Records 
WHERE Status = 'Resigned';

-- 3. Delete employees with Monthly_Salary less than 35000
DELETE FROM Employee_Records 
WHERE Monthly_Salary < 35000;

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show employee names with 10% salary hike
SELECT Employee_ID, First_Name, Last_Name, Salary, Salary * 1.10 AS New_Salary
FROM Employees;

-- 2. Show all employees earning more than 90,000
SELECT First_Name, Last_Name, Salary
FROM Employees
WHERE Salary > 90000;

-- 3. Show all employees who are either 'Manager' OR earn less than 40,000
SELECT First_Name, Last_Name, Position, Salary
FROM Employees
WHERE Position = 'Manager' OR Salary < 40000;

-- 4. Show employees whose email ends with '@hdfcbank.com'
SELECT First_Name, Last_Name, Email
FROM Employees
WHERE Email LIKE '%@hdfcbank.com';

-- 5. Show employees with first names starting with 'S'
SELECT Employee_ID, First_Name, Last_Name
FROM Employees
WHERE First_Name LIKE 'S%';

-- 6. Show employees who are either 'Active' OR belong to Branch_ID 2
SELECT First_Name, Last_Name, Status, Branch_ID
FROM Employees
WHERE Status = 'Active' OR Branch_ID = 2;

-- 7. Show employees who joined between 2015 and 2018
SELECT First_Name, Last_Name, DOJ
FROM Employees
WHERE DOJ BETWEEN '2015-01-01' AND '2018-12-31';

-- 8. Classify salary levels as 'High' if >= 90k, else 'Standard'
SELECT First_Name, Last_Name, Salary,
       CASE WHEN Salary >= 90000 THEN 'High' ELSE 'Standard' END AS Salary_Level
FROM Employees;

-- 9. Show employee names in uppercase
SELECT UPPER(First_Name) AS First_Upper, UPPER(Last_Name) AS Last_Upper
FROM Employees;

-- 10. Show last 4 digits of employees' contact numbers
SELECT Employee_ID, RIGHT(Contact_Number, 4) AS Last4Digits
FROM Employees;


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all employees working in Branch_ID = 1
SELECT First_Name, Last_Name, Branch_ID
FROM Employees
WHERE Branch_ID = 1;

-- 2. Show distinct positions in the bank
SELECT DISTINCT Position FROM Employees;

-- 3. Show employees ordered by Salary (descending)
SELECT First_Name, Last_Name, Position, Salary
FROM Employees
ORDER BY Salary DESC;

-- 4. Count employees by Position
SELECT Position, COUNT(*) AS Total_Employees
FROM Employees
GROUP BY Position;

-- 5. Show positions where average salary is more than 60,000
SELECT Position, AVG(Salary) AS Avg_Salary
FROM Employees
GROUP BY Position
HAVING AVG(Salary) > 60000;

-- 6. Show the 5 longest serving employees (oldest DOJ)
SELECT First_Name, Last_Name, DOJ
FROM Employees
ORDER BY DOJ ASC
LIMIT 5;

-- 7. Show full name (concatenated) of all employees
SELECT CONCAT(First_Name, ' ', Last_Name) AS Full_Name
FROM Employees;

-- 8. Show branch-wise total salary paid to employees
SELECT Branch_ID, SUM(Salary) AS Total_Salary
FROM Employees
GROUP BY Branch_ID;

-- 9. Show employees who are either Resigned or Retired
SELECT First_Name, Last_Name, Status
FROM Employees
WHERE Status IN ('Resigned', 'Retired');

-- 10. Show employees with alias 'Emp_Name' for full name
SELECT CONCAT(First_Name, ' ', Last_Name) AS Emp_Name, Position
FROM Employees;



-- Table-6 Loans
CREATE TABLE Loans (
  Loan_ID INT PRIMARY KEY AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  Loan_Type ENUM('Home', 'Personal', 'Car', 'Education', 'Business') NOT NULL,
  Amount DECIMAL(12,2) NOT NULL,
  Interest_Rate DECIMAL(5,2) NOT NULL,
  Duration_Years INT NOT NULL,
  Start_Date DATE NOT NULL,
  Status ENUM('Approved', 'Pending', 'Closed', 'Rejected') DEFAULT 'Pending',
  EMI_Amount DECIMAL(10,2),
  Branch_ID INT,
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
  FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
);


-- insert records into table-6
INSERT INTO Loans (Customer_ID, Loan_Type, Amount, Interest_Rate, Duration_Years, Start_Date, Status, EMI_Amount, Branch_ID) VALUES
(1, 'Home', 2500000.00, 8.25, 15, '2020-06-01', 'Approved', 24315.00, 1),
(2, 'Car', 800000.00, 9.00, 7, '2021-04-15', 'Approved', 13000.00, 2),
(3, 'Education', 600000.00, 10.50, 5, '2022-01-10', 'Pending', 10600.00, 3),
(4, 'Personal', 400000.00, 12.00, 4, '2019-11-05', 'Closed', 10500.00, 4),
(5, 'Business', 1500000.00, 9.75, 10, '2021-07-23', 'Approved', 19500.00, 5),
(6, 'Home', 3000000.00, 8.10, 20, '2020-03-12', 'Approved', 25100.00, 1),
(7, 'Car', 900000.00, 9.25, 6, '2023-02-20', 'Pending', 15700.00, 2),
(8, 'Education', 550000.00, 10.25, 5, '2020-09-30', 'Closed', 10250.00, 3),
(9, 'Personal', 300000.00, 11.50, 3, '2022-06-17', 'Approved', 9900.00, 4),
(10, 'Business', 2000000.00, 9.50, 12, '2018-12-10', 'Rejected', 22000.00, 5),
(11, 'Home', 2800000.00, 8.35, 15, '2019-08-01', 'Approved', 22500.00, 1),
(12, 'Car', 750000.00, 8.90, 5, '2021-03-19', 'Approved', 13400.00, 2),
(13, 'Education', 650000.00, 10.75, 6, '2022-05-25', 'Approved', 11200.00, 3),
(14, 'Personal', 450000.00, 12.25, 4, '2019-10-14', 'Closed', 10900.00, 4),
(15, 'Business', 1200000.00, 9.60, 8, '2020-07-08', 'Approved', 16700.00, 5),
(16, 'Home', 3200000.00, 8.05, 20, '2020-04-26', 'Approved', 26000.00, 1),
(17, 'Car', 820000.00, 9.15, 7, '2023-01-13', 'Pending', 14500.00, 2),
(18, 'Education', 580000.00, 10.45, 5, '2020-10-21', 'Approved', 10800.00, 3),
(19, 'Personal', 350000.00, 11.75, 3, '2021-08-30', 'Approved', 10100.00, 4),
(20, 'Business', 1800000.00, 9.45, 10, '2022-02-18', 'Approved', 21500.00, 5);


-- display table-6
select * from Loans;

truncate table Loans;

drop table Loans;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all loan details
SELECT * FROM Loans;

-- 2. Select only Approved loans
SELECT Loan_ID, Customer_ID, Loan_Type, Amount, EMI_Amount 
FROM Loans 
WHERE Status = 'Approved';

-- 3. Select loans with Amount greater than 2,000,000
SELECT Loan_ID, Loan_Type, Amount, Interest_Rate 
FROM Loans 
WHERE Amount > 2000000;

-- 4. Select distinct Loan Types
SELECT DISTINCT Loan_Type 
FROM Loans;

-- 5. Select loans started after 2021
SELECT Loan_ID, Customer_ID, Loan_Type, Start_Date 
FROM Loans 
WHERE Start_Date > '2021-01-01';


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add a column for Collateral
ALTER TABLE Loans ADD COLUMN Collateral VARCHAR(100);

-- 2. Modify EMI_Amount to support higher precision
ALTER TABLE Loans MODIFY COLUMN EMI_Amount DECIMAL(12,2);

-- 3. Add a column for Processing_Fee
ALTER TABLE Loans ADD COLUMN Processing_Fee DECIMAL(10,2);

-- 4. Drop the Processing_Fee column
ALTER TABLE Loans DROP COLUMN Processing_Fee;

-- 5. Change column Amount to Loan_Amount
ALTER TABLE Loans CHANGE COLUMN Amount Loan_Amount DECIMAL(12,2);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Loans to Bank_Loans
RENAME TABLE Loans TO Bank_Loans;

-- 2. Rename table Bank_Loans back to Loans
RENAME TABLE Bank_Loans TO Loans;

-- 3. Rename table Loans to Loan_Records
RENAME TABLE Loans TO Loan_Records;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update Loan_Amount of Loan_ID = 3
UPDATE Loan_Records 
SET Loan_Amount = 650000.00 
WHERE Loan_ID = 3;

-- 2. Update Status of Loan_ID = 7 to 'Approved'
UPDATE Loan_Records 
SET Status = 'Approved' 
WHERE Loan_ID = 7;

-- 3. Update Collateral for all Home loans to 'House Property'
UPDATE Loan_Records 
SET Collateral = 'House Property' 
WHERE Loan_Type = 'Home';

-- 4. Update Interest_Rate of Loan_ID = 15
UPDATE Loan_Records 
SET Interest_Rate = 10.25 
WHERE Loan_ID = 15;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete loan with Loan_ID = 10
DELETE FROM Loan_Records 
WHERE Loan_ID = 10;

-- 2. Delete all Rejected loans
DELETE FROM Loan_Records 
WHERE Status = 'Rejected';

-- 3. Delete all loans with Loan_Amount less than 400000
DELETE FROM Loan_Records 
WHERE Loan_Amount < 400000;

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show Loan_ID, Amount, and EMI with 5% increase in EMI
SELECT Loan_ID, Amount, EMI_Amount, EMI_Amount * 1.05 AS New_EMI
FROM Loans;

-- 2. Show all loans with Amount greater than 20,00,000
SELECT Loan_ID, Loan_Type, Amount
FROM Loans
WHERE Amount > 2000000;

-- 3. Show all loans that are either 'Home' OR have Duration_Years less than 5
SELECT Loan_ID, Loan_Type, Duration_Years
FROM Loans
WHERE Loan_Type = 'Home' OR Duration_Years < 5;

-- 4. Show loans with interest rate between 8% and 9%
SELECT Loan_ID, Loan_Type, Interest_Rate
FROM Loans
WHERE Interest_Rate BETWEEN 8.00 AND 9.00;

-- 5. Show loan types starting with 'P'
SELECT Loan_ID, Loan_Type
FROM Loans
WHERE Loan_Type LIKE 'P%';

-- 6. Show loans not having status 'Approved'
SELECT Loan_ID, Loan_Type, Status
FROM Loans
WHERE Status <> 'Approved';

-- 7. Categorize loans: 'High' if Amount > 20L, else 'Standard'
SELECT Loan_ID, Loan_Type, Amount,
       CASE WHEN Amount > 2000000 THEN 'High' ELSE 'Standard' END AS Loan_Category
FROM Loans;

-- 8. Show year of loan start
SELECT Loan_ID, Loan_Type, YEAR(Start_Date) AS Loan_Year
FROM Loans;

-- 9. Show only first 3 characters of Loan_Type
SELECT Loan_ID, LEFT(Loan_Type, 3) AS Short_Type
FROM Loans;

-- 10. Calculate total interest payable over full loan term
SELECT Loan_ID, Amount, Interest_Rate, Duration_Years,
       (Amount * Interest_Rate * Duration_Years / 100) AS Total_Interest
FROM Loans;


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all approved loans
SELECT Loan_ID, Loan_Type, Status
FROM Loans
WHERE Status = 'Approved';

-- 2. Show distinct loan types
SELECT DISTINCT Loan_Type FROM Loans;

-- 3. Show loans ordered by Amount descending
SELECT Loan_ID, Loan_Type, Amount
FROM Loans
ORDER BY Amount DESC;

-- 4. Count number of loans by Loan_Type
SELECT Loan_Type, COUNT(*) AS Total_Loans
FROM Loans
GROUP BY Loan_Type;

-- 5. Show loan types where average interest rate > 9%
SELECT Loan_Type, AVG(Interest_Rate) AS Avg_Rate
FROM Loans
GROUP BY Loan_Type
HAVING AVG(Interest_Rate) > 9;

-- 6. Show top 5 highest EMI loans
SELECT Loan_ID, Loan_Type, EMI_Amount
FROM Loans
ORDER BY EMI_Amount DESC
LIMIT 5;

-- 7. Show loans started after 2021
SELECT Loan_ID, Loan_Type, Start_Date
FROM Loans
WHERE Start_Date > '2021-12-31';

-- 8. Show branch-wise total loan amount
SELECT Branch_ID, SUM(Amount) AS Total_Loan_Amount
FROM Loans
GROUP BY Branch_ID;

-- 9. Show customers with more than one loan
SELECT Customer_ID, COUNT(*) AS Loan_Count
FROM Loans
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- 10. Show loans with alias 'Loan_Details' as concatenation of Loan_Type and Status
SELECT Loan_ID, CONCAT(Loan_Type, ' - ', Status) AS Loan_Details
FROM Loans;



-- Table-7 Cards
CREATE TABLE Cards (
  Card_ID INT PRIMARY KEY AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  Card_Type ENUM('Debit', 'Credit') NOT NULL,
  Card_Number CHAR(16) UNIQUE NOT NULL,
  CVV CHAR(3) NOT NULL,
  Expiry_Date DATE NOT NULL,
  Issue_Date DATE NOT NULL,
  Card_Limit DECIMAL(10,2),
  Status ENUM('Active', 'Blocked', 'Expired') DEFAULT 'Active',
  Branch_ID INT,
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
  FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
);


-- insert records into table-7
INSERT INTO Cards (Customer_ID, Card_Type, Card_Number, CVV, Expiry_Date, Issue_Date, Card_Limit, Status, Branch_ID) VALUES
(1, 'Credit', '4567123412345678', '123', '2027-05-31', '2022-05-10', 200000.00, 'Active', 1),
(2, 'Debit', '4213456789012345', '456', '2026-12-31', '2021-01-15', NULL, 'Active', 2),
(3, 'Credit', '4987654321123456', '789', '2025-08-31', '2020-08-25', 150000.00, 'Blocked', 3),
(4, 'Debit', '4567234567891234', '234', '2027-03-31', '2022-03-12', NULL, 'Active', 4),
(5, 'Credit', '4988123412345678', '567', '2026-09-30', '2021-09-19', 100000.00, 'Active', 5),
(6, 'Debit', '4556678912345678', '321', '2028-01-31', '2023-01-01', NULL, 'Active', 1),
(7, 'Credit', '4123456789345612', '654', '2024-06-30', '2019-06-10', 75000.00, 'Expired', 2),
(8, 'Debit', '4678901234567890', '432', '2027-10-31', '2022-10-05', NULL, 'Active', 3),
(9, 'Credit', '4987345612784561', '987', '2025-02-28', '2020-02-22', 125000.00, 'Blocked', 4),
(10, 'Debit', '4556567812341234', '543', '2026-07-31', '2021-07-14', NULL, 'Active', 5),
(11, 'Credit', '4534567812345670', '876', '2029-11-30', '2024-01-01', 300000.00, 'Active', 1),
(12, 'Debit', '4678123498765432', '321', '2028-05-31', '2023-05-23', NULL, 'Active', 2),
(13, 'Credit', '4567891234789012', '654', '2027-04-30', '2022-04-10', 200000.00, 'Active', 3),
(14, 'Debit', '4123789012340987', '789', '2026-03-31', '2021-03-01', NULL, 'Blocked', 4),
(15, 'Credit', '4987234509876543', '234', '2025-12-31', '2020-12-05', 175000.00, 'Active', 5),
(16, 'Debit', '4789012345123987', '432', '2029-06-30', '2024-06-17', NULL, 'Active', 1),
(17, 'Credit', '4567893456012345', '123', '2028-08-31', '2023-08-01', 250000.00, 'Active', 2),
(18, 'Debit', '4765432189012345', '567', '2027-01-31', '2022-01-10', NULL, 'Active', 3),
(19, 'Credit', '4567345612348765', '876', '2025-11-30', '2020-11-19', 110000.00, 'Blocked', 4),
(20, 'Debit', '4789123456789012', '987', '2028-04-30', '2023-04-25', NULL, 'Active', 5);


-- display table-7
select * from Cards;

truncate table Cards;

drop table Cards;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all card details
SELECT * FROM Cards;

-- 2. Select only Active cards
SELECT Card_ID, Customer_ID, Card_Type, Card_Number, Expiry_Date 
FROM Cards 
WHERE Status = 'Active';

-- 3. Select cards that are Credit with a limit greater than 150000
SELECT Card_ID, Customer_ID, Card_Number, Card_Limit 
FROM Cards 
WHERE Card_Type = 'Credit' AND Card_Limit > 150000;

-- 4. Select distinct Card Types issued
SELECT DISTINCT Card_Type 
FROM Cards;

-- 5. Select all cards expiring before 2026
SELECT Card_ID, Customer_ID, Card_Type, Expiry_Date 
FROM Cards 
WHERE Expiry_Date < '2026-01-01';


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add a column for Card_Network (e.g., Visa, MasterCard)
ALTER TABLE Cards ADD COLUMN Card_Network VARCHAR(50);

-- 2. Modify Card_Limit to allow higher values
ALTER TABLE Cards MODIFY COLUMN Card_Limit DECIMAL(12,2);

-- 3. Add a column for Annual_Fee
ALTER TABLE Cards ADD COLUMN Annual_Fee DECIMAL(10,2);

-- 4. Drop the Annual_Fee column
ALTER TABLE Cards DROP COLUMN Annual_Fee;

-- 5. Change column Card_Number to Account_Card_Number
ALTER TABLE Cards CHANGE COLUMN Card_Number Account_Card_Number CHAR(16);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Cards to Bank_Cards
RENAME TABLE Cards TO Bank_Cards;

-- 2. Rename table Bank_Cards back to Cards
RENAME TABLE Bank_Cards TO Cards;

-- 3. Rename table Cards to Card_Records
RENAME TABLE Cards TO Card_Records;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update Card_Limit of Card_ID = 3
UPDATE Card_Records 
SET Card_Limit = 160000.00 
WHERE Card_ID = 3;

-- 2. Update Status of Card_ID = 7 to 'Blocked'
UPDATE Card_Records 
SET Status = 'Blocked' 
WHERE Card_ID = 7;

-- 3. Update Card_Network of all Credit cards to 'Visa'
UPDATE Card_Records 
SET Card_Network = 'Visa' 
WHERE Card_Type = 'Credit';

-- 4. Update Expiry_Date of Card_ID = 14
UPDATE Card_Records 
SET Expiry_Date = '2028-12-31' 
WHERE Card_ID = 14;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete card with Card_ID = 9
DELETE FROM Card_Records 
WHERE Card_ID = 9;

-- 2. Delete all Expired cards
DELETE FROM Card_Records 
WHERE Status = 'Expired';

-- 3. Delete all cards with Card_Limit less than 100000
DELETE FROM Card_Records 
WHERE Card_Limit < 100000;

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show Card_ID, Card_Type, and last 4 digits of Card_Number
SELECT Card_ID, Card_Type, RIGHT(Card_Number, 4) AS Last4Digits
FROM Cards;

-- 2. Show Credit cards with limit above 1,50,000
SELECT Card_ID, Customer_ID, Card_Type, Card_Limit
FROM Cards
WHERE Card_Type = 'Credit' AND Card_Limit > 150000;

-- 3. Show Debit cards OR cards issued before 2021
SELECT Card_ID, Card_Type, Issue_Date
FROM Cards
WHERE Card_Type = 'Debit' OR Issue_Date < '2021-01-01';

-- 4. Show cards expiring between 2025 and 2027
SELECT Card_ID, Card_Type, Expiry_Date
FROM Cards
WHERE YEAR(Expiry_Date) BETWEEN 2025 AND 2027;

-- 5. Show all customers whose CVV starts with '1'
SELECT Card_ID, Customer_ID, CVV
FROM Cards
WHERE CVV LIKE '1%';

-- 6. Show cards not having status 'Active'
SELECT Card_ID, Card_Type, Status
FROM Cards
WHERE Status <> 'Active';

-- 7. Categorize cards: 'Premium' if limit > 2,00,000 else 'Standard'
SELECT Card_ID, Card_Type, Card_Limit,
       CASE WHEN Card_Limit > 200000 THEN 'Premium' ELSE 'Standard' END AS Card_Category
FROM Cards
WHERE Card_Type = 'Credit';

-- 8. Show year of card issue
SELECT Card_ID, YEAR(Issue_Date) AS Issue_Year
FROM Cards;

-- 9. Show first 6 digits of Card_Number (Bank Identifier)
SELECT Card_ID, LEFT(Card_Number, 6) AS BIN
FROM Cards;

-- 10. Increase card limit by 10% (only for Credit cards)
SELECT Card_ID, Card_Type, Card_Limit,
       (Card_Limit * 1.10) AS New_Limit
FROM Cards
WHERE Card_Type = 'Credit';


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all Active cards
SELECT Card_ID, Card_Type, Status
FROM Cards
WHERE Status = 'Active';

-- 2. Show distinct Card Types
SELECT DISTINCT Card_Type FROM Cards;

-- 3. Show all cards ordered by Expiry_Date ASC
SELECT Card_ID, Card_Type, Expiry_Date
FROM Cards
ORDER BY Expiry_Date ASC;

-- 4. Count number of cards by Card_Type
SELECT Card_Type, COUNT(*) AS Total_Cards
FROM Cards
GROUP BY Card_Type;

-- 5. Show only those card types where average limit > 1,80,000
SELECT Card_Type, AVG(Card_Limit) AS Avg_Limit
FROM Cards
WHERE Card_Type = 'Credit'
GROUP BY Card_Type
HAVING AVG(Card_Limit) > 180000;

-- 6. Show top 5 Credit cards with highest limits
SELECT Card_ID, Customer_ID, Card_Limit
FROM Cards
WHERE Card_Type = 'Credit'
ORDER BY Card_Limit DESC
LIMIT 5;

-- 7. Show all cards issued after 2022
SELECT Card_ID, Customer_ID, Issue_Date
FROM Cards
WHERE Issue_Date > '2022-12-31';

-- 8. Show branch-wise total Credit Card limits
SELECT Branch_ID, SUM(Card_Limit) AS Total_Credit_Limit
FROM Cards
WHERE Card_Type = 'Credit'
GROUP BY Branch_ID;

-- 9. Show customers who own more than one card
SELECT Customer_ID, COUNT(*) AS Card_Count
FROM Cards
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- 10. Show card details with alias 'Card_Info' (Card_Type + Status)
SELECT Card_ID, CONCAT(Card_Type, ' - ', Status) AS Card_Info
FROM Cards;



-- Table-8
CREATE TABLE ATMs (
  ATM_ID INT PRIMARY KEY AUTO_INCREMENT,
  Branch_ID INT NOT NULL,
  Location VARCHAR(100) NOT NULL,
  City VARCHAR(50) NOT NULL,
  State VARCHAR(50) NOT NULL,
  Pincode CHAR(6) NOT NULL,
  Type ENUM('On-site', 'Off-site') NOT NULL,
  Installed_Date DATE NOT NULL,
  Status ENUM('Operational', 'Out of Service', 'Under Maintenance') DEFAULT 'Operational',
  Cash_Available DECIMAL(12,2),
  FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
);


INSERT INTO ATMs (Branch_ID, Location, City, State, Pincode, Type, Installed_Date, Status, Cash_Available) VALUES
(1, 'HDFC Tower, Sion East', 'Mumbai', 'Maharashtra', '400022', 'On-site', '2017-01-12', 'Operational', 2500000.00),
(2, 'MG Road', 'Pune', 'Maharashtra', '411001', 'Off-site', '2018-05-23', 'Operational', 2000000.00),
(3, 'JP Nagar', 'Bangalore', 'Karnataka', '560078', 'On-site', '2019-08-15', 'Under Maintenance', 1500000.00),
(4, 'Banjara Hills', 'Hyderabad', 'Telangana', '500034', 'Off-site', '2020-03-10', 'Operational', 1800000.00),
(5, 'Salt Lake', 'Kolkata', 'West Bengal', '700091', 'On-site', '2016-11-29', 'Out of Service', 0.00),
(1, 'Phoenix Mall', 'Mumbai', 'Maharashtra', '400013', 'Off-site', '2021-02-17', 'Operational', 2300000.00),
(2, 'Koregaon Park', 'Pune', 'Maharashtra', '411001', 'On-site', '2018-12-10', 'Operational', 2100000.00),
(3, 'Electronic City', 'Bangalore', 'Karnataka', '560100', 'Off-site', '2017-09-05', 'Out of Service', 0.00),
(4, 'Charminar', 'Hyderabad', 'Telangana', '500002', 'On-site', '2022-04-01', 'Operational', 1700000.00),
(5, 'Park Street', 'Kolkata', 'West Bengal', '700016', 'Off-site', '2019-10-20', 'Under Maintenance', 500000.00),
(1, 'Dadar West', 'Mumbai', 'Maharashtra', '400028', 'On-site', '2020-01-30', 'Operational', 2600000.00),
(2, 'Shivaji Nagar', 'Pune', 'Maharashtra', '411005', 'Off-site', '2021-07-04', 'Operational', 1900000.00),
(3, 'Whitefield', 'Bangalore', 'Karnataka', '560066', 'On-site', '2016-06-22', 'Operational', 2200000.00),
(4, 'Secunderabad', 'Hyderabad', 'Telangana', '500003', 'Off-site', '2023-02-10', 'Operational', 2000000.00),
(5, 'Howrah', 'Kolkata', 'West Bengal', '711101', 'On-site', '2020-09-14', 'Out of Service', 0.00),
(1, 'Powai', 'Mumbai', 'Maharashtra', '400076', 'Off-site', '2022-07-01', 'Operational', 2300000.00),
(2, 'Viman Nagar', 'Pune', 'Maharashtra', '411014', 'On-site', '2019-11-11', 'Operational', 2100000.00),
(3, 'Marathahalli', 'Bangalore', 'Karnataka', '560037', 'Off-site', '2021-05-21', 'Operational', 2400000.00),
(4, 'HiTech City', 'Hyderabad', 'Telangana', '500081', 'On-site', '2018-08-08', 'Operational', 1800000.00),
(5, 'New Town', 'Kolkata', 'West Bengal', '700135', 'Off-site', '2023-03-15', 'Operational', 2500000.00);


-- display table-8
select * from ATMs;

truncate table ATMs;

drop table ATMs;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all ATM details
SELECT * FROM ATMs;

-- 2. Select only Operational ATMs
SELECT ATM_ID, Branch_ID, Location, City, Cash_Available 
FROM ATMs 
WHERE Status = 'Operational';

-- 3. Select ATMs in Mumbai city
SELECT ATM_ID, Location, Type, Cash_Available 
FROM ATMs 
WHERE City = 'Mumbai';

-- 4. Select ATMs with Cash_Available more than 2,000,000
SELECT ATM_ID, City, Location, Cash_Available 
FROM ATMs 
WHERE Cash_Available > 2000000;

-- 5. Select distinct ATM Types installed in the bank
SELECT DISTINCT Type 
FROM ATMs;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add a column for Machine_Model
ALTER TABLE ATMs ADD COLUMN Machine_Model VARCHAR(50);

-- 2. Modify Cash_Available to support higher amounts
ALTER TABLE ATMs MODIFY COLUMN Cash_Available DECIMAL(15,2);

-- 3. Add a column for Last_Service_Date
ALTER TABLE ATMs ADD COLUMN Last_Service_Date DATE;

-- 4. Drop the Last_Service_Date column
ALTER TABLE ATMs DROP COLUMN Last_Service_Date;

-- 5. Change column Location to ATM_Location
ALTER TABLE ATMs CHANGE COLUMN Location ATM_Location VARCHAR(100);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table ATMs to Bank_ATMs
RENAME TABLE ATMs TO Bank_ATMs;

-- 2. Rename table Bank_ATMs back to ATMs
RENAME TABLE Bank_ATMs TO ATMs;

-- 3. Rename table ATMs to ATM_Records
RENAME TABLE ATMs TO ATM_Records;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update Cash_Available for ATM_ID = 3
UPDATE ATM_Records 
SET Cash_Available = 1800000.00 
WHERE ATM_ID = 3;

-- 2. Update Status of ATM_ID = 5 to 'Operational'
UPDATE ATM_Records 
SET Status = 'Operational' 
WHERE ATM_ID = 5;

-- 3. Update Machine_Model for all On-site ATMs to 'NCR-ModelX'
UPDATE ATM_Records 
SET Machine_Model = 'NCR-ModelX' 
WHERE Type = 'On-site';

-- 4. Update Installed_Date for ATM_ID = 10
UPDATE ATM_Records 
SET Installed_Date = '2021-01-01' 
WHERE ATM_ID = 10;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete ATM with ATM_ID = 8
DELETE FROM ATM_Records 
WHERE ATM_ID = 8;

-- 2. Delete all ATMs that are 'Out of Service'
DELETE FROM ATM_Records 
WHERE Status = 'Out of Service';

-- 3. Delete all ATMs with Cash_Available less than 500000
DELETE FROM ATM_Records 
WHERE Cash_Available < 500000;

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show ATMs where Cash_Available > 2,000,000
SELECT ATM_ID, Location, City, Cash_Available
FROM ATMs
WHERE Cash_Available > 2000000;

-- 2. Show ATMs in Maharashtra OR Karnataka
SELECT ATM_ID, Location, State, City
FROM ATMs
WHERE State = 'Maharashtra' OR State = 'Karnataka';

-- 3. Show ATMs installed between 2018 and 2020
SELECT ATM_ID, Location, Installed_Date
FROM ATMs
WHERE YEAR(Installed_Date) BETWEEN 2018 AND 2020;

-- 4. Show ATMs where Pincode starts with '56'
SELECT ATM_ID, Location, Pincode, City
FROM ATMs
WHERE Pincode LIKE '56%';

-- 5. Show ATMs that are not Operational
SELECT ATM_ID, Location, Status
FROM ATMs
WHERE Status <> 'Operational';

-- 6. Add a column Category → 'High Cash' if Cash_Available >= 2,200,000 else 'Normal'
SELECT ATM_ID, Location, Cash_Available,
       CASE WHEN Cash_Available >= 2200000 THEN 'High Cash' ELSE 'Normal' END AS Category
FROM ATMs;

-- 7. Show ATMs where City IN ('Mumbai', 'Pune', 'Kolkata')
SELECT ATM_ID, Location, City, State
FROM ATMs
WHERE City IN ('Mumbai', 'Pune', 'Kolkata');

-- 8. Show ATMs installed before 2018 and still Operational
SELECT ATM_ID, Location, Installed_Date, Status
FROM ATMs
WHERE Installed_Date < '2018-01-01' AND Status = 'Operational';

-- 9. Show last 3 digits of Pincode for all ATMs
SELECT ATM_ID, Location, RIGHT(Pincode, 3) AS Last3Digits
FROM ATMs;

-- 10. Increase Cash_Available by 5% (display only)
SELECT ATM_ID, Location, Cash_Available,
       (Cash_Available * 1.05) AS New_Cash
FROM ATMs;


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all Operational ATMs
SELECT ATM_ID, Location, City, Status
FROM ATMs
WHERE Status = 'Operational';

-- 2. Show distinct States where ATMs exist
SELECT DISTINCT State FROM ATMs;

-- 3. Show all ATMs ordered by Installed_Date ASC
SELECT ATM_ID, Location, Installed_Date
FROM ATMs
ORDER BY Installed_Date ASC;

-- 4. Count number of ATMs by State
SELECT State, COUNT(*) AS Total_ATMs
FROM ATMs
GROUP BY State;

-- 5. Show average Cash_Available for On-site ATMs
SELECT Type, AVG(Cash_Available) AS Avg_Cash
FROM ATMs
WHERE Type = 'On-site'
GROUP BY Type;

-- 6. Show cities where ATMs have more than 2 million average cash
SELECT City, AVG(Cash_Available) AS Avg_Cash
FROM ATMs
GROUP BY City
HAVING AVG(Cash_Available) > 2000000;

-- 7. Show top 5 ATMs with highest cash
SELECT ATM_ID, Location, Cash_Available
FROM ATMs
ORDER BY Cash_Available DESC
LIMIT 5;

-- 8. Show Branch-wise total cash available
SELECT Branch_ID, SUM(Cash_Available) AS Total_Cash
FROM ATMs
GROUP BY Branch_ID;

-- 9. Show states with more than 4 ATMs
SELECT State, COUNT(*) AS ATM_Count
FROM ATMs
GROUP BY State
HAVING COUNT(*) > 4;

-- 10. Show ATMs with alias 'ATM_Info' (City + Location)
SELECT ATM_ID, CONCAT(City, ' - ', Location) AS ATM_Info
FROM ATMs;


-- Table-9
CREATE TABLE Cheques (
  Cheque_ID INT PRIMARY KEY AUTO_INCREMENT,
  Account_ID INT NOT NULL,
  Cheque_Number CHAR(10) UNIQUE NOT NULL,
  Issue_Date DATE,
  Payee_Name VARCHAR(100),
  Amount DECIMAL(12,2),
  Status ENUM('Cleared', 'Bounced', 'Pending'),
  IFSC_Code CHAR(11),
  Branch_ID INT,
  Remarks VARCHAR(255),
  FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID),
  FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
);


-- insert records into table-9
INSERT INTO Cheques (Account_ID, Cheque_Number, Issue_Date, Payee_Name, Amount, Status, IFSC_Code, Branch_ID, Remarks) VALUES
(1, 'CHQ000001', '2024-05-01', 'Reliance Digital', 20000.00, 'Cleared', 'HDFC0000001', 1, 'TV Purchase'),
(2, 'CHQ000002', '2024-05-03', 'Tata Motors', 750000.00, 'Pending', 'HDFC0000002', 2, 'Car Downpayment'),
(3, 'CHQ000003', '2024-05-05', 'LIC India', 15000.00, 'Cleared', 'HDFC0000003', 3, 'Policy Premium'),
(4, 'CHQ000004', '2024-05-06', 'BESCOM', 2000.00, 'Cleared', 'HDFC0000004', 4, 'Electricity Bill'),
(5, 'CHQ000005', '2024-05-07', 'Akash Tutorials', 45000.00, 'Bounced', 'HDFC0000005', 5, 'Tuition Fees'),
(6, 'CHQ000006', '2024-05-08', 'Flipkart', 12000.00, 'Cleared', 'HDFC0000001', 1, 'Online Order'),
(7, 'CHQ000007', '2024-05-09', 'Big Bazaar', 8000.00, 'Pending', 'HDFC0000002', 2, 'Groceries'),
(8, 'CHQ000008', '2024-05-10', 'HDFC Life', 35000.00, 'Cleared', 'HDFC0000003', 3, 'Insurance Payment'),
(9, 'CHQ000009', '2024-05-11', 'Toyota Showroom', 600000.00, 'Bounced', 'HDFC0000004', 4, 'Car Booking'),
(10, 'CHQ000010', '2024-05-12', 'Axis Bank', 25000.00, 'Cleared', 'HDFC0000005', 5, 'Loan Repayment'),
(11, 'CHQ000011', '2024-05-13', 'Amazon India', 9000.00, 'Cleared', 'HDFC0000001', 1, 'Electronics'),
(12, 'CHQ000012', '2024-05-14', 'Red Bus', 1500.00, 'Cleared', 'HDFC0000002', 2, 'Bus Booking'),
(13, 'CHQ000013', '2024-05-15', 'Swiggy', 700.00, 'Cleared', 'HDFC0000003', 3, 'Food Delivery'),
(14, 'CHQ000014', '2024-05-16', 'Max Hospital', 90000.00, 'Pending', 'HDFC0000004', 4, 'Medical Bill'),
(15, 'CHQ000015', '2024-05-17', 'TNEB', 1800.00, 'Cleared', 'HDFC0000005', 5, 'Utility Bill'),
(16, 'CHQ000016', '2024-05-18', 'IRCTC', 3200.00, 'Cleared', 'HDFC0000001', 1, 'Train Tickets'),
(17, 'CHQ000017', '2024-05-19', 'Cleartrip', 8500.00, 'Cleared', 'HDFC0000002', 2, 'Flight Booking'),
(18, 'CHQ000018', '2024-05-20', 'Vodafone Idea', 999.00, 'Cleared', 'HDFC0000003', 3, 'Postpaid Bill'),
(19, 'CHQ000019', '2024-05-21', 'Urban Clap', 2300.00, 'Pending', 'HDFC0000004', 4, 'Home Service'),
(20, 'CHQ000020', '2024-05-22', 'OYO Rooms', 3200.00, 'Cleared', 'HDFC0000005', 5, 'Hotel Booking');


-- display table-9
select * from Cheques;

truncate table Cheques;

drop table Cheques;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all cheque details
SELECT * FROM Cheques;

-- 2. Select all cleared cheques with amount more than 10,000
SELECT Cheque_ID, Cheque_Number, Payee_Name, Amount, Status 
FROM Cheques 
WHERE Status = 'Cleared' AND Amount > 10000;

-- 3. Select all bounced cheques with remarks
SELECT Cheque_ID, Payee_Name, Amount, Remarks 
FROM Cheques 
WHERE Status = 'Bounced';

-- 4. Select cheques issued from Branch_ID = 2
SELECT Cheque_ID, Cheque_Number, Payee_Name, Amount, Status 
FROM Cheques 
WHERE Branch_ID = 2;

-- 5. Select distinct payees across all cheques
SELECT DISTINCT Payee_Name 
FROM Cheques;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add a column for Cheque_Type (Bearer/Order)
ALTER TABLE Cheques ADD COLUMN Cheque_Type ENUM('Bearer', 'Order') DEFAULT 'Bearer';

-- 2. Modify Amount column to hold higher precision
ALTER TABLE Cheques MODIFY COLUMN Amount DECIMAL(15,2);

-- 3. Add a column for Clearing_Date
ALTER TABLE Cheques ADD COLUMN Clearing_Date DATE;

-- 4. Drop the Clearing_Date column
ALTER TABLE Cheques DROP COLUMN Clearing_Date;

-- 5. Change Remarks column to Cheque_Remarks
ALTER TABLE Cheques CHANGE COLUMN Remarks Cheque_Remarks VARCHAR(255);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Cheques to Bank_Cheques
RENAME TABLE Cheques TO Bank_Cheques;

-- 2. Rename table Bank_Cheques back to Cheques
RENAME TABLE Bank_Cheques TO Cheques;

-- 3. Rename table Cheques to Cheque_Records
RENAME TABLE Cheques TO Cheque_Records;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update Status of cheque CHQ000002 to 'Cleared'
UPDATE Cheque_Records 
SET Status = 'Cleared' 
WHERE Cheque_Number = 'CHQ000002';

-- 2. Update Remarks for cheque CHQ000009
UPDATE Cheque_Records 
SET Cheque_Remarks = 'Cheque returned due to insufficient balance' 
WHERE Cheque_Number = 'CHQ000009';

-- 3. Update Payee_Name for cheque CHQ000007
UPDATE Cheque_Records 
SET Payee_Name = 'Big Bazaar India Pvt Ltd' 
WHERE Cheque_Number = 'CHQ000007';

-- 4. Update Amount for cheque CHQ000014
UPDATE Cheque_Records 
SET Amount = 95000.00 
WHERE Cheque_Number = 'CHQ000014';


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete cheque with Cheque_ID = 20
DELETE FROM Cheque_Records 
WHERE Cheque_ID = 20;

-- 2. Delete all bounced cheques
DELETE FROM Cheque_Records 
WHERE Status = 'Bounced';

-- 3. Delete all cheques issued before '2024-05-05'
DELETE FROM Cheque_Records 
WHERE Issue_Date < '2024-05-05';

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all cheques where Amount > 50,000
SELECT Cheque_ID, Payee_Name, Amount
FROM Cheques
WHERE Amount > 50000;

-- 2. Show all cheques issued between 2024-05-05 and 2024-05-15
SELECT Cheque_ID, Cheque_Number, Issue_Date, Payee_Name
FROM Cheques
WHERE Issue_Date BETWEEN '2024-05-05' AND '2024-05-15';

-- 3. Show all cheques where Payee_Name starts with 'A'
SELECT Cheque_ID, Payee_Name, Amount
FROM Cheques
WHERE Payee_Name LIKE 'A%';

-- 4. Show all cheques that are not Cleared
SELECT Cheque_ID, Payee_Name, Status
FROM Cheques
WHERE Status <> 'Cleared';

-- 5. Show all cheques where Payee_Name IN ('Flipkart', 'Amazon India', 'Swiggy')
SELECT Cheque_ID, Payee_Name, Amount
FROM Cheques
WHERE Payee_Name IN ('Flipkart', 'Amazon India', 'Swiggy');

-- 6. Show all cheques with Amount < 2000 OR Amount > 100000
SELECT Cheque_ID, Payee_Name, Amount
FROM Cheques
WHERE Amount < 2000 OR Amount > 100000;

-- 7. Show all cheques where Remarks contain 'Car'
SELECT Cheque_ID, Payee_Name, Remarks, Amount
FROM Cheques
WHERE Remarks LIKE '%Car%';

-- 8. Add column Category: 'High Value' if Amount >= 100000 else 'Normal'
SELECT Cheque_ID, Payee_Name, Amount,
       CASE WHEN Amount >= 100000 THEN 'High Value' ELSE 'Normal' END AS Category
FROM Cheques;

-- 9. Show all cheques where IFSC_Code ends with '3'
SELECT Cheque_ID, Payee_Name, IFSC_Code
FROM Cheques
WHERE IFSC_Code LIKE '%3';

-- 10. Increase Amount by 10% (display only)
SELECT Cheque_ID, Payee_Name, Amount, (Amount * 1.1) AS New_Amount
FROM Cheques;


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all Cleared cheques
SELECT Cheque_ID, Payee_Name, Amount, Status
FROM Cheques
WHERE Status = 'Cleared';

-- 2. Show distinct Payee_Names
SELECT DISTINCT Payee_Name
FROM Cheques;

-- 3. Show all cheques ordered by Amount DESC
SELECT Cheque_ID, Payee_Name, Amount
FROM Cheques
ORDER BY Amount DESC;

-- 4. Count number of cheques by Status
SELECT Status, COUNT(*) AS Total_Cheques
FROM Cheques
GROUP BY Status;

-- 5. Show total cheque amount per Branch_ID
SELECT Branch_ID, SUM(Amount) AS Total_Amount
FROM Cheques
GROUP BY Branch_ID;

-- 6. Show average cheque amount for each Status
SELECT Status, AVG(Amount) AS Avg_Amount
FROM Cheques
GROUP BY Status;

-- 7. Show Payees having total cheque amount > 100,000
SELECT Payee_Name, SUM(Amount) AS Total_Amount
FROM Cheques
GROUP BY Payee_Name
HAVING SUM(Amount) > 100000;

-- 8. Show top 5 highest cheque payments
SELECT Cheque_ID, Payee_Name, Amount
FROM Cheques
ORDER BY Amount DESC
LIMIT 5;

-- 9. Show Branch-wise count of cheques
SELECT Branch_ID, COUNT(*) AS Cheque_Count
FROM Cheques
GROUP BY Branch_ID;

-- 10. Show cheque info with alias 'Cheque_Info' (Cheque_Number + Payee_Name)
SELECT Cheque_ID, CONCAT(Cheque_Number, ' - ', Payee_Name) AS Cheque_Info
FROM Cheques;



-- Table-10
CREATE TABLE Fixed_Deposits (
  FD_ID INT PRIMARY KEY AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  Branch_ID INT NOT NULL,
  Deposit_Amount DECIMAL(12,2),
  Interest_Rate DECIMAL(4,2),
  Start_Date DATE,
  Maturity_Date DATE,
  Duration_Months INT,
  Status ENUM('Active', 'Matured', 'Closed'),
  Nominee_Name VARCHAR(100),
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
  FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
);


-- insert records into table-10
INSERT INTO Fixed_Deposits (Customer_ID, Branch_ID, Deposit_Amount, Interest_Rate, Start_Date, Maturity_Date, Duration_Months, Status, Nominee_Name) VALUES
(1, 1, 200000.00, 6.50, '2023-01-01', '2024-01-01', 12, 'Matured', 'Rita Sharma'),
(2, 2, 500000.00, 6.80, '2023-06-01', '2026-06-01', 36, 'Active', 'Nikhil Mehta'),
(3, 3, 100000.00, 6.40, '2022-04-01', '2023-04-01', 12, 'Closed', 'Anjali Kumar'),
(4, 4, 250000.00, 6.75, '2022-10-01', '2024-10-01', 24, 'Active', 'Priya Singh'),
(5, 5, 300000.00, 6.90, '2023-07-01', '2026-07-01', 36, 'Active', 'Rajesh Verma'),
(6, 1, 150000.00, 6.60, '2022-08-01', '2023-08-01', 12, 'Matured', 'Vikas Rao'),
(7, 2, 600000.00, 6.85, '2023-03-01', '2024-03-01', 12, 'Active', 'Meena Nair'),
(8, 3, 400000.00, 6.70, '2021-09-01', '2022-09-01', 12, 'Closed', 'Sanjay Das'),
(9, 4, 1000000.00, 7.00, '2022-01-01', '2025-01-01', 36, 'Active', 'Lakshmi Pillai'),
(10, 5, 120000.00, 6.30, '2023-11-01', '2024-11-01', 12, 'Active', 'Pooja Kale'),
(11, 1, 800000.00, 7.10, '2023-05-01', '2025-05-01', 24, 'Active', 'Saurabh Iyer'),
(12, 2, 450000.00, 6.65, '2023-06-01', '2024-06-01', 12, 'Active', 'Shruti Mohan'),
(13, 3, 180000.00, 6.20, '2021-07-01', '2022-07-01', 12, 'Closed', 'Arjun Menon'),
(14, 4, 230000.00, 6.80, '2023-02-01', '2024-02-01', 12, 'Active', 'Rashmi Gaikwad'),
(15, 5, 150000.00, 6.55, '2022-10-01', '2023-10-01', 12, 'Matured', 'Sudeep Jadhav'),
(16, 1, 300000.00, 6.70, '2023-09-01', '2024-09-01', 12, 'Active', 'Namrata Roy'),
(17, 2, 250000.00, 6.85, '2023-12-01', '2024-12-01', 12, 'Active', 'Deepa Patil'),
(18, 3, 320000.00, 6.90, '2022-03-01', '2023-03-01', 12, 'Closed', 'Bhavna Kapoor'),
(19, 4, 270000.00, 6.75, '2023-04-01', '2024-04-01', 12, 'Active', 'Nilesh Sinha'),
(20, 5, 900000.00, 7.20, '2023-08-01', '2025-08-01', 24, 'Active', 'Harsha Malhotra');


-- display table-10
select * from Fixed_Deposits;

truncate table Fixed_Deposits;

drop table Fixed_Deposits;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all Fixed Deposits
SELECT * FROM Fixed_Deposits;

-- 2. Select all Active deposits with amount more than 5,00,000
SELECT FD_ID, Customer_ID, Deposit_Amount, Interest_Rate, Status 
FROM Fixed_Deposits 
WHERE Status = 'Active' AND Deposit_Amount > 500000;

-- 3. Select Matured deposits and their nominees
SELECT FD_ID, Deposit_Amount, Maturity_Date, Nominee_Name 
FROM Fixed_Deposits 
WHERE Status = 'Matured';

-- 4. Select deposits from Branch_ID = 3
SELECT FD_ID, Customer_ID, Deposit_Amount, Status 
FROM Fixed_Deposits 
WHERE Branch_ID = 3;

-- 5. Select distinct Nominee names
SELECT DISTINCT Nominee_Name 
FROM Fixed_Deposits;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add a column for FD_Type (Regular/Tax-Saver)
ALTER TABLE Fixed_Deposits ADD COLUMN FD_Type ENUM('Regular', 'Tax-Saver') DEFAULT 'Regular';

-- 2. Modify Interest_Rate precision
ALTER TABLE Fixed_Deposits MODIFY COLUMN Interest_Rate DECIMAL(5,3);

-- 3. Add a column for Compounding_Frequency
ALTER TABLE Fixed_Deposits ADD COLUMN Compounding_Frequency ENUM('Monthly', 'Quarterly', 'Half-Yearly', 'Yearly') DEFAULT 'Quarterly';

-- 4. Drop the Compounding_Frequency column
ALTER TABLE Fixed_Deposits DROP COLUMN Compounding_Frequency;

-- 5. Change Nominee_Name column to Nominee_Details
ALTER TABLE Fixed_Deposits CHANGE COLUMN Nominee_Name Nominee_Details VARCHAR(100);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Fixed_Deposits to FD_Accounts
RENAME TABLE Fixed_Deposits TO FD_Accounts;

-- 2. Rename table FD_Accounts back to Fixed_Deposits
RENAME TABLE FD_Accounts TO Fixed_Deposits;

-- 3. Rename table Fixed_Deposits to Deposit_Records
RENAME TABLE Fixed_Deposits TO Deposit_Records;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update Status of FD_ID = 2 to 'Matured'
UPDATE Deposit_Records 
SET Status = 'Matured' 
WHERE FD_ID = 2;

-- 2. Update Interest Rate of FD_ID = 9 to 7.25
UPDATE Deposit_Records 
SET Interest_Rate = 7.25 
WHERE FD_ID = 9;

-- 3. Update Nominee for FD_ID = 5
UPDATE Deposit_Records 
SET Nominee_Details = 'Anita Verma' 
WHERE FD_ID = 5;

-- 4. Update Deposit Amount for FD_ID = 17
UPDATE Deposit_Records 
SET Deposit_Amount = 275000.00 
WHERE FD_ID = 17;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete FD with FD_ID = 3
DELETE FROM Deposit_Records 
WHERE FD_ID = 3;

-- 2. Delete all Closed deposits
DELETE FROM Deposit_Records 
WHERE Status = 'Closed';

-- 3. Delete all deposits that matured before '2023-01-01'
DELETE FROM Deposit_Records 
WHERE Maturity_Date < '2023-01-01';

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all deposits greater than ₹5,00,000
SELECT FD_ID, Customer_ID, Deposit_Amount
FROM Fixed_Deposits
WHERE Deposit_Amount > 500000;

-- 2. Show all deposits with interest rate between 6.5% and 7%
SELECT FD_ID, Deposit_Amount, Interest_Rate
FROM Fixed_Deposits
WHERE Interest_Rate BETWEEN 6.50 AND 7.00;

-- 3. Show all deposits with Status not equal to 'Active'
SELECT FD_ID, Deposit_Amount, Status
FROM Fixed_Deposits
WHERE Status <> 'Active';

-- 4. Show deposits where nominee name starts with 'R'
SELECT FD_ID, Nominee_Name, Deposit_Amount
FROM Fixed_Deposits
WHERE Nominee_Name LIKE 'R%';

-- 5. Show deposits where Status IN ('Matured', 'Closed')
SELECT FD_ID, Customer_ID, Status, Deposit_Amount
FROM Fixed_Deposits
WHERE Status IN ('Matured', 'Closed');

-- 6. Show deposits where Duration is 12 months AND Deposit_Amount > 2,00,000
SELECT FD_ID, Deposit_Amount, Duration_Months
FROM Fixed_Deposits
WHERE Duration_Months = 12 AND Deposit_Amount > 200000;

-- 7. Show deposits where Maturity_Date < '2024-01-01'
SELECT FD_ID, Deposit_Amount, Maturity_Date
FROM Fixed_Deposits
WHERE Maturity_Date < '2024-01-01';

-- 8. Calculate maturity value = Deposit_Amount + (Deposit_Amount * Interest_Rate * Duration_Months / 1200)
SELECT FD_ID, Deposit_Amount, Interest_Rate, Duration_Months,
       (Deposit_Amount + (Deposit_Amount * Interest_Rate * Duration_Months / 1200)) AS Maturity_Value
FROM Fixed_Deposits;

-- 9. Show all deposits with Deposit_Amount < 2,00,000 OR Status = 'Closed'
SELECT FD_ID, Deposit_Amount, Status
FROM Fixed_Deposits
WHERE Deposit_Amount < 200000 OR Status = 'Closed';

-- 10. Show nominee names that end with 'a'
SELECT FD_ID, Nominee_Name
FROM Fixed_Deposits
WHERE Nominee_Name LIKE '%a';


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all Active deposits
SELECT FD_ID, Deposit_Amount, Status
FROM Fixed_Deposits
WHERE Status = 'Active';

-- 2. Show distinct interest rates available
SELECT DISTINCT Interest_Rate
FROM Fixed_Deposits;

-- 3. Show deposits ordered by Deposit_Amount descending
SELECT FD_ID, Deposit_Amount, Status
FROM Fixed_Deposits
ORDER BY Deposit_Amount DESC;

-- 4. Count how many deposits are in each Status
SELECT Status, COUNT(*) AS Total_Count
FROM Fixed_Deposits
GROUP BY Status;

-- 5. Show total deposit amount per Branch_ID
SELECT Branch_ID, SUM(Deposit_Amount) AS Total_Deposit
FROM Fixed_Deposits
GROUP BY Branch_ID;

-- 6. Show average Deposit_Amount for each Status
SELECT Status, AVG(Deposit_Amount) AS Avg_Deposit
FROM Fixed_Deposits
GROUP BY Status;

-- 7. Show Branches where total deposit amount > 10,00,000
SELECT Branch_ID, SUM(Deposit_Amount) AS Total_Deposit
FROM Fixed_Deposits
GROUP BY Branch_ID
HAVING SUM(Deposit_Amount) > 1000000;

-- 8. Show top 5 largest fixed deposits
SELECT FD_ID, Deposit_Amount, Customer_ID
FROM Fixed_Deposits
ORDER BY Deposit_Amount DESC
LIMIT 5;

-- 9. Show count of FDs per Customer
SELECT Customer_ID, COUNT(*) AS FD_Count
FROM Fixed_Deposits
GROUP BY Customer_ID;

-- 10. Show FD details with alias "FD_Info" (Customer_ID + Deposit_Amount)
SELECT FD_ID, CONCAT('Customer-', Customer_ID, ': ', Deposit_Amount) AS FD_Info
FROM Fixed_Deposits;


-- Table-11
CREATE TABLE Online_Banking (
  Login_ID INT PRIMARY KEY AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  Username VARCHAR(50) UNIQUE NOT NULL,
  Password_Hash VARCHAR(255) NOT NULL,
  Last_Login DATETIME,
  Login_Status ENUM('Active', 'Blocked'),
  Security_Question VARCHAR(100),
  Security_Answer_Hash VARCHAR(255),
  Registered_Device VARCHAR(100),
  IP_Address VARCHAR(45),
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- insert records into table-11
INSERT INTO Online_Banking 
(Customer_ID, Username, Password_Hash, Last_Login, Login_Status, Security_Question, Security_Answer_Hash, Registered_Device, IP_Address) 
VALUES
(1, 'rahul2025', 'hash_pass1', '2025-06-01 10:15:30', 'Active', 'What is your favorite Indian city?', 'hash_ans1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', '49.205.134.21'),
(2, 'meena123', 'hash_pass2', '2025-06-02 11:30:45', 'Active', 'What was your first school?', 'hash_ans2', 'Mozilla/5.0 (Linux; Android 11)', '117.203.20.11'),
(3, 'arjun_k', 'hash_pass3', '2025-06-03 08:20:10', 'Blocked', 'What is your pet’s name?', 'hash_ans3', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)', '103.25.124.8'),
(4, 'priya_n', 'hash_pass4', '2025-06-04 14:10:50', 'Active', 'What is your mother’s maiden name?', 'hash_ans4', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64)', '182.72.48.10'),
(5, 'sachinmumbai', 'hash_pass5', '2025-06-05 09:05:25', 'Blocked', 'What is your favorite Indian city?', 'hash_ans5', 'Mozilla/5.0 (Linux; Android 10)', '106.51.24.199'),
(6, 'kavita_1997', 'hash_pass6', '2025-06-06 16:40:35', 'Active', 'What was your first school?', 'hash_ans6', 'Mozilla/5.0 (Windows NT 10.0)', '115.113.199.30'),
(7, 'vijay_chennai', 'hash_pass7', '2025-06-07 12:55:12', 'Blocked', 'What is your pet’s name?', 'hash_ans7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X)', '122.180.105.44'),
(8, 'anita_b', 'hash_pass8', '2025-06-08 07:20:45', 'Active', 'What is your favorite Indian city?', 'hash_ans8', 'Mozilla/5.0 (Linux; Android 9)', '27.7.148.12'),
(9, 'ravi1988', 'hash_pass9', '2025-06-09 13:10:18', 'Active', 'What is your mother’s maiden name?', 'hash_ans9', 'Mozilla/5.0 (Windows NT 6.3)', '49.15.34.57'),
(10, 'neha_patil', 'hash_pass10', '2025-06-10 15:30:00', 'Blocked', 'What is your pet’s name?', 'hash_ans10', 'Mozilla/5.0 (Windows NT 6.1)', '117.199.68.203'),
(11, 'rohan_singh', 'hash_pass11', '2025-06-11 10:45:29', 'Active', 'What was your first school?', 'hash_ans11', 'Mozilla/5.0 (Linux; Android 8.1)', '182.75.103.115'),
(12, 'sneha_r', 'hash_pass12', '2025-06-12 11:15:49', 'Blocked', 'What is your favorite Indian city?', 'hash_ans12', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_5)', '103.46.233.2'),
(13, 'deepak_verma', 'hash_pass13', '2025-06-13 08:35:15', 'Active', 'What is your mother’s maiden name?', 'hash_ans13', 'Mozilla/5.0 (Windows NT 10.0)', '49.207.180.6'),
(14, 'poonamsharma', 'hash_pass14', '2025-06-14 12:25:36', 'Blocked', 'What is your pet’s name?', 'hash_ans14', 'Mozilla/5.0 (Linux; Android 10)', '117.212.71.9'),
(15, 'amitgupta99', 'hash_pass15', '2025-06-15 09:50:20', 'Active', 'What was your first school?', 'hash_ans15', 'Mozilla/5.0 (Macintosh; Intel Mac OS X)', '112.196.11.77'),
(16, 'divya_j', 'hash_pass16', '2025-06-16 07:10:50', 'Blocked', 'What is your favorite Indian city?', 'hash_ans16', 'Mozilla/5.0 (Windows NT 6.1)', '103.57.83.13'),
(17, 'manoj_kumar', 'hash_pass17', '2025-06-17 11:20:32', 'Active', 'What is your pet’s name?', 'hash_ans17', 'Mozilla/5.0 (Android 11; Mobile)', '49.248.198.122'),
(18, 'reshma_d', 'hash_pass18', '2025-06-18 08:40:55', 'Active', 'What was your first school?', 'hash_ans18', 'Mozilla/5.0 (Windows NT 10.0)', '122.163.190.16'),
(19, 'aniljain', 'hash_pass19', '2025-06-19 13:05:20', 'Blocked', 'What is your favorite Indian city?', 'hash_ans19', 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4)', '59.96.128.7'),
(20, 'preeti_bansal', 'hash_pass20', '2025-06-20 14:55:44', 'Active', 'What is your mother’s maiden name?', 'hash_ans20', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64)', '106.195.44.10');


-- display table-11
select * from Online_Banking;

truncate table Online_Banking;

drop table Online_Banking;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all online banking users
SELECT * FROM Online_Banking;

-- 2. Select Active users with their last login details
SELECT Login_ID, Username, Last_Login, IP_Address 
FROM Online_Banking 
WHERE Login_Status = 'Active';

-- 3. Select all Blocked users
SELECT Login_ID, Username, Security_Question, Registered_Device 
FROM Online_Banking 
WHERE Login_Status = 'Blocked';

-- 4. Find users who logged in after 15th June 2025
SELECT Username, Last_Login, IP_Address 
FROM Online_Banking 
WHERE Last_Login > '2025-06-15';

-- 5. Count how many users use Windows devices
SELECT COUNT(*) AS Windows_Users 
FROM Online_Banking 
WHERE Registered_Device LIKE '%Windows%';


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column for Two_Factor_Enabled
ALTER TABLE Online_Banking ADD COLUMN Two_Factor_Enabled BOOLEAN DEFAULT FALSE;

-- 2. Increase Username length
ALTER TABLE Online_Banking MODIFY COLUMN Username VARCHAR(100);

-- 3. Add column for Failed_Login_Attempts
ALTER TABLE Online_Banking ADD COLUMN Failed_Login_Attempts INT DEFAULT 0;

-- 4. Drop column Failed_Login_Attempts
ALTER TABLE Online_Banking DROP COLUMN Failed_Login_Attempts;

-- 5. Change column Registered_Device to Device_Info
ALTER TABLE Online_Banking CHANGE COLUMN Registered_Device Device_Info VARCHAR(150);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Online_Banking to NetBanking
RENAME TABLE Online_Banking TO NetBanking;

-- 2. Rename NetBanking back to Online_Banking
RENAME TABLE NetBanking TO Online_Banking;

-- 3. Rename Online_Banking to Digital_Banking
RENAME TABLE Online_Banking TO Digital_Banking;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update Login_Status to 'Blocked' for Login_ID = 2
UPDATE Digital_Banking 
SET Login_Status = 'Blocked' 
WHERE Login_ID = 2;

-- 2. Update last login timestamp for Login_ID = 8
UPDATE Digital_Banking 
SET Last_Login = '2025-06-21 09:00:00' 
WHERE Login_ID = 8;

-- 3. Update IP Address for Login_ID = 12
UPDATE Digital_Banking 
SET IP_Address = '103.120.45.99' 
WHERE Login_ID = 12;

-- 4. Update Username for Login_ID = 15
UPDATE Digital_Banking 
SET Username = 'amit_gupta2025' 
WHERE Login_ID = 15;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete record with Login_ID = 5
DELETE FROM Digital_Banking 
WHERE Login_ID = 5;

-- 2. Delete all Blocked users
DELETE FROM Digital_Banking 
WHERE Login_Status = 'Blocked';

-- 3. Delete users who never logged in (Last_Login IS NULL)
DELETE FROM Digital_Banking 
WHERE Last_Login IS NULL;

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all users with Login_Status not equal to 'Active'
SELECT Login_ID, Username, Login_Status
FROM Online_Banking
WHERE Login_Status <> 'Active';

-- 2. Show all users whose username starts with 'a'
SELECT Login_ID, Username
FROM Online_Banking
WHERE Username LIKE 'a%';

-- 3. Show all users whose username ends with '_n'
SELECT Login_ID, Username
FROM Online_Banking
WHERE Username LIKE '%_n';

-- 4. Show users who logged in after '2025-06-10'
SELECT Username, Last_Login
FROM Online_Banking
WHERE Last_Login > '2025-06-10';

-- 5. Show all users with IP address starting with '49.'
SELECT Username, IP_Address
FROM Online_Banking
WHERE IP_Address LIKE '49.%';

-- 6. Show users whose Registered_Device contains 'Windows'
SELECT Username, Registered_Device
FROM Online_Banking
WHERE Registered_Device LIKE '%Windows%';

-- 7. Show users where Security_Question is 'What is your pet’s name?'
SELECT Username, Security_Question
FROM Online_Banking
WHERE Security_Question = 'What is your pet’s name?';

-- 8. Show all users with Login_ID between 5 and 10
SELECT Login_ID, Username
FROM Online_Banking
WHERE Login_ID BETWEEN 5 AND 10;

-- 9. Show users with Login_Status IN ('Active', 'Blocked')
SELECT Username, Login_Status
FROM Online_Banking
WHERE Login_Status IN ('Active', 'Blocked');

-- 10. Show users who logged in before '2025-06-05' OR have status 'Blocked'
SELECT Username, Last_Login, Login_Status
FROM Online_Banking
WHERE Last_Login < '2025-06-05' OR Login_Status = 'Blocked';


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all Active users
SELECT Username, Login_Status
FROM Online_Banking
WHERE Login_Status = 'Active';

-- 2. Show distinct Security Questions used
SELECT DISTINCT Security_Question
FROM Online_Banking;

-- 3. Show all users ordered by Last_Login descending
SELECT Username, Last_Login
FROM Online_Banking
ORDER BY Last_Login DESC;

-- 4. Count number of users in each Login_Status
SELECT Login_Status, COUNT(*) AS Total_Users
FROM Online_Banking
GROUP BY Login_Status;

-- 5. Count users by Security Question
SELECT Security_Question, COUNT(*) AS Users_Count
FROM Online_Banking
GROUP BY Security_Question;

-- 6. Show usernames grouped by Registered_Device containing 'Android'
SELECT Registered_Device, COUNT(*) AS Android_Users
FROM Online_Banking
WHERE Registered_Device LIKE '%Android%'
GROUP BY Registered_Device;

-- 7. Show devices used by more than 1 user
SELECT Registered_Device, COUNT(*) AS User_Count
FROM Online_Banking
GROUP BY Registered_Device
HAVING COUNT(*) > 1;

-- 8. Show top 5 recent logins
SELECT Username, Last_Login
FROM Online_Banking
ORDER BY Last_Login DESC
LIMIT 5;

-- 9. Show number of users with each IP prefix (first 2 digits)
SELECT SUBSTRING_INDEX(IP_Address, '.', 2) AS IP_Prefix, COUNT(*) AS Users_Count
FROM Online_Banking
GROUP BY SUBSTRING_INDEX(IP_Address, '.', 2);

-- 10. Show Login_ID, Username with alias "User_Info" (Username + IP_Address)
SELECT Login_ID, CONCAT(Username, ' - ', IP_Address) AS User_Info
FROM Online_Banking;


-- Table-12
CREATE TABLE Beneficiaries (
  Beneficiary_ID INT PRIMARY KEY AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  Name VARCHAR(100) NOT NULL,
  Account_Number BIGINT NOT NULL,
  IFSC_Code CHAR(11) NOT NULL,
  Bank_Name VARCHAR(100),
  Added_Date DATE,
  Type ENUM('Internal', 'External'),
  Status ENUM('Active', 'Inactive'),
  Nickname VARCHAR(50),
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);


-- isnert records into table-12
INSERT INTO Beneficiaries 
(Customer_ID, Name, Account_Number, IFSC_Code, Bank_Name, Added_Date, Type, Status, Nickname)
VALUES
(1, 'Ramesh Patel', 5021101100123456, 'HDFC0001234', 'HDFC Bank', '2025-05-01', 'Internal', 'Active', 'Ramu'),
(1, 'Sneha Kapoor', 5021101100987654, 'ICIC0000456', 'ICICI Bank', '2025-05-02', 'External', 'Active', 'Sneha Aunty'),
(2, 'Vikram Sinha', 5021101100111122, 'SBIN0000678', 'State Bank of India', '2025-05-03', 'External', 'Inactive', 'Vikky'),
(3, 'Anita Sharma', 5021101100998877, 'AXIS0000345', 'Axis Bank', '2025-05-04', 'Internal', 'Active', 'Anu'),
(4, 'Karan Mehta', 5021101100776655, 'HDFC0000234', 'HDFC Bank', '2025-05-05', 'Internal', 'Active', 'Karan Bro'),
(5, 'Priya Nair', 5021101100112333, 'KKBK0000567', 'Kotak Mahindra Bank', '2025-05-06', 'External', 'Active', 'Pri'),
(6, 'Sunil Gupta', 5021101100554433, 'PNB0000123', 'Punjab National Bank', '2025-05-07', 'External', 'Inactive', 'Sunil Ji'),
(7, 'Meena Iyer', 5021101100887744, 'YESB0000789', 'YES Bank', '2025-05-08', 'Internal', 'Active', 'Meena Di'),
(8, 'Rajiv Bhatia', 5021101100667788, 'BOI0000990', 'Bank of India', '2025-05-09', 'External', 'Active', 'Rajiv Mama'),
(9, 'Divya Agarwal', 5021101100443322, 'HDFC0000789', 'HDFC Bank', '2025-05-10', 'Internal', 'Active', 'Divz'),
(10, 'Amitabh Joshi', 5021101100221133, 'IDFB0000444', 'IDFC FIRST Bank', '2025-05-11', 'External', 'Inactive', 'Amit Uncle'),
(11, 'Kavita Chauhan', 5021101100114488, 'SBIN0001020', 'State Bank of India', '2025-05-12', 'Internal', 'Active', 'Kavi'),
(12, 'Farhan Sheikh', 5021101100992211, 'ICIC0000789', 'ICICI Bank', '2025-05-13', 'External', 'Active', 'Far'),
(13, 'Nikhil Deshmukh', 5021101100321321, 'HDFC0000444', 'HDFC Bank', '2025-05-14', 'Internal', 'Active', 'Nik'),
(14, 'Surbhi Singh', 5021101100678990, 'UTIB0001234', 'Axis Bank', '2025-05-15', 'External', 'Inactive', 'Surbs'),
(15, 'Manoj Bajaj', 5021101100111642, 'UBIN0554433', 'Union Bank of India', '2025-05-16', 'External', 'Active', 'Mano'),
(16, 'Pooja Kaur', 5021101100881133, 'BARB0BANDRA', 'Bank of Baroda', '2025-05-17', 'Internal', 'Active', 'Poo'),
(17, 'Deepak Ghosh', 5021101100341290, 'CNRB0000420', 'Canara Bank', '2025-05-18', 'External', 'Inactive', 'Dipu'),
(18, 'Nisha Verma', 5021101100223321, 'HDFC0000222', 'HDFC Bank', '2025-05-19', 'Internal', 'Active', 'Nishu'),
(19, 'Aarav Joshi', 5021101100998876, 'SBIN0000764', 'State Bank of India', '2025-05-20', 'Internal', 'Active', 'AJ'),
(20, 'Ishita Das', 5021101100887765, 'ICIC0000112', 'ICICI Bank', '2025-05-21', 'External', 'Active', 'Ishu');



-- display table-12
select * from Beneficiaries;

truncate table Beneficiaries;

drop table Beneficiaries;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all beneficiaries
SELECT * FROM Beneficiaries;

-- 2. Select all active beneficiaries
SELECT Beneficiary_ID, Name, Account_Number, Bank_Name, Type 
FROM Beneficiaries 
WHERE Status = 'Active';

-- 3. Select all inactive beneficiaries with their nicknames
SELECT Beneficiary_ID, Name, Nickname, Bank_Name 
FROM Beneficiaries 
WHERE Status = 'Inactive';

-- 4. Select beneficiaries added after 10th May 2025
SELECT Name, Bank_Name, Added_Date 
FROM Beneficiaries 
WHERE Added_Date > '2025-05-10';

-- 5. Count beneficiaries per bank
SELECT Bank_Name, COUNT(*) AS Total_Beneficiaries
FROM Beneficiaries
GROUP BY Bank_Name;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column for Transfer_Limit
ALTER TABLE Beneficiaries ADD COLUMN Transfer_Limit DECIMAL(12,2) DEFAULT 50000.00;

-- 2. Modify Nickname length
ALTER TABLE Beneficiaries MODIFY COLUMN Nickname VARCHAR(100);

-- 3. Add column for Relationship (Friend/Family/Business)
ALTER TABLE Beneficiaries ADD COLUMN Relationship VARCHAR(50);

-- 4. Drop column Relationship
ALTER TABLE Beneficiaries DROP COLUMN Relationship;

-- 5. Change column Name to Beneficiary_Name
ALTER TABLE Beneficiaries CHANGE COLUMN Name Beneficiary_Name VARCHAR(100);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Beneficiaries to Customer_Beneficiaries
RENAME TABLE Beneficiaries TO Customer_Beneficiaries;

-- 2. Rename Customer_Beneficiaries back to Beneficiaries
RENAME TABLE Customer_Beneficiaries TO Beneficiaries;

-- 3. Rename Beneficiaries to Payees
RENAME TABLE Beneficiaries TO Payees;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update status of Beneficiary_ID = 3 to Active
UPDATE Payees 
SET Status = 'Active' 
WHERE Beneficiary_ID = 3;

-- 2. Update Nickname of Beneficiary_ID = 8
UPDATE Payees 
SET Nickname = 'Rajiv Uncle' 
WHERE Beneficiary_ID = 8;

-- 3. Update Bank_Name for Beneficiary_ID = 10
UPDATE Payees 
SET Bank_Name = 'IDFC Bank Limited' 
WHERE Beneficiary_ID = 10;

-- 4. Update IFSC_Code for Beneficiary_ID = 16
UPDATE Payees 
SET IFSC_Code = 'BARB0001234' 
WHERE Beneficiary_ID = 16;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete beneficiary with Beneficiary_ID = 20
DELETE FROM Payees 
WHERE Beneficiary_ID = 20;

-- 2. Delete all inactive beneficiaries
DELETE FROM Payees 
WHERE Status = 'Inactive';

-- 3. Delete beneficiaries from HDFC Bank
DELETE FROM Payees 
WHERE Bank_Name = 'HDFC Bank';

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show beneficiaries with Status not equal to 'Active'
SELECT Beneficiary_ID, Name, Status
FROM Beneficiaries
WHERE Status <> 'Active';

-- 2. Show beneficiaries whose Nickname starts with 'S'
SELECT Name, Nickname
FROM Beneficiaries
WHERE Nickname LIKE 'S%';

-- 3. Show beneficiaries added after '2025-05-10'
SELECT Name, Added_Date
FROM Beneficiaries
WHERE Added_Date > '2025-05-10';

-- 4. Show beneficiaries of HDFC Bank
SELECT Name, Bank_Name
FROM Beneficiaries
WHERE Bank_Name = 'HDFC Bank';

-- 5. Show beneficiaries where Type is either 'Internal' or 'External'
SELECT Name, Type
FROM Beneficiaries
WHERE Type IN ('Internal', 'External');

-- 6. Show beneficiaries with Account_Number greater than 5021101100500000
SELECT Name, Account_Number
FROM Beneficiaries
WHERE Account_Number > 5021101100500000;

-- 7. Show beneficiaries added between '2025-05-05' and '2025-05-15'
SELECT Name, Added_Date
FROM Beneficiaries
WHERE Added_Date BETWEEN '2025-05-05' AND '2025-05-15';

-- 8. Show beneficiaries whose Nickname contains 'u'
SELECT Name, Nickname
FROM Beneficiaries
WHERE Nickname LIKE '%u%';

-- 9. Show beneficiaries whose Bank_Name ends with 'Bank'
SELECT Name, Bank_Name
FROM Beneficiaries
WHERE Bank_Name LIKE '%Bank';

-- 10. Show beneficiaries who are 'Inactive' OR of Type 'Internal'
SELECT Name, Type, Status
FROM Beneficiaries
WHERE Status = 'Inactive' OR Type = 'Internal';


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all Active beneficiaries
SELECT Name, Status
FROM Beneficiaries
WHERE Status = 'Active';

-- 2. Show distinct bank names
SELECT DISTINCT Bank_Name
FROM Beneficiaries;

-- 3. Show all beneficiaries ordered by Added_Date ascending
SELECT Name, Added_Date
FROM Beneficiaries
ORDER BY Added_Date ASC;

-- 4. Count beneficiaries grouped by Type
SELECT Type, COUNT(*) AS Total_Beneficiaries
FROM Beneficiaries
GROUP BY Type;

-- 5. Count beneficiaries grouped by Status
SELECT Status, COUNT(*) AS Total_Beneficiaries
FROM Beneficiaries
GROUP BY Status;

-- 6. Count beneficiaries grouped by Bank_Name
SELECT Bank_Name, COUNT(*) AS Beneficiary_Count
FROM Beneficiaries
GROUP BY Bank_Name;

-- 7. Show banks having more than 2 beneficiaries
SELECT Bank_Name, COUNT(*) AS Total
FROM Beneficiaries
GROUP BY Bank_Name
HAVING COUNT(*) > 2;

-- 8. Show top 5 latest beneficiaries added
SELECT Name, Added_Date
FROM Beneficiaries
ORDER BY Added_Date DESC
LIMIT 5;

-- 9. Show number of beneficiaries added on each date
SELECT Added_Date, COUNT(*) AS Beneficiaries_Added
FROM Beneficiaries
GROUP BY Added_Date;

-- 10. Show Beneficiary_ID and a formatted alias "Full_Info" (Name + Bank)
SELECT Beneficiary_ID, CONCAT(Name, ' - ', Bank_Name) AS Full_Info
FROM Beneficiaries;



-- Table-13
CREATE TABLE Lockers (
  Locker_ID INT PRIMARY KEY AUTO_INCREMENT,
  Branch_ID INT NOT NULL,
  Customer_ID INT NOT NULL,
  Locker_Size ENUM('Small', 'Medium', 'Large'),
  Rent_Amount DECIMAL(10,2),
  Allocation_Date DATE,
  Expiry_Date DATE,
  Status ENUM('Allocated', 'Vacant'),
  Access_Code CHAR(6),
  Last_Accessed DATETIME,
  FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID),
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
); 


-- insert records into table-13
INSERT INTO Lockers 
(Branch_ID, Customer_ID, Locker_Size, Rent_Amount, Allocation_Date, Expiry_Date, Status, Access_Code, Last_Accessed)
VALUES
(1, 1, 'Small', 1500.00, '2023-01-10', '2026-01-10', 'Allocated', 'A1B2C3', '2025-06-10 11:45:00'),
(2, 2, 'Medium', 2500.00, '2022-05-15', '2025-05-15', 'Allocated', 'D4E5F6', '2025-07-01 09:30:00'),
(3, 3, 'Large', 4000.00, '2024-02-01', '2027-02-01', 'Allocated', 'G7H8I9', '2025-06-28 14:20:00'),
(4, 4, 'Medium', 2700.00, '2022-08-20', '2025-08-20', 'Allocated', 'J1K2L3', '2025-06-14 10:10:00'),
(5, 5, 'Small', 1600.00, '2023-11-30', '2026-11-30', 'Allocated', 'M4N5O6', '2025-07-10 08:05:00'),
(1, 6, 'Large', 3900.00, '2023-07-10', '2026-07-10', 'Allocated', 'P7Q8R9', '2025-06-20 15:45:00'),
(2, 7, 'Medium', 2600.00, '2023-03-15', '2026-03-15', 'Allocated', 'S1T2U3', '2025-06-26 12:30:00'),
(3, 8, 'Small', 1550.00, '2022-12-01', '2025-12-01', 'Allocated', 'V4W5X6', '2025-07-03 16:10:00'),
(4, 9, 'Large', 4050.00, '2024-06-05', '2027-06-05', 'Allocated', 'Y7Z8A9', '2025-06-25 13:00:00'),
(5, 10, 'Medium', 2550.00, '2023-09-25', '2026-09-25', 'Allocated', 'B1C2D3', '2025-06-23 11:11:00'),
(1, 11, 'Small', 1500.00, '2022-11-11', '2025-11-11', 'Vacant', 'E4F5G6', NULL),
(2, 12, 'Large', 4100.00, '2023-06-20', '2026-06-20', 'Allocated', 'H7I8J9', '2025-07-02 17:45:00'),
(3, 13, 'Medium', 2700.00, '2022-10-15', '2025-10-15', 'Vacant', 'K1L2M3', NULL),
(4, 14, 'Large', 4000.00, '2024-04-01', '2027-04-01', 'Allocated', 'N4O5P6', '2025-06-18 10:00:00'),
(5, 15, 'Small', 1600.00, '2023-02-14', '2026-02-14', 'Allocated', 'Q7R8S9', '2025-06-30 09:15:00'),
(1, 16, 'Medium', 2600.00, '2022-09-30', '2025-09-30', 'Allocated', 'T1U2V3', '2025-07-01 08:40:00'),
(2, 17, 'Large', 4050.00, '2023-08-01', '2026-08-01', 'Vacant', 'W4X5Y6', NULL),
(3, 18, 'Small', 1550.00, '2024-01-01', '2027-01-01', 'Allocated', 'Z7A8B9', '2025-06-27 12:00:00'),
(4, 19, 'Medium', 2550.00, '2022-06-15', '2025-06-15', 'Allocated', 'C1D2E3', '2025-06-22 14:55:00'),
(5, 20, 'Large', 4100.00, '2023-10-10', '2026-10-10', 'Allocated', 'F4G5H6', '2025-06-29 16:35:00');


-- display table-13
select * from Lockers;

truncate table Lockers;

drop table Lockers;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all lockers
SELECT * FROM Lockers;

-- 2. Select only allocated lockers with size and rent
SELECT Locker_ID, Locker_Size, Rent_Amount, Status
FROM Lockers
WHERE Status = 'Allocated';

-- 3. Select all vacant lockers
SELECT Locker_ID, Branch_ID, Locker_Size, Rent_Amount
FROM Lockers
WHERE Status = 'Vacant';

-- 4. Find lockers whose expiry date is before July 2025
SELECT Locker_ID, Customer_ID, Expiry_Date
FROM Lockers
WHERE Expiry_Date < '2025-07-01';

-- 5. Count lockers by size
SELECT Locker_Size, COUNT(*) AS Total_Lockers
FROM Lockers
GROUP BY Locker_Size;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column for Security_Deposit
ALTER TABLE Lockers ADD COLUMN Security_Deposit DECIMAL(10,2) DEFAULT 1000.00;

-- 2. Modify Access_Code to increase length
ALTER TABLE Lockers MODIFY COLUMN Access_Code CHAR(10);

-- 3. Add column for Locker_Location
ALTER TABLE Lockers ADD COLUMN Locker_Location VARCHAR(100);

-- 4. Drop column Locker_Location
ALTER TABLE Lockers DROP COLUMN Locker_Location;

-- 5. Change column Rent_Amount to Annual_Rent
ALTER TABLE Lockers CHANGE COLUMN Rent_Amount Annual_Rent DECIMAL(10,2);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Lockers to Bank_Lockers
RENAME TABLE Lockers TO Bank_Lockers;

-- 2. Rename Bank_Lockers back to Lockers
RENAME TABLE Bank_Lockers TO Lockers;

-- 3. Rename Lockers to Safe_Lockers
RENAME TABLE Lockers TO Safe_Lockers;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update rent for Locker_ID = 5
UPDATE Safe_Lockers 
SET Annual_Rent = 1800.00 
WHERE Locker_ID = 5;

-- 2. Update status of Locker_ID = 11 to Allocated
UPDATE Safe_Lockers 
SET Status = 'Allocated', Last_Accessed = NOW()
WHERE Locker_ID = 11;

-- 3. Update Access_Code for Locker_ID = 3
UPDATE Safe_Lockers 
SET Access_Code = 'NEW123' 
WHERE Locker_ID = 3;

-- 4. Update Expiry_Date for Locker_ID = 19
UPDATE Safe_Lockers 
SET Expiry_Date = '2026-12-31' 
WHERE Locker_ID = 19;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete locker with Locker_ID = 20
DELETE FROM Safe_Lockers 
WHERE Locker_ID = 20;

-- 2. Delete all vacant lockers
DELETE FROM Safe_Lockers 
WHERE Status = 'Vacant';

-- 3. Delete lockers with Annual_Rent less than 2000
DELETE FROM Safe_Lockers 
WHERE Annual_Rent < 2000.00;

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all lockers that are not allocated
SELECT Locker_ID, Status
FROM Lockers
WHERE Status <> 'Allocated';

-- 2. Show lockers with rent amount greater than 3000
SELECT Locker_ID, Locker_Size, Rent_Amount
FROM Lockers
WHERE Rent_Amount > 3000;

-- 3. Show lockers with size either 'Small' or 'Medium'
SELECT Locker_ID, Locker_Size
FROM Lockers
WHERE Locker_Size IN ('Small', 'Medium');

-- 4. Show lockers allocated after '2023-01-01'
SELECT Locker_ID, Allocation_Date
FROM Lockers
WHERE Allocation_Date > '2023-01-01';

-- 5. Show lockers expiring before '2026-01-01'
SELECT Locker_ID, Expiry_Date
FROM Lockers
WHERE Expiry_Date < '2026-01-01';

-- 6. Show lockers with Access_Code starting with 'A'
SELECT Locker_ID, Access_Code
FROM Lockers
WHERE Access_Code LIKE 'A%';

-- 7. Show lockers last accessed on or after '2025-07-01'
SELECT Locker_ID, Last_Accessed
FROM Lockers
WHERE Last_Accessed >= '2025-07-01';

-- 8. Show lockers with rent between 1500 and 3000
SELECT Locker_ID, Locker_Size, Rent_Amount
FROM Lockers
WHERE Rent_Amount BETWEEN 1500 AND 3000;

-- 9. Show lockers whose Access_Code contains '5'
SELECT Locker_ID, Access_Code
FROM Lockers
WHERE Access_Code LIKE '%5%';

-- 10. Show lockers that are 'Vacant' OR 'Large'
SELECT Locker_ID, Locker_Size, Status
FROM Lockers
WHERE Status = 'Vacant' OR Locker_Size = 'Large';


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all allocated lockers
SELECT Locker_ID, Status
FROM Lockers
WHERE Status = 'Allocated';

-- 2. Show distinct locker sizes
SELECT DISTINCT Locker_Size
FROM Lockers;

-- 3. Show all lockers ordered by Rent_Amount descending
SELECT Locker_ID, Locker_Size, Rent_Amount
FROM Lockers
ORDER BY Rent_Amount DESC;

-- 4. Count lockers grouped by Locker_Size
SELECT Locker_Size, COUNT(*) AS Total_Lockers
FROM Lockers
GROUP BY Locker_Size;

-- 5. Count lockers grouped by Status
SELECT Status, COUNT(*) AS Total
FROM Lockers
GROUP BY Status;

-- 6. Show average rent for each locker size
SELECT Locker_Size, AVG(Rent_Amount) AS Avg_Rent
FROM Lockers
GROUP BY Locker_Size;

-- 7. Show locker sizes having average rent > 3000
SELECT Locker_Size, AVG(Rent_Amount) AS Avg_Rent
FROM Lockers
GROUP BY Locker_Size
HAVING AVG(Rent_Amount) > 3000;

-- 8. Show the 5 most recently accessed lockers
SELECT Locker_ID, Last_Accessed
FROM Lockers
WHERE Last_Accessed IS NOT NULL
ORDER BY Last_Accessed DESC
LIMIT 5;

-- 9. Show lockers expiring in 2025 grouped by Branch
SELECT Branch_ID, COUNT(*) AS Lockers_Expiring_2025
FROM Lockers
WHERE YEAR(Expiry_Date) = 2025
GROUP BY Branch_ID;

-- 10. Show Locker_ID with a formatted field showing "Size - Rent"
SELECT Locker_ID, CONCAT(Locker_Size, ' - ₹', Rent_Amount) AS Size_Rent
FROM Lockers;


-- Table-14
CREATE TABLE Complaints (
  Complaint_ID INT PRIMARY KEY AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  Complaint_Type ENUM('ATM', 'NetBanking', 'Card', 'Branch', 'Loan', 'Other'),
  Description TEXT,
  Complaint_Date DATE,
  Status ENUM('Open', 'Resolved', 'In Progress'),
  Resolution_Date DATE,
  Assigned_To_Employee INT,
  Feedback_Rating INT CHECK (Feedback_Rating BETWEEN 1 AND 5),
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
  FOREIGN KEY (Assigned_To_Employee) REFERENCES Employees(Employee_ID)
);


-- insert records into table-14
INSERT INTO Complaints 
(Customer_ID, Complaint_Type, Description, Complaint_Date, Status, Resolution_Date, Assigned_To_Employee, Feedback_Rating)
VALUES
(1, 'ATM', 'ATM did not dispense cash but amount debited.', '2025-06-01', 'Resolved', '2025-06-03', 2, 4),
(2, 'NetBanking', 'Unable to log in to net banking.', '2025-06-02', 'In Progress', NULL, 3, NULL),
(3, 'Card', 'Credit card application rejected without reason.', '2025-06-03', 'Resolved', '2025-06-05', 4, 3),
(4, 'Branch', 'Rude behavior by branch staff.', '2025-06-04', 'Open', NULL, NULL, NULL),
(5, 'Loan', 'Interest wrongly charged on personal loan.', '2025-06-05', 'In Progress', NULL, 5, NULL),
(6, 'Other', 'Issue with email alerts for transactions.', '2025-06-06', 'Resolved', '2025-06-08', 6, 5),
(7, 'ATM', 'Card got stuck in ATM.', '2025-06-07', 'Resolved', '2025-06-08', 2, 4),
(8, 'NetBanking', 'UPI transactions failing repeatedly.', '2025-06-08', 'Open', NULL, NULL, NULL),
(9, 'Card', 'Incorrect annual charges on debit card.', '2025-06-09', 'Resolved', '2025-06-10', 4, 4),
(10, 'Loan', 'Loan disbursement delayed.', '2025-06-10', 'Resolved', '2025-06-12', 5, 2),
(11, 'Branch', 'Cash deposit machine not working.', '2025-06-11', 'Resolved', '2025-06-13', 1, 5),
(12, 'ATM', 'No receipt issued after withdrawal.', '2025-06-12', 'Open', NULL, NULL, NULL),
(13, 'NetBanking', 'Unable to reset password.', '2025-06-13', 'In Progress', NULL, 3, NULL),
(14, 'Card', 'Blocked card still showing active.', '2025-06-14', 'Resolved', '2025-06-15', 4, 3),
(15, 'Branch', 'Crowded counter service on Saturday.', '2025-06-15', 'Open', NULL, NULL, NULL),
(16, 'Loan', 'Pre-closure not reflecting.', '2025-06-16', 'Resolved', '2025-06-17', 5, 4),
(17, 'Other', 'Wrong SMS alerts for another account.', '2025-06-17', 'Resolved', '2025-06-18', 6, 5),
(18, 'ATM', 'Unable to change ATM PIN.', '2025-06-18', 'In Progress', NULL, 2, NULL),
(19, 'NetBanking', 'Login OTP not received.', '2025-06-19', 'Resolved', '2025-06-20', 3, 4),
(20, 'Card', 'Add-on card not delivered.', '2025-06-20', 'Resolved', '2025-06-22', 4, 2);


-- display table-14
select * from Complaints;

truncate table Complaints;

drop table Complaints;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all complaints
SELECT * FROM Complaints;

-- 2. Select only open complaints
SELECT Complaint_ID, Customer_ID, Complaint_Type, Complaint_Date, Status
FROM Complaints
WHERE Status = 'Open';

-- 3. Select complaints assigned to Employee_ID = 3
SELECT Complaint_ID, Complaint_Type, Status, Assigned_To_Employee
FROM Complaints
WHERE Assigned_To_Employee = 3;

-- 4. Select complaints with feedback rating 4 or 5
SELECT Complaint_ID, Complaint_Type, Feedback_Rating
FROM Complaints
WHERE Feedback_Rating >= 4;

-- 5. Count complaints by type
SELECT Complaint_Type, COUNT(*) AS Total_Complaints
FROM Complaints
GROUP BY Complaint_Type;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column Priority
ALTER TABLE Complaints ADD COLUMN Priority ENUM('Low', 'Medium', 'High') DEFAULT 'Medium';

-- 2. Modify Description column to VARCHAR(500)
ALTER TABLE Complaints MODIFY COLUMN Description VARCHAR(500);

-- 3. Add column Escalated_To_Manager
ALTER TABLE Complaints ADD COLUMN Escalated_To_Manager INT;

-- 4. Drop column Escalated_To_Manager
ALTER TABLE Complaints DROP COLUMN Escalated_To_Manager;

-- 5. Change column Complaint_Date to Reported_Date
ALTER TABLE Complaints CHANGE COLUMN Complaint_Date Reported_Date DATE;


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Complaints to Customer_Complaints
RENAME TABLE Complaints TO Customer_Complaints;

-- 2. Rename Customer_Complaints back to Complaints
RENAME TABLE Customer_Complaints TO Complaints;

-- 3. Rename Complaints to Service_Complaints
RENAME TABLE Complaints TO Service_Complaints;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update status of Complaint_ID = 4 to In Progress
UPDATE Service_Complaints
SET Status = 'In Progress', Assigned_To_Employee = 1
WHERE Complaint_ID = 4;

-- 2. Update feedback rating for Complaint_ID = 10
UPDATE Service_Complaints
SET Feedback_Rating = 3
WHERE Complaint_ID = 10;

-- 3. Update Resolution_Date for Complaint_ID = 2
UPDATE Service_Complaints
SET Resolution_Date = '2025-07-01'
WHERE Complaint_ID = 2;

-- 4. Update Assigned_To_Employee for all ATM complaints
UPDATE Service_Complaints
SET Assigned_To_Employee = 2
WHERE Complaint_Type = 'ATM';


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete complaint with Complaint_ID = 12
DELETE FROM Service_Complaints 
WHERE Complaint_ID = 12;

-- 2. Delete all complaints with status 'Open'
DELETE FROM Service_Complaints 
WHERE Status = 'Open';

-- 3. Delete complaints with feedback rating <= 2
DELETE FROM Service_Complaints 
WHERE Feedback_Rating <= 2;

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all complaints that are not resolved
SELECT Complaint_ID, Status
FROM Complaints
WHERE Status <> 'Resolved';

-- 2. Show all complaints of type 'ATM' or 'NetBanking'
SELECT Complaint_ID, Complaint_Type
FROM Complaints
WHERE Complaint_Type IN ('ATM', 'NetBanking');

-- 3. Show complaints filed after '2025-06-10'
SELECT Complaint_ID, Complaint_Date
FROM Complaints
WHERE Complaint_Date > '2025-06-10';

-- 4. Show complaints resolved before '2025-06-15'
SELECT Complaint_ID, Resolution_Date
FROM Complaints
WHERE Resolution_Date < '2025-06-15';

-- 5. Show complaints that have feedback rating less than 3
SELECT Complaint_ID, Feedback_Rating
FROM Complaints
WHERE Feedback_Rating < 3;

-- 6. Show complaints with feedback rating between 4 and 5
SELECT Complaint_ID, Feedback_Rating
FROM Complaints
WHERE Feedback_Rating BETWEEN 4 AND 5;

-- 7. Show complaints assigned to employee with ID 2
SELECT Complaint_ID, Assigned_To_Employee
FROM Complaints
WHERE Assigned_To_Employee = 2;

-- 8. Show complaints with description containing 'Loan'
SELECT Complaint_ID, Description
FROM Complaints
WHERE Description LIKE '%Loan%';

-- 9. Show complaints with null resolution date
SELECT Complaint_ID, Status
FROM Complaints
WHERE Resolution_Date IS NULL;

-- 10. Show complaints of type 'ATM' OR having feedback rating = 5
SELECT Complaint_ID, Complaint_Type, Feedback_Rating
FROM Complaints
WHERE Complaint_Type = 'ATM' OR Feedback_Rating = 5;


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Show all complaints ordered by Complaint_Date descending
SELECT Complaint_ID, Complaint_Date, Status
FROM Complaints
ORDER BY Complaint_Date DESC;

-- 2. Show distinct complaint types
SELECT DISTINCT Complaint_Type
FROM Complaints;

-- 3. Count complaints grouped by Complaint_Type
SELECT Complaint_Type, COUNT(*) AS Total_Complaints
FROM Complaints
GROUP BY Complaint_Type;

-- 4. Count complaints grouped by Status
SELECT Status, COUNT(*) AS Total_Complaints
FROM Complaints
GROUP BY Status;

-- 5. Find average feedback rating for each complaint type
SELECT Complaint_Type, AVG(Feedback_Rating) AS Avg_Rating
FROM Complaints
WHERE Feedback_Rating IS NOT NULL
GROUP BY Complaint_Type;

-- 6. Show complaint types where average feedback rating is less than 4
SELECT Complaint_Type, AVG(Feedback_Rating) AS Avg_Rating
FROM Complaints
WHERE Feedback_Rating IS NOT NULL
GROUP BY Complaint_Type
HAVING AVG(Feedback_Rating) < 4;

-- 7. Show top 5 most recent resolved complaints
SELECT Complaint_ID, Complaint_Date, Resolution_Date
FROM Complaints
WHERE Status = 'Resolved'
ORDER BY Resolution_Date DESC
LIMIT 5;

-- 8. Show number of complaints assigned to each employee
SELECT Assigned_To_Employee, COUNT(*) AS Complaints_Assigned
FROM Complaints
WHERE Assigned_To_Employee IS NOT NULL
GROUP BY Assigned_To_Employee;

-- 9. Show the earliest complaint for each complaint type
SELECT Complaint_Type, MIN(Complaint_Date) AS First_Complaint
FROM Complaints
GROUP BY Complaint_Type;

-- 10. Show complaints with feedback rating along with a remark
SELECT Complaint_ID, Feedback_Rating,
       CASE 
         WHEN Feedback_Rating = 5 THEN 'Excellent Service'
         WHEN Feedback_Rating = 4 THEN 'Good Service'
         WHEN Feedback_Rating = 3 THEN 'Average'
         WHEN Feedback_Rating = 2 THEN 'Poor'
         WHEN Feedback_Rating = 1 THEN 'Very Poor'
         ELSE 'Not Rated'
       END AS Feedback_Remark
FROM Complaints;


-- Table-15
CREATE TABLE Insurance_Policies (
  Policy_ID INT PRIMARY KEY AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  Policy_Type ENUM('Life', 'Health', 'Vehicle', 'Travel'),
  Policy_Provider VARCHAR(100),
  Policy_Number VARCHAR(50) UNIQUE,
  Start_Date DATE,
  End_Date DATE,
  Premium_Amount DECIMAL(10,2),
  Status ENUM('Active', 'Lapsed', 'Claimed'),
  Nominee_Name VARCHAR(100),
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);


-- insert records into table-15
INSERT INTO Insurance_Policies 
(Customer_ID, Policy_Type, Policy_Provider, Policy_Number, Start_Date, End_Date, Premium_Amount, Status, Nominee_Name)
VALUES
(1, 'Life', 'HDFC Life', 'LIFE123456', '2021-05-01', '2041-05-01', 12000.00, 'Active', 'Priya Mehta'),
(2, 'Health', 'Star Health', 'HLTH789101', '2023-01-10', '2026-01-10', 8500.00, 'Active', 'Rakesh Sharma'),
(3, 'Vehicle', 'ICICI Lombard', 'VEHIC45238', '2024-06-15', '2025-06-15', 4300.00, 'Active', 'Sunil Yadav'),
(4, 'Travel', 'Tata AIG', 'TRVL890123', '2025-04-01', '2025-04-15', 1500.00, 'Claimed', 'Deepika Rao'),
(5, 'Life', 'SBI Life', 'LIFE998877', '2020-08-20', '2040-08-20', 10000.00, 'Active', 'Kavita Singh'),
(6, 'Health', 'Max Bupa', 'HLTH652341', '2022-09-01', '2025-09-01', 7800.00, 'Lapsed', 'Amit Sinha'),
(7, 'Vehicle', 'Bajaj Allianz', 'VEH445566', '2024-01-01', '2025-01-01', 5100.00, 'Active', 'Vikram Das'),
(8, 'Travel', 'Religare', 'TRVL321654', '2025-02-10', '2025-02-20', 1600.00, 'Claimed', 'Neha Kulkarni'),
(9, 'Life', 'HDFC Life', 'LIFE786534', '2019-12-01', '2039-12-01', 14000.00, 'Active', 'Shruti Nair'),
(10, 'Health', 'Niva Bupa', 'HLTH334455', '2023-05-15', '2026-05-15', 9200.00, 'Active', 'Rohit Malhotra'),
(11, 'Vehicle', 'Tata AIG', 'VEH786534', '2023-11-01', '2024-11-01', 3900.00, 'Active', 'Manish Gupta'),
(12, 'Travel', 'ICICI Lombard', 'TRVL456789', '2025-03-10', '2025-03-20', 1750.00, 'Claimed', 'Preeti Sharma'),
(13, 'Life', 'SBI Life', 'LIFE192837', '2021-07-10', '2041-07-10', 11000.00, 'Active', 'Meera Jain'),
(14, 'Health', 'Care Health', 'HLTH998877', '2022-02-01', '2025-02-01', 8600.00, 'Lapsed', 'Arvind Rao'),
(15, 'Vehicle', 'Bajaj Allianz', 'VEH123789', '2024-03-05', '2025-03-05', 4800.00, 'Active', 'Sandeep Patil'),
(16, 'Travel', 'Digit Insurance', 'TRVL102938', '2025-06-01', '2025-06-10', 1600.00, 'Active', 'Simran Kaur'),
(17, 'Life', 'HDFC Life', 'LIFE564738', '2020-10-15', '2040-10-15', 12500.00, 'Active', 'Anjali Menon'),
(18, 'Health', 'Star Health', 'HLTH111222', '2023-08-01', '2026-08-01', 8900.00, 'Active', 'Tarun Reddy'),
(19, 'Vehicle', 'ICICI Lombard', 'VEH674839', '2024-05-10', '2025-05-10', 4200.00, 'Active', 'Ankit Bhatt'),
(20, 'Travel', 'Tata AIG', 'TRVL223344', '2025-07-01', '2025-07-10', 1550.00, 'Active', 'Divya Pandey');


-- display table-15
select * from Insurance_Policies;


truncate table Insurance_Policies;

drop table Insurance_Policies;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all insurance policies
SELECT * FROM Insurance_Policies;

-- 2. Select only Life insurance policies
SELECT Policy_ID, Customer_ID, Policy_Provider, Premium_Amount, Status
FROM Insurance_Policies
WHERE Policy_Type = 'Life';

-- 3. Select all policies that are Lapsed
SELECT Policy_Number, Policy_Type, Policy_Provider, End_Date, Status
FROM Insurance_Policies
WHERE Status = 'Lapsed';

-- 4. Count total policies by provider
SELECT Policy_Provider, COUNT(*) AS Total_Policies
FROM Insurance_Policies
GROUP BY Policy_Provider;

-- 5. Find policies with premium amount greater than 10,000
SELECT Policy_Number, Policy_Type, Premium_Amount, Nominee_Name
FROM Insurance_Policies
WHERE Premium_Amount > 10000;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column Agent_Name
ALTER TABLE Insurance_Policies ADD COLUMN Agent_Name VARCHAR(100);

-- 2. Modify Nominee_Name to allow longer names
ALTER TABLE Insurance_Policies MODIFY COLUMN Nominee_Name VARCHAR(150);

-- 3. Add column Claim_Amount
ALTER TABLE Insurance_Policies ADD COLUMN Claim_Amount DECIMAL(12,2);

-- 4. Drop column Claim_Amount
ALTER TABLE Insurance_Policies DROP COLUMN Claim_Amount;

-- 5. Change column Policy_Provider to Insurer_Name
ALTER TABLE Insurance_Policies CHANGE COLUMN Policy_Provider Insurer_Name VARCHAR(100);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Insurance_Policies to Policies
RENAME TABLE Insurance_Policies TO Policies;

-- 2. Rename Policies back to Insurance_Policies
RENAME TABLE Policies TO Insurance_Policies;

-- 3. Rename Insurance_Policies to Customer_Policies
RENAME TABLE Insurance_Policies TO Customer_Policies;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update status of Policy_ID = 3 to Lapsed
UPDATE Customer_Policies
SET Status = 'Lapsed'
WHERE Policy_ID = 3;

-- 2. Update premium amount for Policy_ID = 5
UPDATE Customer_Policies
SET Premium_Amount = 10500.00
WHERE Policy_ID = 5;

-- 3. Extend End_Date of Policy_ID = 7 by one year
UPDATE Customer_Policies
SET End_Date = DATE_ADD(End_Date, INTERVAL 1 YEAR)
WHERE Policy_ID = 7;

-- 4. Update Nominee_Name for Policy_ID = 10
UPDATE Customer_Policies
SET Nominee_Name = 'Sneha Malhotra'
WHERE Policy_ID = 10;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete policy with Policy_ID = 4
DELETE FROM Customer_Policies
WHERE Policy_ID = 4;

-- 2. Delete all claimed travel policies
DELETE FROM Customer_Policies
WHERE Policy_Type = 'Travel' AND Status = 'Claimed';

-- 3. Delete all policies with premium less than 2000
DELETE FROM Customer_Policies
WHERE Premium_Amount < 2000;

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all active insurance policies
SELECT Policy_ID, Policy_Type, Status
FROM Insurance_Policies
WHERE Status = 'Active';

-- 2. Show all policies which are not of type 'Life'
SELECT Policy_ID, Policy_Type
FROM Insurance_Policies
WHERE Policy_Type <> 'Life';

-- 3. Show all policies where premium is greater than 10,000
SELECT Policy_ID, Policy_Type, Premium_Amount
FROM Insurance_Policies
WHERE Premium_Amount > 10000;

-- 4. Show policies of type 'Health' OR 'Vehicle'
SELECT Policy_ID, Policy_Type
FROM Insurance_Policies
WHERE Policy_Type IN ('Health', 'Vehicle');

-- 5. Show policies with premium between 4000 and 9000
SELECT Policy_ID, Policy_Type, Premium_Amount
FROM Insurance_Policies
WHERE Premium_Amount BETWEEN 4000 AND 9000;

-- 6. Show policies with policy provider containing 'HDFC'
SELECT Policy_ID, Policy_Provider
FROM Insurance_Policies
WHERE Policy_Provider LIKE '%HDFC%';

-- 7. Show all policies that ended before '2025-06-01'
SELECT Policy_ID, End_Date
FROM Insurance_Policies
WHERE End_Date < '2025-06-01';

-- 8. Show policies of type 'Travel' with status 'Claimed'
SELECT Policy_ID, Policy_Type, Status
FROM Insurance_Policies
WHERE Policy_Type = 'Travel' AND Status = 'Claimed';

-- 9. Show policies whose nominee name starts with 'S'
SELECT Policy_ID, Nominee_Name
FROM Insurance_Policies
WHERE Nominee_Name LIKE 'S%';

-- 10. Show policies where Start_Date is null (data validation check)
SELECT Policy_ID
FROM Insurance_Policies
WHERE Start_Date IS NULL;


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. List all policies ordered by Premium_Amount descending
SELECT Policy_ID, Policy_Type, Premium_Amount
FROM Insurance_Policies
ORDER BY Premium_Amount DESC;

-- 2. Show distinct policy providers
SELECT DISTINCT Policy_Provider
FROM Insurance_Policies;

-- 3. Count policies grouped by Policy_Type
SELECT Policy_Type, COUNT(*) AS Total_Policies
FROM Insurance_Policies
GROUP BY Policy_Type;

-- 4. Count policies grouped by Status
SELECT Status, COUNT(*) AS Total_Policies
FROM Insurance_Policies
GROUP BY Status;

-- 5. Find average premium for each Policy_Type
SELECT Policy_Type, AVG(Premium_Amount) AS Avg_Premium
FROM Insurance_Policies
GROUP BY Policy_Type;

-- 6. Show policy providers where average premium is greater than 9000
SELECT Policy_Provider, AVG(Premium_Amount) AS Avg_Premium
FROM Insurance_Policies
GROUP BY Policy_Provider
HAVING AVG(Premium_Amount) > 9000;

-- 7. Show top 5 highest premium policies
SELECT Policy_ID, Policy_Type, Premium_Amount
FROM Insurance_Policies
ORDER BY Premium_Amount DESC
LIMIT 5;

-- 8. Show number of policies per customer
SELECT Customer_ID, COUNT(*) AS Total_Policies
FROM Insurance_Policies
GROUP BY Customer_ID;

-- 9. Find earliest start date for each policy type
SELECT Policy_Type, MIN(Start_Date) AS First_Policy
FROM Insurance_Policies
GROUP BY Policy_Type;

-- 10. Show policies with remarks based on status
SELECT Policy_ID, Status,
       CASE 
         WHEN Status = 'Active' THEN 'Currently Running'
         WHEN Status = 'Lapsed' THEN 'Policy Expired'
         WHEN Status = 'Claimed' THEN 'Already Claimed'
       END AS Status_Remark
FROM Insurance_Policies;


-- Table-16
CREATE TABLE Recurring_Deposits (
  RD_ID INT PRIMARY KEY AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  Account_ID INT NOT NULL,
  Start_Date DATE,
  Maturity_Date DATE,
  Monthly_Installment DECIMAL(10,2),
  Interest_Rate DECIMAL(5,2),
  Total_Deposit DECIMAL(10,2),
  Status ENUM('Active', 'Matured', 'Closed'),
  Nominee_Name VARCHAR(100),
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
  FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);

-- insert records into table-16
INSERT INTO Recurring_Deposits (Customer_ID, Account_ID, Start_Date, Maturity_Date, Monthly_Installment, Interest_Rate, Total_Deposit, Status, Nominee_Name) VALUES
(1, 1, '2023-01-10', '2026-01-10', 2000.00, 6.50, 72000.00, 'Active', 'Aarav Patel'),
(2, 2, '2022-03-15', '2025-03-15', 1500.00, 6.25, 54000.00, 'Matured', 'Neha Sharma'),
(3, 3, '2023-07-01', '2026-07-01', 2500.00, 6.75, 90000.00, 'Active', 'Rohit Singh'),
(4, 4, '2022-12-20', '2025-12-20', 1800.00, 6.40, 64800.00, 'Closed', 'Kavya Iyer'),
(5, 5, '2023-05-05', '2026-05-05', 3000.00, 7.00, 108000.00, 'Active', 'Siddharth Mehta'),
(6, 6, '2021-06-01', '2024-06-01', 1200.00, 6.00, 43200.00, 'Matured', 'Aanya Nair'),
(7, 7, '2023-09-15', '2026-09-15', 2200.00, 6.30, 79200.00, 'Active', 'Harshita Reddy'),
(8, 8, '2022-10-10', '2025-10-10', 1700.00, 6.20, 61200.00, 'Closed', 'Aditya Joshi'),
(9, 9, '2023-02-01', '2026-02-01', 2600.00, 6.80, 93600.00, 'Active', 'Ritika Desai'),
(10, 10, '2023-04-01', '2026-04-01', 2000.00, 6.50, 72000.00, 'Active', 'Mehul Shah'),
(11, 11, '2022-08-20', '2025-08-20', 1600.00, 6.10, 57600.00, 'Closed', 'Tanya Bansal'),
(12, 12, '2023-03-10', '2026-03-10', 1900.00, 6.45, 68400.00, 'Active', 'Nikhil Kapoor'),
(13, 13, '2022-11-01', '2025-11-01', 2300.00, 6.60, 82800.00, 'Matured', 'Shruti Verma'),
(14, 14, '2023-06-15', '2026-06-15', 2100.00, 6.70, 75600.00, 'Active', 'Yash Thakur'),
(15, 15, '2021-09-25', '2024-09-25', 1400.00, 6.10, 50400.00, 'Matured', 'Priya Menon'),
(16, 16, '2022-01-01', '2025-01-01', 1700.00, 6.20, 61200.00, 'Closed', 'Arjun Das'),
(17, 17, '2023-10-01', '2026-10-01', 2800.00, 7.00, 100800.00, 'Active', 'Sneha Kulkarni'),
(18, 18, '2022-05-20', '2025-05-20', 1500.00, 6.30, 54000.00, 'Matured', 'Devika Rao'),
(19, 19, '2023-08-08', '2026-08-08', 2400.00, 6.55, 86400.00, 'Active', 'Kabir Chatterjee'),
(20, 20, '2023-12-01', '2026-12-01', 2000.00, 6.50, 72000.00, 'Active', 'Ishita Malhotra');



-- display table-16
select * from Recurring_Deposits;

truncate table Recurring_Deposits;

drop table Recurring_Deposits;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all recurring deposits
SELECT * FROM Recurring_Deposits;

-- 2. Select all Active recurring deposits with installment > 2000
SELECT RD_ID, Customer_ID, Monthly_Installment, Interest_Rate, Status
FROM Recurring_Deposits
WHERE Status = 'Active' AND Monthly_Installment > 2000;

-- 3. Get matured deposits with maturity date in 2025
SELECT RD_ID, Customer_ID, Maturity_Date, Total_Deposit
FROM Recurring_Deposits
WHERE Status = 'Matured' AND YEAR(Maturity_Date) = 2025;

-- 4. Count deposits by status
SELECT Status, COUNT(*) AS Total
FROM Recurring_Deposits
GROUP BY Status;

-- 5. Find deposits with interest rate >= 6.70
SELECT RD_ID, Customer_ID, Monthly_Installment, Interest_Rate
FROM Recurring_Deposits
WHERE Interest_Rate >= 6.70;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column Agent_Name
ALTER TABLE Recurring_Deposits ADD COLUMN Agent_Name VARCHAR(100);

-- 2. Modify Monthly_Installment to allow bigger amounts
ALTER TABLE Recurring_Deposits MODIFY COLUMN Monthly_Installment DECIMAL(12,2);

-- 3. Add column Maturity_Amount
ALTER TABLE Recurring_Deposits ADD COLUMN Maturity_Amount DECIMAL(12,2);

-- 4. Drop column Maturity_Amount
ALTER TABLE Recurring_Deposits DROP COLUMN Maturity_Amount;

-- 5. Change column Nominee_Name to Nominee_Full_Name
ALTER TABLE Recurring_Deposits CHANGE COLUMN Nominee_Name Nominee_Full_Name VARCHAR(120);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Recurring_Deposits to RD_Accounts
RENAME TABLE Recurring_Deposits TO RD_Accounts;

-- 2. Rename table back to Recurring_Deposits
RENAME TABLE RD_Accounts TO Recurring_Deposits;

-- 3. Rename Recurring_Deposits to Customer_RD
RENAME TABLE Recurring_Deposits TO Customer_RD;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update status of RD_ID = 4 to Matured
UPDATE Customer_RD
SET Status = 'Matured'
WHERE RD_ID = 4;

-- 2. Update interest rate of RD_ID = 5 to 7.20
UPDATE Customer_RD
SET Interest_Rate = 7.20
WHERE RD_ID = 5;

-- 3. Increase Monthly_Installment by 500 for RD_ID = 7
UPDATE Customer_RD
SET Monthly_Installment = Monthly_Installment + 500
WHERE RD_ID = 7;

-- 4. Change Nominee_Full_Name for RD_ID = 10
UPDATE Customer_RD
SET Nominee_Full_Name = 'Rohan Shah'
WHERE RD_ID = 10;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete RD with RD_ID = 2
DELETE FROM Customer_RD
WHERE RD_ID = 2;

-- 2. Delete all closed deposits
DELETE FROM Customer_RD
WHERE Status = 'Closed';

-- 3. Delete deposits with Monthly_Installment less than 1500
DELETE FROM Customer_RD
WHERE Monthly_Installment < 1500;

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all active recurring deposits
SELECT RD_ID, Customer_ID, Status
FROM Recurring_Deposits
WHERE Status = 'Active';

-- 2. Show recurring deposits where monthly installment is not equal to 2000
SELECT RD_ID, Monthly_Installment
FROM Recurring_Deposits
WHERE Monthly_Installment <> 2000;

-- 3. Show deposits with monthly installment greater than 2500
SELECT RD_ID, Customer_ID, Monthly_Installment
FROM Recurring_Deposits
WHERE Monthly_Installment > 2500;

-- 4. Show deposits with interest rate less than or equal to 6.25
SELECT RD_ID, Interest_Rate
FROM Recurring_Deposits
WHERE Interest_Rate <= 6.25;

-- 5. Show deposits with total deposit between 60,000 and 80,000
SELECT RD_ID, Total_Deposit
FROM Recurring_Deposits
WHERE Total_Deposit BETWEEN 60000 AND 80000;

-- 6. Show deposits whose nominee name starts with 'S'
SELECT RD_ID, Nominee_Name
FROM Recurring_Deposits
WHERE Nominee_Name LIKE 'S%';

-- 7. Show deposits that matured before '2025-01-01'
SELECT RD_ID, Maturity_Date
FROM Recurring_Deposits
WHERE Maturity_Date < '2025-01-01';

-- 8. Show deposits which are Active OR Matured
SELECT RD_ID, Status
FROM Recurring_Deposits
WHERE Status IN ('Active', 'Matured');

-- 9. Show deposits where Start_Date is after '2023-06-01'
SELECT RD_ID, Start_Date
FROM Recurring_Deposits
WHERE Start_Date > '2023-06-01';

-- 10. Show deposits where Nominee_Name is NULL (data validation check)
SELECT RD_ID
FROM Recurring_Deposits
WHERE Nominee_Name IS NULL;


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. List deposits ordered by Total_Deposit descending
SELECT RD_ID, Total_Deposit
FROM Recurring_Deposits
ORDER BY Total_Deposit DESC;

-- 2. Show distinct interest rates offered
SELECT DISTINCT Interest_Rate
FROM Recurring_Deposits;

-- 3. Count deposits grouped by Status
SELECT Status, COUNT(*) AS Total_Deposits
FROM Recurring_Deposits
GROUP BY Status;

-- 4. Find average monthly installment by Status
SELECT Status, AVG(Monthly_Installment) AS Avg_Installment
FROM Recurring_Deposits
GROUP BY Status;

-- 5. Find maximum total deposit for each Status
SELECT Status, MAX(Total_Deposit) AS Max_Deposit
FROM Recurring_Deposits
GROUP BY Status;

-- 6. Show statuses where average interest rate is greater than 6.5
SELECT Status, AVG(Interest_Rate) AS Avg_Rate
FROM Recurring_Deposits
GROUP BY Status
HAVING AVG(Interest_Rate) > 6.5;

-- 7. Show top 5 deposits with highest monthly installment
SELECT RD_ID, Monthly_Installment
FROM Recurring_Deposits
ORDER BY Monthly_Installment DESC
LIMIT 5;

-- 8. Show number of deposits per customer
SELECT Customer_ID, COUNT(*) AS Total_RDs
FROM Recurring_Deposits
GROUP BY Customer_ID;

-- 9. Find earliest Start_Date per Status
SELECT Status, MIN(Start_Date) AS First_RD
FROM Recurring_Deposits
GROUP BY Status;

-- 10. Show deposits with custom labels based on Status
SELECT RD_ID, Status,
       CASE 
         WHEN Status = 'Active' THEN 'Running Deposit'
         WHEN Status = 'Matured' THEN 'Completed Deposit'
         WHEN Status = 'Closed' THEN 'Prematurely Closed'
       END AS Deposit_Status_Remark
FROM Recurring_Deposits;



-- Table-17
CREATE TABLE KYC_Documents (
  KYC_ID INT PRIMARY KEY AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  PAN_Number CHAR(10) UNIQUE,
  Aadhaar_Number CHAR(12) UNIQUE,
  Address_Proof VARCHAR(100),
  Identity_Proof VARCHAR(100),
  Submission_Date DATE,
  Verified_Status ENUM('Verified', 'Pending', 'Rejected'),
  Verified_By INT,
  Remarks VARCHAR(255),
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
  FOREIGN KEY (Verified_By) REFERENCES Employees(Employee_ID)
);

-- insert records into table-17
INSERT INTO KYC_Documents 
(Customer_ID, PAN_Number, Aadhaar_Number, Address_Proof, Identity_Proof, Submission_Date, Verified_Status, Verified_By, Remarks)
VALUES
(1, 'ABCDE1234F', '123456789012', 'Electricity Bill', 'PAN Card', '2023-01-05', 'Verified', 5, 'Verified without issues'),
(2, 'FGHIJ5678K', '234567890123', 'Aadhaar Card', 'Driving License', '2022-11-15', 'Verified', 4, 'Valid documents'),
(3, 'LMNOP9012Q', '345678901234', 'Passport', 'Voter ID', '2023-02-01', 'Pending', NULL, 'Awaiting manual check'),
(4, 'QRSTU3456V', '456789012345', 'Aadhaar Card', 'PAN Card', '2023-03-22', 'Verified', 2, 'Approved by compliance'),
(5, 'WXYZA7890Z', '567890123456', 'Telephone Bill', 'Aadhaar Card', '2023-04-10', 'Rejected', 1, 'Mismatch in Aadhaar details'),
(6, 'BCDEF2345L', '678901234567', 'Ration Card', 'PAN Card', '2022-12-01', 'Verified', 3, 'No issues found'),
(7, 'GHIJK6789P', '789012345678', 'Bank Statement', 'Driving License', '2023-01-18', 'Pending', NULL, 'Document blur'),
(8, 'MNOPQ1234T', '890123456789', 'Aadhaar Card', 'Voter ID', '2022-10-10', 'Verified', 4, 'Verified successfully'),
(9, 'UVWXY5678R', '901234567890', 'Passport', 'PAN Card', '2023-05-15', 'Rejected', 1, 'Signature mismatch'),
(10, 'ZABCD9012X', '112233445566', 'Utility Bill', 'Driving License', '2023-06-05', 'Verified', 5, 'Corrected and verified'),
(11, 'EFGHI3456Y', '223344556677', 'Gas Bill', 'Aadhaar Card', '2023-04-22', 'Verified', 3, 'Ok'),
(12, 'JKLMN7890A', '334455667788', 'Rental Agreement', 'PAN Card', '2022-09-01', 'Pending', NULL, 'Under review'),
(13, 'OPQRS1234C', '445566778899', 'Aadhaar Card', 'Passport', '2023-02-25', 'Verified', 2, 'Verified'),
(14, 'TUVWX5678D', '556677889900', 'Voter ID', 'Driving License', '2023-03-05', 'Verified', 4, 'Complete'),
(15, 'YZABC9012E', '667788990011', 'Bank Passbook', 'PAN Card', '2022-08-10', 'Rejected', 1, 'Invalid proof'),
(16, 'CDEFG3456G', '778899001122', 'Electricity Bill', 'Voter ID', '2023-04-18', 'Pending', NULL, 'Low resolution'),
(17, 'HIJKL7890H', '889900112233', 'Aadhaar Card', 'PAN Card', '2023-01-20', 'Verified', 5, 'Clean verification'),
(18, 'MNOPQ1234I', '990011223344', 'Telephone Bill', 'Passport', '2022-11-12', 'Verified', 2, 'Good'),
(19, 'RSTUV5678J', '101112131415', 'Gas Connection Bill', 'Driving License', '2023-06-01', 'Verified', 3, 'Approved'),
(20, 'WXYZA9012K', '121314151617', 'Rent Agreement', 'PAN Card', '2023-05-10', 'Pending', NULL, 'Awaiting validation');


-- display table-17
select * from KYC_Documents;

truncate table KYC_Documents;

drop table KYC_Documents;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all KYC documents
SELECT * FROM KYC_Documents;

-- 2. Select only pending KYC verifications
SELECT KYC_ID, Customer_ID, PAN_Number, Aadhaar_Number, Remarks
FROM KYC_Documents
WHERE Verified_Status = 'Pending';

-- 3. Find all rejected KYCs along with remarks
SELECT KYC_ID, Customer_ID, Verified_By, Remarks
FROM KYC_Documents
WHERE Verified_Status = 'Rejected';

-- 4. Count how many KYCs each employee verified
SELECT Verified_By, COUNT(*) AS Total_Verified
FROM KYC_Documents
WHERE Verified_By IS NOT NULL
GROUP BY Verified_By;

-- 5. Show customers with Aadhaar starting with '123'
SELECT Customer_ID, Aadhaar_Number, Verified_Status
FROM KYC_Documents
WHERE Aadhaar_Number LIKE '123%';


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column Reviewer_Comments
ALTER TABLE KYC_Documents ADD COLUMN Reviewer_Comments VARCHAR(255);

-- 2. Modify PAN_Number length from 10 to 15
ALTER TABLE KYC_Documents MODIFY COLUMN PAN_Number CHAR(15) UNIQUE;

-- 3. Add column Verification_Date
ALTER TABLE KYC_Documents ADD COLUMN Verification_Date DATE;

-- 4. Drop column Reviewer_Comments
ALTER TABLE KYC_Documents DROP COLUMN Reviewer_Comments;

-- 5. Change Address_Proof to Proof_of_Address
ALTER TABLE KYC_Documents CHANGE COLUMN Address_Proof Proof_of_Address VARCHAR(150);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table KYC_Documents to Customer_KYC
RENAME TABLE KYC_Documents TO Customer_KYC;

-- 2. Rename table back to KYC_Documents
RENAME TABLE Customer_KYC TO KYC_Documents;

-- 3. Rename KYC_Documents to KYC_Records
RENAME TABLE KYC_Documents TO KYC_Records;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Mark KYC_ID = 3 as Verified and assign Employee 4
UPDATE KYC_Records
SET Verified_Status = 'Verified', Verified_By = 4, Remarks = 'Verified successfully'
WHERE KYC_ID = 3;

-- 2. Update remarks for KYC_ID = 7
UPDATE KYC_Records
SET Remarks = 'Resubmission required due to blurry document'
WHERE KYC_ID = 7;

-- 3. Change Aadhaar_Number for Customer_ID = 5
UPDATE KYC_Records
SET Aadhaar_Number = '999999999999'
WHERE Customer_ID = 5;

-- 4. Assign verifier (Employee_ID = 2) for all pending KYCs
UPDATE KYC_Records
SET Verified_By = 2
WHERE Verified_Status = 'Pending' AND Verified_By IS NULL;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete rejected KYCs
DELETE FROM KYC_Records
WHERE Verified_Status = 'Rejected';

-- 2. Delete KYC where Customer_ID = 12
DELETE FROM KYC_Records
WHERE Customer_ID = 12;

-- 3. Delete all KYCs submitted before 2022-01-01
DELETE FROM KYC_Records
WHERE Submission_Date < '2022-01-01';

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all verified KYC documents
SELECT KYC_ID, Customer_ID, Verified_Status
FROM KYC_Documents
WHERE Verified_Status = 'Verified';

-- 2. Show rejected KYCs
SELECT KYC_ID, Customer_ID, Remarks
FROM KYC_Documents
WHERE Verified_Status = 'Rejected';

-- 3. Show KYCs submitted after '2023-01-01'
SELECT KYC_ID, Submission_Date
FROM KYC_Documents
WHERE Submission_Date > '2023-01-01';

-- 4. Show KYCs where PAN starts with 'A'
SELECT KYC_ID, PAN_Number
FROM KYC_Documents
WHERE PAN_Number LIKE 'A%';

-- 5. Show KYCs where Aadhaar number ends with '12'
SELECT KYC_ID, Aadhaar_Number
FROM KYC_Documents
WHERE Aadhaar_Number LIKE '%12';

-- 6. Show pending KYCs without verifier assigned
SELECT KYC_ID, Verified_Status
FROM KYC_Documents
WHERE Verified_Status = 'Pending' AND Verified_By IS NULL;

-- 7. Show KYCs where Address_Proof is either 'Aadhaar Card' or 'Passport'
SELECT KYC_ID, Address_Proof
FROM KYC_Documents
WHERE Address_Proof IN ('Aadhaar Card', 'Passport');

-- 8. Show KYCs with Submission_Date between '2023-03-01' and '2023-05-31'
SELECT KYC_ID, Submission_Date
FROM KYC_Documents
WHERE Submission_Date BETWEEN '2023-03-01' AND '2023-05-31';

-- 9. Show KYCs verified by employee ID 3
SELECT KYC_ID, Verified_By
FROM KYC_Documents
WHERE Verified_By = 3;

-- 10. Show KYCs where remarks are not null
SELECT KYC_ID, Remarks
FROM KYC_Documents
WHERE Remarks IS NOT NULL;


-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. List all KYCs ordered by Submission_Date (newest first)
SELECT KYC_ID, Submission_Date
FROM KYC_Documents
ORDER BY Submission_Date DESC;

-- 2. Show distinct types of Address_Proof used
SELECT DISTINCT Address_Proof
FROM KYC_Documents;

-- 3. Count how many KYCs are in each Verified_Status
SELECT Verified_Status, COUNT(*) AS Total
FROM KYC_Documents
GROUP BY Verified_Status;

-- 4. Find which employee verified the maximum KYCs
SELECT Verified_By, COUNT(*) AS Total_Verified
FROM KYC_Documents
WHERE Verified_Status = 'Verified'
GROUP BY Verified_By
ORDER BY Total_Verified DESC
LIMIT 1;

-- 5. Show customers whose KYC has been rejected
SELECT Customer_ID
FROM KYC_Documents
WHERE Verified_Status = 'Rejected';

-- 6. Group by Address_Proof type and count usage
SELECT Address_Proof, COUNT(*) AS Usage_Count
FROM KYC_Documents
GROUP BY Address_Proof;

-- 7. Show employees who verified more than 2 KYCs
SELECT Verified_By, COUNT(*) AS Total_Verified
FROM KYC_Documents
WHERE Verified_Status = 'Verified'
GROUP BY Verified_By
HAVING COUNT(*) > 2;

-- 8. Find earliest and latest Submission_Date of KYC
SELECT MIN(Submission_Date) AS Earliest, MAX(Submission_Date) AS Latest
FROM KYC_Documents;

-- 9. Show KYCs with custom remarks based on Verified_Status
SELECT KYC_ID, Verified_Status,
       CASE 
         WHEN Verified_Status = 'Verified' THEN 'All Good'
         WHEN Verified_Status = 'Pending' THEN 'Need Action'
         WHEN Verified_Status = 'Rejected' THEN 'Failed Verification'
       END AS Status_Remark
FROM KYC_Documents;

-- 10. Show total KYCs submitted per month (2023 only)
SELECT MONTH(Submission_Date) AS Month, COUNT(*) AS KYCs_Submitted
FROM KYC_Documents
WHERE YEAR(Submission_Date) = 2023
GROUP BY MONTH(Submission_Date)
ORDER BY Month;



-- Table-18
CREATE TABLE Account_Statements (
  Statement_ID INT PRIMARY KEY AUTO_INCREMENT,
  Account_ID INT NOT NULL,
  Start_Date DATE,
  End_Date DATE,
  Generated_On DATE,
  Total_Credits DECIMAL(12,2),
  Total_Debits DECIMAL(12,2),
  Closing_Balance DECIMAL(12,2),
  Format ENUM('PDF', 'Excel'),
  Status ENUM('Generated', 'Failed'),
  FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);


-- insert records into table-18
INSERT INTO Account_Statements (Account_ID, Start_Date, End_Date, Generated_On, Total_Credits, Total_Debits, Closing_Balance, Format, Status) VALUES
(1, '2024-06-01', '2024-06-30', '2024-07-01', 55000.00, 23000.00, 32000.00, 'PDF', 'Generated'),
(2, '2024-06-01', '2024-06-30', '2024-07-01', 30000.00, 15000.00, 15000.00, 'Excel', 'Generated'),
(3, '2024-06-01', '2024-06-30', '2024-07-01', 45000.00, 32000.00, 13000.00, 'PDF', 'Generated'),
(4, '2024-06-01', '2024-06-30', '2024-07-01', 28000.00, 8000.00, 20000.00, 'Excel', 'Generated'),
(5, '2024-06-01', '2024-06-30', '2024-07-01', 15000.00, 12000.00, 3000.00, 'PDF', 'Generated'),
(6, '2024-06-01', '2024-06-30', '2024-07-01', 60000.00, 45000.00, 15000.00, 'Excel', 'Generated'),
(7, '2024-06-01', '2024-06-30', '2024-07-01', 37000.00, 29000.00, 8000.00, 'PDF', 'Generated'),
(8, '2024-06-01', '2024-06-30', '2024-07-01', 20000.00, 5000.00, 15000.00, 'Excel', 'Generated'),
(9, '2024-06-01', '2024-06-30', '2024-07-01', 80000.00, 65000.00, 15000.00, 'PDF', 'Generated'),
(10, '2024-06-01', '2024-06-30', '2024-07-01', 25000.00, 10000.00, 15000.00, 'Excel', 'Generated'),
(11, '2024-06-01', '2024-06-30', '2024-07-01', 45000.00, 20000.00, 25000.00, 'PDF', 'Generated'),
(12, '2024-06-01', '2024-06-30', '2024-07-01', 30000.00, 18000.00, 12000.00, 'Excel', 'Generated'),
(13, '2024-06-01', '2024-06-30', '2024-07-01', 50000.00, 25000.00, 25000.00, 'PDF', 'Generated'),
(14, '2024-06-01', '2024-06-30', '2024-07-01', 28000.00, 18000.00, 10000.00, 'Excel', 'Generated'),
(15, '2024-06-01', '2024-06-30', '2024-07-01', 20000.00, 5000.00, 15000.00, 'PDF', 'Generated'),
(16, '2024-06-01', '2024-06-30', '2024-07-01', 31000.00, 21000.00, 10000.00, 'Excel', 'Generated'),
(17, '2024-06-01', '2024-06-30', '2024-07-01', 27000.00, 9000.00, 18000.00, 'PDF', 'Generated'),
(18, '2024-06-01', '2024-06-30', '2024-07-01', 15000.00, 10000.00, 5000.00, 'Excel', 'Generated'),
(19, '2024-06-01', '2024-06-30', '2024-07-01', 40000.00, 35000.00, 5000.00, 'PDF', 'Generated'),
(20, '2024-06-01', '2024-06-30', '2024-07-01', 60000.00, 30000.00, 30000.00, 'Excel', 'Generated');



-- display table-18
select * from Account_Statements;


truncate table Account_Statements;

drop table Account_Statements;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Select all account statements
SELECT * FROM Account_Statements;

-- 2. Show only PDF generated statements
SELECT Statement_ID, Account_ID, Closing_Balance
FROM Account_Statements
WHERE Format = 'PDF';

-- 3. Find statements with closing balance less than 10,000
SELECT Statement_ID, Account_ID, Closing_Balance
FROM Account_Statements
WHERE Closing_Balance < 10000;

-- 4. Calculate total credits and debits across all accounts
SELECT SUM(Total_Credits) AS Total_Credits_All, SUM(Total_Debits) AS Total_Debits_All
FROM Account_Statements;

-- 5. Show account IDs with highest closing balance
SELECT Account_ID, Closing_Balance
FROM Account_Statements
ORDER BY Closing_Balance DESC
LIMIT 5;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column Generated_By
ALTER TABLE Account_Statements ADD COLUMN Generated_By INT;

-- 2. Modify Closing_Balance to allow more precision
ALTER TABLE Account_Statements MODIFY COLUMN Closing_Balance DECIMAL(15,2);

-- 3. Add column Remarks
ALTER TABLE Account_Statements ADD COLUMN Remarks VARCHAR(255);

-- 4. Drop column Remarks
ALTER TABLE Account_Statements DROP COLUMN Remarks;

-- 5. Change column Format to File_Format
ALTER TABLE Account_Statements CHANGE COLUMN Format File_Format ENUM('PDF', 'Excel');


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Account_Statements to Statements
RENAME TABLE Account_Statements TO Statements;

-- 2. Rename table back to Account_Statements
RENAME TABLE Statements TO Account_Statements;

-- 3. Rename Account_Statements to Bank_Statements
RENAME TABLE Account_Statements TO Bank_Statements;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update status of Statement_ID = 5 to Failed
UPDATE Bank_Statements
SET Status = 'Failed'
WHERE Statement_ID = 5;

-- 2. Change File_Format of Statement_ID = 3 to Excel
UPDATE Bank_Statements
SET File_Format = 'Excel'
WHERE Statement_ID = 3;

-- 3. Increase Total_Credits by 5000 for Account_ID = 10
UPDATE Bank_Statements
SET Total_Credits = Total_Credits + 5000
WHERE Account_ID = 10;

-- 4. Recalculate Closing_Balance for Statement_ID = 10
UPDATE Bank_Statements
SET Closing_Balance = Total_Credits - Total_Debits
WHERE Statement_ID = 10;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete all failed statements
DELETE FROM Bank_Statements
WHERE Status = 'Failed';

-- 2. Delete statement for Account_ID = 18
DELETE FROM Bank_Statements
WHERE Account_ID = 18;

-- 3. Delete statements generated before July 1, 2024
DELETE FROM Bank_Statements
WHERE Generated_On < '2024-07-01';

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all account statements where Total_Credits > 50,000
SELECT Statement_ID, Account_ID, Total_Credits
FROM Account_Statements
WHERE Total_Credits > 50000;

-- 2. Show statements with Total_Debits < 10,000
SELECT Statement_ID, Account_ID, Total_Debits
FROM Account_Statements
WHERE Total_Debits < 10000;

-- 3. Find accounts where Closing_Balance = 15000
SELECT Account_ID, Closing_Balance
FROM Account_Statements
WHERE Closing_Balance = 15000.00;

-- 4. Show statements generated in July 2024
SELECT Statement_ID, Generated_On
FROM Account_Statements
WHERE MONTH(Generated_On) = 7 AND YEAR(Generated_On) = 2024;

-- 5. Find accounts where credits are greater than debits
SELECT Account_ID, Total_Credits, Total_Debits
FROM Account_Statements
WHERE Total_Credits > Total_Debits;

-- 6. Find accounts where debits are greater than credits
SELECT Account_ID, Total_Credits, Total_Debits
FROM Account_Statements
WHERE Total_Debits > Total_Credits;

-- 7. Show statements where Closing_Balance is less than 10,000
SELECT Statement_ID, Account_ID, Closing_Balance
FROM Account_Statements
WHERE Closing_Balance < 10000;

-- 8. Show statements generated in PDF format
SELECT Statement_ID, Format
FROM Account_Statements
WHERE Format = 'PDF';

-- 9. Show statements generated in Excel format
SELECT Statement_ID, Format
FROM Account_Statements
WHERE Format = 'Excel';

-- 10. Show accounts where Status = 'Generated' and Closing_Balance > 20000
SELECT Account_ID, Closing_Balance, Status
FROM Account_Statements
WHERE Status = 'Generated' AND Closing_Balance > 20000;



-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. List all statements ordered by Closing_Balance (highest first)
SELECT Account_ID, Closing_Balance
FROM Account_Statements
ORDER BY Closing_Balance DESC;

-- 2. Show distinct formats used for statements
SELECT DISTINCT Format
FROM Account_Statements;

-- 3. Count how many statements are in each Format
SELECT Format, COUNT(*) AS Total
FROM Account_Statements
GROUP BY Format;

-- 4. Count how many statements are in each Status
SELECT Status, COUNT(*) AS Total
FROM Account_Statements
GROUP BY Status;

-- 5. Show average credits, debits, and balance across all accounts
SELECT AVG(Total_Credits) AS Avg_Credits,
       AVG(Total_Debits) AS Avg_Debits,
       AVG(Closing_Balance) AS Avg_Balance
FROM Account_Statements;

-- 6. Find account(s) with the maximum Closing_Balance
SELECT Account_ID, Closing_Balance
FROM Account_Statements
ORDER BY Closing_Balance DESC
LIMIT 1;

-- 7. Find account(s) with the minimum Closing_Balance
SELECT Account_ID, Closing_Balance
FROM Account_Statements
ORDER BY Closing_Balance ASC
LIMIT 1;

-- 8. Show total credits and debits grouped by Format
SELECT Format, SUM(Total_Credits) AS Total_Credits, SUM(Total_Debits) AS Total_Debits
FROM Account_Statements
GROUP BY Format;

-- 9. Show accounts where Closing_Balance > average Closing_Balance
SELECT Account_ID, Closing_Balance
FROM Account_Statements
WHERE Closing_Balance > (SELECT AVG(Closing_Balance) FROM Account_Statements);

-- 10. Show number of accounts with balance above 20,000 per format
SELECT Format, COUNT(*) AS Accounts_Above_20k
FROM Account_Statements
WHERE Closing_Balance > 20000
GROUP BY Format;



-- Table-19

CREATE TABLE Customer_Feedback (
    Feedback_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Feedback_Date DATE,
    Channel ENUM('Branch', 'Online', 'Mobile App', 'ATM'),
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comments TEXT,
    Response_Status ENUM('Pending', 'Acknowledged', 'Resolved'),
    Handled_By INT,
    Follow_Up_Date DATE,
    FOREIGN KEY (Customer_ID)
        REFERENCES Customers (Customer_ID),
    FOREIGN KEY (Handled_By)
        REFERENCES Employees (Employee_ID)
);


-- insert records into table-19
INSERT INTO Customer_Feedback 
(Customer_ID, Feedback_Date, Channel, Rating, Comments, Response_Status, Handled_By, Follow_Up_Date)
VALUES
(1, '2023-05-01', 'Online', 4, 'NetBanking was slow.', 'Acknowledged', 4, '2023-05-03'),
(2, '2023-04-15', 'Branch', 5, 'Excellent service at Malad branch.', 'Resolved', 3, '2023-04-16'),
(3, '2023-03-20', 'ATM', 3, 'ATM was out of cash.', 'Pending', NULL, NULL),
(4, '2023-06-10', 'Mobile App', 2, 'Frequent app crashes during login.', 'Acknowledged', 5, '2023-06-12'),
(5, '2023-01-05', 'Branch', 5, 'Helpful staff and clean premises.', 'Resolved', 2, '2023-01-06'),
(6, '2023-02-14', 'Online', 4, 'Smooth transaction process.', 'Resolved', 3, '2023-02-15'),
(7, '2023-03-05', 'ATM', 1, 'Card got stuck in ATM.', 'Acknowledged', 1, '2023-03-06'),
(8, '2023-04-22', 'Branch', 3, 'Long waiting time at counter.', 'Acknowledged', 2, '2023-04-23'),
(9, '2023-05-30', 'Mobile App', 4, 'App is user-friendly.', 'Resolved', 4, '2023-06-01'),
(10, '2023-06-25', 'Online', 5, 'Best banking experience.', 'Resolved', 5, '2023-06-26'),
(11, '2023-01-11', 'ATM', 2, 'ATM receipt not printed.', 'Pending', NULL, NULL),
(12, '2023-02-18', 'Mobile App', 4, 'Biometric login is fast.', 'Resolved', 2, '2023-02-19'),
(13, '2023-03-28', 'Branch', 3, 'Branch renovation ongoing.', 'Acknowledged', 1, '2023-03-29'),
(14, '2023-04-09', 'Online', 5, 'Love the new UPI interface.', 'Resolved', 4, '2023-04-10'),
(15, '2023-05-18', 'ATM', 1, 'Machine was not working.', 'Acknowledged', 3, '2023-05-19'),
(16, '2023-06-12', 'Mobile App', 2, 'Payment failed multiple times.', 'Pending', NULL, NULL),
(17, '2023-01-25', 'Online', 4, 'Quick OTP verification.', 'Resolved', 5, '2023-01-26'),
(18, '2023-02-07', 'Branch', 5, 'Very courteous staff.', 'Resolved', 2, '2023-02-08'),
(19, '2023-03-12', 'ATM', 2, 'ATM closed without notice.', 'Acknowledged', 1, '2023-03-13'),
(20, '2023-04-30', 'Mobile App', 5, 'Excellent performance.', 'Resolved', 4, '2023-05-01');


-- display table-19
select * from Customer_Feedback;

truncate table Customer_Feedback;

drop table Customer_Feedback;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. View all customer feedback
SELECT * FROM Customer_Feedback;

-- 2. Show only unresolved feedback (Pending + Acknowledged)
SELECT Feedback_ID, Customer_ID, Channel, Rating, Response_Status
FROM Customer_Feedback
WHERE Response_Status <> 'Resolved';

-- 3. Find feedbacks with lowest ratings (1 or 2)
SELECT Feedback_ID, Customer_ID, Channel, Rating, Comments
FROM Customer_Feedback
WHERE Rating <= 2;

-- 4. Count number of feedbacks received per channel
SELECT Channel, COUNT(*) AS Total_Feedbacks
FROM Customer_Feedback
GROUP BY Channel;

-- 5. Show customers who gave 5-star feedback
SELECT Customer_ID, Feedback_Date, Channel, Comments
FROM Customer_Feedback
WHERE Rating = 5;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column Feedback_Type
ALTER TABLE Customer_Feedback ADD COLUMN Feedback_Type ENUM('Complaint', 'Suggestion', 'Compliment');

-- 2. Modify Comments column length
ALTER TABLE Customer_Feedback MODIFY COLUMN Comments VARCHAR(500);

-- 3. Add column Resolved_Date
ALTER TABLE Customer_Feedback ADD COLUMN Resolved_Date DATE;

-- 4. Drop column Resolved_Date
ALTER TABLE Customer_Feedback DROP COLUMN Resolved_Date;

-- 5. Change column Comments to Feedback_Comments
ALTER TABLE Customer_Feedback CHANGE COLUMN Comments Feedback_Comments TEXT;


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Customer_Feedback to Feedback
RENAME TABLE Customer_Feedback TO Feedback;

-- 2. Rename table Feedback back to Customer_Feedback
RENAME TABLE Feedback TO Customer_Feedback;

-- 3. Rename Customer_Feedback to Client_Feedback
RENAME TABLE Customer_Feedback TO Client_Feedback;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update Response_Status for Feedback_ID = 3 to Acknowledged
UPDATE Client_Feedback
SET Response_Status = 'Acknowledged', Handled_By = 2, Follow_Up_Date = '2023-03-22'
WHERE Feedback_ID = 3;

-- 2. Change rating for Feedback_ID = 16 from 2 to 3
UPDATE Client_Feedback
SET Rating = 3
WHERE Feedback_ID = 16;

-- 3. Mark Feedback_ID = 11 as Resolved
UPDATE Client_Feedback
SET Response_Status = 'Resolved', Handled_By = 4, Follow_Up_Date = '2023-01-12'
WHERE Feedback_ID = 11;

-- 4. Update Feedback_Type for Feedback_ID = 7 to Complaint
UPDATE Client_Feedback
SET Feedback_Type = 'Complaint'
WHERE Feedback_ID = 7;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete feedbacks with Rating = 1
DELETE FROM Client_Feedback
WHERE Rating = 1;

-- 2. Delete all pending feedbacks
DELETE FROM Client_Feedback
WHERE Response_Status = 'Pending';

-- 3. Delete feedbacks submitted before February 2023
DELETE FROM Client_Feedback
WHERE Feedback_Date < '2023-02-01';

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all feedback where Rating = 5
SELECT Feedback_ID, Customer_ID, Rating, Comments
FROM Customer_Feedback
WHERE Rating = 5;

-- 2. Show feedbacks where Rating < 3
SELECT Feedback_ID, Channel, Rating, Comments
FROM Customer_Feedback
WHERE Rating < 3;

-- 3. Find feedbacks submitted through 'ATM'
SELECT Feedback_ID, Customer_ID, Channel, Comments
FROM Customer_Feedback
WHERE Channel = 'ATM';

-- 4. Show all feedbacks with Response_Status = 'Pending'
SELECT Feedback_ID, Customer_ID, Comments
FROM Customer_Feedback
WHERE Response_Status = 'Pending';

-- 5. Show feedbacks where Follow_Up_Date IS NULL
SELECT Feedback_ID, Customer_ID, Response_Status
FROM Customer_Feedback
WHERE Follow_Up_Date IS NULL;

-- 6. Show feedbacks given in May 2023
SELECT Feedback_ID, Customer_ID, Feedback_Date, Comments
FROM Customer_Feedback
WHERE MONTH(Feedback_Date) = 5 AND YEAR(Feedback_Date) = 2023;

-- 7. Find feedbacks handled by employee 4
SELECT Feedback_ID, Customer_ID, Handled_By, Response_Status
FROM Customer_Feedback
WHERE Handled_By = 4;

-- 8. Show feedbacks where Channel = 'Mobile App' AND Rating >= 4
SELECT Feedback_ID, Customer_ID, Rating, Comments
FROM Customer_Feedback
WHERE Channel = 'Mobile App' AND Rating >= 4;

-- 9. Find customers who gave Online feedback but Rating <= 3
SELECT Customer_ID, Rating, Comments
FROM Customer_Feedback
WHERE Channel = 'Online' AND Rating <= 3;

-- 10. Show feedbacks where Response_Status <> 'Resolved'
SELECT Feedback_ID, Customer_ID, Response_Status
FROM Customer_Feedback
WHERE Response_Status <> 'Resolved';



-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. List all feedback ordered by Rating (highest first)
SELECT Customer_ID, Channel, Rating, Comments
FROM Customer_Feedback
ORDER BY Rating DESC;

-- 2. Show distinct feedback channels used
SELECT DISTINCT Channel
FROM Customer_Feedback;

-- 3. Count feedback per Channel
SELECT Channel, COUNT(*) AS Total_Feedbacks
FROM Customer_Feedback
GROUP BY Channel;

-- 4. Count feedback by Response_Status
SELECT Response_Status, COUNT(*) AS Total
FROM Customer_Feedback
GROUP BY Response_Status;

-- 5. Show average rating for each Channel
SELECT Channel, AVG(Rating) AS Avg_Rating
FROM Customer_Feedback
GROUP BY Channel;

-- 6. Find the Channel with the maximum average rating
SELECT Channel, AVG(Rating) AS Avg_Rating
FROM Customer_Feedback
GROUP BY Channel
ORDER BY Avg_Rating DESC
LIMIT 1;

-- 7. Find the Channel with the lowest average rating
SELECT Channel, AVG(Rating) AS Avg_Rating
FROM Customer_Feedback
GROUP BY Channel
ORDER BY Avg_Rating ASC
LIMIT 1;

-- 8. Show the number of feedback handled by each employee
SELECT Handled_By, COUNT(*) AS Feedback_Count
FROM Customer_Feedback
WHERE Handled_By IS NOT NULL
GROUP BY Handled_By;

-- 9. Show average rating only for 'Resolved' feedbacks
SELECT AVG(Rating) AS Avg_Resolved_Rating
FROM Customer_Feedback
WHERE Response_Status = 'Resolved';

-- 10. Show total feedback given each month
SELECT DATE_FORMAT(Feedback_Date, '%Y-%m') AS Month, COUNT(*) AS Feedback_Count
FROM Customer_Feedback
GROUP BY DATE_FORMAT(Feedback_Date, '%Y-%m')
ORDER BY Month;



-- Table-20
CREATE TABLE Bill_Payments (
  Bill_ID INT PRIMARY KEY AUTO_INCREMENT,
  Account_ID INT NOT NULL,
  Biller_Name VARCHAR(100),
  Category ENUM('Electricity', 'Mobile', 'DTH', 'Gas', 'Internet'),
  Amount DECIMAL(10,2),
  Payment_Date DATE,
  Status ENUM('Successful', 'Failed', 'Pending'),
  Mode ENUM('NetBanking', 'UPI', 'Debit Card', 'Credit Card'),
  Reference_No VARCHAR(50),
  FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);

-- insert records into table-20
INSERT INTO Bill_Payments (Account_ID, Biller_Name, Category, Amount, Payment_Date, Status, Mode, Reference_No) VALUES
(1, 'MSEDCL', 'Electricity', 1450.50, '2024-06-05', 'Successful', 'NetBanking', 'BILLREF1001'),
(2, 'Airtel Postpaid', 'Mobile', 599.00, '2024-06-10', 'Successful', 'UPI', 'BILLREF1002'),
(3, 'Tata Sky', 'DTH', 350.00, '2024-06-12', 'Successful', 'Debit Card', 'BILLREF1003'),
(4, 'Adani Gas', 'Gas', 980.75, '2024-06-15', 'Successful', 'NetBanking', 'BILLREF1004'),
(5, 'ACT Fibernet', 'Internet', 1150.00, '2024-06-17', 'Successful', 'Credit Card', 'BILLREF1005'),
(6, 'BEST Electric', 'Electricity', 1300.00, '2024-06-18', 'Successful', 'UPI', 'BILLREF1006'),
(7, 'Vodafone Idea', 'Mobile', 499.00, '2024-06-20', 'Successful', 'UPI', 'BILLREF1007'),
(8, 'Dish TV', 'DTH', 400.00, '2024-06-21', 'Successful', 'Debit Card', 'BILLREF1008'),
(9, 'Mahanagar Gas', 'Gas', 870.60, '2024-06-22', 'Successful', 'NetBanking', 'BILLREF1009'),
(10, 'Jio Fiber', 'Internet', 999.00, '2024-06-23', 'Successful', 'Credit Card', 'BILLREF1010'),
(11, 'TNEB', 'Electricity', 1225.00, '2024-06-24', 'Successful', 'UPI', 'BILLREF1011'),
(12, 'BSNL Mobile', 'Mobile', 429.00, '2024-06-25', 'Successful', 'UPI', 'BILLREF1012'),
(13, 'Sun Direct', 'DTH', 320.00, '2024-06-25', 'Pending', 'Debit Card', 'BILLREF1013'),
(14, 'Indraprastha Gas', 'Gas', 890.20, '2024-06-26', 'Successful', 'NetBanking', 'BILLREF1014'),
(15, 'Excitel Broadband', 'Internet', 850.00, '2024-06-26', 'Successful', 'Credit Card', 'BILLREF1015'),
(16, 'Torrent Power', 'Electricity', 1510.00, '2024-06-27', 'Successful', 'UPI', 'BILLREF1016'),
(17, 'Jio Postpaid', 'Mobile', 699.00, '2024-06-27', 'Failed', 'UPI', 'BILLREF1017'),
(18, 'Airtel DTH', 'DTH', 390.00, '2024-06-28', 'Successful', 'Debit Card', 'BILLREF1018'),
(19, 'HP Gas', 'Gas', 930.00, '2024-06-28', 'Successful', 'NetBanking', 'BILLREF1019'),
(20, 'Hathway Internet', 'Internet', 1049.00, '2024-06-29', 'Successful', 'Credit Card', 'BILLREF1020');


-- display table-20
select * from Bill_Payments;

truncate table Bill_Payments;

drop table Bill_Payments;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. View all bill payments
SELECT * FROM Bill_Payments;

-- 2. Show only failed or pending payments
SELECT Bill_ID, Account_ID, Biller_Name, Category, Amount, Status
FROM Bill_Payments
WHERE Status IN ('Failed', 'Pending');

-- 3. Find highest bill amount paid
SELECT Bill_ID, Account_ID, Biller_Name, Category, Amount, Payment_Date
FROM Bill_Payments
ORDER BY Amount DESC
LIMIT 1;

-- 4. Count number of payments by category
SELECT Category, COUNT(*) AS Total_Payments
FROM Bill_Payments
GROUP BY Category;

-- 5. Total amount spent via UPI
SELECT SUM(Amount) AS Total_UPI_Payments
FROM Bill_Payments
WHERE Mode = 'UPI';


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column Late_Fee
ALTER TABLE Bill_Payments ADD COLUMN Late_Fee DECIMAL(10,2) DEFAULT 0.00;

-- 2. Modify Biller_Name length
ALTER TABLE Bill_Payments MODIFY COLUMN Biller_Name VARCHAR(150);

-- 3. Add column Due_Date
ALTER TABLE Bill_Payments ADD COLUMN Due_Date DATE;

-- 4. Drop column Due_Date
ALTER TABLE Bill_Payments DROP COLUMN Due_Date;

-- 5. Change column Reference_No to Payment_Reference
ALTER TABLE Bill_Payments CHANGE COLUMN Reference_No Payment_Reference VARCHAR(50);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Bill_Payments to Payments
RENAME TABLE Bill_Payments TO Payments;

-- 2. Rename table Payments back to Bill_Payments
RENAME TABLE Payments TO Bill_Payments;

-- 3. Rename Bill_Payments to Utility_Bill_Payments
RENAME TABLE Bill_Payments TO Utility_Bill_Payments;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update status of Bill_ID = 13 from Pending to Successful
UPDATE Utility_Bill_Payments
SET Status = 'Successful'
WHERE Bill_ID = 13;

-- 2. Update mode of Bill_ID = 17 from UPI to NetBanking
UPDATE Utility_Bill_Payments
SET Mode = 'NetBanking'
WHERE Bill_ID = 17;

-- 3. Add Late_Fee of 50 for Bill_ID = 11
UPDATE Utility_Bill_Payments
SET Late_Fee = 50.00
WHERE Bill_ID = 11;

-- 4. Correct biller name for Bill_ID = 5
UPDATE Utility_Bill_Payments
SET Biller_Name = 'ACT Broadband'
WHERE Bill_ID = 5;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete all failed payments
DELETE FROM Utility_Bill_Payments
WHERE Status = 'Failed';

-- 2. Delete payments less than 400
DELETE FROM Utility_Bill_Payments
WHERE Amount < 400;

-- 3. Delete all payments made before June 15, 2024
DELETE FROM Utility_Bill_Payments
WHERE Payment_Date < '2024-06-15';

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all successful bill payments
SELECT Bill_ID, Biller_Name, Amount, Mode
FROM Bill_Payments
WHERE Status = 'Successful';

-- 2. Show payments with Amount > 1000
SELECT Bill_ID, Biller_Name, Amount
FROM Bill_Payments
WHERE Amount > 1000;

-- 3. Show bill payments made using UPI
SELECT Bill_ID, Account_ID, Biller_Name, Amount
FROM Bill_Payments
WHERE Mode = 'UPI';

-- 4. Show all failed bill payments
SELECT Bill_ID, Account_ID, Biller_Name, Amount, Status
FROM Bill_Payments
WHERE Status = 'Failed';

-- 5. Find payments where Category = 'Electricity'
SELECT Bill_ID, Biller_Name, Amount
FROM Bill_Payments
WHERE Category = 'Electricity';

-- 6. Find payments where Category = 'Mobile' AND Amount < 600
SELECT Bill_ID, Biller_Name, Amount
FROM Bill_Payments
WHERE Category = 'Mobile' AND Amount < 600;

-- 7. Find payments where Payment_Date BETWEEN '2024-06-20' AND '2024-06-25'
SELECT Bill_ID, Biller_Name, Amount, Payment_Date
FROM Bill_Payments
WHERE Payment_Date BETWEEN '2024-06-20' AND '2024-06-25';

-- 8. Show payments where Status <> 'Successful'
SELECT Bill_ID, Biller_Name, Status
FROM Bill_Payments
WHERE Status <> 'Successful';

-- 9. Show all billers whose names start with 'Jio'
SELECT Bill_ID, Biller_Name, Amount
FROM Bill_Payments
WHERE Biller_Name LIKE 'Jio%';

-- 10. Show all Internet payments that are not made by Credit Card
SELECT Bill_ID, Biller_Name, Amount, Mode
FROM Bill_Payments
WHERE Category = 'Internet' AND Mode <> 'Credit Card';



-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. List all bill payments ordered by Amount (highest first)
SELECT Bill_ID, Biller_Name, Amount
FROM Bill_Payments
ORDER BY Amount DESC;

-- 2. Show distinct categories of bills paid
SELECT DISTINCT Category
FROM Bill_Payments;

-- 3. Count total bills paid by each payment Mode
SELECT Mode, COUNT(*) AS Total_Payments
FROM Bill_Payments
GROUP BY Mode;

-- 4. Count number of payments in each Category
SELECT Category, COUNT(*) AS Total_Bills
FROM Bill_Payments
GROUP BY Category;

-- 5. Show average payment amount by Category
SELECT Category, AVG(Amount) AS Avg_Amount
FROM Bill_Payments
GROUP BY Category;

-- 6. Find the Category with the maximum average bill amount
SELECT Category, AVG(Amount) AS Avg_Amount
FROM Bill_Payments
GROUP BY Category
ORDER BY Avg_Amount DESC
LIMIT 1;

-- 7. Find the Category with the minimum average bill amount
SELECT Category, AVG(Amount) AS Avg_Amount
FROM Bill_Payments
GROUP BY Category
ORDER BY Avg_Amount ASC
LIMIT 1;

-- 8. Show total payment amount collected via each Mode
SELECT Mode, SUM(Amount) AS Total_Amount
FROM Bill_Payments
WHERE Status = 'Successful'
GROUP BY Mode;

-- 9. Show number of bills paid per day
SELECT Payment_Date, COUNT(*) AS Total_Bills
FROM Bill_Payments
GROUP BY Payment_Date
ORDER BY Payment_Date;

-- 10. Show maximum bill amount for each Category
SELECT Category, MAX(Amount) AS Max_Bill
FROM Bill_Payments
GROUP BY Category;



-- Table-21
CREATE TABLE Safe_Deposit_Visits (
  Visit_ID INT PRIMARY KEY AUTO_INCREMENT,
  Locker_ID INT NOT NULL,
  Customer_ID INT NOT NULL,
  Visit_Date DATE,
  Time_In TIME,
  Time_Out TIME,
  Verified_By_Employee INT,
  Purpose VARCHAR(100),
  Comments TEXT,
  FOREIGN KEY (Locker_ID) REFERENCES Lockers(Locker_ID),
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
  FOREIGN KEY (Verified_By_Employee) REFERENCES Employees(Employee_ID)
);

-- insert records into table-21
INSERT INTO Safe_Deposit_Visits (Locker_ID, Customer_ID, Visit_Date, Time_In, Time_Out, Verified_By_Employee, Purpose, Comments) VALUES
(1, 1, '2024-06-01', '10:00:00', '10:20:00', 1, 'Document Storage', 'Routine check'),
(2, 2, '2024-06-03', '11:15:00', '11:35:00', 2, 'Jewellery Deposit', 'Family visit'),
(3, 3, '2024-06-05', '12:00:00', '12:30:00', 3, 'Important Papers', 'Locker cleaned'),
(4, 4, '2024-06-06', '09:45:00', '10:10:00', 4, 'Valuable Deposit', 'Added new documents'),
(5, 5, '2024-06-07', '14:00:00', '14:25:00', 5, 'Passport Storage', 'Routine access'),
(6, 6, '2024-06-08', '15:30:00', '15:50:00', 6, 'Property Papers', 'Updated items'),
(7, 7, '2024-06-10', '16:10:00', '16:40:00', 7, 'Cash Deposit', 'Confidential'),
(8, 8, '2024-06-11', '10:30:00', '10:50:00', 8, 'Ornaments Check', 'No issues'),
(9, 9, '2024-06-13', '13:20:00', '13:45:00', 9, 'Legal Papers', 'Reviewed contents'),
(10, 10, '2024-06-14', '11:00:00', '11:25:00', 10, 'Title Deeds', 'Routine'),
(1, 11, '2024-06-15', '09:30:00', '09:50:00', 1, 'Storage Update', 'Added documents'),
(2, 12, '2024-06-16', '12:10:00', '12:35:00', 2, 'Gold Deposit', 'Increased value'),
(3, 13, '2024-06-17', '13:00:00', '13:30:00', 3, 'Insurance Files', 'Rearranged papers'),
(4, 14, '2024-06-18', '15:00:00', '15:25:00', 4, 'Jewellery Safety', 'Checked inventory'),
(5, 15, '2024-06-19', '10:00:00', '10:20:00', 5, 'Bank Papers', 'Added legal forms'),
(6, 16, '2024-06-20', '11:10:00', '11:35:00', 6, 'Family Jewels', 'Locker secured'),
(7, 17, '2024-06-21', '12:45:00', '13:05:00', 7, 'Documents Storage', 'Files sorted'),
(8, 18, '2024-06-22', '14:30:00', '14:50:00', 8, 'Education Certificates', 'Scanned items'),
(9, 19, '2024-06-23', '09:50:00', '10:15:00', 9, 'Investment Papers', 'Review done'),
(10, 20, '2024-06-24', '11:45:00', '12:10:00', 10, 'Confidential Docs', 'Sealed items');


-- display table-21
select * from Safe_Deposit_Visits;

truncate table Safe_Deposit_Visits;

drop table Safe_Deposit_Visits;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. View all visits
SELECT * FROM Safe_Deposit_Visits;

-- 2. Show visits verified by employee 5
SELECT Visit_ID, Locker_ID, Customer_ID, Visit_Date, Purpose
FROM Safe_Deposit_Visits
WHERE Verified_By_Employee = 5;

-- 3. Count number of visits per locker
SELECT Locker_ID, COUNT(*) AS Total_Visits
FROM Safe_Deposit_Visits
GROUP BY Locker_ID;

-- 4. Show visits where Time_Out - Time_In was more than 20 minutes
SELECT Visit_ID, Locker_ID, Customer_ID, 
       TIMEDIFF(Time_Out, Time_In) AS Duration
FROM Safe_Deposit_Visits
WHERE TIMEDIFF(Time_Out, Time_In) > '00:20:00';

-- 5. Find the latest visit
SELECT *
FROM Safe_Deposit_Visits
ORDER BY Visit_Date DESC, Time_In DESC
LIMIT 1;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column Visit_Type
ALTER TABLE Safe_Deposit_Visits ADD COLUMN Visit_Type ENUM('Personal', 'Family', 'Business') DEFAULT 'Personal';

-- 2. Modify Purpose length
ALTER TABLE Safe_Deposit_Visits MODIFY COLUMN Purpose VARCHAR(200);

-- 3. Add column Security_Code
ALTER TABLE Safe_Deposit_Visits ADD COLUMN Security_Code VARCHAR(20);

-- 4. Drop column Comments
ALTER TABLE Safe_Deposit_Visits DROP COLUMN Comments;

-- 5. Change column Visit_Date to Access_Date
ALTER TABLE Safe_Deposit_Visits CHANGE COLUMN Visit_Date Access_Date DATE;


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Safe_Deposit_Visits to Locker_Visits
RENAME TABLE Safe_Deposit_Visits TO Locker_Visits;

-- 2. Rename table Locker_Visits back to Safe_Deposit_Visits
RENAME TABLE Locker_Visits TO Safe_Deposit_Visits;

-- 3. Rename Safe_Deposit_Visits to Customer_Locker_Visits
RENAME TABLE Safe_Deposit_Visits TO Customer_Locker_Visits;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update Purpose of Visit_ID = 7
UPDATE Customer_Locker_Visits
SET Purpose = 'Cash & Documents Storage'
WHERE Visit_ID = 7;

-- 2. Update Visit_Type for Visit_ID = 2 to Family
UPDATE Customer_Locker_Visits
SET Visit_Type = 'Family'
WHERE Visit_ID = 2;

-- 3. Assign Security_Code for Visit_ID = 10
UPDATE Customer_Locker_Visits
SET Security_Code = 'SEC12345'
WHERE Visit_ID = 10;

-- 4. Update Purpose of Visit_ID = 15
UPDATE Customer_Locker_Visits
SET Purpose = 'Legal & Bank Papers'
WHERE Visit_ID = 15;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete visits before June 5, 2024
DELETE FROM Customer_Locker_Visits
WHERE Access_Date < '2024-06-05';

-- 2. Delete visits verified by employee 3
DELETE FROM Customer_Locker_Visits
WHERE Verified_By_Employee = 3;

-- 3. Delete all visits with duration less than 15 minutes
DELETE FROM Customer_Locker_Visits
WHERE TIMEDIFF(Time_Out, Time_In) < '00:15:00';

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all visits by Customer_ID = 1
SELECT * 
FROM Safe_Deposit_Visits
WHERE Customer_ID = 1;

-- 2. Find visits that happened after '2024-06-15'
SELECT Visit_ID, Customer_ID, Visit_Date
FROM Safe_Deposit_Visits
WHERE Visit_Date > '2024-06-15';

-- 3. Show all visits verified by Employee_ID = 5
SELECT Visit_ID, Locker_ID, Customer_ID, Visit_Date
FROM Safe_Deposit_Visits
WHERE Verified_By_Employee = 5;

-- 4. Find visits where Purpose = 'Jewellery Deposit'
SELECT Visit_ID, Customer_ID, Visit_Date, Purpose
FROM Safe_Deposit_Visits
WHERE Purpose = 'Jewellery Deposit';

-- 5. Show all visits between 10:00 AM and 12:00 PM
SELECT Visit_ID, Customer_ID, Time_In, Time_Out
FROM Safe_Deposit_Visits
WHERE Time_In BETWEEN '10:00:00' AND '12:00:00';

-- 6. Find visits where Purpose contains 'Documents'
SELECT Visit_ID, Customer_ID, Purpose
FROM Safe_Deposit_Visits
WHERE Purpose LIKE '%Document%';

-- 7. Show visits where duration > 25 minutes
SELECT Visit_ID, Customer_ID, 
       TIMESTAMPDIFF(MINUTE, Time_In, Time_Out) AS Duration_Minutes
FROM Safe_Deposit_Visits
WHERE TIMESTAMPDIFF(MINUTE, Time_In, Time_Out) > 25;

-- 8. Show visits where Comments IS NOT NULL
SELECT Visit_ID, Customer_ID, Purpose, Comments
FROM Safe_Deposit_Visits
WHERE Comments IS NOT NULL;

-- 9. Show visits where Locker_ID IN (1, 2, 3)
SELECT Visit_ID, Locker_ID, Customer_ID, Visit_Date
FROM Safe_Deposit_Visits
WHERE Locker_ID IN (1, 2, 3);

-- 10. Show visits where Verified_By_Employee <> 1
SELECT Visit_ID, Customer_ID, Verified_By_Employee
FROM Safe_Deposit_Visits
WHERE Verified_By_Employee <> 1;



-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. List all visits ordered by Visit_Date
SELECT Visit_ID, Customer_ID, Visit_Date
FROM Safe_Deposit_Visits
ORDER BY Visit_Date;

-- 2. Show distinct purposes of locker visits
SELECT DISTINCT Purpose
FROM Safe_Deposit_Visits;

-- 3. Count number of visits per Locker
SELECT Locker_ID, COUNT(*) AS Total_Visits
FROM Safe_Deposit_Visits
GROUP BY Locker_ID;

-- 4. Count visits verified by each employee
SELECT Verified_By_Employee, COUNT(*) AS Total_Verifications
FROM Safe_Deposit_Visits
GROUP BY Verified_By_Employee;

-- 5. Find the locker with the maximum number of visits
SELECT Locker_ID, COUNT(*) AS Visit_Count
FROM Safe_Deposit_Visits
GROUP BY Locker_ID
ORDER BY Visit_Count DESC
LIMIT 1;

-- 6. Show average visit duration (minutes) per Locker
SELECT Locker_ID, AVG(TIMESTAMPDIFF(MINUTE, Time_In, Time_Out)) AS Avg_Duration
FROM Safe_Deposit_Visits
GROUP BY Locker_ID;

-- 7. Show max visit duration per Locker
SELECT Locker_ID, MAX(TIMESTAMPDIFF(MINUTE, Time_In, Time_Out)) AS Max_Duration
FROM Safe_Deposit_Visits
GROUP BY Locker_ID;

-- 8. Show number of visits per day
SELECT Visit_Date, COUNT(*) AS Total_Visits
FROM Safe_Deposit_Visits
GROUP BY Visit_Date
ORDER BY Visit_Date;

-- 9. Show lockers that were accessed by more than 1 customer
SELECT Locker_ID, COUNT(DISTINCT Customer_ID) AS Unique_Customers
FROM Safe_Deposit_Visits
GROUP BY Locker_ID
HAVING COUNT(DISTINCT Customer_ID) > 1;

-- 10. Show employees who verified more than 2 visits
SELECT Verified_By_Employee, COUNT(*) AS Verified_Visits
FROM Safe_Deposit_Visits
GROUP BY Verified_By_Employee
HAVING COUNT(*) > 2;


-- Table-22
CREATE TABLE Mobile_Banking (
  MB_ID INT PRIMARY KEY AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  Registered_Mobile CHAR(10),
  Device_Model VARCHAR(50),
  OS_Type ENUM('Android', 'iOS'),
  App_Version VARCHAR(10),
  Last_Login DATETIME,
  OTP_Enabled BOOLEAN,
  Biometric_Enabled BOOLEAN,
  App_Status ENUM('Active', 'Inactive'),
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- insert records into table-22
INSERT INTO Mobile_Banking (Customer_ID, Registered_Mobile, Device_Model, OS_Type, App_Version, Last_Login, OTP_Enabled, Biometric_Enabled, App_Status) VALUES
(1, '9876543210', 'Samsung Galaxy S21', 'Android', 'v4.5.1', '2024-07-10 14:23:00', TRUE, TRUE, 'Active'),
(2, '9123456789', 'iPhone 13', 'iOS', 'v4.5.2', '2024-07-12 10:15:00', TRUE, FALSE, 'Active'),
(3, '9988776655', 'OnePlus 9', 'Android', 'v4.4.9', '2024-07-09 18:40:00', TRUE, TRUE, 'Active'),
(4, '8877665544', 'Redmi Note 11', 'Android', 'v4.5.0', '2024-07-11 09:50:00', TRUE, TRUE, 'Active'),
(5, '9765432109', 'iPhone SE', 'iOS', 'v4.5.3', '2024-07-08 12:00:00', TRUE, FALSE, 'Inactive'),
(6, '9345678912', 'Realme 8 Pro', 'Android', 'v4.5.1', '2024-07-13 08:10:00', TRUE, TRUE, 'Active'),
(7, '9012345678', 'Samsung M33', 'Android', 'v4.4.8', '2024-07-12 19:20:00', TRUE, FALSE, 'Active'),
(8, '8899776655', 'iPhone XR', 'iOS', 'v4.5.2', '2024-07-10 13:30:00', TRUE, TRUE, 'Active'),
(9, '7890654321', 'Motorola G71', 'Android', 'v4.5.0', '2024-07-11 15:45:00', TRUE, TRUE, 'Active'),
(10, '8654321098', 'iPhone 12', 'iOS', 'v4.5.3', '2024-07-12 10:00:00', TRUE, FALSE, 'Inactive'),
(11, '9745612345', 'Vivo V25', 'Android', 'v4.4.7', '2024-07-13 11:00:00', TRUE, TRUE, 'Active'),
(12, '9090909090', 'iPhone 11', 'iOS', 'v4.5.1', '2024-07-13 16:30:00', TRUE, TRUE, 'Active'),
(13, '8812345678', 'Samsung A52', 'Android', 'v4.5.0', '2024-07-12 14:00:00', TRUE, FALSE, 'Active'),
(14, '9123678912', 'OnePlus Nord', 'Android', 'v4.5.1', '2024-07-11 09:15:00', TRUE, TRUE, 'Active'),
(15, '9312345678', 'iPhone 14', 'iOS', 'v4.5.2', '2024-07-13 18:40:00', TRUE, TRUE, 'Active'),
(16, '8877456123', 'Redmi Note 12', 'Android', 'v4.5.1', '2024-07-13 07:50:00', TRUE, FALSE, 'Active'),
(17, '9001234567', 'Realme Narzo 50', 'Android', 'v4.4.9', '2024-07-10 20:00:00', TRUE, TRUE, 'Active'),
(18, '8754321098', 'iPhone XS', 'iOS', 'v4.5.2', '2024-07-11 22:30:00', TRUE, TRUE, 'Inactive'),
(19, '9654321098', 'Samsung M13', 'Android', 'v4.5.1', '2024-07-13 06:00:00', TRUE, TRUE, 'Active'),
(20, '9988123456', 'iPhone 15', 'iOS', 'v4.5.3', '2024-07-13 17:45:00', TRUE, TRUE, 'Active');



-- display table-22
select * from Mobile_Banking;

truncate table Mobile_Banking;

drop table Mobile_Banking;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. View all mobile banking records
SELECT * FROM Mobile_Banking;

-- 2. Show only iOS users who have biometric enabled
SELECT MB_ID, Customer_ID, Registered_Mobile, Device_Model
FROM Mobile_Banking
WHERE OS_Type = 'iOS' AND Biometric_Enabled = TRUE;

-- 3. Count number of users per OS type
SELECT OS_Type, COUNT(*) AS Total_Users
FROM Mobile_Banking
GROUP BY OS_Type;

-- 4. Find users who last logged in after '2024-07-12'
SELECT Customer_ID, Registered_Mobile, Last_Login
FROM Mobile_Banking
WHERE Last_Login > '2024-07-12 00:00:00';

-- 5. Show active users who don’t have biometric enabled
SELECT MB_ID, Customer_ID, Device_Model, OS_Type
FROM Mobile_Banking
WHERE App_Status = 'Active' AND Biometric_Enabled = FALSE;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column Login_Attempts
ALTER TABLE Mobile_Banking ADD COLUMN Login_Attempts INT DEFAULT 0;

-- 2. Modify App_Version to VARCHAR(20)
ALTER TABLE Mobile_Banking MODIFY COLUMN App_Version VARCHAR(20);

-- 3. Add column Push_Notifications
ALTER TABLE Mobile_Banking ADD COLUMN Push_Notifications BOOLEAN DEFAULT TRUE;

-- 4. Drop column Device_Model
ALTER TABLE Mobile_Banking DROP COLUMN Device_Model;

-- 5. Change column Registered_Mobile to Mobile_Number
ALTER TABLE Mobile_Banking CHANGE COLUMN Registered_Mobile Mobile_Number CHAR(10);


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Mobile_Banking to MB_Users
RENAME TABLE Mobile_Banking TO MB_Users;

-- 2. Rename table MB_Users back to Mobile_Banking
RENAME TABLE MB_Users TO Mobile_Banking;

-- 3. Rename Mobile_Banking to Digital_Banking_Mobile
RENAME TABLE Mobile_Banking TO Digital_Banking_Mobile;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update App_Status of MB_ID = 5 to Active
UPDATE Digital_Banking_Mobile
SET App_Status = 'Active'
WHERE MB_ID = 5;

-- 2. Update App_Version of iOS users to v4.6.0
UPDATE Digital_Banking_Mobile
SET App_Version = 'v4.6.0'
WHERE OS_Type = 'iOS';

-- 3. Increment Login_Attempts for MB_ID = 10
UPDATE Digital_Banking_Mobile
SET Login_Attempts = Login_Attempts + 1
WHERE MB_ID = 10;

-- 4. Disable Push_Notifications for MB_ID = 15
UPDATE Digital_Banking_Mobile
SET Push_Notifications = FALSE
WHERE MB_ID = 15;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete inactive users
DELETE FROM Digital_Banking_Mobile
WHERE App_Status = 'Inactive';

-- 2. Delete users with App_Version older than 'v4.5.0'
DELETE FROM Digital_Banking_Mobile
WHERE App_Version < 'v4.5.0';

-- 3. Delete records where biometric is not enabled
DELETE FROM Digital_Banking_Mobile
WHERE Biometric_Enabled = FALSE;

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all active mobile banking users
SELECT MB_ID, Customer_ID, Registered_Mobile, App_Status
FROM Mobile_Banking
WHERE App_Status = 'Active';

-- 2. Find all iOS users
SELECT Customer_ID, Device_Model, OS_Type
FROM Mobile_Banking
WHERE OS_Type = 'iOS';

-- 3. Show customers who have OTP enabled but not Biometric
SELECT Customer_ID, Registered_Mobile, OTP_Enabled, Biometric_Enabled
FROM Mobile_Banking
WHERE OTP_Enabled = TRUE AND Biometric_Enabled = FALSE;

-- 4. Show users with App_Version less than 'v4.5.0'
SELECT Customer_ID, Device_Model, App_Version
FROM Mobile_Banking
WHERE App_Version < 'v4.5.0';

-- 5. Find users who logged in after '2024-07-12'
SELECT Customer_ID, Last_Login
FROM Mobile_Banking
WHERE Last_Login > '2024-07-12 00:00:00';

-- 6. Show customers with Samsung devices
SELECT Customer_ID, Device_Model
FROM Mobile_Banking
WHERE Device_Model LIKE '%Samsung%';

-- 7. Find inactive users
SELECT Customer_ID, Registered_Mobile, App_Status
FROM Mobile_Banking
WHERE App_Status = 'Inactive';

-- 8. Show customers with App_Version IN ('v4.4.7', 'v4.4.8', 'v4.4.9')
SELECT Customer_ID, App_Version
FROM Mobile_Banking
WHERE App_Version IN ('v4.4.7', 'v4.4.8', 'v4.4.9');

-- 9. Find Android users without biometric authentication
SELECT Customer_ID, Device_Model, OS_Type, Biometric_Enabled
FROM Mobile_Banking
WHERE OS_Type = 'Android' AND Biometric_Enabled = FALSE;

-- 10. Show customers who logged in between '2024-07-10' and '2024-07-12'
SELECT Customer_ID, Last_Login
FROM Mobile_Banking
WHERE Last_Login BETWEEN '2024-07-10 00:00:00' AND '2024-07-12 23:59:59';



-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Count total active vs inactive users
SELECT App_Status, COUNT(*) AS Total_Users
FROM Mobile_Banking
GROUP BY App_Status;

-- 2. Count Android vs iOS users
SELECT OS_Type, COUNT(*) AS Total_Users
FROM Mobile_Banking
GROUP BY OS_Type;

-- 3. Find the latest login per OS_Type
SELECT OS_Type, MAX(Last_Login) AS Latest_Login
FROM Mobile_Banking
GROUP BY OS_Type;

-- 4. Find the earliest login per App_Status
SELECT App_Status, MIN(Last_Login) AS First_Login
FROM Mobile_Banking
GROUP BY App_Status;

-- 5. Count how many users are using each app version
SELECT App_Version, COUNT(*) AS Total_Users
FROM Mobile_Banking
GROUP BY App_Version
ORDER BY App_Version;

-- 6. Find how many users enabled both OTP and Biometric
SELECT COUNT(*) AS Secure_Users
FROM Mobile_Banking
WHERE OTP_Enabled = TRUE AND Biometric_Enabled = TRUE;

-- 7. Show all devices ordered by Last_Login (latest first)
SELECT Customer_ID, Device_Model, Last_Login
FROM Mobile_Banking
ORDER BY Last_Login DESC;

-- 8. Count how many active users use iOS
SELECT OS_Type, COUNT(*) AS Active_iOS_Users
FROM Mobile_Banking
WHERE App_Status = 'Active' AND OS_Type = 'iOS'
GROUP BY OS_Type;

-- 9. Show customers grouped by OTP enabled status
SELECT OTP_Enabled, COUNT(*) AS Total_Users
FROM Mobile_Banking
GROUP BY OTP_Enabled;

-- 10. Find OS_Type that has more than 5 active users
SELECT OS_Type, COUNT(*) AS Active_Users
FROM Mobile_Banking
WHERE App_Status = 'Active'
GROUP BY OS_Type
HAVING COUNT(*) > 5;



-- Table-23
CREATE TABLE UPI_Transactions (
  UPI_ID INT PRIMARY KEY AUTO_INCREMENT,
  Sender_VPA VARCHAR(50),
  Receiver_VPA VARCHAR(50),
  Transaction_Date DATETIME,
  Amount DECIMAL(10,2),
  Status ENUM('Success', 'Failed', 'Pending'),
  Reference_No VARCHAR(50) UNIQUE,
  Bank_Name VARCHAR(50),
  Transaction_Type ENUM('Send', 'Receive'),
  Linked_Account_ID INT,
  FOREIGN KEY (Linked_Account_ID) REFERENCES Accounts(Account_ID)
);

-- insert records into table-23
INSERT INTO UPI_Transactions (Sender_VPA, Receiver_VPA, Transaction_Date, Amount, Status, Reference_No, Bank_Name, Transaction_Type, Linked_Account_ID) VALUES
('rahul@ybl', 'amazon@icici', '2024-07-10 14:45:00', 1249.50, 'Success', 'UPIREF1001', 'HDFC Bank', 'Send', 1),
('sneha@oksbi', 'flipkart@axis', '2024-07-11 16:30:00', 850.00, 'Success', 'UPIREF1002', 'SBI', 'Send', 2),
('amit@okaxis', 'zomato@hdfc', '2024-07-12 19:10:00', 350.25, 'Success', 'UPIREF1003', 'Axis Bank', 'Send', 3),
('neha@ybl', 'paytm@icici', '2024-07-13 08:20:00', 199.00, 'Success', 'UPIREF1004', 'HDFC Bank', 'Send', 4),
('karan@oksbi', 'swiggy@ybl', '2024-07-10 21:50:00', 489.75, 'Success', 'UPIREF1005', 'SBI', 'Send', 5),
('ravi@okaxis', 'rahul@ybl', '2024-07-11 10:00:00', 1000.00, 'Success', 'UPIREF1006', 'Axis Bank', 'Receive', 6),
('priya@ybl', 'myntra@hdfc', '2024-07-11 11:10:00', 1299.00, 'Success', 'UPIREF1007', 'HDFC Bank', 'Send', 7),
('deepak@okhdfc', 'neha@ybl', '2024-07-12 12:30:00', 850.00, 'Success', 'UPIREF1008', 'HDFC Bank', 'Receive', 8),
('ramesh@ybl', 'bigbasket@icici', '2024-07-12 14:00:00', 575.45, 'Success', 'UPIREF1009', 'ICICI Bank', 'Send', 9),
('ankita@oksbi', 'snapdeal@hdfc', '2024-07-13 13:15:00', 700.00, 'Success', 'UPIREF1010', 'SBI', 'Send', 10),
('manoj@ybl', 'rahul@okaxis', '2024-07-13 18:30:00', 200.00, 'Failed', 'UPIREF1011', 'HDFC Bank', 'Send', 11),
('suman@okaxis', 'electricity@upi', '2024-07-10 15:50:00', 1320.00, 'Success', 'UPIREF1012', 'Axis Bank', 'Send', 12),
('meena@ybl', 'gas@upi', '2024-07-10 16:40:00', 945.75, 'Success', 'UPIREF1013', 'HDFC Bank', 'Send', 13),
('raj@okhdfc', 'rent@upi', '2024-07-11 09:00:00', 8000.00, 'Success', 'UPIREF1014', 'HDFC Bank', 'Send', 14),
('sana@oksbi', 'loan@upi', '2024-07-11 11:30:00', 5600.00, 'Pending', 'UPIREF1015', 'SBI', 'Send', 15),
('akash@okaxis', 'anu@ybl', '2024-07-12 13:50:00', 1200.00, 'Success', 'UPIREF1016', 'Axis Bank', 'Send', 16),
('deepa@ybl', 'grocery@upi', '2024-07-12 17:25:00', 2150.50, 'Success', 'UPIREF1017', 'HDFC Bank', 'Send', 17),
('shyam@oksbi', 'movie@upi', '2024-07-13 10:10:00', 450.00, 'Success', 'UPIREF1018', 'SBI', 'Send', 18),
('nidhi@okaxis', 'anu@ybl', '2024-07-13 19:00:00', 750.00, 'Success', 'UPIREF1019', 'Axis Bank', 'Send', 19),
('rohit@ybl', 'ravi@oksbi', '2024-07-13 20:45:00', 980.00, 'Success', 'UPIREF1020', 'HDFC Bank', 'Send', 20);


-- display table-23
select * from UPI_Transactions;


truncate table UPI_Transactions;

drop table UPI_Transactions;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. View all UPI transactions
SELECT * FROM UPI_Transactions;

-- 2. Show only failed transactions
SELECT UPI_ID, Sender_VPA, Receiver_VPA, Amount, Transaction_Date
FROM UPI_Transactions
WHERE Status = 'Failed';

-- 3. Get total transaction amount grouped by bank
SELECT Bank_Name, SUM(Amount) AS Total_Amount
FROM UPI_Transactions
GROUP BY Bank_Name;

-- 4. Find highest transaction amount and its details
SELECT *
FROM UPI_Transactions
ORDER BY Amount DESC
LIMIT 1;

-- 5. List all pending transactions
SELECT Reference_No, Sender_VPA, Receiver_VPA, Amount, Transaction_Date
FROM UPI_Transactions
WHERE Status = 'Pending';


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column Transaction_Mode
ALTER TABLE UPI_Transactions ADD COLUMN Transaction_Mode VARCHAR(20) DEFAULT 'UPI';

-- 2. Modify Amount precision
ALTER TABLE UPI_Transactions MODIFY COLUMN Amount DECIMAL(12,2);

-- 3. Add column Merchant_Category
ALTER TABLE UPI_Transactions ADD COLUMN Merchant_Category VARCHAR(50);

-- 4. Drop column Bank_Name
ALTER TABLE UPI_Transactions DROP COLUMN Bank_Name;

-- 5. Change column Transaction_Date to Txn_DateTime
ALTER TABLE UPI_Transactions CHANGE COLUMN Transaction_Date Txn_DateTime DATETIME;


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table UPI_Transactions to UPI_Txn
RENAME TABLE UPI_Transactions TO UPI_Txn;

-- 2. Rename table UPI_Txn back to UPI_Transactions
RENAME TABLE UPI_Txn TO UPI_Transactions;

-- 3. Rename UPI_Transactions to Digital_UPI_Transactions
RENAME TABLE UPI_Transactions TO Digital_UPI_Transactions;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update status of UPIREF1015 (loan payment) from Pending to Success
UPDATE Digital_UPI_Transactions
SET Status = 'Success'
WHERE Reference_No = 'UPIREF1015';

-- 2. Update Transaction_Mode for all records of SBI to 'Mobile'
UPDATE Digital_UPI_Transactions
SET Transaction_Mode = 'Mobile'
WHERE Sender_VPA LIKE '%@oksbi' OR Receiver_VPA LIKE '%@oksbi';

-- 3. Assign Merchant_Category = 'E-commerce' for Amazon, Flipkart, Snapdeal, Myntra
UPDATE Digital_UPI_Transactions
SET Merchant_Category = 'E-commerce'
WHERE Receiver_VPA IN ('amazon@icici', 'flipkart@axis', 'snapdeal@hdfc', 'myntra@hdfc');

-- 4. Increase all transactions below 500 by 10% (service charge adjustment)
UPDATE Digital_UPI_Transactions
SET Amount = Amount * 1.10
WHERE Amount < 500;


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete all failed transactions
DELETE FROM Digital_UPI_Transactions
WHERE Status = 'Failed';

-- 2. Delete transactions where Amount < 200
DELETE FROM Digital_UPI_Transactions
WHERE Amount < 200;

-- 3. Delete transactions older than '2024-07-11'
DELETE FROM Digital_UPI_Transactions
WHERE Txn_DateTime < '2024-07-11 00:00:00';

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all successful transactions
SELECT UPI_ID, Sender_VPA, Receiver_VPA, Amount, Status
FROM UPI_Transactions
WHERE Status = 'Success';

-- 2. Show all failed transactions
SELECT UPI_ID, Sender_VPA, Receiver_VPA, Amount, Status
FROM UPI_Transactions
WHERE Status = 'Failed';

-- 3. Show transactions where Amount > 1000
SELECT UPI_ID, Sender_VPA, Amount
FROM UPI_Transactions
WHERE Amount > 1000;

-- 4. Find all SBI transactions
SELECT UPI_ID, Sender_VPA, Receiver_VPA, Bank_Name
FROM UPI_Transactions
WHERE Bank_Name = 'SBI';

-- 5. Show transactions made between '2024-07-11' and '2024-07-12'
SELECT UPI_ID, Sender_VPA, Amount, Transaction_Date
FROM UPI_Transactions
WHERE Transaction_Date BETWEEN '2024-07-11 00:00:00' AND '2024-07-12 23:59:59';

-- 6. Show transactions with Amount IN (199, 200, 350.25)
SELECT UPI_ID, Sender_VPA, Amount
FROM UPI_Transactions
WHERE Amount IN (199.00, 200.00, 350.25);

-- 7. Show all rent or loan related payments
SELECT UPI_ID, Sender_VPA, Receiver_VPA, Amount
FROM UPI_Transactions
WHERE Receiver_VPA LIKE '%rent%' OR Receiver_VPA LIKE '%loan%';

-- 8. Show transactions where Reference_No starts with 'UPIREF10'
SELECT UPI_ID, Reference_No, Amount
FROM UPI_Transactions
WHERE Reference_No LIKE 'UPIREF10%';

-- 9. Show HDFC Bank transactions greater than 2000
SELECT UPI_ID, Sender_VPA, Amount, Bank_Name
FROM UPI_Transactions
WHERE Bank_Name = 'HDFC Bank' AND Amount > 2000;

-- 10. Show all pending transactions
SELECT UPI_ID, Sender_VPA, Receiver_VPA, Amount, Status
FROM UPI_Transactions
WHERE Status = 'Pending';



-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Count total transactions by status
SELECT Status, COUNT(*) AS Total
FROM UPI_Transactions
GROUP BY Status;

-- 2. Count transactions by bank
SELECT Bank_Name, COUNT(*) AS Total_Transactions
FROM UPI_Transactions
GROUP BY Bank_Name;

-- 3. Find total transaction amount per bank
SELECT Bank_Name, SUM(Amount) AS Total_Amount
FROM UPI_Transactions
GROUP BY Bank_Name;

-- 4. Find average transaction amount per bank
SELECT Bank_Name, AVG(Amount) AS Avg_Amount
FROM UPI_Transactions
GROUP BY Bank_Name;

-- 5. Find maximum transaction amount per bank
SELECT Bank_Name, MAX(Amount) AS Max_Transaction
FROM UPI_Transactions
GROUP BY Bank_Name;

-- 6. Find minimum transaction amount per bank
SELECT Bank_Name, MIN(Amount) AS Min_Transaction
FROM UPI_Transactions
GROUP BY Bank_Name;

-- 7. Find total transactions per day
SELECT DATE(Transaction_Date) AS Trans_Date, COUNT(*) AS Total_Transactions
FROM UPI_Transactions
GROUP BY DATE(Transaction_Date);

-- 8. Find total money sent vs received
SELECT Transaction_Type, SUM(Amount) AS Total_Amount
FROM UPI_Transactions
GROUP BY Transaction_Type;

-- 9. Find users who sent more than 2000 in total
SELECT Sender_VPA, SUM(Amount) AS Total_Sent
FROM UPI_Transactions
WHERE Transaction_Type = 'Send'
GROUP BY Sender_VPA
HAVING SUM(Amount) > 2000;

-- 10. Find banks with more than 3 successful transactions
SELECT Bank_Name, COUNT(*) AS Successful_Transactions
FROM UPI_Transactions
WHERE Status = 'Success'
GROUP BY Bank_Name
HAVING COUNT(*) > 3;



-- Table-24 
CREATE TABLE Service_Requests (
  Request_ID INT PRIMARY KEY AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  Request_Type ENUM('Cheque Book', 'Account Statement', 'Credit Card', 'Address Change', 'Mobile Update'),
  Request_Date DATE NOT NULL,
  Status ENUM('Pending', 'In Process', 'Completed', 'Rejected') DEFAULT 'Pending',
  Handled_By INT,
  Completion_Date DATE,
  Priority ENUM('Low', 'Medium', 'High') DEFAULT 'Medium',
  Branch_ID INT,
  Remarks VARCHAR(255),
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
  FOREIGN KEY (Handled_By) REFERENCES Employees(Employee_ID),
  FOREIGN KEY (Branch_ID) REFERENCES Branches(Branch_ID)
);


-- insert records into table-24
INSERT INTO Service_Requests 
(Customer_ID, Request_Type, Request_Date, Status, Handled_By, Completion_Date, Priority, Branch_ID, Remarks)
VALUES
(1, 'Cheque Book', '2024-06-05', 'Completed', 2, '2024-06-08', 'Medium', 1, 'Cheque book delivered via courier'),
(2, 'Mobile Update', '2024-06-07', 'Completed', 4, '2024-06-09', 'Low', 3, 'Mobile number updated successfully'),
(3, 'Credit Card', '2024-06-08', 'In Process', 5, NULL, 'High', 2, 'Card issuance under process'),
(4, 'Address Change', '2024-06-09', 'Pending', NULL, NULL, 'Medium', 4, 'Proof of address awaited'),
(5, 'Account Statement', '2024-06-10', 'Completed', 1, '2024-06-11', 'Low', 1, 'Statement emailed to registered ID'),
(6, 'Cheque Book', '2024-06-11', 'Completed', 3, '2024-06-14', 'Medium', 2, 'Delivered in-person at branch'),
(7, 'Credit Card', '2024-06-12', 'Rejected', 6, '2024-06-14', 'High', 4, 'Low CIBIL score'),
(8, 'Address Change', '2024-06-13', 'In Process', 2, NULL, 'Medium', 3, 'KYC document review ongoing'),
(9, 'Mobile Update', '2024-06-14', 'Completed', 7, '2024-06-15', 'Low', 2, 'Updated via NetBanking'),
(10, 'Account Statement', '2024-06-15', 'Completed', 4, '2024-06-16', 'Low', 1, 'Printed and collected'),
(11, 'Cheque Book', '2024-06-16', 'Pending', NULL, NULL, 'Medium', 5, 'Request registered via ATM'),
(12, 'Credit Card', '2024-06-17', 'In Process', 1, NULL, 'High', 2, 'Document verification in progress'),
(13, 'Address Change', '2024-06-18', 'Completed', 9, '2024-06-20', 'Low', 3, 'Updated in core banking system'),
(14, 'Mobile Update', '2024-06-19', 'Rejected', 5, '2024-06-20', 'Medium', 2, 'Mismatch in ID proof'),
(15, 'Cheque Book', '2024-06-20', 'Completed', 6, '2024-06-23', 'Medium', 1, 'Delivered to home address'),
(16, 'Credit Card', '2024-06-21', 'Completed', 10, '2024-06-24', 'High', 4, 'Card dispatched via BlueDart'),
(17, 'Address Change', '2024-06-22', 'In Process', 3, NULL, 'Medium', 3, 'KYC under review'),
(18, 'Mobile Update', '2024-06-23', 'Completed', 2, '2024-06-24', 'Low', 1, 'Completed via mobile app'),
(19, 'Account Statement', '2024-06-24', 'Completed', 8, '2024-06-25', 'Low', 2, 'Sent for last 3 months'),
(20, 'Cheque Book', '2024-06-25', 'Completed', 5, '2024-06-28', 'Medium', 4, 'Couriered on request');

-- display table-24
select * from Service_Requests;

truncate table Service_Requests;

drop table Service_Requests;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Fetch all service requests
SELECT * FROM Service_Requests;

-- 2. Get all pending requests
SELECT Request_ID, Customer_ID, Request_Type, Request_Date, Priority
FROM Service_Requests
WHERE Status = 'Pending';

-- 3. Count requests by type
SELECT Request_Type, COUNT(*) AS Total_Requests
FROM Service_Requests
GROUP BY Request_Type;

-- 4. List high-priority requests that are not yet completed
SELECT Request_ID, Customer_ID, Request_Type, Status, Priority
FROM Service_Requests
WHERE Priority = 'High' AND Status <> 'Completed';

-- 5. Find average completion time for completed requests
SELECT AVG(DATEDIFF(Completion_Date, Request_Date)) AS Avg_Days_To_Complete
FROM Service_Requests
WHERE Status = 'Completed';


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column Escalated BOOLEAN
ALTER TABLE Service_Requests ADD COLUMN Escalated BOOLEAN DEFAULT FALSE;

-- 2. Modify Remarks column size
ALTER TABLE Service_Requests MODIFY COLUMN Remarks VARCHAR(500);

-- 3. Add column Service_Channel
ALTER TABLE Service_Requests ADD COLUMN Service_Channel ENUM('Branch', 'Online', 'ATM', 'MobileApp') DEFAULT 'Branch';

-- 4. Drop column Priority
ALTER TABLE Service_Requests DROP COLUMN Priority;

-- 5. Change Completion_Date to Closed_Date
ALTER TABLE Service_Requests CHANGE COLUMN Completion_Date Closed_Date DATE;


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Service_Requests to Customer_Service_Requests
RENAME TABLE Service_Requests TO Customer_Service_Requests;

-- 2. Rename back to Service_Requests
RENAME TABLE Customer_Service_Requests TO Service_Requests;

-- 3. Rename to Branch_Service_Requests
RENAME TABLE Service_Requests TO Branch_Service_Requests;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Mark request #4 as "In Process" and assign employee 8
UPDATE Branch_Service_Requests
SET Status = 'In Process', Handled_By = 8
WHERE Request_ID = 4;

-- 2. Escalate all requests with High priority still in Pending or In Process
UPDATE Branch_Service_Requests
SET Escalated = TRUE
WHERE Priority = 'High' AND Status IN ('Pending', 'In Process');

-- 3. Update Service_Channel to 'MobileApp' for all Mobile Update requests
UPDATE Branch_Service_Requests
SET Service_Channel = 'MobileApp'
WHERE Request_Type = 'Mobile Update';

-- 4. Update Remarks for all rejected requests
UPDATE Branch_Service_Requests
SET Remarks = CONCAT(Remarks, ' | Escalated to Head Office')
WHERE Status = 'Rejected';


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete all rejected requests
DELETE FROM Branch_Service_Requests
WHERE Status = 'Rejected';

-- 2. Delete low-priority completed requests before 2024-06-15
DELETE FROM Branch_Service_Requests
WHERE Status = 'Completed' AND Closed_Date < '2024-06-15';

-- 3. Delete requests with no handler assigned and still pending
DELETE FROM Branch_Service_Requests
WHERE Status = 'Pending' AND Handled_By IS NULL;

-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all pending service requests
SELECT Request_ID, Customer_ID, Request_Type, Status
FROM Service_Requests
WHERE Status = 'Pending';

-- 2. Show all completed requests handled by employee 2
SELECT Request_ID, Customer_ID, Request_Type, Status, Completion_Date
FROM Service_Requests
WHERE Status = 'Completed' AND Handled_By = 2;

-- 3. Show requests made between 2024-06-10 and 2024-06-20
SELECT Request_ID, Customer_ID, Request_Type, Request_Date
FROM Service_Requests
WHERE Request_Date BETWEEN '2024-06-10' AND '2024-06-20';

-- 4. Show all requests where Priority = 'High'
SELECT Request_ID, Customer_ID, Request_Type, Status, Priority
FROM Service_Requests
WHERE Priority = 'High';

-- 5. Show all rejected requests
SELECT Request_ID, Customer_ID, Request_Type, Remarks
FROM Service_Requests
WHERE Status = 'Rejected';

-- 6. Show requests that were completed in less than 3 days
SELECT Request_ID, Request_Type, Request_Date, Completion_Date,
       DATEDIFF(Completion_Date, Request_Date) AS Days_Taken
FROM Service_Requests
WHERE Status = 'Completed' AND DATEDIFF(Completion_Date, Request_Date) < 3;

-- 7. Show all requests where remarks mention 'KYC'
SELECT Request_ID, Customer_ID, Request_Type, Remarks
FROM Service_Requests
WHERE Remarks LIKE '%KYC%';

-- 8. Show requests not yet assigned to any employee
SELECT Request_ID, Customer_ID, Request_Type, Status
FROM Service_Requests
WHERE Handled_By IS NULL;

-- 9. Show requests from Branch_ID 2 that are still in process
SELECT Request_ID, Customer_ID, Request_Type, Status
FROM Service_Requests
WHERE Branch_ID = 2 AND Status = 'In Process';

-- 10. Show customers who requested either Cheque Book or Mobile Update
SELECT Request_ID, Customer_ID, Request_Type, Status
FROM Service_Requests
WHERE Request_Type IN ('Cheque Book', 'Mobile Update');



-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Count number of requests by type
SELECT Request_Type, COUNT(*) AS Total_Requests
FROM Service_Requests
GROUP BY Request_Type;

-- 2. Count requests by status
SELECT Status, COUNT(*) AS Total_Requests
FROM Service_Requests
GROUP BY Status;

-- 3. Find average days taken for completion (only completed requests)
SELECT AVG(DATEDIFF(Completion_Date, Request_Date)) AS Avg_Days_Taken
FROM Service_Requests
WHERE Status = 'Completed';

-- 4. Find maximum turnaround time (days taken) for completed requests
SELECT MAX(DATEDIFF(Completion_Date, Request_Date)) AS Max_Days_Taken
FROM Service_Requests
WHERE Status = 'Completed';

-- 5. Count requests per branch
SELECT Branch_ID, COUNT(*) AS Total_Requests
FROM Service_Requests
GROUP BY Branch_ID;

-- 6. Find employees who handled more than 2 requests
SELECT Handled_By, COUNT(*) AS Requests_Handled
FROM Service_Requests
WHERE Handled_By IS NOT NULL
GROUP BY Handled_By
HAVING COUNT(*) > 2;

-- 7. Find customers who made more than 1 request
SELECT Customer_ID, COUNT(*) AS Request_Count
FROM Service_Requests
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- 8. Count high-priority requests by status
SELECT Status, COUNT(*) AS High_Priority_Requests
FROM Service_Requests
WHERE Priority = 'High'
GROUP BY Status;

-- 9. Find branch with most completed requests
SELECT Branch_ID, COUNT(*) AS Completed_Requests
FROM Service_Requests
WHERE Status = 'Completed'
GROUP BY Branch_ID
ORDER BY Completed_Requests DESC
LIMIT 1;

-- 10. Find the most common request type in each branch
SELECT Branch_ID, Request_Type, COUNT(*) AS Total
FROM Service_Requests
GROUP BY Branch_ID, Request_Type
ORDER BY Branch_ID, Total DESC;


-- Table-25
CREATE TABLE Credit_Scores (
  Score_ID INT PRIMARY KEY AUTO_INCREMENT,
  Customer_ID INT NOT NULL,
  PAN_Number CHAR(10) NOT NULL UNIQUE,
  Score_Provider ENUM('CIBIL', 'Experian', 'Equifax') NOT NULL,
  Credit_Score INT CHECK (Credit_Score BETWEEN 300 AND 900),
  Last_Updated DATE,
  Score_Status ENUM('Excellent', 'Good', 'Average', 'Poor'),
  Loan_Eligibility BOOLEAN DEFAULT FALSE,
  Credit_Utilization_Percentage DECIMAL(5,2),
  Remarks VARCHAR(255),
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);


-- insert records into table-25
INSERT INTO Credit_Scores 
(Customer_ID, PAN_Number, Score_Provider, Credit_Score, Last_Updated, Score_Status, Loan_Eligibility, Credit_Utilization_Percentage, Remarks)
VALUES
(1, 'ABCDE1234F', 'CIBIL', 812, '2024-06-20', 'Excellent', TRUE, 28.65, 'Strong repayment history'),
(2, 'PQRSX6789A', 'Experian', 745, '2024-06-18', 'Good', TRUE, 34.50, 'Moderate credit usage'),
(3, 'LMNOP4321K', 'Equifax', 689, '2024-06-17', 'Average', FALSE, 55.20, 'High credit utilization'),
(4, 'MNOPQ3456L', 'CIBIL', 710, '2024-06-16', 'Good', TRUE, 29.10, 'Timely EMI payments'),
(5, 'STUVW1234Z', 'Experian', 604, '2024-06-14', 'Average', FALSE, 62.00, 'Multiple loan accounts'),
(6, 'QWERT5678Y', 'Equifax', 798, '2024-06-12', 'Excellent', TRUE, 21.30, 'Excellent history'),
(7, 'ASDFG2345H', 'CIBIL', 503, '2024-06-11', 'Poor', FALSE, 78.90, 'Missed credit card payments'),
(8, 'ZXCVB6789J', 'Experian', 680, '2024-06-10', 'Average', FALSE, 43.00, 'Some delays observed'),
(9, 'TYUIO1234M', 'CIBIL', 725, '2024-06-08', 'Good', TRUE, 30.00, 'Good repayment trend'),
(10, 'HGFED5678R', 'Equifax', 840, '2024-06-07', 'Excellent', TRUE, 15.90, 'Low usage, excellent track'),
(11, 'BNMAS2345V', 'CIBIL', 661, '2024-06-06', 'Average', FALSE, 48.20, 'High personal loan EMI'),
(12, 'CVBNM1234X', 'Experian', 780, '2024-06-05', 'Excellent', TRUE, 22.00, 'Well-managed accounts'),
(13, 'WERTH6789N', 'Equifax', 602, '2024-06-04', 'Average', FALSE, 60.00, 'Old credit card pending'),
(14, 'PLKMN4567D', 'CIBIL', 832, '2024-06-03', 'Excellent', TRUE, 17.80, 'Very low utilization'),
(15, 'QAZWS1234E', 'Experian', 693, '2024-06-02', 'Average', FALSE, 39.90, 'Borderline approval range'),
(16, 'EDCRF3456B', 'Equifax', 559, '2024-06-01', 'Poor', FALSE, 74.50, 'Irregular payments'),
(17, 'LOPIU1234T', 'CIBIL', 777, '2024-05-30', 'Excellent', TRUE, 25.30, 'Consistent performance'),
(18, 'MJNHG3456S', 'Experian', 720, '2024-05-29', 'Good', TRUE, 31.00, 'On-time home loan payments'),
(19, 'UJIKM6789O', 'CIBIL', 610, '2024-05-28', 'Average', FALSE, 57.70, 'Overused credit limit'),
(20, 'GHYTR4567P', 'Equifax', 895, '2024-05-26', 'Excellent', TRUE, 11.40, 'Top-tier credit profile');


-- display table-25
select * from Credit_Scores;


truncate table Credit_Scores;

drop table Credit_Scores;

-- ======================
-- 5 SELECT QUERIES
-- ======================

-- 1. Fetch all credit score records
SELECT * FROM Credit_Scores;

-- 2. Get customers with Excellent credit status
SELECT Customer_ID, PAN_Number, Credit_Score, Score_Provider
FROM Credit_Scores
WHERE Score_Status = 'Excellent';

-- 3. Find average credit score grouped by provider
SELECT Score_Provider, AVG(Credit_Score) AS Avg_Score
FROM Credit_Scores
GROUP BY Score_Provider;

-- 4. List customers not eligible for loans with Poor or Average status
SELECT Customer_ID, PAN_Number, Credit_Score, Score_Status
FROM Credit_Scores
WHERE Loan_Eligibility = FALSE AND Score_Status IN ('Poor', 'Average');

-- 5. Get top 5 customers with highest credit scores
SELECT Customer_ID, PAN_Number, Credit_Score, Score_Status
FROM Credit_Scores
ORDER BY Credit_Score DESC
LIMIT 5;


-- ======================
-- 5 ALTER QUERIES
-- ======================

-- 1. Add column Last_Checked timestamp
ALTER TABLE Credit_Scores ADD COLUMN Last_Checked TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- 2. Modify Remarks column size
ALTER TABLE Credit_Scores MODIFY COLUMN Remarks VARCHAR(500);

-- 3. Add column Credit_Risk_Level
ALTER TABLE Credit_Scores ADD COLUMN Credit_Risk_Level ENUM('Low', 'Medium', 'High') DEFAULT 'Medium';

-- 4. Drop column Loan_Eligibility
ALTER TABLE Credit_Scores DROP COLUMN Loan_Eligibility;

-- 5. Change Score_Status to Credit_Status
ALTER TABLE Credit_Scores CHANGE COLUMN Score_Status Credit_Status ENUM('Excellent', 'Good', 'Average', 'Poor');


-- ======================
-- 3 RENAME QUERIES
-- ======================

-- 1. Rename table Credit_Scores to Customer_Credit_Scores
RENAME TABLE Credit_Scores TO Customer_Credit_Scores;

-- 2. Rename back to Credit_Scores
RENAME TABLE Customer_Credit_Scores TO Credit_Scores;

-- 3. Rename to Credit_History
RENAME TABLE Credit_Scores TO Credit_History;


-- ======================
-- 4 UPDATE QUERIES
-- ======================

-- 1. Update Credit_Risk_Level based on score < 600
UPDATE Credit_History
SET Credit_Risk_Level = 'High'
WHERE Credit_Score < 600;

-- 2. Update Credit_Risk_Level for scores between 600–750
UPDATE Credit_History
SET Credit_Risk_Level = 'Medium'
WHERE Credit_Score BETWEEN 600 AND 750;

-- 3. Update Credit_Risk_Level for scores above 750
UPDATE Credit_History
SET Credit_Risk_Level = 'Low'
WHERE Credit_Score > 750;

-- 4. Update Remarks for Poor credit customers
UPDATE Credit_History
SET Remarks = CONCAT(Remarks, ' | Urgent improvement required')
WHERE Credit_Status = 'Poor';


-- ======================
-- 3 DELETE QUERIES
-- ======================

-- 1. Delete all records with score below 500
DELETE FROM Credit_History
WHERE Credit_Score < 500;

-- 2. Delete records where last updated is before 2024-06-01
DELETE FROM Credit_History
WHERE Last_Updated < '2024-06-01';

-- 3. Delete duplicate records by PAN (if any)
DELETE c1
FROM Credit_History c1
JOIN Credit_History c2
ON c1.PAN_Number = c2.PAN_Number AND c1.Score_ID > c2.Score_ID;


-- ===============================
-- 🔹 10 QUERIES USING OPERATORS
-- ===============================

-- 1. Show all customers with Excellent credit score
SELECT Customer_ID, PAN_Number, Credit_Score, Score_Status
FROM Credit_Scores
WHERE Score_Status = 'Excellent';

-- 2. Show customers eligible for loan
SELECT Customer_ID, PAN_Number, Credit_Score, Loan_Eligibility
FROM Credit_Scores
WHERE Loan_Eligibility = TRUE;

-- 3. Show customers with credit score between 700 and 800
SELECT Customer_ID, PAN_Number, Credit_Score
FROM Credit_Scores
WHERE Credit_Score BETWEEN 700 AND 800;

-- 4. Show customers with poor credit or high utilization > 70%
SELECT Customer_ID, PAN_Number, Credit_Score, Credit_Utilization_Percentage
FROM Credit_Scores
WHERE Score_Status = 'Poor' OR Credit_Utilization_Percentage > 70;

-- 5. Show customers not eligible for loan
SELECT Customer_ID, PAN_Number, Credit_Score, Loan_Eligibility
FROM Credit_Scores
WHERE Loan_Eligibility = FALSE;

-- 6. Show customers whose PAN starts with 'A'
SELECT Customer_ID, PAN_Number, Credit_Score
FROM Credit_Scores
WHERE PAN_Number LIKE 'A%';

-- 7. Show customers updated after 2024-06-10
SELECT Customer_ID, PAN_Number, Last_Updated
FROM Credit_Scores
WHERE Last_Updated > '2024-06-10';

-- 8. Show customers with CIBIL score provider
SELECT Customer_ID, PAN_Number, Score_Provider, Credit_Score
FROM Credit_Scores
WHERE Score_Provider = 'CIBIL';

-- 9. Show customers with utilization between 20% and 40%
SELECT Customer_ID, PAN_Number, Credit_Utilization_Percentage
FROM Credit_Scores
WHERE Credit_Utilization_Percentage BETWEEN 20 AND 40;

-- 10. Show customers with Average or Poor score status
SELECT Customer_ID, PAN_Number, Score_Status
FROM Credit_Scores
WHERE Score_Status IN ('Average', 'Poor');



-- ===============================
-- 🔹 10 QUERIES USING CLAUSES
-- ===============================

-- 1. Count of customers by Score_Status
SELECT Score_Status, COUNT(*) AS Total_Customers
FROM Credit_Scores
GROUP BY Score_Status;

-- 2. Count of customers eligible for loan
SELECT Loan_Eligibility, COUNT(*) AS Total_Customers
FROM Credit_Scores
GROUP BY Loan_Eligibility;

-- 3. Average credit score by Score_Provider
SELECT Score_Provider, AVG(Credit_Score) AS Avg_Credit_Score
FROM Credit_Scores
GROUP BY Score_Provider;

-- 4. Maximum credit utilization
SELECT MAX(Credit_Utilization_Percentage) AS Max_Utilization
FROM Credit_Scores;

-- 5. Minimum credit score
SELECT MIN(Credit_Score) AS Min_Credit_Score
FROM Credit_Scores;

-- 6. Top 5 customers with highest credit score
SELECT Customer_ID, PAN_Number, Credit_Score
FROM Credit_Scores
ORDER BY Credit_Score DESC
LIMIT 5;

-- 7. Count of customers by Score_Provider
SELECT Score_Provider, COUNT(*) AS Total_Customers
FROM Credit_Scores
GROUP BY Score_Provider;

-- 8. Average utilization for customers with Excellent score
SELECT AVG(Credit_Utilization_Percentage) AS Avg_Utilization
FROM Credit_Scores
WHERE Score_Status = 'Excellent';

-- 9. Find customers with last update before 2024-06-01
SELECT Customer_ID, PAN_Number, Last_Updated
FROM Credit_Scores
WHERE Last_Updated < '2024-06-01';

-- 10. Count of customers per score range
SELECT 
  CASE 
    WHEN Credit_Score >= 800 THEN '800-900'
    WHEN Credit_Score >= 700 THEN '700-799'
    WHEN Credit_Score >= 600 THEN '600-699'
    ELSE 'Below 600'
  END AS Score_Range,
  COUNT(*) AS Total_Customers
FROM Credit_Scores
GROUP BY Score_Range;
