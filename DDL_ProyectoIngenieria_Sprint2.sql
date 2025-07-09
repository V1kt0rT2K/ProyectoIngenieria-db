---SCHEMAS-----
CREATE SCHEMA stock;
GO

CREATE SCHEMA supply;
GO

CREATE SCHEMA sales;
GO

CREATE SCHEMA orders;
GO

use ProyectoIngenieria
go

---TABLES----

CREATE TABLE asset.tblStageTypes(
    idStageType INTEGER PRIMARY KEY IDENTITY,
	stageTypeName NVARCHAR(MAX) NOT NULL,
	description NVARCHAR(MAX)
);

CREATE TABLE asset.tblStages(
    idStage INTEGER PRIMARY KEY IDENTITY,
	stageName NVARCHAR(MAX) NOT NULL,
	description NVARCHAR(MAX),
	idStageType INTEGER,
	CONSTRAINT fkStage_StageType
	FOREIGN KEY (idStageType) REFERENCES asset.tblStageTypes(idStageType)
);

CREATE TABLE supply.tblVaccineTypes(
    idVaccineType INTEGER PRIMARY KEY IDENTITY,
	vaccineName NVARCHAR(MAX) NOT NULL,
	description NVARCHAR(MAX)
);

CREATE TABLE supply.tblVaccines(
    idVaccine INTEGER PRIMARY KEY IDENTITY,
	vaccineName NVARCHAR(MAX) NOT NULL,
	idVaccineType INTEGER,
	idStage INTEGER,
	CONSTRAINT fkVaccine_VaccineType
	FOREIGN KEY (idVaccineType) REFERENCES supply.tblVaccineTypes(idVaccineType),
	CONSTRAINT fkVaccine_Stage
	FOREIGN KEY (idStage) REFERENCES asset.tblStages(idStage)
);

CREATE TABLE supply.tblVaccineBatches(
    idVaccineBatch INTEGER PRIMARY KEY IDENTITY,
	quantity INTEGER NOT NULL,
	idVaccine INTEGER,
	expirationDate DATE NOT NULL,
	isEmpty BIT NOT NULL DEFAULT 0,
	CONSTRAINT fkVaccineBatch_Vaccine
	FOREIGN KEY (idVaccine) REFERENCES supply.tblVaccines(idVaccine),
);

CREATE TABLE stock.tblSwineBatches(
    idSwineBatch INTEGER PRIMARY KEY IDENTITY,
	swineQuantityRemaining INTEGER NOT NULL,
	estimatedWeight DOUBLE(8,2) NOT NULL,
	generationDate DATETIME DEFAULT GETDATE(),
	idStage INTEGER,
	CONSTRAINT fkSwineBatch_Stage
	FOREIGN KEY (idStage) REFERENCES asset.tblStages(idStage),
);

CREATE TABLE supply.tblMedicalRecords(
    idMedicalRecord INTEGER PRIMARY KEY IDENTITY,
	generationDate DATATIME DEFAULT GETDATE(),
	idSwineBatch INTEGER,
	quantityUsed DOUBLE(4,2) NOT NULL,
	idVaccineBatch INTEGER,
	idUser INTEGER,
	CONSTRAINT fkMedicalRecord_SwineBatch
	FOREIGN KEY (idSwineBatch) REFERENCES stock.tblSwineBatches(idSwineBatch),
	CONSTRAINT fkMedicalRecord_VaccineBatch
	FOREIGN KEY (idVaccineBatch) REFERENCES supply.tblVaccineBatches(idVaccineBatch),
	CONSTRAINT fkMedicalRecord_User
	FOREIGN KEY (idUser) REFERENCES users.tblUsers(idUser),
);

CREATE TABLE stock.tblSwine(
    idSwine INTEGER PRIMARY KEY IDENTITY,
	numberAssigned NVARCHAR(MAX) NOT NULL,
	idSwineBatch INTEGER,
	isProcessed BIT NOT NULL DEFAULT 0,
	CONSTRAINT fkSwine_SwineBatch
	FOREIGN KEY (idSwineBatch) REFERENCES stock.tblSwineBatches(idSwineBatch),
);

CREATE TABLE stock.tblSwineCutTypes(
    idSwineCutType INTEGER PRIMARY KEY IDENTITY,
	swineCutTypeName NVARCHAR(MAX) NOT NULL,
	description NVARCHAR(MAX),
);

CREATE TABLE stock.tblSwineCutBatches(
    idAvaliableSwineCut INTEGER PRIMARY KEY IDENTITY,
	quantity INTEGER NOT NULL,
	idSwineCutType INTEGER,
	expirationDate DATE NOT NULL,
	isEmpty BIT NOT NULL DEFAULT 0,
	CONSTRAINT fkSwineCutBatch_SwineCutType
	FOREIGN KEY (idSwineCutType) REFERENCES stock.tblSwineCutTypes(idSwineCutType),
);

