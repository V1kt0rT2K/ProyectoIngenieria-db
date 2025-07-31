USE ProyectoIngenieria
GO

------------INITIAL INSERTS--------------

INSERT INTO asset.tblStatusTypes(statusTypeName)
VALUES	('Estados de Solicitud'),
		('Estados de Orden de Compra'),
		('Estados de Pedido de Venta');
GO

-----DEJAR LA SUCESION DE LOS INSERTS DE STATUS RESPECTO A LA PROGRESION DE CADA UNO
INSERT INTO asset.tblStatus(statusName, statusDescription, idStatusType)
VALUES	('Aprobado','La solicitud fue revisada y aprobada con éxito.', 1),
		('Revisión','La solicitud esta pendiente de revisión.', 1),			------DEJAR SIEMPRE EL ESTADO REVISION COMO SEGUNDO
		('Denegado','La solicitud fue revisada y denegado con éxito.',1),
		('En Camino','La orden de compra fue realizada y se esta esperando la recepción.',2),
		('Por Ingresar','La orden de compra fue recibida y se debe ingresar al sistema.',2),
		('Ingresado','La orden de compra fue ingresada al sistema.',2),
		('Cancelado', 'La orden de compra fue cancelada', 2),
		('Pendiente','El pedido esta pendiente para su entrega.',3),
		('Entregado','El pedido fue entregado.',3);

GO

INSERT INTO asset.tblStageTypes(stageTypeName,stageTypeDescription)
VALUES	('PORCINO','Etapas del ciclo productivo en porcinocultura');
GO


INSERT INTO asset.tblStages(stageName, stageDescription,idStageType, stageTime)
VALUES	('Pre-Inicio','Fase neonatal desde el nacimiento hasta el destete (0-21 días). Cuidados intensivos en temperatura y alimentación líquida.', 1, 1),
		('Inicio','Periodo post-destete (21-63 días). Adaptación a alimento sólido, desarrollo del sistema digestivo e inmunitario.', 1, 2),
		('Crecimiento','Etapa de rápido desarrollo muscular (63-112 días). Máxima eficiencia alimenticia y crecimiento óseo.', 1,3),
		('Desarrollo','Fase de terminación (112-168 días). Maduración tisular y consolidación del crecimiento.', 1, 4),
		('Engorde','Periodo final de acabado (>168 días). Acumulación de grasa intramuscular y preparación para mercado.', 1, 5);
GO

INSERT INTO users.tblUserRoles(roleName,roleDescription, show)
VALUES	('Administrador', 'Usuario encargado de supervisar el sistema.' , 0),
		('Cajero', 'Usuario que realiza ventas en mostrador', 1),
		('Encargado de Almacén','Usuario encargado de supervisar los ingresos y egresos de inventarios.', 1),
		('SYSADMIN', 'Desarrollador' , 0),	----DEJAR SYSADMIN SIEMPRE CON ID 4
		('Encargado de Ventas', 'Usuario que maneja los pedidos para venta de productos.' , 1),
		('Operador de Granja', 'Usuario que realiza la gestión con los lotes de cerdos.' , 1)
GO


INSERT INTO asset.tblActions(actionName)
VALUES	('getAllUsers'),
		('searchUsers'),
		('updateUser');

--------USERS INSERTS ----------

INSERT INTO users.tblPersons(identityNumber,firstName,secondName,lastName,secondLastName)
VALUES	('0715200500005','VIKTOR', 'ANDRE','HERNANDEZ', 'VELASQUEZ'),
		('0801198508594','MARIA', 'GONZALEZ','HERNANDEZ', 'VELASQUEZ'),
		('0801198502131','JUAN', 'MANUEL','MENGANO', 'VELASQUEZ'),
		('0801198534423','FULANO', 'DETAL','HERNANDEZ', 'VELASQUEZ'),
		('0801198500002','PEDRO', 'ARMANDO','HERNANDEZ', 'VELASQUEZ'),
		('0801198577721','MENGANO', 'DETAL','HERNANDEZ', 'VELASQUEZ');

