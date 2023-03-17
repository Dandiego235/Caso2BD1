/*use copos;

INSERT INTO tiposEventosCar (nombreEvento, enabled) VALUES
('Apertura', 1),
('Cierre', 1),
('Ingreso', 1),
('Salida', 1),
('CambioTurno', 1);

INSERT INTO checkStatuses (nombreStatus, enabled) VALUES
('Confirmado', 1),
('Cancelado', 1),
('Diferencias', 1),
('Pendiente', 1),
('Procesando', 1),
('Completado', 1);

INSERT INTO coperos (nombre, telefono, cuentaBancaria, enabled, createdAt, computer, username, checksum) VALUES
('John Doe', 12345678, '95325407219874586241632509731246508084676124896093', 1, '2023-03-10 09:30:00', 'computer1', 'user1',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Mary Smith', 98765432, '38921579046210593740581720713506235904215619867538', 1, '2023-03-09 12:00:00', 'computer2', 'user2',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Peter Parker', 23456789, '12746385902753108495296087135473802956439157035841', 1, '2023-03-08 15:45:00', 'computer3', 'user3',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Anna Garcia', 34567890, '76285934789601327510896352819347602510679083450790', 1, '2023-03-07 18:20:00', 'computer4', 'user4',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Luis Hernandez', 45678901, '35170894362105890347582301965823901456792018452793', 1, '2023-03-06 21:10:00', 'computer5', 'user5',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Robert Johnson', 56789012, '24680359214879605193742850310975862497501263458021', 1, '2023-03-05 10:30:00', 'computer6', 'user6',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Carla Martinez', 67890123, '89173508294719654802371564892603574109826503721549', 1, '2023-03-04 13:45:00', 'computer7', 'user7',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Fernando Torres', 78901234, '50294813675913208695470281534967820945739062187504', 1, '2023-03-03 16:20:00', 'computer8', 'user8',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Monica Rodriguez', 89012345, '46795802315701823509658739452601987025394106837549', 1, '2023-03-02 19:10:00', 'computer9', 'user9',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Jorge Gonzalez', 90123456, '81964702915734806250375910642539871068947532051469', 1, '2023-03-01 22:30:00', 'computer10', 'user10',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Laura Alvarez', 34567812, '53078490273185469025794806321409568039762103548975', 1, '2023-02-28 09:15:00', 'computer11', 'user11',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Alberto Castro', 23456781, '21358069741085694752037809654120978354601938275014', 1, '2023-02-27 12:30:00', 'computer12', 'user12',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Beatriz Romero', 45678123, '91368740529701324659842715603897512406915382045763', 1, '2023-02-26 15:45:00', 'computer13', 'user13',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Juan Hernandez', 12349876, '17624590328479610857923046587354901263458097531028', 1, '2023-02-25 18:20:00', 'computer14', 'user14',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Alfonso Davies', 89016472, '46810235790532194085790346580231759674809312506943', 1, '2023-03-10 09:30:00', 'computer1', 'user1',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Alice Johnson', 60123235, '3456789012345678901234567890123456789012', 1, '2023-03-08 15:45:00', 'computer3', 'user3',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Bob Brown', 81924433, '4567890123456789012345678901234567890123', 1, '2023-03-07 18:20:00', 'computer4', 'user4',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Eva Green', 92375632, '5678901234567890123456789012345678901234', 1, '2023-03-06 21:10:00', 'computer5', 'user5',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Juan Perez', 12345678, '59403725801620493875012648579321058694750382165024', 1, '2022-01-01 09:00:00', 'computer1', 'user1',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Maria Rodriguez', 98765432, '30895740213658971064579203846509723156840925760318', 1, '2022-02-02 12:00:00', 'computer2', 'user2',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Pedro Gonzalez', 23456789, '83215096740135869745910234658732095146708931520486', 1, '2022-03-03 15:00:00', 'computer3', 'user3',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Ana Ramirez', 34567890, '56012378490563219804751032968475021396845702135048', 1, '2022-04-04 18:00:00', 'comcputer4', 'user4',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Luisa Fernandez', 45678901, '40325689701895746230186594072513860492573681058921', 1, '2022-05-05 21:00:00', 'computer5', 'user5',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Roberto Martinez', 56789012, '17890324569810756249356821905304769123580475293681', 1, '2022-06-06 10:00:00', 'computer6', 'user6',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Carla Sanchez', 67890123, '64379012506825793105489620731584620978435612093875', 1, '2022-07-07 13:00:00', 'computer7', 'user7',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Fernando Garcia', 78901234, '51023784698563129704589620347158602493587210643985', 1, '2022-08-08 16:00:00', 'computer8', 'user8',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Monica Castro', 89012345, '23875904136589217409653827014567905832701594638012', 1, '2022-09-09 19:00:00', 'computer9', 'user9',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Jorge Jimenez', 90123456, '72039568451386794025193408652741390528694750126348', 1, '2022-10-10 22:00:00', 'computer10', 'user10',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Laura Alvarez', 34567812, '46017293875102893568403925710659483207950623145897', 1, '2022-11-11 09:00:00', 'computer11', 'user11',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256)),
('Alberto Castro', 23456781, '52039867541089623579043125768409521763908405213758', 1, '2022-12-12 12:00:00', 'computer12', 'user12',
SHA2(CONCAT(cuentaBancaria, coperoId, createdAt, computer, username, nombre, telefono, 'Wakanda Forever', enabled), 256));

-- SELECT * FROM coperos;

INSERT INTO carritos (color, dinero, placa, enabled, createdAt, updatedAt, computer, username, checksum) VALUES
('rojo', 0, 'ABC-123', 1, '2022-01-01 10:00:00', NULL, 'computer1', 'user1', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('azul', 0, 'DEF-456', 1, '2022-01-02 11:30:00', NULL, 'computer2', 'user2', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('verde', 0, 'GHI-789', 1, '2022-01-03 14:45:00', NULL, 'computer1', 'user3', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('amarillo', 0, 'JKL-012', 1, '2022-01-04 09:15:00', NULL, 'computer2', 'user4', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('negro', 0, 'MNO-345', 1, '2022-01-05 08:00:00', NULL, 'computer3', 'user5', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('blanco', 0, 'PQR-678', 1, '2022-01-06 17:45:00', NULL, 'computer3', 'user6', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('morado', 0, 'STU-901', 1, '2022-01-07 15:30:00', NULL, 'computer4', 'user7', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('gris', 0, 'VWX-234', 1, '2022-01-08 12:00:00', NULL, 'computer4', 'user8', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('anaranjado', 0, 'YZA-567', 1, '2022-01-09 09:15:00', NULL, 'computer5', 'user9', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('rosado', 0, 'BCD-890', 1, '2022-01-10 14:45:00', NULL, 'computer5', 'user10', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('cafe', 0, 'EFG-123', 1, '2022-01-11 09:15:00', NULL, 'computer6', 'user11', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('plateado', 0, 'HIJ-456', 1, '2022-01-12 11:30:00', NULL, 'computer6', 'user12', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('dorado', 0, 'DGR-235', 1, '2022-01-10 14:45:00', NULL, 'computer5', 'user10', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('celeste', 0, 'TWN-039', 1, '2022-01-11 09:15:00', NULL, 'computer6', 'user11', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256)),
('turquesa', 0, 'WKN-777', 1, '2022-01-12 11:30:00', NULL, 'computer6', 'user12', SHA2(CONCAT(username, placa, createdAt, dinero, enabled, 'carritos', computer, color), 256));

-- SELECT * FROM carritos;

INSERT INTO playas (nombre, enabled) VALUES
('playa herradura', 1),
('playa blanca', 1),
('playa tamarindo', 1),
('playa jacó', 1);

-- SELECT * FROM playas;

INSERT INTO ingredientes (descripcion, medida, enabled) VALUES
('hielo granizado', 'tazas', 1),
('leche en polvo', 'cucharadas', 1),
('leche condensada', 'cucharadas', 1),
('sirope', 'tazas', 1),
('sabor café', 'tazas', 1),
('sabor limon', 'tazas', 1),
('sabor chicle', 'tazas', 1),
('sabor maracuya', 'tazas', 1),
('tequila', 'onzas', 1),
('cointreau', 'onzas', 1),
('jugo de limon', 'onzas', 1),
('sal', 'cucharada', 1),
('vaso', 'unidad', 1),
('jugo de piña', 'mL', 1),
('ron blanco', 'mL', 1),
('crema de coco', 'mL', 1),
('piña', 'gramos', 1),
('lima', 'unidad', 1),
('azúcar granulada', 'cucharadita', 1),
('menta', 'gramos', 1),
('agua carbonatada', 'mL', 1);

-- SELECT * FROM ingredientes;

INSERT INTO copoProductos (nombre, enabled, createdAt, computer, username, checksum) VALUES
('copo regular', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo regular grande', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor café', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor cafe grande', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor limon', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor limon grande', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor chicle', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor chicle grande', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor maracuya', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('copo sabor maracuya grande', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('margarita', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('piña colada', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256)),
('mojito', 1, '2023-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(username, enabled, createdAt, 'copoProducts', nombre), 256));

-- SELECT * FROM copoProductos;

INSERT INTO ingredientesPorProductos (productoId, ingredienteId, cantidad, enabled, createdAt, computer, username, checksum) VALUES
(1, 1, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(1, 2, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(1, 3, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(1, 4, 0.25, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(1, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(2, 1, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(2, 2, 6, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(2, 3, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(2, 4, 0.5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(2, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(3, 1, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(3, 2, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(3, 3, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(3, 5, 0.25, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(3, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(4, 1, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(4, 2, 6, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(4, 3, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(4, 5, 0.5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(4, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(5, 1, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(5, 2, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(5, 3, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(5, 6, 0.25, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(5, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(6, 1, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(6, 2, 6, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(6, 3, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(6, 6, 0.5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(6, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(7, 1, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(7, 2, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(7, 3, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(7, 7, 0.25, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(7, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(8, 1, 2, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(8, 2, 6, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(8, 3, 4, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(8, 7, 0.5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(8, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(9, 9, 1.5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(9, 10, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(9, 11, 0.75, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(9, 12, 0.5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(9, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(10, 14, 120, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(10, 15, 60, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(10, 16, 60, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(10, 17, 15, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(10, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(11, 18, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(11, 19, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(11, 20, 5, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(11, 15, 60, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(11, 21, 180, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256)),
(11, 13, 1, 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(ingredienteId, cantidad, productoId, createdAt, username, enabled, computer), 256));

-- SELECT * FROM ingredientesPorProductos;

INSERT INTO preciosporproducto (productoId, precio, fechaInicio, enabled, createdAt, computer, username, checksum) VALUES
(1, 2500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(2, 4000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(3, 2500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(4, 4000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(5, 2500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(6, 4000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(7, 2500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(8, 4000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(9, 5000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(10, 5000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256)),
(11, 5000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, computer, productoId, enabled, username), 256));

-- SELECT * FROM preciosDefault;

INSERT INTO preciosPorProducto (productoId, playaId, precio, fechaInicio, enabled, createdAt, computer, username, checksum) VALUES
(3, 1, 3500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, playaId, fechaInicio, computer, productoId, enabled, username), 256)),
(4, 1, 5000, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, playaId, fechaInicio, computer, productoId, enabled, username), 256)),
(10, 3, 5500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, playaId, fechaInicio, computer, productoId, enabled, username), 256)),
(9, 4, 5500, '2022-01-05 09:30:00', 1, '2022-01-05 09:30:00', 'computer1', 'user1', SHA2(CONCAT(precio, createdAt, playaId, fechaInicio, computer, productoId, enabled, username), 256));

INSERT INTO ingredientesPorCarrito (carritoId, ingredienteId, cantidad, enabled, createdAt, computer, username, checksum) VALUES
(1, 1, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 2, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 3, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 4, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 5, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 6, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 7, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 8, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 9, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 10, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 11, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 12, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 13, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 14, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 15, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 16, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 17, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 18, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 19, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 20, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256)),
(1, 21, 0, 1, NOW(), 'computer1', 'user1', SHA2(CONCAT('A WILD GENGAR Appeared'), 256));*/

