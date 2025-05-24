-- Tabla de usuarios del sistema
CREATE TABLE usuario (
  id SERIAL PRIMARY KEY,
  correo VARCHAR(100) NOT NULL UNIQUE,
  nombre_completo VARCHAR(100) NOT NULL,
  contrasena VARCHAR(255) NOT NULL,
  telefono VARCHAR(20),
  creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de roles del sistema (ej. administrador, propietario)
CREATE TABLE rol (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla de usuarios administrativos
CREATE TABLE usuario_admin (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER NOT NULL REFERENCES usuario(id),
  creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de usuarios residentes
CREATE TABLE usuario_residente (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER NOT NULL REFERENCES usuario(id),
  creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de conjuntos residenciales
CREATE TABLE residencial (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100),
  direccion TEXT,
  creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de edificios dentro del conjunto residencial
CREATE TABLE edificio (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100),
  residencial_id INTEGER REFERENCES residencial(id),
  creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de propiedades (ej. apartamentos, casas)
CREATE TABLE propiedad (
  id SERIAL PRIMARY KEY,
  numero VARCHAR(20),
  edificio_id INTEGER REFERENCES edificio(id),
  residencial_id INTEGER REFERENCES residencial(id),
  residente_id INTEGER REFERENCES usuario_residente(id),
  creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de anuncios o comunicados
CREATE TABLE anuncio (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  contenido TEXT NOT NULL,
  creado_por INTEGER REFERENCES usuario_admin(id),
  creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de servicios (ej. mantenimiento, aseo, etc.)
CREATE TABLE servicio (
  id SERIAL PRIMARY KEY,
  descripcion TEXT,
  creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de estados de los servicios
CREATE TABLE estado_servicio (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

-- Relación entre servicios y sus estados
CREATE TABLE estado_servicio_servicio (
  id SERIAL PRIMARY KEY,
  estado_servicio_id INTEGER REFERENCES estado_servicio(id),
  servicio_id INTEGER REFERENCES servicio(id)
);

-- Relación entre servicios y propiedades donde se prestan
CREATE TABLE servicio_propiedad (
  id SERIAL PRIMARY KEY,
  servicio_id INTEGER REFERENCES servicio(id),
  propiedad_id INTEGER REFERENCES propiedad(id)
);

-- Tabla de reservas (ej. salón comunal, zonas)
CREATE TABLE reserva (
  id SERIAL PRIMARY KEY,
  residente_id INTEGER REFERENCES usuario_residente(id),
  propiedad_id INTEGER REFERENCES propiedad(id),
  fecha_reserva DATE,
  creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de pagos realizados
CREATE TABLE pago (
  id SERIAL PRIMARY KEY,
  monto DECIMAL(10,2),
  fecha_pago DATE,
  metodo_pago VARCHAR(50),
  creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Relación entre pagos y reservas
CREATE TABLE pago_reserva (
  id SERIAL PRIMARY KEY,
  pago_id INTEGER REFERENCES pago(id),
  reserva_id INTEGER REFERENCES reserva(id)
);


INSERT INTO usuarios (correo, nombre_completo, contrasena, telefono) VALUES
('ana@example.com', 'Ana Torres', 'pass1234', '3001112233'),
('luis@example.com', 'Luis Pérez', 'pass2345', '3102223344'),
('maria@example.com', 'María Gómez', 'pass3456', '3203334455'),
('jose@example.com', 'José Martínez', 'pass4567', '3004445566'),
('laura@example.com', 'Laura Díaz', 'pass5678', '3105556677'),
('juan@example.com', 'Juan Herrera', 'pass6789', '3206667788'),
('carla@example.com', 'Carla Ríos', 'pass7890', '3007778899'),
('diego@example.com', 'Diego Castro', 'pass8901', '3108889900'),
('sara@example.com', 'Sara León', 'pass9012', '3209990011'),
('david@example.com', 'David Romero', 'pass0123', '3001234567');


INSERT INTO roles (nombre) VALUES
('Administrador'),
('Residente'),
('Propietario'),
('Conserje'),
('Visitante'),
('Contador'),
('Técnico'),
('Seguridad'),
('Junta Directiva'),
('Super Administrador');


INSERT INTO adm_user (usuario_id) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);


INSERT INTO resident_user (usuario_id) VALUES
(2), (3), (4), (5), (6), (7), (8), (9), (10), (1);


INSERT INTO residential (nombre, direccion) VALUES
('Residencial Palma Real', 'Calle 1 #23-45'),
('Conjunto Altos del Bosque', 'Carrera 7 #89-12'),
('Residencias La Esperanza', 'Diagonal 5 #33-21'),
('Villa Campestre', 'Transversal 12 #90-10'),
('Altamira Condominio', 'Avenida 3 #20-05'),
('Conjunto Cerrado El Lago', 'Calle 45 #14-22'),
('Torres del Sol', 'Carrera 15 #76-30'),
('Residencias El Prado', 'Calle 80 #19-55'),
('Parques del Río', 'Carrera 2 #66-44'),
('Mirador de los Andes', 'Avenida 8 #50-20');

INSERT INTO building (nombre, residencial_id) VALUES
('Torre A', 1), ('Torre B', 1), ('Edificio C', 2), ('Torre D', 3),
('Torre E', 4), ('Edificio F', 5), ('Bloque G', 6), ('Torre H', 7),
('Torre I', 8), ('Bloque J', 9);


INSERT INTO property (numero, edificio_id, residencial_id, propietario_id) VALUES
('101', 1, 1, 1), ('102', 1, 1, 2), ('201', 2, 1, 3),
('301', 3, 2, 4), ('401', 4, 3, 5), ('501', 5, 4, 6),
('601', 6, 5, 7), ('701', 7, 6, 8), ('801', 8, 7, 9), ('901', 9, 8, 10);


INSERT INTO announcements (titulo, contenido, creado_por) VALUES
('Reunión de copropietarios', 'Será el próximo sábado a las 5pm', 1),
('Corte de agua', 'Este miércoles por mantenimiento', 2),
('Fumigación general', 'Programada para el viernes', 3),
('Pago de administración', 'Fecha límite: 10 de cada mes', 4),
('Obras en portería', 'Durarán 3 días', 5),
('Fiesta de fin de año', 'Confirmar asistencia', 6),
('Normas de convivencia', 'Revisar reglamento actualizado', 7),
('Instalación cámaras', 'Inicio de instalación el lunes', 8),
('Cierre parqueadero', 'Por limpieza general', 9),
('Clases de yoga', 'Inscripciones abiertas', 10);



INSERT INTO services (descripcion) VALUES
('Plomería'),
('Electricidad'),
('Limpieza general'),
('Recolección de basura'),
('Mantenimiento zonas comunes'),
('Fumigación'),
('Reparación ascensores'),
('Seguridad adicional'),
('Jardinería'),
('Pintura edificio');


INSERT INTO service_status (nombre) VALUES
('Pendiente'),
('En curso'),
('Finalizado'),
('Programado'),
('Cancelado'),
('Aprobado'),
('Rechazado'),
('En revisión'),
('En espera'),
('Urgente');


INSERT INTO service_status_services (estado_servicio_id, servicio_id) VALUES
(1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,7), (8,8), (9,9), (10,10);


INSERT INTO services_property (servicio_id, propiedad_id) VALUES
(1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,7), (8,8), (9,9), (10,10);


INSERT INTO reservations (residente_id, propiedad_id, fecha_reserva) VALUES
(1,1,'2025-06-01'), (2,2,'2025-06-02'), (3,3,'2025-06-03'),
(4,4,'2025-06-04'), (5,5,'2025-06-05'), (6,6,'2025-06-06'),
(7,7,'2025-06-07'), (8,8,'2025-06-08'), (9,9,'2025-06-09'), (10,10,'2025-06-10');



INSERT INTO payments (monto, fecha_pago, metodo) VALUES
(100000, '2025-06-01', 'Efectivo'),
(120000, '2025-06-02', 'Transferencia'),
(110000, '2025-06-03', 'Tarjeta'),
(95000, '2025-06-04', 'Nequi'),
(130000, '2025-06-05', 'Daviplata'),
(115000, '2025-06-06', 'Tarjeta'),
(98000, '2025-06-07', 'Transferencia'),
(102000, '2025-06-08', 'Efectivo'),
(125000, '2025-06-09', 'Nequi'),
(90000, '2025-06-10', 'Efectivo');


INSERT INTO reservation_payments (pago_id, reserva_id) VALUES
(1,1), (2,2), (3,3), (4,4), (5,5),
(6,6), (7,7), (8,8), (9,9), (10,10);



-- 1. Ver todos los usuarios
SELECT * FROM usuarios;

-- 2. Ver todos los roles
SELECT * FROM roles;

-- 3. Ver todos los edificios del residencial con ID 1
SELECT * FROM building WHERE residencial_id = 1;

-- 4. Ver todas las propiedades de un edificio específico
SELECT * FROM property WHERE edificio_id = 2;

-- 5. Ver todos los servicios activos (status = 'En curso')
SELECT s.* FROM services s
JOIN service_status_services sss ON s.id = sss.servicio_id
JOIN service_status ss ON ss.id = sss.estado_servicio_id
WHERE ss.nombre = 'En curso';



-- 6. Mostrar usuarios con su rol (suponiendo que tienes tabla usuario_rol)
SELECT u.nombre_completo, r.nombre AS rol
FROM usuarios u
JOIN adm_user au ON u.id = au.usuario_id
JOIN roles r ON r.id = 1;

-- 7. Mostrar propiedades con su edificio y residencial
SELECT p.numero, b.nombre AS edificio, r.nombre AS residencial
FROM property p
JOIN building b ON p.edificio_id = b.id
JOIN residential r ON p.residencial_id = r.id;

-- 8. Mostrar reservas con nombre del residente
SELECT ru.usuario_id, u.nombre_completo, r.fecha_reserva
FROM reservations r
JOIN resident_user ru ON r.residente_id = ru.usuario_id
JOIN usuarios u ON u.id = ru.usuario_id;

-- 9. Mostrar pagos con fecha, monto y método
SELECT * FROM payments ORDER BY fecha_pago DESC;

-- 10. Mostrar pagos con nombre del residente
SELECT u.nombre_completo, p.monto, p.fecha_pago
FROM payments p
JOIN reservation_payments rp ON p.id = rp.pago_id
JOIN reservations r ON rp.reserva_id = r.id
JOIN usuarios u ON u.id = r.residente_id;


-- 11. Total de pagos realizados
SELECT SUM(monto) AS total_pagado FROM payments;

-- 12. Número de servicios por estado
SELECT ss.nombre AS estado, COUNT(*) AS cantidad
FROM service_status_services sss
JOIN service_status ss ON sss.estado_servicio_id = ss.id
GROUP BY ss.nombre;

-- 13. Total de propiedades por residencial
SELECT r.nombre, COUNT(p.id) AS cantidad_propiedades
FROM residential r
JOIN property p ON r.id = p.residencial_id
GROUP BY r.nombre;


-- 14. Usuarios que han hecho reservas
SELECT nombre_completo FROM usuarios
WHERE id IN (SELECT residente_id FROM reservations);

-- 15. Propiedades sin servicios asignados
SELECT * FROM property
WHERE id NOT IN (SELECT propiedad_id FROM services_property);



-- 16. Pagos mayores a $100.000
SELECT * FROM payments WHERE monto > 100000;

-- 17. Servicios programados (estado = 'Programado')
SELECT s.descripcion
FROM services s
JOIN service_status_services sss ON s.id = sss.servicio_id
JOIN service_status ss ON ss.id = sss.estado_servicio_id
WHERE ss.nombre = 'Programado';

-- 18. Usuarios con teléfono de Claro (empieza por 300)
SELECT * FROM usuarios WHERE telefono LIKE '300%';



-- 19. Últimos 5 pagos realizados
SELECT * FROM payments ORDER BY fecha_pago DESC LIMIT 5;

-- 20. Primeros 10 usuarios ordenados por nombre
SELECT * FROM usuarios ORDER BY nombre_completo ASC LIMIT 10;



-- 21. Cuántos residentes hay en total
SELECT COUNT(*) AS total_residentes FROM resident_user;

-- 22. Cuántos servicios están en cada estado
SELECT ss.nombre AS estado, COUNT(sss.id) AS total
FROM service_status ss
JOIN service_status_services sss ON ss.id = sss.estado_servicio_id
GROUP BY ss.nombre;


-- 23. Ver servicios asignados a una propiedad específica
SELECT s.descripcion
FROM services s
JOIN services_property sp ON s.id = sp.servicio_id
WHERE sp.propiedad_id = 1;

-- 24. Ver todos los anuncios con nombre del creador
SELECT a.titulo, a.contenido, u.nombre_completo AS autor
FROM announcements a
JOIN usuarios u ON a.creado_por = u.id;