INSERT INTO users.tblUsers(email,job,password,isEnabled,idPerson,idRole)
VALUES	('viktor.hernandez@gmail.com','SYSADMIN', 'cdcb7422ca0fe077931b84e6fb7e6dfb7d6678dc7e9ae9c4335e98edc7d5761a', 1,1,4),
		('administrador@gmail.com','ADMINISTRADOR', 'cea115f6db0fcae5bc6b1148d07249e446d0e295382fb562e6ca4d7a354525fe', 1,2,1),
		('cajero@gmail.com','CAJERO', 'cea115f6db0fcae5bc6b1148d07249e446d0e295382fb562e6ca4d7a354525fe', 1,3,2),
		('almacen@gmail.com','ENCARGADO DE ALMACEN', 'cea115f6db0fcae5bc6b1148d07249e446d0e295382fb562e6ca4d7a354525fe', 1,4,3),
		('ventas@gmail.com','ENCARGADO DE VENTAS', 'cea115f6db0fcae5bc6b1148d07249e446d0e295382fb562e6ca4d7a354525fe', 1,5,5),
		('granja@gmail.com','OPERADOR DE GRANJA', 'cea115f6db0fcae5bc6b1148d07249e446d0e295382fb562e6ca4d7a354525fe', 1,6,6);
GO

INSERT INTO users.tblUserRolesHistoric(idUser, oldRoleId, newRoleId)
VALUES	(1,2,3),
		(1,3,1),
		(2,3,2);

INSERT INTO users.tblUserRequests(idUser,idRole,idStatus, userName,email,job)
VALUES	(1,2,1,'VIKTOR HERNANDEZ','viktor.hernandez@gmail.com', 'GERENTE'),
		(2,3,2,'FULANO DE TAL', 'fulano@gmail.com', 'CAJERO'),
		(3,3,2,'FULANO DE TAL', 'fulano@gmail.com', 'CAJERO'),
		(4,3,2,'FULANO DE TAL', 'fulano@gmail.com', 'CAJERO');
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

INSERT INTO stock.tblProductBatches(stockQuantity,idProduct,expirationDate,idSwineBatch, entryQuantity)	--Numero aleatorio entre 1 y 30 para la cantidad
SELECT ROUND(1 + RAND(idProduct)*29, 2), idProduct, DATEADD(DAY, FLOOR(15 + RAND(idProduct)*29) , GETDATE()), 1, ROUND(1 + RAND(idProduct)*29, 2) --Esa cantidad se suma a la fecha para la expiracion
FROM stock.tblProducts;
GO

INSERT INTO stock.tblProductBatches(stockQuantity,idProduct,expirationDate,idSwineBatch, entryQuantity)	--Numero aleatorio entre 1 y 30 para la cantidad
SELECT TOP 3 ROUND(1 + RAND(idProduct)*29, 2), idProduct, DATEADD(DAY, FLOOR(15 + RAND(idProduct)*29) , GETDATE()), 2, ROUND(1 + RAND(idProduct)*29, 2) --Esa cantidad se suma a la fecha para la expiracion
FROM stock.tblProducts;
GO

--INSERT INTO stock.tblProductions(idSwineBatch,idProduct,quantity)
--SELECT 2, sct.idProduct, ROUND(1 + RAND(sct.idProduct)*15, 2)
--FROM stock.tblProducts AS sct;
--GO

INSERT INTO supply.tblSupplyTypes(nameSupplyType)
VALUES	('Desparasitantes'),
		('Vitaminas'),
		('Concentrado'),
		('Herramientas');
GO

