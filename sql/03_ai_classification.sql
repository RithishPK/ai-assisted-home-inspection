-- 03_ai_classification.sql
-- AI-assisted defect classification (Cortex-ready)

CREATE OR REPLACE VIEW INSPECTION_AI_CLASSIFICATION AS
SELECT
  inspection_id,
  room_id,
  inspection_note,
  image_label,

  -- Cortex-ready logic (rule-based fallback used)
  CASE
    WHEN LOWER(inspection_note) LIKE '%crack%' THEN 'structural_crack'
    WHEN LOWER(inspection_note) LIKE '%damp%'
      OR LOWER(inspection_note) LIKE '%seep%' THEN 'water_damp'
    WHEN LOWER(inspection_note) LIKE '%wire%'
      OR LOWER(inspection_note) LIKE '%electrical%' THEN 'electrical_hazard'
    ELSE 'safe'
  END AS defect_tag

FROM INSPECTIONS;
