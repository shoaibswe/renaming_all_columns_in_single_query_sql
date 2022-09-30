
DROP PROCEDURE IF EXISTS rename_updated ;
CREATE PROCEDURE rename_updated()

BEGIN
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 

set @i=0;
select count(TABLE_NAME) into @loopupto FROM information_schema.columns where COLUMN_NAME ='updatedAt';

WHILE @i <= @loopupto DO
	 PREPARE tbl FROM 'select TABLE_NAME FROM information_schema.columns where COLUMN_NAME=\'updatedAt\' order by TABLE_NAME ASC limit ? into @tablename';
		EXECUTE tbl using @i;

		 SET @statement = CONCAT('ALTER table ', @tablename,' rename COLUMN updatedAt to updated_at'); 
		 PREPARE run FROM @statement;
		 EXECUTE run;
			SET @i = @i+ 1;
	   END WHILE;  
END