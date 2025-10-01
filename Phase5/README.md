# 🏦 HDFC Bank Database Project – Phase 5

## 📌 Overview
This project represents **Phase 5** of the **HDFC Bank Database System** built in MySQL.  
It focuses on **enterprise-level database features** like **Views, Stored Procedures, Cursors, Triggers, Window Functions, DCL & TCL operations, and User Management**.  

This phase ensures the database is **optimized, automated, and secure**, simulating real-world banking operations.

---

## 🗂️ Concepts Practiced

### 🔹 1. Views
- Created multiple reporting views for better analysis.  
- **Examples:**  
  - High-value loans  
  - Active accounts  
  - Debit transactions  
  - Employee salary reports  

---

### 🔹 2. Stored Procedures
- Automated complex tasks using stored procedures.  
- **Examples:**  
  - Fetching filtered records  
  - Counting and grouping data  
  - Salary summaries  
  - Transaction reports  

---

### 🔹 3. Cursors
- Used cursors to **iterate through datasets**.  
- **Examples:**  
  - Senior citizen customers  
  - Bounced cheques  
  - NEFT/RTGS transactions  

---

### 🔹 4. Triggers
- Implemented triggers for **automation and data integrity**.  
- **Examples:**  
  - Prevent duplicate entries (Aadhaar, IFSC, Cheque No, Card No)  
  - Auto-update balances and account/card statuses  
  - Log changes in emails, account managers, and balances  

---

### 🔹 5. Window Functions
- Applied analytical window functions:  
  - `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`  
  - Aggregate functions with `OVER()` such as `SUM() OVER`, `COUNT() OVER`  

---

### 🔹 6. Transactions (TCL)
- Practiced **transaction control** for safe operations:  
  - `COMMIT` to save changes permanently  
  - `ROLLBACK` to revert changes in case of errors  

---

### 🔹 7. Data Control (DCL) & User Management
- Created and managed database users:  
  - `analyst`, `branchuser`, `accuser`, `txnuser`, `empuser`, etc.  
- Granted and revoked privileges to enforce **access control**:  
  - `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `EXECUTE`  

---

## 📸 Screenshots

### 1. Active accounts with balance greater than 100k
<img width="355" height="206" alt="Screenshot 2025-10-01 111051" src="https://github.com/user-attachments/assets/f077d2fc-99cc-4c5a-9524-a4cf88e1279a" />


### 2. Customers with FD greater than 5 lakhs
<img width="255" height="160" alt="Screenshot 2025-10-01 111139" src="https://github.com/user-attachments/assets/7cd2c2aa-2810-4d69-abe1-44a0f8198f9b" />

### 3. Joined Cards with Accounts
<img width="317" height="466" alt="Screenshot 2025-10-01 111245" src="https://github.com/user-attachments/assets/ffc933f5-b22c-4a00-8edf-079f0f4b3b33" />

### 4. Customer with maximum balance
<img width="266" height="93" alt="Screenshot 2025-10-01 111329" src="https://github.com/user-attachments/assets/7e5e8dd3-7be0-4414-baf0-03e540c581de" />

### 5. Count of active mobile banking users
<img width="241" height="101" alt="Screenshot 2025-10-01 111409" src="https://github.com/user-attachments/assets/b9961288-21e2-4c9c-b4f5-d70fed1cee09" />


---



🚀 *This completes Phase 5 of the HDFC Bank Database Project.*
