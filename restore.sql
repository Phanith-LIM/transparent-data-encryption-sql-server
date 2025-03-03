-- Step 1: Create the database master key  
USE master;  
GO  
CREATE MASTER KEY  
ENCRYPTION BY PASSWORD = 'HYd@123';  
GO  

-- Step 2: Back up the certificate and the private key  
USE master;  
GO  
CREATE CERTIFICATE [TDE_Certificate]  
FROM FILE = 'C:\certs\TDE_Certificate_For_dbadatabase.cer'  
WITH PRIVATE KEY (file = 'C:\certs\TDE_dba_private_CertKey.pvk',  
DECRYPTION BY PASSWORD = 'HYd@123');


Select name, is_encrypted from sys.databases
Select * from sys.certificates