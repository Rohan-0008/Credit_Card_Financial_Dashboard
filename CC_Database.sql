-- CREDIT CARD DASHBOARD DATABASE SETUP & DATA CLEANING

-- Create a new database for the project
CREATE DATABASE cc;

-- Select the database to work on
USE cc;

-- Display all tables in the current database
SHOW TABLES;

-- Preview base transaction data
SELECT * FROM credit_card;

-- Preview base customer data
SELECT * FROM customer;

-- Check structure of customer table
DESCRIBE customer;

-- Check structure of credit_card table
DESCRIBE credit_card;


-- DATA CLEANING – DATE FORMAT STANDARDIZATION

-- Convert Week_Start_Date from string to DATE format
UPDATE credit_card
SET Week_Start_Date = STR_TO_DATE(Week_Start_Date, '%d-%m-%Y');

-- Modify column data type to DATE for better filtering & analysis
ALTER TABLE credit_card
MODIFY COLUMN Week_Start_Date DATE;


-- ADDITIONAL DATASET CLEANING (cc_add TABLE)

-- Check structure of additional credit card dataset
DESCRIBE cc_add;

-- Rename corrupted column name caused by BOM encoding issue
ALTER TABLE cc_add
RENAME COLUMN ï»¿Client_Num TO Client_Num;

-- Verify column rename
DESCRIBE cc_add;

-- Convert Week_Start_Date format in additional dataset
UPDATE cc_add
SET Week_Start_Date = STR_TO_DATE(Week_Start_Date, '%d-%m-%Y');

-- Ensure date type consistency
ALTER TABLE cc_add
MODIFY COLUMN Week_Start_Date DATE;


-- ADDITIONAL CUSTOMER DATA CLEANING (cust_add TABLE)

-- Check structure of additional customer dataset
DESCRIBE cust_add;

-- Rename corrupted column name
ALTER TABLE cust_add
RENAME COLUMN ï»¿Client_Num TO Client_Num;


-- DATA INTEGRATION / INCREMENTAL LOADING

-- Insert new transaction records into main credit_card table
-- This step was used to test dashboard auto-refresh behavior
INSERT INTO credit_card
SELECT * FROM cc_add;

-- Insert new customer records into main customer table
INSERT INTO customer
SELECT * FROM cust_add;


-- END OF SCRIPT
-- Demonstrates:
-- Database creation
-- Data cleaning
-- Date standardization
-- Column correction
-- Incremental data loading