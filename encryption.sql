---- Show all which database hae been encrypted
Select name, is_encrypted from sys.databases

--Step1:Take the full database backup of Dba
BACKUP DATABASE [dbusers] TO  DISK = N'C:\sqlbackups\dbusers1.bak' WITH NOFORMAT, NOINIT,  
NAME = N'dba-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Step2:Create database master key
USE master;
Go
CREATE MASTER KEY 
ENCRYPTION BY PASSWORD = 'HYd@123';
GO

--Step3:Create certificate
USE master;
GO 
CREATE CERTIFICATE TDE_Certificate
WITH SUBJECT='Certificate for TDE';
GO

--Step4:Create database encryption key
USE dbusers
GO
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE TDE_Certificate;  

--Step5:Back up the certificate and the private key associated with the certificate
USE master;
GO
BACKUP CERTIFICATE [TDE_Certificate]
TO FILE = 'C:\certs\TDE_Certificate_For_dbadatabase.cer'
WITH PRIVATE KEY (file='C:\certs\TDE_dba_private_CertKey.pvk',
ENCRYPTION BY PASSWORD='HYd@123');

--Step6:Turn on encryption on database
ALTER DATABASE dbusers
SET ENCRYPTION ON

--Step8:Check encryption enabled
Select name, is_encrypted from sys.databases
Select * from sys.certificates