-- SELECT * FROM preciosPorProducto;

/*SELECT copoProductos.productoId, copoProductos.nombre, ingredientes.descripcion, ingredientesporproductos.cantidad, ingredientes.medida FROM copoProductos
INNER JOIN ingredientesporproductos ON copoProductos.productoId = ingredientesporproductos.productoId 
INNER JOIN ingredientes ON ingredientesporproductos.ingredienteId = ingredientes.ingredienteId;*/

DROP TABLE IF EXISTS ingredientesEvento;
CREATE TEMPORARY TABLE ingredientesEvento(
  guid VARCHAR(36),
  ingredienteId INT,
  quantity DECIMAL(10,2)
);

DROP PROCEDURE IF EXISTS registrarEventoTurno;
DELIMITER $$
CREATE PROCEDURE registrarEventoTurno(IN pTipoEvento TINYINT, IN pCheckStatus TINYINT, IN pTurnoId INT, IN pFecha DATETIME, IN pComputer VARCHAR(20), IN pUsername VARCHAR(20), IN pGuid VARCHAR(36))
BEGIN
  DECLARE pEventId INT;
  DECLARE pRandom TINYINT;
  
  /*
  SET pRandom = 1;
  IF pTipoEvento <= 3 THEN 
    SET pRandom = FLOOR(1 + (RAND() * porcentajeRobo));
    IF pRandom = 1 THEN 
      IF pTipoEvento <> 1 THEN
        pCheckStatus = 2;
      ENDIF;
    ENDIF;
  ENDIF;
  */

