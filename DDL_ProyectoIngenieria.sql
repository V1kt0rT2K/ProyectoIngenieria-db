
--CREATE DATABASE ProyectoIngenieria;
--GO

USE ProyectoIngenieria;
GO

--CREATE LOGIN UserProyectoIngenieria WITH PASSWORD = 'LOSFA	BULOSOSCADILLAC11',
--CHECK_POLICY = OFF,
--CHECK_EXPIRATION = OFF;
--GO

--CREATE USER UserProyectoIngenieria FOR LOGIN UserProyectoIngenieria;
--EXEC sp_addrolemember N'db_owner', N'UserProyectoIngenieria';
--GO

------- SCHEMAS --------
CREATE SCHEMA users;
GO

CREATE SCHEMA asset;
GO

CREATE SCHEMA stock;
GO

CREATE SCHEMA supply;
GO

CREATE SCHEMA sales;
GO

CREATE SCHEMA orders;
GO

---------------TABLES----------------

------------  ASSET --------------------

CREATE TABLE asset.tblActions(
	idAction INTEGER PRIMARY KEY IDENTITY,
	actionName NVARCHAR(255) NOT NULL,
	actionDescription NVARCHAR(255),
	CONSTRAINT ukAction
	UNIQUE(actionName)
);

CREATE TABLE asset.tblStatusTypes(
	idStatusType INTEGER PRIMARY KEY IDENTITY,
	statusTypeName NVARCHAR(MAX) NOT NULL
);

CREATE TABLE asset.tblStatus(
	idStatus INTEGER PRIMARY KEY IDENTITY,
	statusName NVARCHAR(MAX) NOT NULL,
	statusDescription NVARCHAR(MAX) NOT NULL,
	idStatusType INTEGER NOT NULL,
	CONSTRAINT fkStatus_StatusType
	FOREIGN KEY (idStatusType) REFERENCES asset.tblStatusTypes(idStatusType)
);

CREATE TABLE asset.tblStageTypes(
    idStageType INTEGER PRIMARY KEY IDENTITY,
	stageTypeName NVARCHAR(MAX) NOT NULL,
	stageTypeDescription NVARCHAR(MAX) NOT NULL
);

CREATE TABLE asset.tblStages(
    idStage INTEGER PRIMARY KEY IDENTITY,
	stageName NVARCHAR(MAX) NOT NULL,
	stageDescription NVARCHAR(MAX) NOT NULL,
	idStageType INTEGER NOT NULL,
	stageTime INTEGER NOT NULL,
	CONSTRAINT fkStage_StageType
	FOREIGN KEY (idStageType) REFERENCES asset.tblStageTypes(idStageType)
);

--CREATE TABLE asset.tblNotificationTemplates(
	
--);

CREATE TABLE asset.tblNotifications(
	idNotification INTEGER PRIMARY KEY IDENTITY,
	message NVARCHAR(MAX) NOT NULL,
	generationDate DATETIME NOT NULL DEFAULT GETDATE(),
	show BIT NOT NULL DEFAULT 1,
	idUser INTEGER NOT NULL 
	--CONSTRAINT fkNotification_User
	--FOREIGN KEY (idUser) REFERENCES users.tblUsers
);

-------------USERS-----------------------

CREATE TABLE users.tblPersons(
	idPerson INTEGER PRIMARY KEY IDENTITY,
	identityNumber NVARCHAR(13) NOT NULL,
	firstName NVARCHAR(MAX) NOT NULL,
	secondName NVARCHAR(MAX) NOT NULL,
	lastName NVARCHAR(MAX) NOT NULL,
    secondLastName NVARCHAR(MAX) NOT NULL,
    CONSTRAINT ukIdentityNumber UNIQUE (identityNumber)
);

CREATE TABLE users.tblUserRoles(
	idRole INTEGER PRIMARY KEY IDENTITY,
	roleName NVARCHAR(MAX) NOT NULL,
	roleDescription NVARCHAR(MAX) NOT NULL,
	show BIT NOT NULL DEFAULT 1
);

CREATE TABLE users.tblUsers(
	idUser INTEGER PRIMARY KEY IDENTITY,
	email NVARCHAR(255) NOT NULL,
	job NVARCHAR(MAX) NOT NULL,
	password NVARCHAR(MAX) NOT NULL,
	isEnabled BIT NOT NULL DEFAULT 0,
	idPerson INTEGER NOT NULL,
	idRole INTEGER NOT NULL,
	CONSTRAINT fkUser_Person
	FOREIGN KEY (idPerson) REFERENCES users.tblPersons(idPerson),
	CONSTRAINT fkUser_Role
	FOREIGN KEY (idRole) REFERENCES users.tblUserRoles(idRole),
	CONSTRAINT ukUser_Person UNIQUE(idPerson, idUser),
    CONSTRAINT ukEmail UNIQUE(email)
);

