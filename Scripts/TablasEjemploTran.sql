-- Ejemplo de TRansacciones
USE BaseDatosII
GO
DECLARE @DEL_ERROR INT, @INS_ERROR INT
BEGIN TRAN
	DELETE AUTHORS WHERE AU_ID = '409-56-7088'
	SELECT @DEL_ERROR = @@ERROR
	INSERT AUTHORS VALUES ('409-56-7088', 'BENNET', 'ABRAHAM', '415 658-9932',
	'6223 BATEMAN ST.', 'BERKELEY', 'CA', '94705', 1)
	SELECT @INS_ERROR = @@ERROR
	IF @DEL_ERROR = 0 AND @INS_ERROR = 0
		BEGIN
			PRINT 'NO HAY ERRORES'
			COMMIT TRAN
		END
	ELSE
		BEGIN
			IF @DEL_ERROR <> 0
				PRINT 'HAY ERROR EN EL DELETE'
				PRINT @INS_ERROR
			IF @INS_ERROR <> 0
				PRINT 'HAY ERROR EN EL INSERT'
				PRINT @INS_ERROR
			ROLLBACK TRAN
		END
		
--Manejo de Bases de Datos SQl TRanSAC
select * from SysDataBases

CREATE DATABASE Ejemplo 
On  Primary  
(Name = EjemploData,  
Filename = 'C:\Temp\Ejemplo.MDF',  
Size = 5MB,  MaxSize = 10MB,  
Filegrowth = 20%)  
Log on  
(NAME = EjemploLog,  
Filename = 'C:\Temp\EjemploLog.ldf',  
Size = 3MB,  
MaxSize = 5MB,  
FileGrowth = 1MB)

SP_HELPDB

use Historicos
exec SP_spaceused

select * from SysDataBases

select * from pubs