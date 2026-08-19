# Architecture

```text
+----------------------+
| CSV / SQL Sources    |
+----------+-----------+
           |
           v
+----------------------+
| SSIS Control Flow    |
| Parameters           |
| Pre-checks           |
| Audit initialization |
+----------+-----------+
           |
           v
+----------------------+
| SQL Server STAGING   |
| Customer             |
| Transaction          |
+----------+-----------+
           |
     Validation/Rules
           |
           v
+----------------------+
| SQL Server FINAL     |
| DimCustomer          |
| FactTransaction      |
+----------+-----------+
      +----+----+
      |         |
      v         v
    Audit   Reconciliation
```

Invalid records flow to an audit/rejection table with batch ID, business key, error code, and description.