CREATE TABLE users.tblUserRolesHistoric (
    idUserHistoric INTEGER PRIMARY KEY IDENTITY,
    idUser INTEGER NOT NULL,
    oldRoleId INTEGER NOT NULL, 
    newRoleId INTEGER NOT NULL, 
    generationDate DATETIME DEFAULT GETDATE(), 
    description NVARCHAR(MAX),
    CONSTRAINT fkUserRoleHistoric_User 
    FOREIGN KEY (idUser) REFERENCES users.tblUsers(idUser),
    CONSTRAINT fkUserRoleHistoric_Role 
    FOREIGN KEY (newRoleId) REFERENCES users.tblUserRoles(idRole),
    CONSTRAINT fkUserRoleHistoric_OldRole 
    FOREIGN KEY (oldRoleId) REFERENCES users.tblUserRoles(idRole)
);
GO

CREATE TABLE users.tblUserRequests (
    idUserRequest INTEGER PRIMARY KEY IDENTITY,
    idUser INTEGER NOT NULL,
    generationDate DATETIME NOT NULL DEFAULT GETDATE(),
    idRole INTEGER NOT NULL,
    idStatus INTEGER NOT NULL DEFAULT 2,
    userName NVARCHAR(MAX) NOT NULL,
    email NVARCHAR(MAX) NOT NULL,
    job NVARCHAR(MAX) NOT NULL,
    CONSTRAINT fkUserRequest_User
    FOREIGN KEY (idUser) REFERENCES users.tblUsers(idUser),
    CONSTRAINT fkUserRequest_Role
    FOREIGN KEY (idRole) REFERENCES users.tblUserRoles(idRole),
    CONSTRAINT fkUserRequest_Status
    FOREIGN KEY (idStatus) REFERENCES asset.tblStatus(idStatus),
);
GO

CREATE TABLE users.tblUserDataHistoric (
    idUserHistoric INT PRIMARY KEY IDENTITY,
    idUser INTEGER NOT NULL,
    job NVARCHAR(MAX) NOT NULL,
    firstName NVARCHAR(MAX) NOT NULL,
    secondName NVARCHAR(MAX) NOT NULL,
    lastName NVARCHAR(MAX) NOT NULL,
    identityNumber NVARCHAR(MAX) NOT NULL,
    modificationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fkUserDataHistoric_User
    FOREIGN KEY (idUser) REFERENCES users.tblUsers(idUser)
);
GO

CREATE TABLE users.tblActionRoles(
	idActionRole INTEGER PRIMARY KEY IDENTITY,
	idRole INTEGER NOT NULL,
	idAction INTEGER NOT NULL,
	CONSTRAINT fkActionRoles_Role
	FOREIGN KEY (idRole) REFERENCES users.tblUserRoles(idRole),
	CONSTRAINT fkActionRoles_Action
	FOREIGN KEY (idAction) REFERENCES asset.tblActions(idAction),
	CONSTRAINT ukAction_Role
	UNIQUE (idRole,idAction)
);

----------STOCK---------------

CREATE TABLE stock.tblSwineBatches(
    idSwineBatch INTEGER PRIMARY KEY IDENTITY,
	quantity INTEGER NOT NULL,
	birthDate DATETIME NOT NULL,
	generationDate DATETIME DEFAULT GETDATE(),
	idStage INTEGER NOT NULL,
	stockQuantity INTEGER NOT NULL,
	CONSTRAINT fkSwineBatch_Stage
	FOREIGN KEY (idStage) REFERENCES asset.tblStages(idStage),
);

CREATE TABLE stock.tblProducts(
	idProduct INTEGER PRIMARY KEY IDENTITY,
	productName NVARCHAR(MAX) NOT NULL,
	productDescription NVARCHAR(MAX) NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	orderPoint DECIMAL(8,2) NOT NULL
);

CREATE TABLE stock.tblProductBatches(
	idProductBatch INTEGER PRIMARY KEY IDENTITY,
	idProduct INTEGER NOT NULL,
	expirationDate DATE NOT NULL,
	stockQuantity DECIMAL(8,2) NOT NULL,
	idSwineBatch INTEGER NOT NULL,
	entryQuantity DECIMAL(8,2) NOT NULL,
	CONSTRAINT fkProductBatch_SwineBatch
	FOREIGN KEY (idSwineBatch) REFERENCES stock.tblSwineBatches(idSwineBatch),
	CONSTRAINT fkProductBatch_Product 
	FOREIGN KEY (idProduct) REFERENCES stock.tblProducts(idProduct)
);