-- insertar en eventos carritos
	INSERT INTO eventosCarritos (turnoId, fecha, tipoEventoCarId, checkStatusId, enabled, createdAt, computer, username, eventosCarritos.checksum) VALUES 
  (pTurnoId, pFecha, pTipoEvento, pCheckStatus, 1, pFecha,pComputer, pUsername,  SHA2(CONCAT('Wakanda Forever','Copero system',pComputer,pTurnoId, pFecha, pUsername), 256));

  -- insertar en bitácora ingredientes
  SET pEventId = LAST_INSERT_ID(); 
  INSERT INTO bitacoraIngredientes (eventId, ingredienteId, cantidad, fecha, createdAt, computer, username, bitacoraIngredientes.checksum)
  SELECT pEventId, ingredientesEvento.ingredienteId, ingredientesEvento.quantity, pFecha, pFecha, pComputer,pUsername, SHA2('A wild gengar appeared',256)
  FROM ingredientesEvento
  WHERE ingredientesEvento.guid = pGuid;
  
  -- update ingredients por carrito
  UPDATE ingredientesPorCarrito
  INNER JOIN (SELECT bi.eventId, bi.ingredienteId, SUM(cantidad) AS total FROM bitacoraIngredientes AS bi GROUP BY eventId, ingredienteId) AS matches
  ON matches.ingredienteId = ingredientesPorCarrito.ingredienteId
  INNER JOIN eventosCarritos ON matches.eventId = eventosCarritos.eventId
  INNER JOIN turnos ON eventosCarritos.turnoId = turnos.turnoId
  SET ingredientesPorCarrito.cantidad = ingredientesPorCarrito.cantidad + matches.total
  WHERE matches.eventId = pEventId AND matches.ingredienteId = ingredientesPorCarrito.ingredienteId
  AND ingredientesPorCarrito.carritoId = turnos.carritoId;
  
END$$
DELIMITER ;

DROP TABLE IF EXISTS productosVenta;
CREATE TEMPORARY TABLE productosVenta(
  guid VARCHAR(36),
  productId INT,
  quantity SMALLINT
);

-- SELECT @newGUID;
/*SET @newGUID = UUID();
INSERT INTO productosVenta(guid, productId, quantity) VALUES
(@newGUID, 1, 2),
(@newGUID, 2, 1),
(@newGUID, 3, 1),
(@newGUID, 10, 1);*/

-- SELECT productId FROM productosVenta WHERE guid = @newGUID;
-- SELECT * FROM productosVenta;

DROP PROCEDURE IF EXISTS registrarVenta;
DELIMITER $$
CREATE PROCEDURE registrarVenta(IN pTurnoId INT, IN pTipoPago TINYINT, IN pPostDate DATETIME, IN pComputer VARCHAR(20), IN pUsername VARCHAR(20), IN pGuid VARCHAR(36))
BEGIN
  DECLARE pComisionId INT;
  DECLARE pVentaId INT;
  DECLARE pEventId INT;
  DECLARE pStatusId TINYINT;
  
  SET pStatusId = 1;
  SET pComisionId = (SELECT comisionId FROM comisiones WHERE (comisiones.enabled = 1 AND DATEDIFF(pPostDate, comisiones.fechaInicio) > 0)
  OR (pPostDate BETWEEN comisiones.fechaInicio AND comisiones.fechaFin)); 
     
  INSERT INTO copoVentas (turnoId, postDate, tipoPago, monto, solicitudId, enabled, pagadoCopero, comisionId, createdAt, computer, username, copoVentas.checksum) VALUES
  (pTurnoId, pPostDate, pTipoPago, 0, NULL, 1, 0, pComisionId, pPostDate, pComputer, pUsername, SHA2(CONCAT(turnoId,'Wakanda Forever','Copero system',pComputer,pUsername, comisionId), 256));

  SET pVentaId = LAST_INSERT_ID(); 
  INSERT INTO productosPorVenta (ventaId, productoId, cantidad, enabled, createdAt, computer, username, productosPorVenta.checksum)
  SELECT pVentaId, productosVenta.productId, productosVenta.quantity, 1, pPostDate, pComputer, pUsername, SHA2(CONCAT('Wakanda Forever','Copero system',pComputer,pUsername, pComisionId), 256)
  FROM productosVenta
  WHERE guid = pGuid;

-- insertar en eventos carritos

	IF (SELECT COUNT(*) FROM productosPorVenta WHERE productosPorventa.ventaId = pVentaId) = 0 THEN
		SET pStatusId = 3;
	END IF;
	INSERT INTO eventosCarritos (turnoId, fecha, tipoEventoCarId, checkStatusId, enabled, createdAt, computer, username, eventosCarritos.checksum) VALUES 
  (pTurnoId, pPostDate, 4, pStatusId, 1, pPostDate,pComputer, pUsername,  SHA2(CONCAT('Wakanda Forever','Copero system',pComputer,pTurnoId, pPostDate, pUsername, pComisionId), 256));
  SET pEventId = LAST_INSERT_ID(); 
  
  -- actualizar monto en venta
    IF pStatusId = 1 THEN
	  UPDATE copoVentas INNER JOIN
      (SELECT productosPorVenta.ventaId, SUM(productosPorVenta.cantidad * COALESCE(preciosPlayas.precioPlaya, preciosDefault.precio)) montoTotal
		FROM productosPorVenta
		  INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
		  LEFT JOIN
		  (SELECT productosPorVenta.productoid, preciosPorProducto.precio precioPlaya FROM productosPorVenta
		  INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
		  LEFT JOIN preciosPorProducto ON productosPorVenta.productoId = preciosPorProducto.productoId
		  LEFT JOIN copoVentas ON copoVentas.ventaId = productosPorVenta.ventaId
		  INNER JOIN turnos ON turnos.turnoId= copoVentas.turnoId
		  WHERE productosPorVenta.ventaId = pVentaId AND preciosPorProducto.playaId = turnos.playaId)
		  preciosPlayas ON preciosPlayas.productoId = productosPorVenta.productoId
		  WHERE productosPorVenta.ventaId = pVentaId GROUP BY productosPorVenta.ventaId) AS montoCaja
          ON montoCaja.ventaId = copoVentas.ventaId
	  SET copoVentas.monto = montoCaja.montoTotal
      WHERE copoVentas.ventaId = pVentaId AND montoCaja.ventaId = pVentaId;
	END IF;
    
