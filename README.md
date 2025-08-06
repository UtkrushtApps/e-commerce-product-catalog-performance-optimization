# Task Overview
The Utkrusht e-commerce team has launched a product catalog API built using FastAPI and PostgreSQL. Product browsing—with filters on category and brand—is significantly slower than expected, taking 3–4 seconds for each request. The lack of proper database indexing has made filtered product searches sluggish as the number of items grows, directly impacting user experience and business sales.

# Guidance
- Product listing is slow when filtering by both category and brand.
- The issue is due to the way the PostgreSQL database handles filtering and sorting;
  product and filter columns are not indexed for these queries.
- There's no need to change FastAPI endpoints or validation logic—focus entirely on optimizing the PostgreSQL schema and queries for performance improvements.
- Use EXPLAIN and pg_stat_statements to analyze performance.
- Ensure your optimizations do not break any existing API routes or data relationships.

# Database Access
- Host: <DROPLET_IP>
- Port: 5432
- Database: utkrusht_db
- Username: utkrusht
- Password: skills123
- You can use any PostgreSQL client (e.g., psql, pgAdmin, DBeaver) to examine the schema and query performance.

# Objectives
- Identify and fix slow product filtering by optimizing the PostgreSQL tables and queries.
- Create a composite B-tree index on the products table to speed up WHERE queries using category_id and brand_id.
- Ensure correct filtering and fast response times for the /products endpoint (with both filters applied).
- Validate that all product listings, with and without filters, are correct and load much faster than before.

# How to Verify
- Call the /products endpoint with various filter combinations (category, brand) before and after your changes—response times should drop from 3-4s to well below 1s.
- Use EXPLAIN or EXPLAIN ANALYZE to see that the optimized queries now use your composite index instead of full table scans.
- Confirm that the API continues to behave as expected, producing accurate filtered results with no errors.
- (Optional) Use pg_stat_statements to monitor and verify that query execution times have improved for the affected SELECT statements.