USE ProyectoIngenieria;
GO

-- Deshabilitar restricciones de clave foránea temporalmente
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
GO

-- Eliminar tablas en orden inverso a su creación para evitar problemas de dependencias

-- Tablas de sales
DROP TABLE IF EXISTS sales.tblCaiCodeRanges;
DROP TABLE IF EXISTS sales.tblCaiCodes;
DROP TABLE IF EXISTS sales.tblSalesChecksDetails;
DROP TABLE IF EXISTS sales.tblSalesChecks;
DROP TABLE IF EXISTS sales.tblClients;
DROP TABLE IF EXISTS sales.tblStockPrices;

-- Tablas de supply
DROP TABLE IF EXISTS supply.tblSwineFeeds;
DROP TABLE IF EXISTS supply.tblFeedBatches;
DROP TABLE IF EXISTS supply.tblFeeds;
DROP TABLE IF EXISTS supply.tblSwineVaccines;
DROP TABLE IF EXISTS supply.tblVaccineBatches;
DROP TABLE IF EXISTS supply.tblVaccines;
DROP TABLE IF EXISTS supply.tblVaccineTypes;

-- Tablas de stock
DROP TABLE IF EXISTS stock.tblSwineCutProductions;
DROP TABLE IF EXISTS stock.tblSwineCutBatches;
DROP TABLE IF EXISTS stock.tblSwineCutTypes;
DROP TABLE IF EXISTS stock.tblSwine;
DROP TABLE IF EXISTS stock.tblSwineBatches;

-- Tablas de users
DROP TABLE IF EXISTS users.tblUserDataHistoric;
DROP TABLE IF EXISTS users.tblUserRequests;
DROP TABLE IF EXISTS users.tblUserRolesHistoric;
DROP TABLE IF EXISTS users.tblUsers;
DROP TABLE IF EXISTS users.tblUserRoles;
DROP TABLE IF EXISTS users.tblPersons;

-- Tablas de asset
DROP TABLE IF EXISTS asset.tblStages;
DROP TABLE IF EXISTS asset.tblStageTypes;
DROP TABLE IF EXISTS asset.tblStatus;
DROP TABLE IF EXISTS asset.tblStatusTypes;

-- Eliminar esquemas
DROP SCHEMA IF EXISTS sales;
DROP SCHEMA IF EXISTS orders;
DROP SCHEMA IF EXISTS supply;
DROP SCHEMA IF EXISTS stock;
DROP SCHEMA IF EXISTS asset;
DROP SCHEMA IF EXISTS users;
GO

-- Volver a habilitar restricciones de clave foránea
EXEC sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL';
GO
