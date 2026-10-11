SELECT 
    cr.categoria_riesgo,
    CASE cr.categoria_riesgo
        WHEN 'A' THEN 'Riesgo Normal (0-30 días)'
        WHEN 'B' THEN 'Riesgo Apreciable (31-60 días)'
        WHEN 'C' THEN 'Riesgo Incierto (61-90 días)'
        WHEN 'D' THEN 'Riesgo Significativo (91-180 días)'
        WHEN 'E' THEN 'Incorrible / Irrecuperable (>180 días)'
    END AS descripcion_riesgo,
    COUNT(DISTINCT cr.credito_id) AS cantidad_creditos,
    SUM(cr.saldo_capital_deuda_cop) AS deuda_capital_total_cop,
    SUM(cr.saldo_intereses_mora_cop) AS intereses_mora_totales_cop,
    AVG(cu.dias_mora) AS promedio_dias_mora
FROM Creditos cr
INNER JOIN Cuotas_Credito cu ON cr.credito_id = cu.credito_id
WHERE cu.fecha_pago IS NULL -- Filtrar por cuotas pendientes de pago (deuda activa)
GROUP BY cr.categoria_riesgo
ORDER BY cr.categoria_riesgo ASC;