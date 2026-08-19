IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name='etl_stg') EXEC('CREATE SCHEMA etl_stg');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name='etl_dw') EXEC('CREATE SCHEMA etl_dw');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name='etl_audit') EXEC('CREATE SCHEMA etl_audit');
GO

CREATE TABLE etl_stg.Customer (
    CustomerId INT NOT NULL,
    CustomerName VARCHAR(200),
    Email VARCHAR(250),
    CountryCode CHAR(2),
    ModifiedDate DATETIME2 NOT NULL,
    BatchId BIGINT NOT NULL
);
GO

CREATE TABLE etl_stg.[Transaction] (
    TransactionId BIGINT NOT NULL,
    CustomerId INT,
    TransactionDate DATE,
    Amount DECIMAL(18,2),
    Status VARCHAR(30),
    ModifiedDate DATETIME2 NOT NULL,
    BatchId BIGINT NOT NULL
);
GO

CREATE TABLE etl_dw.DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT NOT NULL UNIQUE,
    CustomerName VARCHAR(200),
    Email VARCHAR(250),
    CountryCode CHAR(2),
    ModifiedDate DATETIME2 NOT NULL
);
GO

CREATE TABLE etl_dw.FactTransaction (
    TransactionId BIGINT PRIMARY KEY,
    CustomerKey INT NOT NULL,
    TransactionDate DATE NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    Status VARCHAR(30),
    BatchId BIGINT NOT NULL
);
GO

CREATE TABLE etl_audit.BatchAudit (
    BatchId BIGINT PRIMARY KEY,
    PackageName VARCHAR(200) NOT NULL,
    StartTime DATETIME2 NOT NULL,
    EndTime DATETIME2 NULL,
    SourceRows INT NULL,
    StagingRows INT NULL,
    FinalRows INT NULL,
    RejectedRows INT NULL,
    Status VARCHAR(20) NOT NULL,
    ErrorMessage VARCHAR(2000) NULL
);
GO

CREATE TABLE etl_audit.RejectedRecord (
    RejectId BIGINT IDENTITY(1,1) PRIMARY KEY,
    BatchId BIGINT NOT NULL,
    SourceName VARCHAR(100) NOT NULL,
    BusinessKey VARCHAR(100),
    ErrorCode VARCHAR(50) NOT NULL,
    ErrorDescription VARCHAR(500) NOT NULL,
    RejectedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO
