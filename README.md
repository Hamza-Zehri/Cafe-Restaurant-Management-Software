# 🍽️ Restaurant POS — Complete System (v2, Final)

A complete, production-architecture Restaurant POS built in Flutter for Windows Desktop, designed around the **exact workflow you described**:

## The real workflow this app implements

1. **Dashboard** shows all tables live — green (available), red (occupied with running total + waiter name).
2. Tap an **available table** → enter guest count → table turns occupied, order created.
3. **POS screen opens** showing menu **groups** (Karahi, Biryani, BBQ, Beverages, Desserts, Rolls) as colored tabs — each group's items (e.g. tap "Karahi" → Chicken Karahi, Mutton Karahi, White Karahi, Beef Karahi all appear with photos).
4. Photos for groups and items are added from **Menu Management** (sidebar → Menu) by uploading from your device — no placeholder, real food photos.
5. Waiter taps items to add to cart on the right. Quantities, special instructions ("extra spicy", "no onion") are supported per item.
6. Waiter taps **"Send to Kitchen"** → a **kitchen ticket is printed immediately** and the order appears live on the **Kitchen Display Screen** with a countdown timer (turns red after 20 minutes).
7. Items in the order can keep being added — each new batch sent to kitchen prints a **new ticket** and increments the kitchen ticket counter (tracked per shift for the X/Z report).
8. When guests are done, waiter/cashier taps **"Print Bill"** → this prints a **Proforma Bill** (marked NOT PAID) for the customer to review.
9. After the customer pays, staff opens **Payment dialog**, selects Cash/Card/Bank/Wallet/Credit, enters cash received (auto-calculates change), confirms.
10. On confirm: a **Final Receipt is printed** (marked PAID), the order is marked paid, the **table is freed automatically**, and all totals roll into the open **Cash Register**.
11. At night, manager goes to **Cash Register → Reports**, runs the **X Report** anytime (no reset, just current totals) and at close of day runs the **Z Report**, which:
    - Shows full breakdown: cash/card/wallet/credit sales, discounts, tax, kitchen ticket count, void count.
    - Asks for actual cash counted in the drawer and shows the **difference vs expected** (for transparency/no theft).
    - Prints the Z report and **closes the shift**, resetting counters for the next day.
12. **Staff & wages**: Employees screen has 3 tabs — Staff List (add/edit roles & salary), Attendance Today (check-in/check-out with live worked-hours timer, daily wage auto-applied), and Salary Payments (pay monthly/daily wages, history tracked per staff member).
13. **Customers/credit**: when a customer pays "Credit", it's tied to a customer profile with credit limit, balance, and a full ledger of debit/payment transactions — fully auditable.

---

## Why this is "no transparency loss" / audit-proof

- Every payment method is tracked separately in the register (cash/card/wallet/credit) — nothing is lumped together.
- Kitchen ticket count is incremented **every time food is sent**, not just once per order — so if a table orders 3 rounds, that's 3 tickets counted, matching physical kitchen paper.
- Voids are tracked as a separate counter — a cashier voiding orders to pocket cash will show up as void count in the Z report.
- Cash reconciliation shows **expected vs actual** with a visible +/- difference highlighted in red if off by more than a small margin.
- All ledger entries (customer credit) have running balance shown so nothing can be "lost" in editing.

---

## Project Structure

```
lib/
├── main.dart                                          # App, router, login, dashboard (part-based library)
├── screens_floor_pos.dart                             # Floor plan + POS order screen
├── screens_kitchen_menu_customers.dart                # Kitchen Display, Menu Management, Customers
├── screens_employees_reports_register_settings.dart   # Staff, Reports (X/Z), Cash Register, Settings
├── app_state.dart                                     # All Riverpod state notifiers & providers
├── domain/entities.dart                               # All business entities (pure Dart)
├── data/datasources/database.dart                     # Drift/SQLite schema + 9 DAOs + seed data
└── core/
    ├── theme/app_theme.dart                           # Material 3 dark/light theme
    └── print_service.dart                             # ESC/POS + A4 PDF printing (kitchen tickets, bills, X/Z reports)
```

This uses Dart's `part`/`part of` mechanism to keep the app as a single cohesive library with shared imports — simpler to maintain than scattered cross-imports for an app this size, while staying fully valid, idiomatic Dart.

---

## Database (SQLite via Drift) — 16 tables

| Table | Purpose |
|---|---|
| `users` | Staff accounts, roles, salary, wage type |
| `floors` / `restaurant_tables` | Floor plan & table positions/status |
| `menu_groups` / `menu_items` | Menu groups with photos, items with photos/price/cost/stock |
| `orders` / `order_items` | Live orders, kitchen ticket count, item-level status (pending→sent→preparing→ready→served) |
| `invoices` | Final paid invoices, payment method, splits |
| `customers` / `credit_ledger` | Customer profiles + full audit ledger |
| `inventory_items` | Raw material stock (low-stock flag) |
| `cash_registers` / `expenses` | Shift tracking, all payment-method totals, expenses |
| `attendance` / `salary_payments` | Staff check-in/out, wage payment history |
| `app_settings` | Key-value settings (tax %, currency, receipt width, etc.) |

---

## Setup & Run

```bash
cd restaurant_pos
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d windows
```

Seed data includes: 2 floors, 12 tables, 6 menu groups (Karahi, Biryani, Beverages, BBQ, Desserts, Rolls & Sandwiches) each pre-populated with realistic items and prices so you can test the full flow immediately.

---

## What to test first

1. Login as Owner → Dashboard.
2. Go to **Cash Register** → open register with opening cash (e.g. 5000).
3. Go to **Floor** → tap an available table → enter guests → POS opens.
4. Tap "Karahi" group → tap "Chicken Karahi" → it lands in the cart.
5. Tap **Send to Kitchen** → a print dialog appears (kitchen ticket) → check **Kitchen** screen, the order appears live.
6. Back in POS, tap **Print Bill** → proforma bill print dialog appears.
7. Tap **Pay** → choose Cash → confirm → final receipt prints → table goes green again on Floor screen.
8. Go to **Reports → X Report** to see the running totals; this does NOT reset anything.
9. Go to **Reports → Z Report**, enter the counted cash, and close the shift — this prints the Z report and resets the register.
10. Go to **Staff** → check in a waiter, then check them out — watch the worked-hours timer.
11. Go to **Menu** to add a new group with a custom photo and items with food photos from your device.
