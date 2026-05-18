-- Loading data (after uploading files to the stage)
-- Upload files: in Snowsight -> Databases -> TRAINING_DB -> DEMO -> Stages -> MY_STAGE -> Upload

COPY INTO employees
FROM @my_stage/employee.csv
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

COPY INTO salaries
FROM @my_stage/salary.csv
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');
