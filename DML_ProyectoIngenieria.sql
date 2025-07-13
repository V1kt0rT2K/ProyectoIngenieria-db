USE ProyectoIngenieria
GO

------------INITIAL INSERTS--------------

INSERT INTO asset.tblStatusTypes(statusTypeName)
VALUES	('Estados de Solicitud');
GO

INSERT INTO asset.tblStatus(statusName, statusDescription, idStatusType)
VALUES	('Aprobado','La solicitud fue revisada y aprobada con éxito.', 1),
		('Revisión','La solicitud esta pendiente de revisión.', 1),
		('Denegado','La solicitud fue revisada y denegado con éxito.',1);

GO

INSERT INTO asset.tblStageTypes(stageTypeName,description)
VALUES	('PORCINO','Etapas del ciclo productivo en porcinocultura');
GO


INSERT INTO asset.tblStages(stageName, description,idStageType)
VALUES	('Pre-Inicio','Fase neonatal desde el nacimiento hasta el destete (0-21 días). Cuidados intensivos en temperatura y alimentación líquida.', 1),
		('Inicio','Periodo post-destete (21-63 días). Adaptación a alimento sólido, desarrollo del sistema digestivo e inmunitario.', 1),
		('Crecimiento','Etapa de rápido desarrollo muscular (63-112 días). Máxima eficiencia alimenticia y crecimiento óseo.', 1),
		('Desarrollo','Fase de terminación (112-168 días). Maduración tisular y consolidación del crecimiento.', 1),
		('Engorde','Periodo final de acabado (>168 días). Acumulación de grasa intramuscular y preparación para mercado.', 1);
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
VALUES	('viktor.hernandez@gmail.com','GERENTE', 'contrasena', 1,1,1),
		('fulano@gmail.com','CAJERO', '123456@F', 0,2,2);
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

INSERT INTO stock.tblSwineBatches(swineQuantityRemaining,estimatedWeight,idStage)
VALUES	(10,200.8,2),
		(9,185.3,5);
GO

INSERT INTO stock.tblSwine(numberAssigned,idSwineBatch,isProcessed)
VALUES	(1,1,0),(2,1,0),(3,1,0),(4,1,0),(5,1,0),(6,1,0),(7,1,0),(8,1,0),(9,1,0),(10,1,0),
		(1,2,0),(2,2,0),(3,2,0),(4,2,0),(5,2,1),(6,2,0),(7,2,0),(8,2,0),(9,2,0),(10,2,0);
GO

INSERT INTO stock.tblSwineCutTypes(swineCutTypeName,description)
VALUES	('Cabeza', 'Incluye orejas, morro, cachetes y cabeza completa para caldos o barbacoa'),
		('Lomo', 'Corte magro y tierno, ideal para chuletas, filetes o asar entero'),
		('Costilla', 'Incluye las costillas (chuletas) con hueso, para parrilla o ahumados'),
		('Pierna', 'También llamada jamón, usado para asar, curar o hacer jamones serranos'),
		('Paleta', 'Parte delantera similar al jamón pero con más grasa intramuscular'),
		('Panceta', 'También llamado tocino o bacon (curado), parte ventral del cerdo'),
		('Chuletón', 'Corte premium del lomo alto con hueso'),
		('Solomillo', 'Corte más tierno y valioso, pequeño y magro'),
		('Espaldilla', 'Corte económico de la parte superior delantera'),
		('Rabo', 'Usado principalmente para guisos y caldos'),
		('Chicharrón', 'Piel de cerdo frita o asada');
GO

INSERT INTO stock.tblSwineCutBatches(quantity,idSwineCutType,expirationDate)	--Numero aleatorio entre 1 y 30 para la cantidad
SELECT ROUND(1 + RAND(idSwineCutType)*29, 2), idSwineCutType, DATEADD(DAY, FLOOR(15 + RAND(idSwineCutType)*29) , GETDATE()) --Esa cantidad se suma a la fecha para la expiracion
FROM stock.tblSwineCutTypes;
GO

INSERT INTO stock.tblSwineCutProductions(idSwine,idSwineCutType,quantity)
SELECT 15, sct.idSwineCutType, ROUND(1 + RAND(sct.idSwineCutType)*15, 2)
FROM stock.tblSwineCutTypes AS sct;
GO

INSERT INTO supply.tblVaccineTypes(vaccineTypeName,description)
VALUES	('Parasitos', 'Vacunas destinadas a tratar parásitos en los cerdos.'),
		('Vitaminas', 'Vacunas destinadas a vitaminar a los cerdos.');
GO

