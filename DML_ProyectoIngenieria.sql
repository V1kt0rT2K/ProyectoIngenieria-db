USE ProyectoIngenieria
GO

------------INITIAL INSERTS--------------

INSERT INTO asset.tblStatusTypes(statusTypeName)
VALUES	('Estados de Solicitud'),
		('Estados de Orden de Compra');
GO

INSERT INTO asset.tblStatus(statusName, statusDescription, idStatusType)
VALUES	('Aprobado','La solicitud fue revisada y aprobada con éxito.', 1),
		('Revisión','La solicitud esta pendiente de revisión.', 1),
		('Denegado','La solicitud fue revisada y denegado con éxito.',1),
		('En Camino','La orden de compra fue realizada y se esta esperando la recepción.',2),
		('Por Ingresar','La orden de compra fue recibida y se debe ingresar al sistema.',2),
		('Ingresado','La orden de compra fue ingresada al sistema.',2);

GO

INSERT INTO asset.tblStageTypes(stageTypeName,stageTypeDescription)
VALUES	('PORCINO','Etapas del ciclo productivo en porcinocultura');
GO


INSERT INTO asset.tblStages(stageName, stageDescription,idStageType)
VALUES	('Pre-Inicio','Fase neonatal desde el nacimiento hasta el destete (0-21 días). Cuidados intensivos en temperatura y alimentación líquida.', 1),
		('Inicio','Periodo post-destete (21-63 días). Adaptación a alimento sólido, desarrollo del sistema digestivo e inmunitario.', 1),
		('Crecimiento','Etapa de rápido desarrollo muscular (63-112 días). Máxima eficiencia alimenticia y crecimiento óseo.', 1),
		('Desarrollo','Fase de terminación (112-168 días). Maduración tisular y consolidación del crecimiento.', 1),
		('Engorde','Periodo final de acabado (>168 días). Acumulación de grasa intramuscular y preparación para mercado.', 1);
GO

INSERT INTO users.tblUserRoles(roleName,roleDescription, show)
VALUES	('SYSADMIN', 'Desarrollador' , 0),
		('Administrador', 'Usuario encargado de supervisar el sistema.' , 0),
		('Cajero', 'Usuario que realiza ventas en mostrador', 1),
		('Encargado de Almacén','Usuario encargado de supervisar los ingresos y egresos de inventarios.', 1);
GO


--------USERS INSERTS ----------

INSERT INTO users.tblPersons(identityNumber,firstName,secondName,lastName,secondLastName)
VALUES	('0715200500005','VIKTOR', 'ANDRE','HERNANDEZ', 'VELASQUEZ'),
		('0801198508594','MARIA', 'GONZALEZ','HERNANDEZ', 'VELASQUEZ'),
		('0801198502131','JUAN', 'MANUEL','MENGANO', 'VELASQUEZ'),
		('0801198534423','FULANO', 'DETAL','HERNANDEZ', 'VELASQUEZ');

INSERT INTO users.tblUsers(email,job,password,isEnabled,idPerson,idRole)
VALUES	('viktor.hernandez@gmail.com','SYSADMIN', 'cdcb7422ca0fe077931b84e6fb7e6dfb7d6678dc7e9ae9c4335e98edc7d5761a', 1,1,1),
		('administrador@gmail.com','ADMINISTRADOR', 'cea115f6db0fcae5bc6b1148d07249e446d0e295382fb562e6ca4d7a354525fe', 1,2,2),
		('cajero@gmail.com','CAJERO', 'cea115f6db0fcae5bc6b1148d07249e446d0e295382fb562e6ca4d7a354525fe', 1,3,3),
		('almacen@gmail.com','ENCARGADO DE ALMACEN', 'cea115f6db0fcae5bc6b1148d07249e446d0e295382fb562e6ca4d7a354525fe', 1,4,4);
GO

INSERT INTO users.tblUserRolesHistoric(idUser, oldRoleId, newRoleId)
VALUES	(1,2,3),
		(1,3,1),
		(2,3,2);

