-- Crear Base de Datos
CREATE DATABASE CooperativaDB;
GO
USE CooperativaDB;
GO

-- 1. Tabla de Asociados (Clientes / Afiliados)
CREATE TABLE Asociados (
    asociado_id INT IDENTITY(1,1) PRIMARY KEY,
    tipo_documento VARCHAR(5) DEFAULT 'CC', -- 'CC', 'CE', 'NIT'
    numero_documento VARCHAR(20) UNIQUE NOT NULL, -- Cédula de Ciudadanía Colombiana
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50) NOT NULL,
    segundo_apellido VARCHAR(50),
    ciudad_residencia VARCHAR(50),
    ingreso_mensual_cop DECIMAL(18,2) NOT NULL,
    saldo_aportes_cop DECIMAL(18,2) NOT NULL, -- Aportes sociales acumulados en la cooperativa
    fecha_vinculacion DATE NOT NULL
);

-- 2. Tabla de Créditos Otorgados
CREATE TABLE Creditos (
    credito_id INT IDENTITY(1001,1) PRIMARY KEY,
    asociado_id INT NOT NULL FOREIGN KEY REFERENCES Asociados(asociado_id),
    linea_credito VARCHAR(50) NOT NULL, -- 'Libranza', 'Libre Inversión', 'Educativo', 'Vivienda'
    monto_solicitado_cop DECIMAL(18,2) NOT NULL,
    tasa_interes_ea DECIMAL(5,2) NOT NULL, -- Tasa Efectiva Anual (%)
    plazo_meses INT NOT NULL,
    saldo_capital_deuda_cop DECIMAL(18,2) NOT NULL, -- Deuda pendiente de capital
    saldo_intereses_mora_cop DECIMAL(18,2) DEFAULT 0.00,
    estado_credito VARCHAR(30) NOT NULL, -- 'Vigente', 'Mora Temprana', 'Cobro Prejuridico', 'Cancelado'
    categoria_riesgo CHAR(1) NOT NULL, -- 'A' (Normal), 'B' (Apreciable), 'C' (Incierto), 'D' (Significativo), 'E' (Irrecuperable)
    fecha_desembolso DATE NOT NULL
);

-- 3. Tabla de Calendario de Cuotas y Deudas
CREATE TABLE Cuotas_Credito (
    cuota_id INT IDENTITY(1,1) PRIMARY KEY,
    credito_id INT NOT NULL FOREIGN KEY REFERENCES Creditos(credito_id),
    numero_cuota INT NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    fecha_pago DATE NULL, -- NULL indica cuota no pagada (deuda)
    valor_cuota_cop DECIMAL(18,2) NOT NULL,
    valor_pagado_cop DECIMAL(18,2) DEFAULT 0.00,
    -- Días de mora calculados dinámicamente respecto a la fecha actual o fecha de pago
    dias_mora AS DATEDIFF(DAY, fecha_vencimiento, ISNULL(fecha_pago, GETDATE()))
);

-- 4. Tabla CRM de Cobranzas y Seguimiento
CREATE TABLE CRM_Gestiones_Cobranza (
    gestion_id INT IDENTITY(1,1) PRIMARY KEY,
    credito_id INT NOT NULL FOREIGN KEY REFERENCES Creditos(credito_id),
    asociado_id INT NOT NULL FOREIGN KEY REFERENCES Asociados(asociado_id),
    fecha_gestion DATETIME DEFAULT GETDATE(),
    canal_contacto VARCHAR(30) NOT NULL, -- 'Llamada', 'WhatsApp', 'Visita Domiciliaria', 'Correo'
    tipo_gestion VARCHAR(50) NOT NULL, -- 'Recordatorio Preventivo', 'Acuerdo de Pago', 'Notificación Prejurídica'
    resultado VARCHAR(100) NOT NULL, -- 'Promesa de Pago', 'No Contesta', 'Insolvencia'
    valor_prometido_cop DECIMAL(18,2) NULL,
    fecha_promesa_pago DATE NULL
);