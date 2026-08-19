# SSIS ETL Pipeline – Multi-Source Data Integration

Portfolio project using synthetic data to demonstrate enterprise-style SQL Server Integration Services (SSIS) ETL.

> **Portfolio disclaimer:** This repository contains no client/proprietary data, credentials, or confidential code. The examples use synthetic data and generic enterprise ETL patterns.

## Objective
- Extract data from CSV and SQL sources
- Validate source data before loading
- Load SQL Server staging tables
- Apply transformations and business rules
- Load curated warehouse tables
- Capture audit, error, and reconciliation information
- Support incremental processing

## Architecture

```text
CSV / SQL Sources
       |
       v
SSIS Control Flow
  |    |     |
Precheck Audit Parameters
       |
       v
SQL Server STAGING
       |
Validation / Transformation
       |
       v
SQL Server FINAL
    /       \
 Audit   Reconciliation
```

## Technology
**SQL Server | SSIS | T-SQL | SQL Server Agent | CSV | ETL | Data Validation | Incremental Loads**

## Packages
### 01_STG_Load.dtsx
Start Audit → Source Checks → Customer Load → Transaction Load → Validation → End Audit

### 02_Final_Load.dtsx
Start Audit → Customer Transformation → Transaction Transformation → Reconciliation → End Audit

## SSIS Components
Flat File Source, OLE DB Source, Lookup, Derived Column, Data Conversion, Conditional Split, OLE DB Destination, Row Count, Execute SQL Task.

## Business Rules
1. Customer ID cannot be null.
2. Transaction ID must be unique.
3. Transaction amount must be >= 0.
4. Transaction date is mandatory.
5. Invalid records are rejected and audited.
6. Incremental loads prevent duplicate transactions.

## Audit
Each run captures Batch ID, package name, start/end time, source rows, staging rows, final rows, rejected rows, status, and error message.

## Repository Structure
```text
README.md
architecture.md
docs/ssis_package_design.md
config/package_parameters.md
sql/01_create_database_objects.sql
sql/02_stored_procedures.sql
sql/03_validation_queries.sql
sample_data/customers.csv
sample_data/transactions.csv
```

## Portfolio Note
The implementation is intentionally generic and is not copied from any employer/client implementation.
