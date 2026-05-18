-- ============================================================
-- DDL: Creating objects for Snowflake training
-- ============================================================

-- 1. Database and schema
CREATE DATABASE IF NOT EXISTS TRAINING_DB;
CREATE SCHEMA IF NOT EXISTS TRAINING_DB.DEMO;

USE DATABASE TRAINING_DB;
USE SCHEMA DEMO;

-- 2. Employees table
CREATE OR REPLACE TABLE employees (
    id              INT PRIMARY KEY,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    department      VARCHAR(50) NOT NULL,
    position        VARCHAR(100) NOT NULL,
    hire_date       DATE NOT NULL
);

-- 3. Salaries table (monthly compensation)
CREATE OR REPLACE TABLE salaries (
    employee_id     INT NOT NULL,
    year            INT NOT NULL,
    month           INT NOT NULL,
    gross_amount    DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- 4. Stage for loading CSV files
CREATE OR REPLACE STAGE my_stage
    FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

-- 5. Verification
SELECT COUNT(*) AS employee_count FROM employees;  -- should be 100
SELECT COUNT(*) AS salary_record_count FROM salaries; -- should be 2400
SELECT * FROM employees LIMIT 5;
SELECT * FROM salaries LIMIT 5;