--CREATE TABLE stock.tblProductions(
--	idProduction INTEGER PRIMARY KEY IDENTITY,
--	idSwineBatch INTEGER NOT NULL,
--	idProduct INTEGER NOT NULL,
--	quantity DECIMAL(8,2) NOT NULL
--	CONSTRAINT fk_Production_SwineBatch
--	FOREIGN KEY (idSwineBatch) REFERENCES stock.tblSwineBatches (idSwineBatch),
--	CONSTRAINT fk_Production_Product
--	FOREIGN KEY (idProduct) REFERENCES stock.tblProducts (idProduct)
--);

------SUPPLY---------

CREATE TABLE supply.tblSupplyTypes(
	idSupplyType INTEGER PRIMARY KEY IDENTITY,
	nameSupplyType NVARCHAR(MAX) NOT NULL
);

CREATE TABLE supply.tblSupplies(
	idSupply INTEGER PRIMARY KEY IDENTITY,
	nameSupply NVARCHAR(MAX) NOT NULL,
	idStage  INTEGER NOT NULL,
	idSupplyType INTEGER NOT NULL,
	orderPoint DECIMAL(8,2) NOT NULL,
	price DECIMAL(8,2) NOT NULL
	CONSTRAINT fkSupply_SupplyType
	FOREIGN KEY(idSupplyType) REFERENCES supply.tblSupplyTypes(idSupplyType),
	CONSTRAINT fkSupply_Stage
	FOREIGN KEY (idStage) REFERENCES asset.tblStages(idStage)
);

CREATE TABLE supply.tblSupplyBatches(
	idSupplyBatch INTEGER PRIMARY KEY IDENTITY,
	idSupply INTEGER NOT NULL,
	stockQuantity DECIMAL(8,2) NOT NULL,
	expirationDate DATE NOT NULL,
	CONSTRAINT fkSupplyBatch_Supply
	FOREIGN KEY (idSupply) REFERENCES supply.tblSupplies(idSupply)
);

CREATE TABLE supply.tblSwineSupplies(
	idSwineSupply INTEGER PRIMARY KEY IDENTITY,
	idSupply INTEGER NOT NULL,
	idSwineBatch INTEGER NOT NULL,
	quantity DECIMAL(8,2) NOT NULL,	
	generationDate DATE DEFAULT GETDATE(),
	idUser INTEGER NOT NULL,
	CONSTRAINT fkSwineSupply_Supply
	FOREIGN KEY (idSupply) REFERENCES supply.tblSupplies(idSupply),
	CONSTRAINT fkSwineSupply_SwineBatch
	FOREIGN KEY (idSwineBatch) REFERENCES stock.tblSwineBatches(idSwineBatch)	
);

-------------SALES-----------------

CREATE TABLE sales.tblCaiCodes(
	idCaiCode INTEGER PRIMARY KEY IDENTITY,
	code NVARCHAR(MAX) NOT NULL,
	establishmentRTN NVARCHAR(MAX) NOT NULL
);

CREATE TABLE sales.tblCaiCodeRanges(
    idCaiCodeRange INTEGER PRIMARY KEY IDENTITY,
	idCaiCode INTEGER NOT NULL,
	startRange NVARCHAR(MAX) NOT NULL,
	endRange NVARCHAR(MAX) NOT NULL,
	expirationDate DATE NOT NULL,
	isActive BIT NOT NULL DEFAULT 1,
	CONSTRAINT fkCaiCodeRange_CaiCode
	FOREIGN KEY (idCaiCode) REFERENCES sales.tblCaiCodes(idCaiCode)
);


CREATE TABLE sales.tblClients(
    idClient INTEGER PRIMARY KEY IDENTITY,
	identification NVARCHAR(50) NOT NULL,
	fullName NVARCHAR(MAX),
	contact NVARCHAR(MAX),
	address NVARCHAR(MAX),
	CONSTRAINT ukIdentityNumber UNIQUE(identification),
);

CREATE TABLE sales.tblSalesChecks(
    idSalesCheck INTEGER PRIMARY KEY IDENTITY,
	generationDate DATETIME NOT NULL DEFAULT GETDATE(),
	idUser INTEGER NOT NULL,
	subTotal DECIMAL(8,2) NOT NULL,
	ISV DECIMAL(8,2) NOT NULL,
	idClient INTEGER,
	idCaiCodeRange INTEGER NOT NULL,
	saleCheckCode NVARCHAR(MAX) NOT NULL,
	CONSTRAINT fkSalesCheck_User
	FOREIGN KEY (idUser) REFERENCES users.tblUsers(idUser),
	CONSTRAINT fkSalesCheck_Client
	FOREIGN KEY (idClient) REFERENCES sales.tblClients(idClient),
	CONSTRAINT fkSalesCheck_CaiCodeRange
	FOREIGN KEY (idCaiCodeRange) REFERENCES sales.tblCaiCodeRanges(idCaiCodeRange),
);

