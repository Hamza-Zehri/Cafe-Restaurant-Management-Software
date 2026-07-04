# 🍽️ Restaurant & Café Management System (Enterprise Edition)

A modern, enterprise-grade **Restaurant & Café Management System** built with **Flutter for Windows Desktop**, designed specifically for restaurants, cafés, fast food outlets, tea shops, and food courts in Pakistan.

The software works completely **offline**, supports **multiple users**, provides **secure hardware-based activation**, and includes everything required to manage daily restaurant operations from order taking to accounting.

---

# ✨ Key Features

- ✅ Beautiful Modern Dashboard
- ✅ Table Management
- ✅ Order Management
- ✅ Kitchen Display System (KDS)
- ✅ Menu & Category Management
- ✅ Deal & Combo Management
- ✅ Customer Management
- ✅ Credit (Udhar) Management
- ✅ Staff & Attendance
- ✅ Salary Management
- ✅ Expense Tracking
- ✅ Cash Register
- ✅ X & Z Reports
- ✅ Inventory Management
- ✅ Receipt & Kitchen Printing
- ✅ Automatic Daily Backup
- ✅ Offline Hardware Licensing
- ✅ SQLite Database
- ✅ Multi-role Security

---

# 🚀 Complete Restaurant Workflow

## 1. Dashboard

The dashboard provides a complete live overview of your restaurant.

- Live Sales
- Today's Orders
- Occupied Tables
- Available Tables
- Staff Status
- Daily Revenue
- Recent Orders
- Quick Navigation

Table colors

🟢 Available

🔴 Occupied

Each occupied table displays:

- Waiter Name
- Running Bill
- Guests
- Order Status

---

## 2. Table Management

Create unlimited:

- Floors
- Dining Areas
- Tables

Features

- Open Table
- Transfer Table
- Merge Tables
- Change Waiter
- Track Guests
- Live Bill

---

## 3. Order Terminal

Instead of using the word **POS**, the customer-facing interface is named:

**Order Terminal**

Workflow

Open Table

↓

Select Category

↓

Add Food

↓

Add Deals

↓

Modify Quantity

↓

Special Instructions

↓

Send Kitchen

↓

Print Kitchen Ticket

↓

Print Bill

↓

Receive Payment

↓

Print Final Receipt

↓

Table Automatically Available

---

## 4. Menu Management

Create unlimited

- Categories
- Food Items
- Drinks
- Desserts

Each item supports

- Name
- Urdu/English
- Price
- Cost
- Barcode
- Image
- Availability
- Kitchen Printer
- Tax

Upload real food images directly from your computer.

---

# 🎁 Deal & Combo Management

The software includes a complete Deal Management System.

Examples

- Family Deal
- Lunch Deal
- BBQ Deal
- Couple Deal
- Student Deal
- Weekend Offer

Each deal supports

- Deal Name
- Deal Price
- Included Items
- Deal Image
- Available Time
- Active/Inactive

Deals appear directly inside the **Order Terminal** for quick ordering.

Kitchen tickets and customer receipts automatically print all included deal items.

---

# 👨‍🍳 Kitchen Display System

After clicking **Send to Kitchen**

The software

- Prints Kitchen Order Ticket
- Sends order to Kitchen Display
- Starts Preparation Timer

Kitchen staff can update

Pending

↓

Preparing

↓

Ready

↓

Served

Late orders are highlighted automatically.

---

# 💵 Billing & Payments

Supports

- Cash
- Card
- Bank Transfer
- Mobile Wallet
- Credit (Udhar)

Features

- Cash Received
- Change Calculation
- Discounts
- Taxes
- Service Charges
- Split Payments

Print

- Kitchen Ticket
- Proforma Bill
- Final Receipt
- A4 Invoice

---

# 👥 Customer Management

Maintain complete customer records.

Store

- Name
- Phone
- Address
- Notes
- Credit Limit
- Balance

Full credit ledger

Debit

↓

Payment

↓

Running Balance

Complete transaction history is preserved.

---

# 👨‍💼 Staff Management

Employee roles

- Owner
- Manager
- Cashier
- Waiter
- Kitchen Staff
- Chef
- Helper
- Delivery Rider

Only **Owner** and **Manager** require login credentials.

Other staff members are created for

- Attendance
- Salary
- Reporting

without needing usernames or passwords.

