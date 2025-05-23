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
