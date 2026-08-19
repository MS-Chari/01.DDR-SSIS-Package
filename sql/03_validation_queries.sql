-- Duplicate transactions
SELECT TransactionId, COUNT(*) AS DuplicateCount
FROM etl_stg.[Transaction]
GROUP BY TransactionId
HAVING COUNT(*) > 1;

-- Invalid amounts
SELECT * FROM etl_stg.[Transaction]
WHERE Amount IS NULL OR Amount < 0;

-- Missing customer IDs
SELECT * FROM etl_stg.Customer
WHERE CustomerId IS NULL;

-- Unknown customers
SELECT t.*
FROM etl_stg.[Transaction] t
LEFT JOIN etl_stg.Customer c ON c.CustomerId=t.CustomerId
WHERE c.CustomerId IS NULL;

-- Batch reconciliation
SELECT BatchId, COUNT(*) AS StagingRows
FROM etl_stg.[Transaction]
GROUP BY BatchId;