INSERT INTO supply.tblVaccines(vaccineName, idVaccineType, idStage)
VALUES
    -- Vacunas para Pre-Inicio (0-21 días)
    ('Ivermectina neonatal', 1, 1),          -- Tipo: Parásitos
    ('Complejo vitamínico ADE', 2, 1),       -- Tipo: Vitaminas
    ('Desparasitante lactante', 1, 1),       -- Tipo: Parásitos
    -- Vacunas para Inicio (21-63 días)
    ('Levamisol crecimiento', 1, 2),         -- Tipo: Parásitos
    ('Vitamina B12 + Hierro', 2, 2),         -- Tipo: Vitaminas
    ('Anti-coccidiosico', 1, 2),             -- Tipo: Parásitos
    -- Vacunas para Crecimiento (63-112 días)
    ('Dexametasona vitamínica', 2, 3),       -- Tipo: Vitaminas
    ('Antihelmíntico broad-spectrum', 1, 3), -- Tipo: Parásitos
    ('Complejo B inyectable', 2, 3),         -- Tipo: Vitaminas
    -- Vacunas para Desarrollo (112-168 días)
    ('Vitamina E + Selenio', 2, 4),          -- Tipo: Vitaminas
    ('Fenbendazol oral', 1, 4),              -- Tipo: Parásitos
    ('Aminoácidos esenciales', 2, 4),        -- Tipo: Vitaminas
    -- Vacunas para Engorde (>168 días)
    ('Desparasitante pre-sacrificio', 1, 5), -- Tipo: Parásitos
    ('Vitamina K antihemorrágica', 2, 5),    -- Tipo: Vitaminas
    ('Minerales quelados', 2, 5);            -- Tipo: Vitaminas
GO

INSERT INTO supply.tblVaccineBatches(idVaccine,quantity,expirationDate)
SELECT idVaccine, FLOOR(1 + RAND(idVaccine)*10), DATEADD(DAY, FLOOR(1 + RAND(idVaccine)*29) , GETDATE())
FROM supply.tblVaccines;
GO

INSERT INTO supply.tblSwineVaccines(idVaccineBatch,idSwineBatch,quantityUsed,idUser)
VALUES	(4, 1, 10, 1),
		(14, 2, 9, 1);
GO


INSERT INTO supply.tblFeeds(feedName, idStage)
VALUES
    ('Leche maternizada premium', 1),
    ('Pre-starter 22% proteína', 1),
    ('Suplemento vitamínico lactante', 1),
    ('Starter 20% proteína', 2),
    ('Dieta post-destete probiótica', 2),
    ('Crecimiento inicial 18% proteína', 2),
    ('Dieta crecimiento 16% proteína', 3),
    ('Mix energético maíz-soja', 3),
    ('Suplemento mineral crecimiento', 3),
    ('Dieta desarrollo 14% proteína', 4),
    ('Alto rendimiento terminación', 4),
    ('Fibra control desarrollo', 4),
    ('Dieta acabado 12% proteína', 5),
    ('Mezcla pre-mercado grasa intramuscular', 5),
    ('Suplemento finalización', 5);
GO

INSERT INTO supply.tblFeedBatches(idFeed,quantity,expirationDate)
SELECT idFeed, ROUND((1 + RAND(idFeed)*15),2), DATEADD(DAY, FLOOR(6 + RAND(idFeed)*29) , GETDATE())
FROM supply.tblFeeds;
GO

INSERT INTO supply.tblSwineFeeds(idFeedBatch,idSwineBatch,idUser,quantityUsed)
VALUES	(5,1,1,12.2),
		(13,2,1,15.3);
GO

INSERT INTO sales.tblCaiCodes(code,establishmentRTN)
VALUES	('35DB45-58RFG5-34DF3R-23KGT5-98UIP4-2A','2711-5621-12281');
GO

INSERT INTO sales.tblCaiCodeRanges(idCaiCode,startRange,endRange,expirationDate)
VALUES	(1,'000-007-01-00000056','000-007-01-00000065', DATEADD(MONTH,1,GETDATE()));
GO

INSERT INTO sales.tblStockPrices(idSwineCutType,priceUnit)
SELECT idSwineCutType, ROUND((10 + RAND(idSwineCutType)*20),2)
FROM stock.tblSwineCutTypes;
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

INSERT INTO sales.tblSalesChecksDetails(idSalesCheck,idSwineCutBatch,quantity)
VALUES	(1,4,19.2),
		(1,2,15.2),
		(1,6,3),
		(2,9,14.8),
		(2,7,19.2),
		(3,6,19.2),
		(3,11,19.2),
		(4,10,19.2);
GO