INSERT INTO supply.tblSupplies(nameSupply,idSupplyType,idStage, orderPoint, price)
VALUES
     --Vacunas para Pre-Inicio (0-21 días)
    ('Ivermectina neonatal', 1, 1, 5, 11),          -- Tipo: Parásitos
    ('Complejo vitamínico ADE', 2, 1, 5, 12),       -- Tipo: Vitaminas
    ('Desparasitante lactante', 1, 1, 5, 13.1),       -- Tipo: Parásitos
     --Vacunas para Inicio (21-63 días)
    ('Levamisol crecimiento', 1, 2, 5, 14),         -- Tipo: Parásitos
    ('Vitamina B12 + Hierro', 2, 2, 5, 19),         -- Tipo: Vitaminas
    ('Anti-coccidiosico', 1, 2, 5, 19),             -- Tipo: Parásitos
     --Vacunas para Crecimiento (63-112 días)
    ('Dexametasona vitamínica', 2, 3, 5, 20),       -- Tipo: Vitaminas
    ('Antihelmíntico broad-spectrum', 1, 3, 5, 21), -- Tipo: Parásitos
    ('Complejo B inyectable', 2, 3, 5, 22),         -- Tipo: Vitaminas
     --Vacunas para Desarrollo (112-168 días)
    ('Vitamina E + Selenio', 2, 4, 5, 23),          -- Tipo: Vitaminas
    ('Fenbendazol oral', 1, 4, 5, 24),              -- Tipo: Parásitos
    ('Aminoácidos esenciales', 2, 4, 5, 25),        -- Tipo: Vitaminas
     --Vacunas para Engorde (>168 días)
    ('Desparasitante pre-sacrificio', 1, 5, 5, 26), -- Tipo: Parásitos
    ('Vitamina K antihemorrágica', 2, 5, 5, 27),    -- Tipo: Vitaminas
    ('Minerales quelados', 2, 5, 5, 28),            -- Tipo: Vitaminas
	------CONCENTRADO-----
	('Leche maternizada premium',3 , 1, 5, 29),
    ('Pre-starter 22% proteína',3, 1, 5, 30),
    ('Suplemento vitamínico lactante',3, 1, 5, 31),
    ('Starter 20% proteína',3, 2, 5, 32),
    ('Dieta post-destete probiótica',3, 2, 5, 33),
    ('Crecimiento inicial 18% proteína',3, 2, 5, 34),
    ('Dieta crecimiento 16% proteína',3, 3, 5, 35),
    ('Mix energético maíz-soja',3, 3, 5, 36),
    ('Suplemento mineral crecimiento',3, 3, 5, 37),
    ('Dieta desarrollo 14% proteína',3, 4, 5, 38),
    ('Alto rendimiento terminación',3, 4, 5, 39),
    ('Fibra control desarrollo',3, 4, 5, 40),
    ('Dieta acabado 12% proteína',3, 5, 5, 41),
    ('Mezcla pre-mercado grasa intramuscular',3, 5, 5, 42),
    ('Suplemento finalización',3, 5, 5, 43);
GO

INSERT INTO supply.tblSupplyBatches(idSupply, stockQuantity,expirationDate)
SELECT idSupply, FLOOR(1 + RAND(idSupply)*10), DATEADD(DAY, FLOOR(1 + RAND(idSupply)*29) , GETDATE())
FROM supply.tblSupplies;
GO

INSERT INTO supply.tblSupplyBatches(idSupply, stockQuantity,expirationDate)
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


INSERT INTO sales.tblClientTypes(clientTypeName)
VALUES	('Minorista'),
		('Mayorista');
GO

INSERT INTO sales.tblClients(identification, fullName, contact, address, idClientType)
VALUES	('000', 'CLIENTE FINAL',NULL, NULL, 1),
		('0801198300332', 'MARIO GALDAMEZ', '99093413', 'RES. FRANCISCO MORAZAN', 1),
		('0715200100923', 'JULIA RAMOS',NULL,NULL, 1),
		('0101200600003', 'REPUESTOS LA META',NULL,NULL, 2),
		('0801200567890', 'INVERSIONES KORIUM',NULL,'CHOLOMA', 2);
GO

INSERT INTO sales.tblSalesChecks(idUser,subTotal,ISV,idClient, idCaiCodeRange, saleCheckCode)
VALUES	(1,32982,1231,1, 1,'000-007-01-00000056'),
		(1,43221,442,4, 1 , '000-007-01-00000057'),
		(2,3242,1141,4, 1 , '000-007-01-00000058'),
		(2,999,1341,3, 1 , '000-007-01-00000059');
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