-- insertar en bitácora ingredientes
  INSERT INTO bitacoraIngredientes (eventId, ingredienteId, cantidad, fecha, createdAt, computer, username, bitacoraIngredientes.checksum)
  SELECT pEventId, ingredientesPorProductos.ingredienteId, -(ingredientesPorProductos.cantidad * productosPorVenta.cantidad), pPostDate, pPostDate, pComputer,pUsername, SHA2('A wild gengar appeared',256)
  FROM productosPorVenta
  INNER JOIN copoProductos ON productosPorVenta.productoId = copoProductos.productoId
  INNER JOIN ingredientesPorProductos On copoProductos.productoId = ingredientesporproductos.productoId
  WHERE productosPorVenta.ventaId = pVentaId;

  -- update ingredientes por carrito
  UPDATE ingredientesPorCarrito
  INNER JOIN (SELECT bi.eventId, bi.ingredienteId, SUM(cantidad) AS total FROM bitacoraIngredientes AS bi GROUP BY eventId, ingredienteId) AS matches
  ON matches.ingredienteId = ingredientesPorCarrito.ingredienteId
  INNER JOIN eventosCarritos ON matches.eventId = eventosCarritos.eventId
  INNER JOIN turnos ON eventosCarritos.turnoId = turnos.turnoId
  SET ingredientesPorCarrito.cantidad = ingredientesPorCarrito.cantidad + matches.total
  WHERE matches.eventId = pEventId AND matches.ingredienteId = ingredientesPorCarrito.ingredienteId
  AND ingredientesPorCarrito.carritoId = turnos.carritoId;
  
    -- insertar en caja carritos
	  IF pTipoPago = 1 THEN
		  INSERT INTO cajaCarritos (turnoId, fecha, tipoEventoCarId, checkStatusId, ventaId, monto, createdAt, computer, username, checksum) 
		  SELECT pTurnoId, pPostDate, 4, 1, pVentaId, copoVentas.monto, pPostDate, pComputer, pUsername,
		  SHA2(CONCAT('Wakanda Forever','Copero system',pComputer,pTurnoId, pPostDate, pUsername, pComisionId), 256)
		  FROM copoVentas WHERE copoVentas.ventaId = pVentaId;
	  END IF;

	  /*UPDATE copoVentas, (SELECT cajaCarritos.ventaId As ventaId, SUM(cajaCarritos.monto) AS montoTotal FROM cajaCarritos GROUP BY ventaId) AS cajaTotal
	  SET copoVentas.monto = cajaTotal.montoTotal
	  WHERE copoVentas.ventaId = pVentaId AND cajaTotal.ventaId = pVentaId;*/
  
END$$
DELIMITER ;

/*SELECT ingredientesPorCarrito.ingredienteId, ingredientesPorCarrito.carritoId, ingredientesPorCarrito.cantidad, bitacoraIngredientes.itemId, 
bitacoraIngredientes.ingredienteId, bitacoraIngredientes.cantidad 
FROM ingredientesPorCarrito INNER JOIN turnos ON ingredientesPorCarrito.carritoId = turnos.carritoId
  INNER JOIN eventosCarritos ON eventosCarritos.turnoId = turnos.turnoId
  INNER JOIN bitacoraIngredientes ON bitacoraIngredientes.eventId = eventosCarritos.eventId
    WHERE bitacoraIngredientes.ingredienteId = ingredientesPorCarrito.ingredienteId AND bitacoraIngredientes.eventId = 1 AND bitacoraIngredientes.itemId > 0;

  
SELECT * FROM bitacoraIngredientes INNER JOIN eventosCarritos ON bitacoraIngredientes.eventId = eventosCarritos.eventId
  INNER JOIN turnos ON eventosCarritos.turnoId = turnos.turnoId
  INNER JOIN ingredientesPorCarrito ON ingredientesPorCarrito.carritoId = turnos.carritoId
    WHERE bitacoraIngredientes.ingredienteId = ingredientesPorCarrito.ingredienteId AND bitacoraIngredientes.eventId = 1 AND bitacoraIngredientes.itemId > 0;
*/
/*
SELECT productosPorVenta.ventaId, SUM(productosPorVenta.cantidad * COALESCE(preciosPlayas.precioPlaya, preciosDefault.precio)) montoTotal
		FROM productosPorVenta
		  INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
		  LEFT JOIN
		  (SELECT productosPorVenta.productoid, preciosPorProducto.precio precioPlaya FROM productosPorVenta
		  INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
		  LEFT JOIN preciosPorProducto ON productosPorVenta.productoId = preciosPorProducto.productoId
		  LEFT JOIN copoVentas ON copoVentas.ventaId = productosPorVenta.ventaId
		  INNER JOIN turnos ON turnos.turnoId= copoVentas.turnoId
		  WHERE productosPorVenta.ventaId = 1 AND preciosPorProducto.playaId = turnos.playaId)
		  preciosPlayas ON preciosPlayas.productoId = productosPorVenta.productoId
		  WHERE productosPorVenta.ventaId = 1 GROUP BY productosPorVenta.ventaId;*/
/*SELECT comisionId FROM comisiones WHERE (comisiones.enabled = 1 AND DATEDIFF('2022-01-01', comisiones.fechaInicio) > 0)
  OR ('2022-01-01' BETWEEN comisiones.fechaInicio AND comisiones.fechaFin);
SELECT * FROM comisiones;*/

/*SELECT * FROM copoVentas;
SELECT * From productosPorVenta;
-- select * from turno;
SELECT * FROM cajaCarritos;

INSERT INTO turnos (coperoId, carritoId, playaId, turnoInicio, turnoFin, enabled, createdAt, computer, username, checksum) VALUES
(1, 1, 1, '2023-03-12 08:00:00', '2023-03-12 20:00:00', 1, '2023-03-12 08:00:00', 'computer1', 'user1', SHA2(CONCAT(coperoId, carritoId, playaId, turnoInicio, turnoFin, enabled, createdAt, computer, username), 256));
*/
-- CALL registrarRefill(1, NOW(), 'computer1', 'user1', @guidRef);

-- CALL registrarVenta(last_insert_id(), 1, current_date(), NULL, 'computer1', 'user1', @newGUID);

