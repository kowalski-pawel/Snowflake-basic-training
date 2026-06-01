# Snowflake Basics Training - Workshop Setup Guide

## Prerequisites

- A Snowflake account (trial or existing)
  - Region: **AWS US East (N. Virginia)** or **AWS Europe (Frankfurt)** — required for Cortex Analyst
- Access to Snowsight (web UI)

---

## Step 1: Create the Database and Tables

1. Open **Snowsight** and navigate to **Worksheets**
2. Create a new SQL worksheet
3. Open or paste the contents of `setup_tables.sql`
4. Run the statements **in order**:
   - Creates `TRAINING_DB` database and `DEMO` schema
   - Creates `employees` and `salaries` tables
   - Creates a file stage (`my_stage`) for CSV uploads

---

## Step 2: Upload CSV Files and Load Data

### Option A — Load via UI (recommended for beginners)

1. Go to **Databases** → `TRAINING_DB` → `DEMO` → **Tables**
2. Click `EMPLOYEES` → **Load Data** (top-right)
3. Select `employee.csv`, set format: CSV
4. Click **Load**
5. Repeat for `SALARIES` table using `salary.csv`

### Option B — Load via Stage (SQL)

1. Go to **Databases** → `TRAINING_DB` → `DEMO` → **Stages** → `MY_STAGE`
2. Upload both `employee.csv` and `salary.csv` to the stage
3. Run the COPY INTO statements from `setup_tables.sql`:

```sql
COPY INTO employees
FROM @my_stage/employee.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"');

COPY INTO salaries
FROM @my_stage/salary.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"');
```

### Verify

```sql
SELECT COUNT(*) FROM employees;  -- expected: 100
SELECT COUNT(*) FROM salaries;   -- expected: 2400
```

---

## Step 3: Create the Semantic View via Snowsight UI

1. In Snowsight, go to **AI & ML** → **Analyst**
2. Click **+ Create with Autopilot**
3. Set the name: `TRAINING_SEMANTIC_VIEW`
4. Set the database/schema: `TRAINING_DB` → `DEMO`
5. **Select Tables:**
   - Click `TRAINING_DB` → `DEMO`
      → select `TRAINING_DB.DEMO.EMPLOYEES`
      → select `TRAINING_DB.DEMO.SALARIES`
   - Click `Next`
6. Select all colums from both tables
7. Click **Create**
8. 

---

## Step 4: Test with Cortex Analyst

1. In Snowsight, go to **AI & ML** → **Analyst**
2. Select semantic view: `TRAINING_DB.DEMO.TRAINING_SEMANTIC_VIEW`
3. Go to `Playground` - almost top-rigth corner
4. Ask questions in natural language, e.g.:
   - "How many employees are in each department?"
   - "Who earns the most?"
   - "Show average salary by department"

---

## Step 5: Create a Streamlit App (Cortex Analyst chatbot)

1. In Snowsight, go to **Projects** → **Streamlit**
2. Click **+ Streamlit App**
3. Set the name (e.g. `Cortex_Analyst_Chatbot`)
4. Set the database/schema: `TRAINING_DB` → `DEMO`
5. Choose a warehouse to run the app
6. Click **Create**
7. In the editor, replace the default code with the contents of `streamlit_app.py`
8. Click **Run** — the app lets you ask questions in natural language via Cortex Analyst

---

## Files Overview

| File | Description |
|------|-------------|
| `employee.csv` | 100 employee records |
| `salary.csv` | 2400 monthly salary records (100 employees x 24 months) |
| `setup_tables.sql` | DDL: database, tables, stage, and data loading |
| `streamlit_app.py` | Streamlit chatbot app using Cortex Analyst |
