------------INITIAL INSERTS--------------

INSERT INTO asset.tblStatusTypes(statusTypeName)
VALUES	('Solicitud');
GO

INSERT INTO asset.tblStatus(statusName, statusDescription, idStatusType)
VALUES	('Aprobado','La solicitud fue revisada y aprobada con éxito.', 1),
		('Revisión','La solicitud esta pendiente de revisión.', 1),
		('Denegado','La solicitud fue revisada y denegado con éxito.',1);

GO

INSERT INTO asset.tblStageTypes(stageTypeName,description)
VALUES	('PORCINO','INICIAL');
GO


INSERT INTO asset.tblStages(stageName, description,idStageType)
VALUES	('Pre-Inicio','Edad temprana.', 1),
		('Inicio','Edad ', 1),
		('Crecimiento','Edad en crecimiento.', 1),
		('Desarrollo','Chancho grande', 1),
		('Engorde','Chancho gordo.', 1);
GO

INSERT INTO users.tblUserRoles(roleName,roleDescription, show)
VALUES	('Administrador', 'Usuario encargado de supervisar el sistema.' , 0),
		('Cajero', 'Usuario que realiza ventas en mostrador', 1),
		('Encargado de Almacén','Usuario encargado de supervisar los ingresos y egresos de inventarios.', 1);
GO


--------USERS INSERTS ----------

INSERT INTO users.tblPersons(identityNumber,firstName,secondName,lastName,secondLastName)
VALUES	('0715200500005','VIKTOR', 'ANDRE','HERNANDEZ', 'VELASQUEZ'),
		('0801198508594','FULANO', 'DETAL','HERNANDEZ', 'VELASQUEZ');

INSERT INTO users.tblUsers(email,job,password,isEnabled,idPerson,idRole)
VALUES	('viktor.hernandez@gmail.com','ADMINISTRADOR DEL SISTEMA', 'contrasena', 1,1,1),
		('fulano@gmail.com','CAJERO', '123456@F', 1,2,2);

GO