/*select COALESCE(productosPorVenta.precio, preciosDefault.precio) precio from copoProductos
inner join preciosDefault pdefault on pdefault.productoid = prod.productoid
left join preciosporproducto ppp on ppp.productoid = prod.productoid
left join turnos on turnos.playaid = ppp.playaid
where prod.productoid = productoFetch and turnos.turnoid=pTurnoId and pdefault.enabled = 1 and ppp.enabled=1;

select COALESCE(ppp.precio, pdefault.precio) precio from copoProductos prod
inner join preciosDefault pdefault on pdefault.productoid = prod.productoid
left join preciosporproducto ppp on ppp.productoid = prod.productoid
left join turnos on turnos.playaid = ppp.playaid
where prod.productoid = prod.productoId and turnos.turnoid=1 and pdefault.enabled = 1;
 and ppp.enabled=1;

select productosPorVenta.ventaId, productosPorVenta.productoid, productosPorVenta.cantidad, preciosDefault.precio defaultPrice,
preciosPorProducto.precio precioPlaya, preciosPorProducto.playaId from productosPorVenta
INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
LEFT JOIN preciosPorProducto ON productosPorVenta.productoId = preciosPorProducto.productoId
WHERE productosPorVenta.ventaId;

select productosPorVenta.ventaId, productosPorVenta.productoid, productosPorVenta.cantidad, preciosDefault.precio defaultPrice,
preciosPorProducto.precio precioPlaya, preciosPorProducto.playaId from productosPorVenta
INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
LEFT JOIN preciosPorProducto ON productosPorVenta.productoId = preciosPorProducto.productoId
WHERE productosPorVenta.ventaId;
  
DROP VIEW preciosPlayas;
CREATE VIEW preciosPlayas AS
SELECT productosPorVenta.ventaId, productosPorVenta.productoid, productosPorVenta.cantidad, preciosDefault.precio defaultPrice,
preciosPorProducto.precio precioPlaya, preciosPorProducto.playaId
FROM productosPorVenta
  INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
  LEFT JOIN preciosPorProducto ON productosPorVenta.productoId = preciosPorProducto.productoId
  LEFT JOIN copoVentas ON copoVentas.ventaId = productosPorVenta.ventaId
  INNER JOIN turnos ON turnos.turnoId= copoVentas.turnoId
  WHERE productosPorVenta.ventaId = 1 AND preciosPorProducto.playaId = turnos.playaId;

SELECT * FROM preciosPlayas;

SELECT productosPorVenta.ventaId, productosPorVenta.productoid, productosPorVenta.cantidad, preciosDefault.precio defaultPrice,
preciosPorProducto.precio precioPlaya, preciosPorProducto.playaId,
CASE
	WHEN preciosPorProducto.playaId = turnos.playaId AND preciosPorProducto.enabled = 1  THEN preciosPorProducto.precio * productosPorVenta.cantidad
    WHEN preciosPorProducto.playaId <> turnos.playaId
    THEN preciosDefault.precio * productosPorVenta.cantidad
    ELSE NULL
END AS precioDef
FROM productosPorVenta
  INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
  LEFT JOIN preciosPorProducto ON productosPorVenta.productoId = preciosPorProducto.productoId
  LEFT JOIN copoVentas ON copoVentas.ventaId = productosPorVenta.ventaId
  INNER JOIN turnos ON turnos.turnoId= copoVentas.turnoId
  WHERE productosPorVenta.ventaId = 1 AND (turnos.playaid = preciosPorProducto.playaid or turnos.playaId != preciosPorProducto.playaId or 
  isnull(preciosPorProducto.playaid));
  
SELECT preciosPlayas.ventaId, preciosPlayas.productoId, preciosPlayas.cantidad, preciosPlayas.precioPlaya FROM preciosPlayas
UNION
SELECT productosPorVenta.ventaId, productosPorVenta.productoid, productosPorVenta.cantidad, preciosDefault.precio precio
FROM productosPorVenta
  INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
  LEFT JOIN preciosPlayas ON preciosPlayas.productoId = productosPorVenta.productoId
  WHERE productosPorVenta.ventaId = 1 AND isnull(preciosPlayas.productoId);
  
SELECT productosPorVenta.ventaId, productosPorVenta.productoid, productosPorVenta.cantidad, preciosDefault.precio precio,
preciosPlayas.precioPlaya, preciosPlayas.playaId, preciosPlayas.productoId, COALESCE(preciosPlayas.precioPlaya, preciosDefault.precio) precioDef
FROM productosPorVenta
  INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
  LEFT JOIN preciosPlayas ON preciosPlayas.productoId = productosPorVenta.productoId
  WHERE productosPorVenta.ventaId = 1;
  
SELECT productosPorVenta.ventaId, productosPorVenta.productoid, productosPorVenta.cantidad, preciosDefault.precio precio,
preciosPlayas.precioPlaya, preciosPlayas.productoId, COALESCE(preciosPlayas.precioPlaya, preciosDefault.precio) precioDef,
productosPorVenta.cantidad * COALESCE(preciosPlayas.precioPlaya, preciosDefault.precio) precioDef
FROM productosPorVenta
  INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
  LEFT JOIN
  (SELECT productosPorVenta.productoid, preciosPorProducto.precio precioPlaya FROM productosPorVenta
  INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
  LEFT JOIN preciosPorProducto ON productosPorVenta.productoId = preciosPorProducto.productoId
  LEFT JOIN copoVentas ON copoVentas.ventaId = productosPorVenta.ventaId
  INNER JOIN turnos ON turnos.turnoId= copoVentas.turnoId
  WHERE productosPorVenta.ventaId = 1 AND preciosPorProducto.playaId = turnos.playaId)
  preciosPlayas ON preciosPlayas.productoId = productosPorVenta.productoId
  WHERE productosPorVenta.ventaId = 1;
  
SELECT productosPorVenta.ventaId, productosPorVenta.productoid, productosPorVenta.cantidad, preciosDefault.precio precio,
preciosPorProducto.precio, preciosPorProducto.playaId, preciosPlayas.precioPlaya, preciosPlayas.playaId, preciosPlayas.productoId
FROM productosPorVenta
  INNER JOIN preciosDefault ON productosPorVenta.productoId = preciosDefault.productoId
  LEFT JOIN preciosPorProducto ON productosPorVenta.productoId = preciosPorProducto.productoId
  LEFT JOIN copoVentas ON copoVentas.ventaId = productosPorVenta.ventaId
  LEFT JOIN preciosPlayas ON preciosPlayas.productoId = productosPorVenta.productoId
  WHERE productosPorVenta.ventaId = 1;
  AND isnull(preciosPlayas.productoId);
  
AND turnos.playaId = preciosPorProducto.playaId;
  
SELECT productosPorVenta.ventaId, productosPorVenta.productoid, productosPorVenta.cantidad FROM productosPorVenta
WHERE ventaId = 1;

SELECT * FROM ingredientesPorCarrito
  INNER JOIN (SELECT bi.eventId, bi.ingredienteId, SUM(cantidad) AS total FROM bitacoraIngredientes AS bi GROUP BY eventId, ingredienteId) AS matches
  ON matches.ingredienteId = ingredientesPorCarrito.ingredienteId
  WHERE matches.eventId = 1 AND carritoId = 1;
SELECT * FROM ingredientesPorCarrito
  INNER JOIN (SELECT bi.eventId, bi.ingredienteId, SUM(cantidad) AS total FROM bitacoraIngredientes AS bi GROUP BY eventId, ingredienteId) AS matches
  ON matches.ingredienteId = ingredientesPorCarrito.ingredienteId
  INNER JOIN eventosCarritos ON matches.eventId = eventosCarritos.eventId
  INNER JOIN turnos ON eventosCarritos.turnoId = turnos.turnoId;

SELECT bi.eventId, bi.ingredienteId, SUM(cantidad) AS total FROM bitacoraIngredientes AS bi GROUP BY eventId, ingredienteId;

SELECT * FROM preciosPorProducto;
SELECT * FROM eventosCarritos;
SELECT * FROM bitacoraingredientes;

SELECT * FROM ingredientesPorCarrito;

SELECT * FROM cajaCarritos;

SELECT * FROM copoVentas;

SELECT * FROM productosPorVenta where ventaId = 1;*/


