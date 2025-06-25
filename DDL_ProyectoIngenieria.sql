
CREATE DATABASE ProyectoIngenieria;
GO

USE ProyectoIngenieria;
GO

CREATE LOGIN UserProyectoIngenieria WITH PASSWORD = 'LOSFABULOSOSCADILLAC11',
CHECK_POLICY = OFF,
CHECK_EXPIRATION = OFF;
GO

CREATE USER UserProyectoIngenieria FOR LOGIN UserProyectoIngenieria;
EXEC sp_addrolemember N'db_owner', N'UserProyectoIngenieria';
GO

------- SCHEMAS --------
CREATE SCHEMA users;
GO

CREATE SCHEMA asset;
GO

---------------TABLES----------------

------------  ASSET --------------------
CREATE TABLE asset.tblStatus(
	idStatus INTEGER PRIMARY KEY IDENTITY,
	statusName NVARCHAR(MAX) NOT NULL,
	statusDescription NVARCHAR(MAX) NOT NULL
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
	roleDescription NVARCHAR(MAX) NOT NULL
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
    idRole INTEGER NOT NULL,
    generationDate DATETIME DEFAULT GETDATE(),
    description NVARCHAR(MAX),
    CONSTRAINT fkUserRoleHistoric_User
    FOREIGN KEY (idUser) REFERENCES users.tblUsers(idUser),
    CONSTRAINT fkUserRoleHistoric_Role
    FOREIGN KEY (idRole) REFERENCES users.tblUserRoles(idRole)
);
GO

CREATE TABLE users.tblUserRequests (
    idUserRequest INTEGER PRIMARY KEY IDENTITY,
    idUser INTEGER NOT NULL,
    generationDate DATETIME NOT NULL DEFAULT GETDATE(),
    idRole INTEGER NOT NULL,
    idStatus INTEGER NOT NULL,
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



------------INITIAL INSERTS--------------

INSERT INTO asset.tblStatus(statusName, statusDescription)
VALUES	('Aprobado','La solicitud fue revisada y aprobada con éxito.'),
		('Revisión','La solicitud esta pendiente de revisión.'),
		('Denegado','La solicitud fue revisada y denegado con éxito.');

INSERT INTO users.tblUserRoles(roleName,roleDescription)
VALUES	('Administrador', 'Usuario encargado de supervisar el sistema.'),
		('Cajero', 'Usuario que realiza ventas en mostrador'),
		('Encargado de Almacén','Usuario encargado de supervisar los ingresos y egresos de inventarios.');