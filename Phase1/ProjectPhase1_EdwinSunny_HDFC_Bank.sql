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