DROP TABLE IF EXISTS horarios;
CREATE TABLE horarios(
  guid VARCHAR (36),
  horarioId INT PRIMARY KEY AUTO_INCREMENT,
  horaInicio TIME NOT NULL,
  horaFinal TIME NOT NULL
);

-- SELECT @newGUID;

-- tabla agrupadora de horarios de turnos por día, los cuales componen el dataset.
-- se asume que tienen que estar en orden.
SET @newTimeGUID = UUID();
INSERT INTO horarios(guid, horaInicio, horaFinal) VALUES
(@newTimeGUID, '07:00:00', '12:00:00'),
(@newTimeGUID, '13:00:00', '20:00:00');

-- tabla para generar combinaciones de carrito - playa, las cuales son fijas,
-- luego, se le asigna un copero aleatorio, el cual va a ir cambiando por el turno.
-- esta asignación se hace dentro del stored procedure de llenar base
DROP TABLE IF EXISTS combinations;
CREATE TABLE combinations(
	combinationId INT PRIMARY KEY AUTO_INCREMENT,
	carritoId  INT,
    playaId INT,
    coperoId INT DEFAULT NULL
);

-- insertamos combinaciones carrito-playa para el dataset
INSERT INTO combinations (carritoId, playaId) VALUES
(1,1), (2,2), (3,3), (4,4), (5,1), (6,2), (7,3), (8,4), (9,1),
(10,2), (11,3), (12,4), (13,1), (14,2), (15,3);

-- tabla con coperos ID 
DROP TABLE IF EXISTS randomCoperos;
CREATE TABLE randomCoperos(
	randomCoperoId INT PRIMARY KEY AUTO_INCREMENT,
    coperoId INT
);

INSERT INTO randomCoperos (coperoId) SELECT coperoId from coperos ORDER BY RAND() LIMIT 15;
UPDATE combinations INNER JOIN randomCoperos ON combinations.combinationId = randomCoperos.randomCoperoId
SET combinations.coperoId = randomCoperos.coperoId
WHERE combinationId > 0;

DROP TABLE IF EXISTS turnosCombinations;
CREATE TEMPORARY TABLE turnosCombinations(
  horarioId INT,
  horaInicio TIME NOT NULL,
  horaFinal TIME NOT NULL,
	combinationId INT,
	carritoId  INT,
    playaId INT,
    coperoId INT
);

INSERT INTO turnosCombinations(horarioId, horaInicio, horaFinal, combinationId, carritoId, playaId, coperoId)
SELECT h.horarioId, h.horaInicio, h.horaFinal,  c.combinationId,
c.carritoId, c.playaId, c.coperoId FROM horarios h, combinations c;

-- SELECT * FROM turnosCombinations tc ORDER BY tc.combinationId, tc.horarioId;