CREATE TABLE sales.tblSalesChecksDetails(
    idSalesCheckDetail INTEGER PRIMARY KEY IDENTITY,
	idSalesCheck INTEGER NOT NULL,
	idProduct INTEGER NOT NULL,
	quantity DECIMAL(8,2) NOT NULL,
	CONSTRAINT fkSalesChecksDetail_SalesCheck
	FOREIGN KEY (idSalesCheck) REFERENCES sales.tblSalesChecks(idSalesCheck),
	CONSTRAINT fkSalesChecksDetail_Product
	FOREIGN KEY (idProduct) REFERENCES stock.tblProducts(idProduct),
);
CREATE TABLE sales.tblordersWholesaler(
	idOrderWholesaler INTEGER PRIMARY KEY IDENTITY,
	idClient INTEGER NOT NULL,
	idStatus INTEGER NOT NULL,
	generationDate DATETIME DEFAULT GETDATE() ,
	CONSTRAINT fk_ordersWholesaler_Client
	FOREIGN KEY (idClient) REFERENCES sales.tblClients(idClient),
	CONSTRAINT fk_ordersWholesaler_Status
	FOREIGN KEY (idStatus) REFERENCES asset.tblStatus(idStatus)
);
CREATE TABLE sales.tblordersWholesalerDetails(
	idOrderWholesalerDetail INTEGER PRIMARY KEY IDENTITY,
	idOrderWholesaler INTEGER NOT NULL,
	idProduct INTEGER NOT NULL,
	quantity DECIMAL(8,2) NOT NULL,
	CONSTRAINT fk_WholesalerDetails_OrderWholesaler
	FOREIGN KEY (idOrderWholesaler) REFERENCES sales.tblordersWholesaler(idOrderWholesaler) ,
	CONSTRAINT fk_WholesalerDetails_Product
	FOREIGN KEY (idProduct) REFERENCES stock.tblProducts(idProduct)
);


---------------- ORDERS ----------------
CREATE TABLE orders.tblProviders(
	idProvider INTEGER PRIMARY KEY IDENTITY,
	providerName NVARCHAR(MAX) NOT NULL,
	RTN NVARCHAR(MAX) NOT NULL,
	providerContact NVARCHAR(MAX) NOT NULL,
	location NVARCHAR(MAX) NOT NULL
);

CREATE TABLE orders.tblSupplyPurcharses(
	idSupplyPurcharse INTEGER PRIMARY KEY IDENTITY,
	idUser INTEGER NOT NULL,
	generationDate DATETIME NOT NULL DEFAULT GETDATE(),
	entryDate DATETIME,
	subTotal DECIMAL(8,2) NOT NULL,
	idProvider INTEGER NOT NULL,
	ISV DECIMAL(8,2) NOT NULL, 
	idStatus INTEGER NOT NULL DEFAULT 2,
	idFormerSupplyPurcharse INTEGER
	CONSTRAINT fkSupplyPurcharse_User
	FOREIGN KEY (idUser) REFERENCES users.tblUsers(idUser),
	CONSTRAINT fkSupplyPurcharse_Provider
	FOREIGN KEY (idProvider) REFERENCES orders.tblProviders(idProvider),
	CONSTRAINT fkSupplyPurcharse_Status
	FOREIGN KEY (idStatus) REFERENCES asset.tblStatus(idStatus),
	CONSTRAINT fkSupplyPurcharse_FormerSupplyPurcharse
	FOREIGN KEY (idFormerSupplyPurcharse) REFERENCES orders.tblSupplyPurcharses(idSupplyPurcharse)
);

CREATE TABLE orders.tblSupplyPurcharseDetails(
	idSupplyPurcharseDetail INTEGER PRIMARY KEY IDENTITY,
	idSupplyPurcharse INTEGER NOT NULL,
	idSupply INTEGER NOT NULL,
	quantity DECIMAL(8,2) NOT NULL,
	CONSTRAINT fkSupplyPurcharseDetail_Supply
	FOREIGN KEY (idSupply) REFERENCES  supply.tblSupplies(idSupply),
	CONSTRAINT fkSupplyPurcharseDetail_SupplyPurcharse
	FOREIGN KEY (idSupplyPurcharse) REFERENCES orders.tblSupplyPurcharses(idSupplyPurcharse)
);

GO
---------------------------------- TRIGGERS -------------------------------------

CREATE OR ALTER TRIGGER asset.trgAddSysAdminPermissions
ON asset.tblActions
AFTER INSERT
AS
BEGIN
	INSERT INTO users.tblActionRoles(idRole, idAction)
	SELECT (SELECT idRole FROM users.tblUserRoles WHERE roleName = 'SYSADMIN'), idAction
	FROM INSERTED
END
GO








