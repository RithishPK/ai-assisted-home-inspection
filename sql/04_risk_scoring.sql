-- 04_risk_scoring.sql
-- Room-level and property-level risk aggregation

CREATE OR REPLACE VIEW ROOM_RISK_SCORE AS
SELECT
  inspection_id,
  room_id,
  defect_tag,
  image_label,
  CASE
    WHEN defect_tag IN ('structural_crack','electrical_hazard') THEN 5
    WHEN defect_tag = 'water_damp' THEN 3
    ELSE 1
  END AS risk_score
FROM INSPECTION_AI_CLASSIFICATION;

CREATE OR REPLACE VIEW PROPERTY_RISK AS
SELECT
  r.property_id,
  ROUND(AVG(rr.risk_score),2) AS avg_property_risk
FROM ROOM_RISK_SCORE rr
JOIN ROOMS r
  ON rr.room_id = r.room_id
GROUP BY r.property_id;

CREATE OR REPLACE VIEW PROPERTY_RISK_CATEGORY AS
SELECT
  property_id,
  avg_property_risk,
  CASE
    WHEN avg_property_risk >= 4 THEN 'HIGH RISK'
    WHEN avg_property_risk >= 2 THEN 'MEDIUM RISK'
    ELSE 'LOW RISK'
  END AS risk_level
FROM PROPERTY_RISK;