DROP PROCEDURE IF EXISTS llenarBase;
DELIMITER $$
CREATE PROCEDURE llenarBase(IN pDias TINYINT, IN pFechaInicio DATETIME, IN pCantTurnos INT, IN pCarritosCant INT, IN pProductosCant INT, 
IN pVariedadVentas INT, IN pCantProdVentas INT, IN pVentasMin INT, IN pVentasMax INT,
IN pVentasMinEnd INT, IN pVentasMaxEnd INT, IN pCreatedAt DATETIME, IN pComputer VARCHAR(20), IN pUsername VARCHAR(20), IN pLadron INT, 
IN pRoboIngrediente INT, IN pPorcentajeRobo DECIMAL(4,2))
BEGIN
	DECLARE dias INT;
    DECLARE totalDias INT;
    DECLARE primerDia DATETIME;
    DECLARE pHoraInicio TIME;
    DECLARE pHoraFinal TIME;
    DECLARE turnoLength INT;
    DECLARE rangeMin INT;
    DECLARE rangeMax INT;
    DECLARE ventasCant INT;
    DECLARE ventasNum INT;
    DECLARE ventaGUID VARCHAR(36);
    DECLARE cierreGUID VARCHAR(36);
    DECLARE cierreStatus TINYINT;
    
    SET pHoraInicio = (SELECT horaInicio from horarios WHERE horarioId = 1);
    SET pHoraFinal = (SELECT horaFinal FROM horarios ORDER BY horarioId DESC LIMIT 1);
    SET primerDia = addTime(pFechaInicio, pHoraInicio);
    
    SET dias = 0;
    SET totalDias = pDias;
    diasLoop: LOOP
		IF dias >= totalDias THEN
			LEAVE diasLoop;
		END IF;
        INSERT INTO turnos (coperoId, carritoId, playaId, turnoInicio, turnoFin, enabled, createdAt, computer, username, checksum)
        SELECT tc.coperoId, tc.CarritoId, tc.playaId, addTime(adddate(pFechaInicio, INTERVAL dias Day), tc.horaInicio),
        addTime(adddate(pFechaInicio, INTERVAL dias Day), tc.horaFinal), 
        1, pCreatedAt, pComputer, pUsername,
        SHA2(CONCAT(coperoId, carritoId, playaId, horaInicio, horaFinal, 1, pCreatedAt, pComputer, pUsername), 256)
        FROM turnosCombinations AS tc ORDER BY tc.carritoId, tc.horarioId;
        SET dias = dias + 1;
    END LOOP;

    UPDATE turnos
    SET turnoAnterior = CASE
		WHEN turnoInicio = primerDia THEN NULL
        WHEN TIME(turnoInicio) = pHoraInicio AND turnoInicio <> primerDia THEN turnoId - pCantTurnos * pCarritosCant - 1
        ELSE turnoId - 1
	END
    WHERE turnoId >= 1;
    
    turnosGen: BEGIN
		  DECLARE pTurnoid INT;
          DECLARE dateInicio DATETIME;
          DECLARE dateFinal DATETIME;
		  DECLARE done INT DEFAULT FALSE;
		  DECLARE cur CURSOR FOR SELECT turnoId, turnoInicio, turnoFin FROM turnos;
		  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
          
          OPEN cur;
          
          readLoop: LOOP
			FETCH cur INTO pTurnoId, dateInicio, dateFinal;
			IF done THEN
				LEAVE readLoop;
			END IF;

                -- establezco la longitud del turno
                SET turnoLength = TIME_TO_SEC(TIMEDIFF(dateFinal, dateInicio));
                
                -- reviso si es un fin de semana para generar un intervalo de ventas más corto.
                -- las ventas se van a ir generando de acuerdo con un intervalo random de tiempo tal que quede un rango de ventas durante el turno.
                IF WEEKDAY(dateInicio) = 5 OR WEEKDAY(dateInicio) = 6 THEN
					SET rangeMax = pVentasMaxEnd;
					SET rangeMin = pVentasMinEnd;
				ELSE
					SET rangeMax = pVentasMax;
					SET rangeMin = pVentasMin;
				END IF;
                
                -- generación de ventas.
                SET ventasCant = FLOOR(rangeMin + RAND() * (rangeMax - rangeMin));
                SET ventasNum = 1;

                ventasGen: LOOP
					IF ventasNum > ventasCant THEN
						LEAVE ventasGen;
                    END IF;
                    SET ventaGUID = UUID(); -- agrupador de ventas.
                    
                    -- se va a generar una cantidad random de productos distintos.
                    INSERT INTO productosVenta(guid, productId, quantity)
					SELECT * FROM 
					(SELECT ventaGuid, copoProductos.productoId, FLOOR(0 + RAND() * pCantProdVentas) as cantidad
					FROM copoProductos ORDER BY RAND() LIMIT 5) as randomGen
                    WHERE randomGen.cantidad != 0;
                    
                    CALL registrarVenta (pTurnoId, 1, DATE_ADD(dateInicio, INTERVAL FLOOR(RAND() * turnoLength) SECOND), pComputer, pUsername, ventaGUID);
                    
                    SET ventasNum = ventasNum + 1;
                END LOOP;
                
                -- se inserta la cantidad de ingredientes que se gastó durante el turno para que no queden cantidades negativas.
                INSERT INTO ingredientesEvento (guid, ingredienteId, quantity)
                SELECT ventaGuid, ingredientesPorCarrito.ingredienteId, CEILING(-1.05 * ingredientesPorCarrito.cantidad)
                FROM ingredientesPorCarrito
                INNER JOIN carritos ON ingredientesPorCarrito.carritoId = carritos.carritoId
                INNER JOIN turnos ON carritos.carritoId = turnos.carritoId
                WHERE turnos.turnoId = pTurnoId AND ingredientesPorCarrito.cantidad < 0;
                
				-- registramos la apertura o el cambio de turno. Si el turno es el primero, es una apertura (tipoEvento = 1).
                -- si no, es un cambio de turno (tipoEvento = 3).
                CALL registrarEventoTurno(CASE WHEN TIME(dateInicio) = pHoraInicio THEN 1 ELSE 3 END, 1, 
                pTurnoId, dateInicio, pComputer, pUsername, ventaGUID);
                
                -- si estamos en el ultimo turno del dia
                IF TIME(dateFinal) = pHoraFinal THEN
					SET cierreGUID = UUID();
					IF (SELECT coperoId from turnos where turnoId = pTurnoId) = pLadron THEN
						INSERT INTO ingredientesEvento (guid, ingredienteId, quantity)
						SELECT cierreGUID, ingredientesPorCarrito.ingredienteId,
                        CASE WHEN ingredientesPorCarrito.ingredienteId = pRoboIngrediente THEN -ceiling(pPorcentajeRobo * ingredientesPorCarrito.cantidad)
                        ELSE 0 END
						FROM ingredientesPorCarrito
						INNER JOIN carritos ON ingredientesPorCarrito.carritoId = carritos.carritoId
						INNER JOIN turnos ON carritos.carritoId = turnos.carritoId
						WHERE turnos.turnoId = pTurnoId;
                        SET cierreStatus = 2;
					ELSE
						INSERT INTO ingredientesEvento (guid, ingredienteId, quantity)
						SELECT cierreGUID, ingredientesPorCarrito.ingredienteId, 0
						FROM ingredientesPorCarrito
						INNER JOIN carritos ON ingredientesPorCarrito.carritoId = carritos.carritoId
						INNER JOIN turnos ON carritos.carritoId = turnos.carritoId
						WHERE turnos.turnoId = pTurnoId;
                        SET cierreStatus = 1;
                    END IF;
					CALL registrarEventoTurno(2, cierreStatus, pTurnoId, dateFinal, pComputer, pUsername, cierreGuid);
                END IF;
          END LOOP;
    END turnosGen;
    
    
    /*
		IF dias >= totalDias THEN
			LEAVE diasLoop;
		END IF;
			SET turnoNum = 1;
			WHILE turnoNum <= pCantTurnos DO
				SET indice = 1;
				-- extraigo las horas del horario
				SET pHoraInicio = (SELECT horarios.horaInicio FROM horarios WHERE horarios.horarioId = turnoNum);
				SET pHoraFinal = (SELECT horarios.horaFinal FROM horarios WHERE horarios.horarioId = turnoNum);
                SET dateInicio = addTime(adddate(pFechaInicio, INTERVAL dias Day), pHoraInicio);
                SET dateFinal = addTime(adddate(pFechaInicio, INTERVAL dias Day), pHoraFinal);
                
				WHILE indice <= pCarritosCant DO
                
                -- extraigo el copero, el carrito y la playa
                SET pCopero = (SELECT coperoId FROM combinations WHERE combinationId = indice);
                SET pCarrito = (SELECT carritoId FROM combinations WHERE combinationId = indice);
                SET pPlaya = (SELECT playaId FROM combinations WHERE combinationId = indice);
                -- creo el turno
                -- extraigo el turno anterior si lo tiene.
				IF dias <> 0 OR turnoNum <> 1 THEN
					SET pTurnoAnterior = (SELECT turnos.turnoId FROM turnos WHERE turnos.carritoId = pCarrito ORDER BY turnoFin DESC LIMIT 1);
				ELSE
					SET pTurnoAnterior = NULL;
                END IF;
                INSERT INTO turnos (coperoId, carritoId, playaId, turnoInicio, turnoFin, turnoAnterior, enabled, createdAt, computer, username, checksum) VALUES
                (pCopero, pCarrito, pPlaya, dateInicio, dateFinal, pTurnoAnterior, 1, pCreatedAt, pComputer, pUsername,
                SHA2(CONCAT(coperoId, carritoId, playaId, turnoInicio, turnoFin, enabled, createdAt, computer, username), 256));

                -- guardo el turnoId creado
                SET pTurnoId = last_insert_id();
                
                -- establezco la longitud del turno
                SET turnoLength = TIME_TO_SEC(TIMEDIFF(pHoraFinal, pHoraInicio));
                
                -- reviso si es un fin de semana para generar un intervalo de ventas más corto.
                -- las ventas se van a ir generando de acuerdo con un intervalo random de tiempo tal que quede un rango de ventas durante el turno.
                IF WEEKDAY(dateInicio) = 5 OR WEEKDAY(dateInicio) = 6 THEN
					SET rangeMax = pVentasMaxEnd;
					SET rangeMin = pVentasMinEnd;
				ELSE
					SET rangeMax = pVentasMax;
					SET rangeMin = pVentasMin;
				END IF;
                
                -- generación de ventas.
                SET ventasCant = FLOOR(rangeMin + RAND() * (rangeMax - rangeMin));
                SET ventasNum = 1;

                ventasGen: LOOP
					IF ventasNum > ventasCant THEN
						LEAVE ventasGen;
                    END IF;
                    SET ventaGUID = UUID(); -- agrupador de ventas.
                    
                    -- se va a generar una cantidad random de productos distintos. el máximo lo dicta pVariedadVentas
                    INSERT INTO productosVenta(guid, productId, quantity)
					SELECT * FROM 
					(SELECT ventaGuid, copoProductos.productoId, FLOOR(0 + RAND() * pCantProdVentas) as cantidad
					FROM copoProductos ORDER BY RAND() LIMIT 5) as randomGen
                    WHERE randomGen.cantidad != 0;
                    
                    CALL registrarVenta (pTurnoId, 1, DATE_ADD(dateInicio, INTERVAL FLOOR(RAND() * turnoLength) SECOND), NULL, pComputer, pUsername, ventaGUID);
                    
                    SET ventasNum = ventasNum + 1;
                END LOOP;
                
                -- nos corremos al siguiente carrito
                SET indice = indice + 1;
			END WHILE;
            -- nos corremos al siguiente turno
            SET turnoNum = turnoNum + 1;
        END WHILE;
        
        SET dias = dias + 1;
        
    END LOOP;
    */