INSERT INTO users.tblUserRequests(idUser,idRole,idStatus, userName,email,job)
VALUES	(1,2,1,'VIKTOR HERNANDEZ','viktor.hernandez@gmail.com', 'GERENTE'),
		(2,3,2,'FULANO DE TAL', 'fulano@gmail.com', 'CAJERO');
GO
----------- TEST INSERTS -----------

INSERT INTO stock.tblSwineBatches(quantity,birthDate,idStage, stockQuantity)
VALUES	(10,'2025-07-25 00:31:45.853',2, 5),
		(9,'2025-07-25 00:31:45.853',5, 9);
GO

INSERT INTO stock.tblProducts(productName,productDescription, price, orderPoint)
VALUES	('Cabeza', 'Incluye orejas, morro, cachetes y cabeza completa para caldos o barbacoa', 200, 5),
		('Lomo', 'Corte magro y tierno, ideal para chuletas, filetes o asar entero', 29, 5),
		('Costilla', 'Incluye las costillas (chuletas) con hueso, para parrilla o ahumados', 37, 5),
		('Pierna', 'También llamada jamón, usado para asar, curar o hacer jamones serranos', 56, 5),
		('Paleta', 'Parte delantera similar al jamón pero con más grasa intramuscular', 11, 5),
		('Panceta', 'También llamado tocino o bacon (curado), parte ventral del cerdo', 23, 5),
		('Chuletón', 'Corte premium del lomo alto con hueso', 24, 5),
		('Solomillo', 'Corte más tierno y valioso, pequeño y magro', 78, 5),
		('Espaldilla', 'Corte económico de la parte superior delantera', 50, 5),
		('Rabo', 'Usado principalmente para guisos y caldos', 11, 7),
		('Chicharrón', 'Piel de cerdo frita o asada', 20, 5),
		('Cerdo', 'Unidad de cerdo entero para la venta.', 1000, 5);
GO

INSERT INTO stock.tblProductBatches(stockQuantity,idProduct,expirationDate)	--Numero aleatorio entre 1 y 30 para la cantidad
SELECT ROUND(1 + RAND(idProduct)*29, 2), idProduct, DATEADD(DAY, FLOOR(15 + RAND(idProduct)*29) , GETDATE()) --Esa cantidad se suma a la fecha para la expiracion
FROM stock.tblProducts;
GO

INSERT INTO stock.tblProductBatches(stockQuantity,idProduct,expirationDate)	--Numero aleatorio entre 1 y 30 para la cantidad
SELECT TOP 3 ROUND(1 + RAND(idProduct)*29, 2), idProduct, DATEADD(DAY, FLOOR(15 + RAND(idProduct)*29) , GETDATE()) --Esa cantidad se suma a la fecha para la expiracion
FROM stock.tblProducts;
GO

INSERT INTO stock.tblProductions(idSwineBatch,idProduct,quantity)
SELECT 2, sct.idProduct, ROUND(1 + RAND(sct.idProduct)*15, 2)
FROM stock.tblProducts AS sct;
GO

INSERT INTO supply.tblSupplyTypes(nameSupplyType)
VALUES	('Desparasitantes'),
		('Vitaminas'),
		('Concentrado'),
		('Herramientas');
GO

