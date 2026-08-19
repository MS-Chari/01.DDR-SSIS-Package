CREATE OR ALTER PROCEDURE etl_audit.StartBatch
    @BatchId BIGINT,
    @PackageName VARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO etl_audit.BatchAudit(BatchId,PackageName,StartTime,Status)
    VALUES(@BatchId,@PackageName,SYSUTCDATETIME(),'STARTED');
END;
GO

CREATE OR ALTER PROCEDURE etl_audit.EndBatch
    @BatchId BIGINT,
    @Status VARCHAR(20),
    @SourceRows INT=NULL,
    @StagingRows INT=NULL,
    @FinalRows INT=NULL,
    @RejectedRows INT=NULL,
    @ErrorMessage VARCHAR(2000)=NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE etl_audit.BatchAudit
    SET EndTime=SYSUTCDATETIME(), SourceRows=@SourceRows,
        StagingRows=@StagingRows, FinalRows=@FinalRows,
        RejectedRows=@RejectedRows, Status=@Status,
        ErrorMessage=@ErrorMessage
    WHERE BatchId=@BatchId;
END;
GO