END$$
DELIMITER ;

CALL llenarBase(30, '2022-01-01 00:00:00', 2, 15, 13, 3, 3, 4, 20, 15, 20, NOW(), 'computer1', 'user1', 1, 15, 0.1);

SELECT * FROM turnos;
    
SELECT * FROM ingredientesPorCarrito;
                
SELECT * FROM productosPorVenta ORDER BY ventaId;
SELECT * FROM bitacoraingredientes;
SELECT * FROM turnos;
SELECT * from ingredientesPorCarrito;
SELECT * FROM copoventas ORDER BY turnoId, postDate;
SELECT turnoId, count(turnoId) FROM copoventas GROUP BY turnoId;
SELECT * FROM cajaCarritos;
SELECT eventosCarritos.eventId, eventosCarritos.tipoEventoCarId, eventosCarritos.checkStatusId, bitacoraIngredientes.ingredienteId,
bitacoraIngredientes.cantidad, ingredientesPorCarrito.carritoId, ingredientesPorCarrito.cantidad
 FROM eventosCarritos INNER JOIN bitacoraIngredientes ON bitacoraIngredientes.eventId = eventosCarritos.eventId
INNER JOIN turnos ON turnos.turnoId = eventosCarritos.turnoId
INNER JOIN ingredientesPorCarrito ON bitacoraIngredientes.ingredienteId = ingredientesPorCarrito.ingredienteId
WHERE turnos.coperoId = 1 AND eventosCarritos.tipoEventoCarId = 2 AND bitacoraIngredientes.ingredienteId = 9;

SELECT * FROM bitacoraIngredientes bi INNER JOIN eventosCarritos ec ON bi.eventId = ec.eventId 
INNER JOIN turnos ON ec.turnoId = turnos.turnoId WHERE bi.ingredienteId = 9 AND turnos.coperoId = 1;


/*SELECT * FROM productosPorVenta WHERE ventaId = 113;

SELECT * FROM productosVenta ORDER BY guid;
SELECT * FROM productosPorVenta WHERE ventaId = 144 OR ventaId = 170;
SELECT copoVentas.ventaId, turnos.turnoId, turnos.carritoId, copoVentas.postdate, copoVentas.monto, productosPorVenta.productoId, copoProductos.nombre, productosPorVenta.cantidad, 
playaId FROM productosPorVenta
INNER JOIN copoVentas ON copoVentas.ventaId = productosPorVenta.ventaId
INNER JOIN copoProductos ON copoProductos.productoId = productosPorVenta.productoId
INNER JOIN turnos ON copoVentas.turnoId = turnos.turnoId
ORDER BY copoVentas.ventaId;

SELECT * from eventosCarritos WHERE eventId = 429;
SELECT * FROM copoVentas WHERE turnoId = 112;
SELECT * FROM cajaCarritos WHERE ventaId = 2631;

SELECT * FROM bitacoraIngredientes WHERE eventId = 2631 AND ingredienteId = 16;
SELECT * FROM productosPorVenta WHERE ventaId = 2631;

  SELECT productosPorVenta.ventaId, productosPorVenta.productoId, copoProductos.nombre, productosPorVenta.cantidad AS cantidadProductos,
  ingredientesPorProductos.ingredienteId, -(ingredientesPorProductos.cantidad * productosPorVenta.cantidad)
  FROM productosPorVenta
  INNER JOIN copoProductos ON productosPorVenta.productoId = copoProductos.productoId
  INNER JOIN ingredientesPorProductos On copoProductos.productoId = ingredientesporproductos.productoId
  WHERE productosPorVenta.ventaId = 2631;*/
  