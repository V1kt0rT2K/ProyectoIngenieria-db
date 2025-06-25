
CREATE DATABASE BD_ProyectoIngenieria;
GO

USE BD_ProyectoIngenieria;
GO

--Creación de esquemas
CREATE SCHEMA users;
GO

CREATE SCHEMA asset;
GO

--Creación de tablas
-- Tabla asset.tblStatus
CREATE TABLE asset.tblStatus (
    idStatus INT PRIMARY KEY IDENTITY(1,1),
    statusName NVARCHAR(50) NOT NULL,
    description NVARCHAR(255)
);
GO

-- Tabla users.tblPersons
CREATE TABLE users.tblPersons (
    idPerson INT PRIMARY KEY IDENTITY(1,1),
    firstName NVARCHAR(50) NOT NULL,
    secondName NVARCHAR(50),
    lastName NVARCHAR(50) NOT NULL,
    secondLastName NVARCHAR(50),
    identityNumber NVARCHAR(20) NOT NULL UNIQUE
);
GO

-- Tabla users.tblUserRoles
CREATE TABLE users.tblUserRoles (
    idRole INT PRIMARY KEY IDENTITY(1,1),
    roleName NVARCHAR(50) NOT NULL,
    description NVARCHAR(255)
);
GO

-- Tabla users.tblUsers
CREATE TABLE users.tblUsers (
    idUser INT PRIMARY KEY IDENTITY(1,1),
    email NVARCHAR(100) NOT NULL UNIQUE,
	password NVARCHAR(255) NOT NULL,
    job NVARCHAR(100),
    idPerson INT NOT NULL,
    idRole INT NOT NULL,
    isEnabled BIT DEFAULT 0,
    FOREIGN KEY (idPerson) REFERENCES users.tblPersons(idPerson),
    FOREIGN KEY (idRole) REFERENCES users.tblUserRoles(idRole)
);
GO

-- Tabla users.tblUserRolesHistoric
CREATE TABLE users.tblUserRolesHistoric (
    idUserHistoric INT PRIMARY KEY IDENTITY(1,1),
    idUser INT NOT NULL,
    idRole INT NOT NULL,
    date DATETIME DEFAULT GETDATE(),
    description NVARCHAR(255),
    FOREIGN KEY (idUser) REFERENCES users.tblUsers(idUser),
    FOREIGN KEY (idRole) REFERENCES users.tblUserRoles(idRole)
);
GO

-- Tabla users.tblUserRequest
CREATE TABLE users.tblUserRequest (
    idUserRequest INT PRIMARY KEY IDENTITY(1,1),
    idUser INT NOT NULL,
    generationDate DATETIME DEFAULT GETDATE(),
    idRole INT NOT NULL,
    idStatus INT NOT NULL,
    userName NVARCHAR(100) NOT NULL,
    email NVARCHAR(100)NOT NULL UNIQUE,
    job NVARCHAR(100),
    FOREIGN KEY (idUser) REFERENCES users.tblUsers(idUser),
    FOREIGN KEY (idRole) REFERENCES users.tblUserRoles(idRole),
    FOREIGN KEY (idStatus) REFERENCES asset.tblStatus(idStatus)
);
GO

-- Tabla users.tblUserDataHistoric
CREATE TABLE users.tblUserDataHistoric (
    idUserHistoric INT PRIMARY KEY IDENTITY(1,1),
    idUser INT NOT NULL,
    job NVARCHAR(100),
    firstName NVARCHAR(50) NOT NULL,
    secondName NVARCHAR(50),
    lastName NVARCHAR(50) NOT NULL,
    identityNumber NVARCHAR(20),
    changeDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (idUser) REFERENCES users.tblUsers(idUser)
);
GO