INSERT INTO orders.tblProviders (providerName, RTN, providerContact, location)
VALUES ('TecnoImport S.A.', '0801-2010-12345', 'contacto@tecnoimport.hn', 'ETC'),
		('Distribuidora La Abundancia', '1201-2005-54321', 'ventas@abundancia.hn', 'ETC'),
		('CargoExpress Honduras', '1001-2015-45678', 'servicio@cargoexpress.hn', 'ETC');
GO
--pedido de cliente mayorista pediente	
INSERT INTO sales.tblordersWholesaler(idClient,idStatus,subTotal ,ISV)
VALUES(2,8,10000,2500);
GO
INSERT INTO sales.tblordersWholesalerDetails(idOrderWholesaler,idProduct,quantity )
VALUES(1,12,10);
GO
--pedido de cliente mayorista Finalizado
INSERT INTO sales.tblordersWholesaler(idClient,idStatus,subTotal ,ISV ,deliveryDate)
VALUES(2,9,17000,3500,'2025-07-25 00:31:45.853');
GO
INSERT INTO sales.tblordersWholesalerDetails(idOrderWholesaler,idProduct,quantity )
VALUES(2,12,20);

INSERT INTO orders.tblSupplyPurcharses(idUser, subTotal,idProvider,ISV,idStatus, idFormerSupplyPurcharse)
VALUES	(1,1000, 1, 231, 1, null),
		(1,9000, 3, 931, 1, null),
		(1,1500, 2, 23, 4, null),
		(4,2000, 1, 211, 5, 3);
GO

-- Detalles para la Compra 1 (idSupplyPurcharse = 1)
INSERT INTO orders.tblSupplyPurcharseDetails(idSupplyPurcharse, idSupply, quantity)
VALUES
    (1, 1, 10),   -- 10 unidades de Ivermectina neonatal (Precio: 11 c/u → Subtotal: 110)
    (1, 2, 5),     -- 5 unidades de Complejo vitamínico ADE (Precio: 12 c/u → Subtotal: 60)
    (1, 3, 8),     -- 8 unidades de Desparasitante lactante (Precio: 13.1 c/u → Subtotal: 104.8)
-- Detalles para la Compra 2 (idSupplyPurcharse = 2)
    (2, 16, 20),  -- 20 unidades de Leche maternizada premium (Precio: 29 c/u → Subtotal: 580)
    (2, 17, 15),  -- 15 unidades de Pre-starter 22% proteína (Precio: 30 c/u → Subtotal: 450)
    (2, 18, 30),  -- 30 unidades de Suplemento vitamínico lactante (Precio: 31 c/u → Subtotal: 930)
-- Detalles para la Compra 3 (idSupplyPurcharse = 3)
    (3, 7, 12),   -- 12 unidades de Dexametasona vitamínica (Precio: 20 c/u → Subtotal: 240)
    (3, 8, 5),    -- 5 unidades de Antihelmíntico broad-spectrum (Precio: 21 c/u → Subtotal: 105)
    (3, 9, 7),   -- 7 unidades de Complejo B inyectable (Precio: 22 c/u → Subtotal: 154)
-- Detalles para la Compra 4 (idSupplyPurcharse = 4)
    (4, 25, 10),  -- 10 unidades de Dieta desarrollo 14% proteína (Precio: 38 c/u → Subtotal: 380)
    (4, 26, 8),   -- 8 unidades de Alto rendimiento terminación (Precio: 39 c/u → Subtotal: 312)
    (4, 27, 5);   -- 5 unidades de Fibra control desarrollo (Precio: 40 c/u → Subtotal: 200)
GO

INSERT INTO asset.tblNotifications(message, idUser)
VALUES	('EL INSUMO VACUNAS NECESITA UNA REORDEN',1),
		('EL INSUMO VACUNAS NECESITA UNA REORDEN',4),
		('EL INSUMO DESPARASITANTES NECESITA UNA REORDEN',4),
		('EL INSUMO DESPARASITANTES NECESITA UNA REORDEN',1),
		('EL INSUMO VITAMINAS NECESITA UNA REORDEN',1);
GO
