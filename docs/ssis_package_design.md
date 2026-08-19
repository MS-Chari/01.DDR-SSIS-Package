# SSIS Package Design

## Package 1: 01_STG_Load.dtsx

### Customer Data Flow
Flat File Source → Data Conversion → Derived Column → Conditional Split → OLE DB Destination

### Transaction Data Flow
CSV Source → Data Conversion → Lookup Customer → Conditional Split → OLE DB Destination

Invalid records are redirected to the rejection table.

## Package 2: 02_Final_Load.dtsx

### Customer
STG Customer → Data Quality Check → Lookup Existing Customer → New/Existing Split → DimCustomer

### Transaction
STG Transaction → Lookup Customer Key → Business Rules → Duplicate Check → FactTransaction

## Error Handling
Use SSIS event handlers for OnError and OnTaskFailed. Store package/task information in the audit table.

## Performance
Use appropriate OLE DB batch sizes, indexed lookup keys, staging-first processing, and incremental loads.
