# 🏦 HDFC Bank Database Project – Phase 1

## 📌 Overview
This project represents **Phase 1** of the **HDFC Bank Database System** built in MySQL.  
It focuses on **Database Design & Creation**, where the entire **schema of 25 interrelated tables** was designed, created, and populated with realistic **sample Indian-context records**.

---

## 🗂️ Database Schema
The database consists of **25 tables**, covering almost every banking operation:

1. **Customers** – Personal and KYC details of customers.  
2. **Branches** – Branch-level details (IFSC, MICR, city, state, contact, etc.).  
3. **Accounts** – Account information with types (Savings, Current, Salary, NRI, FD).  
4. **Transactions** – Credit/Debit records with balance updates.  
5. **Employees** – Staff details with branch mapping and salaries.  
6. **Loans** – Multiple loan types with EMI and approval tracking.  
7. **Cards** – Debit/Credit card management with limits and expiry.  
8. **ATMs** – On-site/off-site ATM details with cash availability.  
9. **Cheques** – Issued cheques, payees, status, and remarks.  
10. **Fixed Deposits** – FD details including maturity and nominees.  
11. **Online Banking** – Customer login, devices, IPs, and security.  
12. **Beneficiaries** – Internal and external payee management.  
13. **Lockers** – Locker allocation, rent, and access logs.  
14. **Complaints** – Complaint resolution and tracking system.  
15. **Insurance Policies** – Insurance type, provider, premium, and claims.  
16. **Recurring Deposits** – Monthly RD installment tracking.  
17. **KYC Documents** – Aadhaar, PAN, proofs, and verification.  
18. **Account Statements** – Generated statements with credits/debits.  
19. **Customer Feedback** – Ratings, comments, and response handling.  
20. **Bill Payments** – Electricity, phone, insurance, and other bill payments.  
21. **Safe Deposit Visits** – Locker visit logs with employee verification.  
22. **Mobile Banking** – Registered mobile devices and app security.  
23. **UPI Transactions** – Peer-to-peer transfers with VPAs.  
24. **Service Requests** – Customer service requests and resolution tracking.  
25. **Credit Scores** – Credit history with eligibility and provider data.  

---

## 🎯 Key Highlights
- Full **Database Design** using **DDL** (`CREATE`, `ALTER`, `DROP`).  
- **Referential Integrity** with **Primary Keys & Foreign Keys**.  
- **Constraints Used:**  
  - `NOT NULL`, `UNIQUE`, `CHECK`, `ENUM`, `DEFAULT`.  
- **Sample Data Inserted** – 20+ records per table to simulate real-world scenarios.  
- **Indian Context** – Aadhaar, PAN, IFSC, mobile numbers, and addresses used for realism.  

---


