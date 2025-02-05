--Exitosa
--Registramos un poste y un transformador en una transacci�n exitosa.

BEGIN TRANSACTION;

BEGIN TRY
    -- Insertar un nuevo poste en Salam�
    INSERT INTO Postes (codigo_poste, ubicacion, estado)
    VALUES ('POSTE-001', geography::STGeomFromText('POINT(-90.317571 15.101122)', 4326), 'Activo');

    -- Obtener el ID del poste reci�n insertado
    DECLARE @id_poste INT = SCOPE_IDENTITY();

    -- Insertar un transformador asociado a ese poste
    INSERT INTO Transformadores (codigo_transformador, id_poste, capacidad_kVA, estado)
    VALUES ('TRAFO-001', @id_poste, 50.0, 'Operativo');

    -- Si todo fue exitoso, hacer commit
    COMMIT TRANSACTION;
    PRINT 'Transacci�n completada exitosamente.';
END TRY
BEGIN CATCH
    -- En caso de error, revertir la transacci�n
    ROLLBACK TRANSACTION;
    PRINT 'Error en la transacci�n. Se han revertido los cambios.';
END CATCH;

--Fallida
--Simulamos un fallo al intentar insertar un transformador con una capacidad inv�lida (negativa), lo que provocar� un ROLLBACK.

BEGIN TRANSACTION;

BEGIN TRY
    -- Insertar un nuevo poste en Salam�
    INSERT INTO Postes (codigo_poste, ubicacion, estado)
    VALUES ('POSTE-011', geography::STGeomFromText('POINT(-90.3190 15.1052)', 4326), 'Activo');

    -- Obtener el ID del poste reci�n insertado
    DECLARE @id_poste INT = SCOPE_IDENTITY();

    -- Intentar insertar un transformador con capacidad negativa (esto causar� error por CHECK)
    INSERT INTO Transformadores (codigo_transformador, id_poste, capacidad_kVA, estado)
    VALUES ('TRAFO-002', @id_poste, -25.0, 'Operativo');

    -- No llegar� a esta l�nea si hay error
    COMMIT TRANSACTION;
    PRINT 'Transacci�n completada exitosamente.';
END TRY
BEGIN CATCH
    -- En caso de error, revertir la transacci�n
    ROLLBACK TRANSACTION;
    PRINT 'Error en la transacci�n. Se han revertido los cambios.';
    THROW; -- Lanza el error para mayor detalle
END CATCH;


-- Insertar postes con ubicaciones ficticias en Salam�, Baja Verapaz
INSERT INTO Postes (codigo_poste, ubicacion, estado)
VALUES 
    ('POSTE-101', geography::STGeomFromText('POINT(-90.3185 15.1045)', 4326), 'Activo'),
    ('POSTE-102', geography::STGeomFromText('POINT(-90.3190 15.1050)', 4326), 'Activo'),
    ('POSTE-103', geography::STGeomFromText('POINT(-90.3178 15.1038)', 4326), 'Activo'),
    ('POSTE-104', geography::STGeomFromText('POINT(-90.3182 15.1040)', 4326), 'Inactivo'),
    ('POSTE-105', geography::STGeomFromText('POINT(-90.3195 15.1055)', 4326), 'Activo');

	SELECT TOP (1000) [id_poste]
      ,[codigo_poste]
      ,ubicacion.STAsText() AS geom_wkt
      ,[estado]
  FROM [Transaciones].[dbo].[Postes]

  select * from Transformadores
