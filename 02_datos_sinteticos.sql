-- Insertar Asociados
INSERT INTO Asociados (tipo_documento, numero_documento, primer_nombre, primer_apellido, ciudad_residencia, ingreso_mensual_cop, saldo_aportes_cop, fecha_vinculacion)
VALUES 
('CC', '1090123456', 'Jharol', 'Martínez', 'Cúcuta', 3500000.00, 1200000.00, '2023-02-15'),
('CC', '1018456789', 'Andrea', 'Rincón', 'Bogotá', 5200000.00, 3500000.00, '2021-08-10'),
('CC', '80123456', 'Carlos', 'Gómez', 'Medellín', 2800000.00, 800000.00, '2024-01-20');

-- Insertar Créditos
INSERT INTO Creditos (asociado_id, linea_credito, monto_solicitado_cop, tasa_interes_ea, plazo_meses, saldo_capital_deuda_cop, saldo_intereses_mora_cop, estado_credito, categoria_riesgo, fecha_desembolso)
VALUES 
(1, 'Libranza', 15000000.00, 16.50, 36, 11200000.00, 0.00, 'Vigente', 'A', '2025-03-01'),
(2, 'Libre Inversión', 30000000.00, 19.80, 48, 24500000.00, 350000.00, 'Mora Temprana', 'B', '2024-11-15'),
(3, 'Educativo', 6000000.00, 12.00, 12, 4200000.00, 850000.00, 'Cobro Prejuridico', 'D', '2025-01-10');

-- Insertar Cuotas / Deudas
INSERT INTO Cuotas_Credito (credito_id, numero_cuota, fecha_vencimiento, fecha_pago, valor_cuota_cop, valor_pagado_cop)
VALUES 
(1001, 6, '2026-09-05', '2026-09-04', 530000.00, 530000.00),
(1002, 10, '2026-08-15', NULL, 920000.00, 0.00), -- Cuota vencida no pagada
(1003, 5, '2026-06-10', NULL, 580000.00, 0.00);  -- Cuota en mora alta

-- Insertar Gestiones CRM
INSERT INTO CRM_Gestiones_Cobranza (credito_id, asociado_id, fecha_gestion, canal_contacto, tipo_gestion, resultado, valor_prometido_cop, fecha_promesa_pago)
VALUES 
(1002, 2, '2026-09-01 10:30:00', 'WhatsApp', 'Acuerdo de Pago', 'Promesa de Pago', 920000.00, '2026-09-15'),