INSERT INTO supply.tblSupplies(nameSupply,idSupplyType,idStage, orderPoint)
VALUES
     --Vacunas para Pre-Inicio (0-21 días)
    ('Ivermectina neonatal', 1, 1, 5),          -- Tipo: Parásitos
    ('Complejo vitamínico ADE', 2, 1, 5),       -- Tipo: Vitaminas
    ('Desparasitante lactante', 1, 1, 5),       -- Tipo: Parásitos
     --Vacunas para Inicio (21-63 días)
    ('Levamisol crecimiento', 1, 2, 5),         -- Tipo: Parásitos
    ('Vitamina B12 + Hierro', 2, 2, 5),         -- Tipo: Vitaminas
    ('Anti-coccidiosico', 1, 2, 5),             -- Tipo: Parásitos
     --Vacunas para Crecimiento (63-112 días)
    ('Dexametasona vitamínica', 2, 3, 5),       -- Tipo: Vitaminas
    ('Antihelmíntico broad-spectrum', 1, 3, 5), -- Tipo: Parásitos
    ('Complejo B inyectable', 2, 3, 5),         -- Tipo: Vitaminas
     --Vacunas para Desarrollo (112-168 días)
    ('Vitamina E + Selenio', 2, 4, 5),          -- Tipo: Vitaminas
    ('Fenbendazol oral', 1, 4, 5),              -- Tipo: Parásitos
    ('Aminoácidos esenciales', 2, 4, 5),        -- Tipo: Vitaminas
     --Vacunas para Engorde (>168 días)
    ('Desparasitante pre-sacrificio', 1, 5, 5), -- Tipo: Parásitos
    ('Vitamina K antihemorrágica', 2, 5, 5),    -- Tipo: Vitaminas
    ('Minerales quelados', 2, 5, 5),            -- Tipo: Vitaminas
	------CONCENTRADO-----
	('Leche maternizada premium',3 , 1, 5),
    ('Pre-starter 22% proteína',3, 1, 5),
    ('Suplemento vitamínico lactante',3, 1, 5),
    ('Starter 20% proteína',3, 2, 5),
    ('Dieta post-destete probiótica',3, 2, 5),
    ('Crecimiento inicial 18% proteína',3, 2, 5),
    ('Dieta crecimiento 16% proteína',3, 3, 5),
    ('Mix energético maíz-soja',3, 3, 5),
    ('Suplemento mineral crecimiento',3, 3, 5),
    ('Dieta desarrollo 14% proteína',3, 4, 5),
    ('Alto rendimiento terminación',3, 4, 5),
    ('Fibra control desarrollo',3, 4, 5),
    ('Dieta acabado 12% proteína',3, 5, 5),
    ('Mezcla pre-mercado grasa intramuscular',3, 5, 5),
    ('Suplemento finalización',3, 5, 5);
GO

INSERT INTO supply.tblSupplyBatches(idSupply, quantity,expirationDate)
SELECT idSupply, FLOOR(1 + RAND(idSupply)*10), DATEADD(DAY, FLOOR(1 + RAND(idSupply)*29) , GETDATE())
FROM supply.tblSupplies;
GO

INSERT INTO supply.tblSupplyBatches(idSupply, quantity,expirationDate)
SELECT TOP 3 idSupply, FLOOR(1 + RAND(idSupply)*10), DATEADD(DAY, FLOOR(1 + RAND(idSupply)*29) , GETDATE())
FROM supply.tblSupplies;
GO

INSERT INTO supply.tblSwineSupplies(idSupply,idSwineBatch,quantity,idUser)
VALUES	(4, 1, 10, 1),
		(14, 2, 9, 1);
GO


INSERT INTO sales.tblCaiCodes(code,establishmentRTN)
VALUES	('35DB45-58RFG5-34DF3R-23KGT5-98UIP4-2A','2711-5621-12281');
GO

INSERT INTO sales.tblCaiCodeRanges(idCaiCode,startRange,endRange,expirationDate)
VALUES	(1,'000-007-01-00000056','000-007-01-00000065', DATEADD(MONTH,1,GETDATE()));
GO


INSERT INTO sales.tblClients(identityNumber)
VALUES	('0801198300332'),
		('0715200100923');

INSERT INTO sales.tblSalesChecks(idUser,subTotal,ISV,idClient, idCaiCodeRange, saleCheckCode)
VALUES	(1,32982,1231,1, 1,'000-007-01-00000056'),
		(1,43221,442,1, 1 , '000-007-01-00000057'),
		(1,3242,1141,2, 1 , '000-007-01-00000058'),
		(1,999,1341,2, 1 , '000-007-01-00000059');
GO

INSERT INTO sales.tblSalesChecksDetails(idSalesCheck,idProduct,quantity)
VALUES	(1,4,19.2),
		(1,2,15.2),
		(1,6,3),
		(2,9,14.8),
		(2,7,19.2),
		(3,6,19.2),
		(3,11,19.2),
		(4,10,19.2);
GO



