--Roll back up steps For TDE

--Step1:
Use dbusers
Go
Alter Database dbusers Set Encryption off 

--Step2:
Use dbusers
go
Drop database encryption key 

--Step3:
Use Master
Go
Drop certificate TDE_Certificate

--Step4:--Optional
Use master
Go
Drop master key 