USE ProyectoIngenieria;
GO

-- Deshabilitar restricciones momentáneamente para evitar errores
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
GO

-- Eliminar tablas en orden inverso a sus dependencias

-- 1. Tablas con más dependencias (más "hijas") primero
DROP TABLE IF EXISTS orders.tblSupplyPurcharseDetails;
DROP TABLE IF EXISTS sales.tblSalesChecksDetails;
DROP TABLE IF EXISTS supply.tblSwineSupplies;
DROP TABLE IF EXISTS supply.tblSupplyBatches;
DROP TABLE IF EXISTS stock.tblProductions;
DROP TABLE IF EXISTS stock.tblProductBatches;
DROP TABLE IF EXISTS users.tblUserDataHistoric;
DROP TABLE IF EXISTS users.tblUserRequests;
DROP TABLE IF EXISTS users.tblUserRolesHistoric;
DROP TABLE IF EXISTS asset.tblNotifications;

-- 2. Tablas intermedias
DROP TABLE IF EXISTS orders.tblSupplyPurcharses;
DROP TABLE IF EXISTS sales.tblSalesChecks;
DROP TABLE IF EXISTS sales.tblCaiCodeRanges;
DROP TABLE IF EXISTS supply.tblSupplies;
DROP TABLE IF EXISTS stock.tblSwineBatches;
DROP TABLE IF EXISTS stock.tblProducts;
DROP TABLE IF EXISTS users.tblUsers;

-- 3. Tablas principales (más "padres")
DROP TABLE IF EXISTS sales.tblClientTypes;
DROP TABLE IF EXISTS sales.tblClients;
DROP TABLE IF EXISTS sales.tblCaiCodes;
DROP TABLE IF EXISTS orders.tblProviders;
DROP TABLE IF EXISTS supply.tblSupplyTypes;
DROP TABLE IF EXISTS asset.tblStages;
DROP TABLE IF EXISTS asset.tblStatus;
DROP TABLE IF EXISTS users.tblActionRoles;
DROP TABLE IF EXISTS users.tblUserRoles;
DROP TABLE IF EXISTS users.tblPersons;
DROP TABLE IF EXISTS asset.tblStageTypes;
DROP TABLE IF EXISTS asset.tblStatusTypes;
DROP TABLE IF EXISTS asset.tblActions;


--DROP TRIGGER IF EXISTS asset.trgAddSysAdminPermissions;

-- Volver a habilitar restricciones
EXEC sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL';
GO

-- Eliminar esquemas (opcional, si también quieres eliminarlos)
DROP SCHEMA IF EXISTS orders;
DROP SCHEMA IF EXISTS sales;
DROP SCHEMA IF EXISTS supply;
DROP SCHEMA IF EXISTS stock;
DROP SCHEMA IF EXISTS asset;
DROP SCHEMA IF EXISTS users;
GO