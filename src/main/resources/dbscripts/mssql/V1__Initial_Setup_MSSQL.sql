 IF OBJECT_ID(
		 N'dbo.[version]', N'U'
 ) IS NULL 
	BEGIN 
		CREATE TABLE dbo.[version] 
			([next_update] INT NOT NULL); 
		END;

 go
 
 truncate table dbo.[version]
 
 INSERT INTO dbo.[version] 
	(next_update) 
		VALUES 
			(170);
