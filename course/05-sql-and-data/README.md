# Module 5: SQL and Data

## 1. Learning Objectives
By the end of this module, you will understand:
- How to structure a basic relational dataset.
- How primary and foreign keys enforce data integrity.
- How to query the mock dataset using pgAdmin.

## 2. Concept Explanation

### The Mock E-Commerce Dataset
A database is only useful if it has data. We created a mock dataset consisting of four tables:

1. **customers**: Stores user information. 
   - Primary Key: `customer_id`
2. **products**: Stores the items available for sale.
   - Primary Key: `product_id`
3. **orders**: Stores the transactional event of a purchase.
   - Primary Key: `order_id`
   - Foreign Key: `customer_id` (links the order to the customer who made it).
4. **order_items**: Since an order can have multiple products, this table resolves the many-to-many relationship between orders and products.
   - Primary Key: `order_item_id`
   - Foreign Keys: `order_id` and `product_id`.

### Data Types and Constraints
In our `01-schema.sql` file, you'll notice constraints like `NOT NULL` (a value must be provided) and `UNIQUE` (no two customers can have the same email). We use `DECIMAL(10, 2)` for prices to handle currency correctly.

We also use `ON DELETE CASCADE` for orders. If a customer is deleted, all their associated orders are deleted automatically. However, for products, we use `ON DELETE RESTRICT`. You cannot delete a product if an order item references it (to preserve historical sales data).

## 3. Hands-on Exercise: Executing SQL in pgAdmin

Let's test our data. Open pgAdmin, right-click the `analytics_db` database, and select **Query Tool**.

**Query 1: See all customers**
```sql
SELECT * FROM customers;
```

**Query 2: Calculate total revenue per order**
Copy and paste this into the Query Tool and click the "Execute/Refresh" (Play) button:
```sql
SELECT 
    o.order_id, 
    c.first_name, 
    c.last_name, 
    SUM(oi.quantity * oi.unit_price) AS total_order_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.first_name, c.last_name
ORDER BY total_order_value DESC;
```

## 4. Verification
If the query above returns a list of orders with their calculated total values, your database layer is 100% complete and working!

## 5. Summary
You now have a fully functioning database layer with a realistic mock dataset. However, not everyone in an organization knows SQL. In the next phase, we will introduce Metabase to allow business users to build dashboards visually.
