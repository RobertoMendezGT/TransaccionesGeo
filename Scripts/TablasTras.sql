-- Tabla de Postes
CREATE TABLE Postes (
    id_poste INT IDENTITY(1,1) PRIMARY KEY,
    codigo_poste VARCHAR(50) UNIQUE NOT NULL,
    ubicacion GEOGRAPHY NOT NULL,
    estado VARCHAR(20) CHECK (estado IN ('Activo', 'Inactivo'))
);

-- Tabla de Transformadores
CREATE TABLE Transformadores (
    id_transformador INT IDENTITY(1,1) PRIMARY KEY,
    codigo_transformador VARCHAR(50) UNIQUE NOT NULL,
    id_poste INT NOT NULL,
    capacidad_kVA DECIMAL(5,2) NOT NULL CHECK (capacidad_kVA > 0),
    estado VARCHAR(20) CHECK (estado IN ('Operativo', 'Dañado')),
    FOREIGN KEY (id_poste) REFERENCES Postes(id_poste) ON DELETE CASCADE
);


	