---

# ⏰ Attendance System

Features

- Check In
- Check Out
- Live Working Hours
- Overtime
- Daily Attendance
- Monthly Attendance

---

# 💰 Salary Management

Supports

- Daily Wage
- Weekly Salary
- Monthly Salary

Track

- Salary History
- Advance Payments
- Remaining Balance

---

# 💸 Expense Management

A dedicated **Expense Tracker** is included.

Track any business expense including

- Rent
- Electricity
- Gas
- Water
- Internet
- Staff Meals
- Fuel
- Maintenance
- Repairs
- Cleaning
- Kitchen Supplies
- Grocery Purchases
- Packaging
- Marketing
- Delivery Charges
- Miscellaneous

Features

- Custom Expense Types
- Notes
- Date Filter
- Monthly Summary
- Expense Reports

---

# 📦 Inventory Management

Manage inventory

- Raw Materials
- Drinks
- Packaging
- Kitchen Supplies

Track

- Stock
- Cost
- Minimum Stock
- Alerts

---

# 💼 Cash Register

Open Register

↓

Record Sales

↓

Track Expenses

↓

Close Register

Supports

- Opening Cash
- Closing Cash
- Cash Difference
- Expense Deduction

---

# 📊 Reports

Available Reports

- Daily Sales
- Monthly Sales
- Item Sales
- Category Sales
- Waiter Performance
- Staff Attendance
- Salary Report
- Customer Ledger
- Expense Report
- Inventory Report
- Kitchen Report

### X Report

Running shift report without reset.

### Z Report

End-of-day closing report.

Includes

- Cash Sales
- Card Sales
- Wallet Sales
- Credit Sales
- Discounts
- Taxes
- Expenses
- Kitchen Ticket Count
- Void Orders
- Expected Cash
- Counted Cash
- Cash Difference

---

# 🔒 Offline Software Licensing

The application includes a secure offline activation system.

Features

- Hardware-bound License
- Offline Activation
- RSA Signature Verification
- Machine ID
- Encrypted License Storage

Activation Process

Customer installs software

↓

Machine ID generated

↓

Customer sends Machine ID to Developer

↓

Developer generates Activation Key

↓

Customer enters Activation Key

↓

Software activates permanently on that computer

No internet connection is required.

---

# 💾 Automatic Daily Backup

The system automatically creates database backups.

Features

- Daily Automatic Backup
- Backup on Startup
- Includes SQLite WAL files
- Keeps only the latest 5 days of backups
- Automatically deletes older backups

Backup Location

```
Documents/
└── Restaurant Management/
    └── Backups/
```

---


# 🗄 Database

SQLite (Drift)

Core modules include

- Users
- Floors
- Tables
- Categories
- Menu Items
- Deals
- Orders
- Order Items
- Customers
- Credit Ledger
- Inventory
- Cash Registers
- Expenses
- Attendance
- Salary Payments
- Application Settings
- Software License

---

# 🛠 Technology Stack

- Flutter Desktop
- Dart
- Drift ORM
- SQLite
- Riverpod
- Material 3
- ESC/POS Printing
- PDF Generation
- PointyCastle (RSA Licensing)

---

# ▶️ Installation

```bash
git clone <repository>

cd restaurant_pos_v2

flutter pub get

dart run build_runner build --delete-conflicting-outputs

flutter run -d windows
```

To create a production executable

```bash
flutter build windows --release
```

---

# 🔑 Developer License Generator

Generate activation keys

```bash
dart run tools/keygen.dart <MACHINE_ID>
```

Example

```bash
dart run tools/keygen.dart 2CEE-9255-DD28-3C40
```

Generate RSA keys (developer only)

```bash
dart run tools/generate_keypair.dart
```

**Never distribute `private_key.pem` with the software.**

---

# 🇵🇰 Designed for Pakistan

- Pakistani Rupee (Rs.)
- +92 Phone Numbers
- Restaurant & Café Workflow
- Offline Operation
- Thermal Receipt Printing
- Kitchen Printer Support
- Credit (Udhar) Management
- Windows Desktop Optimized

---

# 📄 License

© Engr. Hamza Asad

All Rights Reserved.

This software is proprietary and protected by an offline hardware-based licensing system. Unauthorized copying, distribution, reverse engineering, or installation on unlicensed computers is prohibited.