CREATE TABLE stock.tblSwineCutProduction(
    idSwineCutProduction INTEGER PRIMARY KEY IDENTITY,
	idSwine INTEGER,
	quantity INTEGER NOT NULL,
	idSwineCutType INTEGER,
	processDate  DATETIME DEFAULT GETDATE(),
	CONSTRAINT fkSwineCutProduction_Swine
	FOREIGN KEY (idSwine) REFERENCES stock.tblSwine(idSwine),
	CONSTRAINT fkSwineCutProduction_SwineCutType
	FOREIGN KEY (idSwineCutType) REFERENCES stock.tblSwineCutTypes(idSwineCutType),
);

CREATE TABLE stock.tblFeeds(
    idFeed INTEGER PRIMARY KEY IDENTITY,
	feedName NVARCHAR(MAX) NOT NULL,
	idStage INTEGER,
	CONSTRAINT fkFeeds_Stage
	FOREIGN KEY (idStage) REFERENCES asset.tblStages(idStage),
);

CREATE TABLE supply.tblFeedBatches(
    idFeedBatch INTEGER PRIMARY KEY IDENTITY,
	idFeed INTEGER,
	quantity INTEGER NOT NULL,
	expirationDate DATE NOT NULL,
	CONSTRAINT fkFeedBatch_Feed
	FOREIGN KEY (idFeed) REFERENCES stock.tblFeeds(idFeed),
);

CREATE TABLE supply.tblSwineFeeds(
    idSwineFeed INTEGER PRIMARY KEY IDENTITY,
	generationDate DATETIME NOT NULL GETDATE(),
	idSwineBatch INTEGER,
	quantityUsed DOUBLE(4,2) NOT NULL,
	idFeedBatch INTEGER,
	idUser INTEGER,
	CONSTRAINT fkSwineFeed_SwineBatch
	FOREIGN KEY (idSwineBatch) REFERENCES stock.tblSwineBatches(idSwineBatch),
	CONSTRAINT fkSwineFeed_FeedBatch
	FOREIGN KEY (idFeedBatch) REFERENCES supply.tblFeedBatches(idFeedBatch),
	CONSTRAINT fkSwineFeed_User
	FOREIGN KEY (idUser) REFERENCES users.tblUsers(idUser),
);

CREATE TABLE sales.tblStockPrices(
    idStockPrice INTEGER PRIMARY KEY IDENTITY,
	idSwineCutType INTEGER,
	priceUnit DOUBLE(4,2) NOT NULL,
	CONSTRAINT fkStockPrice_SwineCutType
	FOREIGN KEY (idSwineCutType) REFERENCES stock.tblSwineCutTypes(idSwineCutType),
);

CREATE TABLE sales.tblClients(
    idClient INTEGER PRIMARY KEY IDENTITY,
	identityNumber NVARCHAR(MAX) NOT NULL,
	CONSTRAINT ukIdentityNumber UNIQUE(identityNumber),
);

CREATE TABLE sales.tblSalesChecks(
    idSalesCheck INTEGER PRIMARY KEY IDENTITY,
	generationDate DATETIME NOT NULL GETDATE(),
	idUser INTEGER,
	subTotal DOUBLE(8,2) NOT NULL,
	ISV NVARCHAR(MAX) NOT NULL,
	idClient INTEGER,
	CONSTRAINT fkSalesCheck_User
	FOREIGN KEY (idUser) REFERENCES users.tblUsers(idUser),
	CONSTRAINT fkSalesCheck_Client
	FOREIGN KEY (idClient) REFERENCES sales.tblClients(idClient),
);

CREATE TABLE sales.tblSalesChecksDetails(
    idSalesCheckDetail INTEGER PRIMARY KEY IDENTITY,
	idSalesCheck INTEGER,
	idSwineCutType INTEGER,
	quantity DOUBLE(8,2) NOT NULL,
	CONSTRAINT fkSalesChecksDetail_SalesCheck
	FOREIGN KEY (idSalesCheck) REFERENCES sales.tblSalesChecks(idSalesCheck),
	CONSTRAINT fkSalesChecksDetail_SwineCutType
	FOREIGN KEY (idSwineCutType) REFERENCES stock.tblSwineCutTypes(idSwineCutType),
);

CREATE TABLE sales.tblCaiCodes(
    idCaiCode INTEGER PRIMARY KEY IDENTITY,
	code NVARCHAR(MAX) NOT NULL,
	startRange INTEGER NOT NULL,
	endRange INTEGER NOT NULL,
	expirationDate DATE NOT NULL,
	isActive BIT NOT NULL DEFAULT 1,
);

CREATE TABLE sales.tblCaiCodeCheck(
    idCaiCodeCheck INTEGER PRIMARY KEY IDENTITY,
	idCaiCode INTEGER,
	idSalesCheck INTEGER,
	saleCheckCode NVARCHAR(MAX) NOT NULL,
	CONSTRAINT fkCaiCodeCheck_CaiCode
	FOREIGN KEY (idCaiCode) REFERENCES sales.tblCaiCodes(idCaiCode),
	CONSTRAINT fkCaiCodeCheck_SalesCheck
	FOREIGN KEY (idSalesCheck) REFERENCES sales.tblSalesChecks(idSalesCheck),
);