
-- Create database (if not exists)
IF DB_ID('VehicleLeasingDB') IS NULL
BEGIN
    CREATE DATABASE VehicleLeasingDB;
END
GO

USE VehicleLeasingDB;
GO

-- Drop tables if they already exist (clean start)
IF OBJECT_ID('Vehicles', 'U') IS NOT NULL DROP TABLE Vehicles;
IF OBJECT_ID('Drivers', 'U') IS NOT NULL DROP TABLE Drivers;
IF OBJECT_ID('Clients', 'U') IS NOT NULL DROP TABLE Clients;
IF OBJECT_ID('Branches', 'U') IS NOT NULL DROP TABLE Branches;
IF OBJECT_ID('Suppliers', 'U') IS NOT NULL DROP TABLE Suppliers;
GO

-- Tables
CREATE TABLE Suppliers (
    SupplierId INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Location NVARCHAR(200)
);

CREATE TABLE Branches (
    BranchId INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Address NVARCHAR(300)
);

CREATE TABLE Clients (
    ClientId INT IDENTITY PRIMARY KEY,
    CompanyName NVARCHAR(200) NOT NULL,
    ContactPerson NVARCHAR(200)
);

CREATE TABLE Drivers (
    DriverId INT IDENTITY PRIMARY KEY,
    FullName NVARCHAR(200) NOT NULL,
    LicenseNumber NVARCHAR(100)
);

CREATE TABLE Vehicles (
    VehicleId INT IDENTITY PRIMARY KEY,
    Manufacturer NVARCHAR(200) NOT NULL,
    Model NVARCHAR(200),
    Year INT,
    SupplierId INT NOT NULL FOREIGN KEY REFERENCES Suppliers(SupplierId),
    BranchId INT NOT NULL FOREIGN KEY REFERENCES Branches(BranchId),
    ClientId INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientId),
    DriverId INT NULL FOREIGN KEY REFERENCES Drivers(DriverId)
);

-- Seed data
INSERT INTO Suppliers (Name, Location) VALUES
('AutoWorld Ltd', 'Johannesburg'),
('Prime Motors', 'Cape Town'),
('Global Vehicles', 'Durban');

INSERT INTO Branches (Name, Address) VALUES
('Johannesburg', 'JHB Central'),
('Cape Town', 'CT Waterfront');

INSERT INTO Clients (CompanyName, ContactPerson) VALUES
('TransAfrica Logistics', 'Sipho Nkosi'),
('EcoRide SA', 'Lindiwe Mthembu');

INSERT INTO Drivers (FullName, LicenseNumber) VALUES
('John Mokoena', 'JHB123456'),
('Lerato Dube', 'CT654321');

INSERT INTO Vehicles (Manufacturer, Model, Year, SupplierId, BranchId, ClientId, DriverId)
VALUES
('Toyota', 'Hilux', 2022, 1, 1, 1, 1),
('Ford', 'Ranger', 2021, 2, 2, 2, 2),
('Mercedes-Benz', 'Sprinter', 2023, 3, 1, 1, 2);
