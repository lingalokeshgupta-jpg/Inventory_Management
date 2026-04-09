Inventory Management System (MySQL)

Project Overview

This project is a database-driven Inventory Management System built using MySQL. It manages suppliers, products,
and orders while ensuring real-time stock updates and data consistency using advanced SQL concepts.

Features

* CRUD operations on all tables
* Relational database design (Primary & Foreign Keys)
* JOIN queries for detailed reports
* Aggregate functions for sales analysis
* Stored Procedures for order placement with validation
* Triggers for automatic stock updates
* Views for simplified reporting


Database Structure

1. Suppliers

* Stores supplier details
* Primary key: `suppliers_id`

2. Products

* Stores product information (price, quantity)
* Foreign key: `suppliers_id`

3. Orders

* Stores order transactions
* Foreign key: `product_id`



How to Run

1. Open MySQL Workbench / CLI
2. Import or run the SQL file:

   ```sql
   SOURCE inventory_management.sql;
   ```
3. Execute stored procedure:

   ```sql
   CALL place_order(1, 5);
   ```
4. View reports:

   ```sql
   SELECT * FROM sales_report;
   ```

Sample Queries

```sql
-- Total sales
SELECT SUM(p.price * o.quantity) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.product_id;

-- Low stock alert
SELECT product_name, quantity
FROM products
WHERE quantity < 20;
```

---

Key Highlights

* Automated stock management using triggers
* Data validation using stored procedures
* Clean and structured database design
* Real-world inventory use case implementation

 Future Improvements

* Add user interface (Web/App)
* Implement authentication system
* Add advanced analytics dashboard


