-- 05_plain_language_summary.sql
-- Plain-language inspection summaries

CREATE OR REPLACE VIEW ROOM_FINDINGS_TEXT AS
SELECT
  rr.room_id,
  r.property_id,
  r.room_type,
  CASE
    WHEN rr.defect_tag = 'structural_crack' THEN 'structural cracks'
    WHEN rr.defect_tag = 'water_damp' THEN 'visible damp or seepage'
    WHEN rr.defect_tag = 'electrical_hazard' THEN 'exposed electrical wiring'
    ELSE 'no visible issues'
  END AS finding_text
FROM ROOM_RISK_SCORE rr
JOIN ROOMS r
  ON rr.room_id = r.room_id;

CREATE OR REPLACE VIEW PROPERTY_INSPECTION_SUMMARY AS
SELECT
  property_id,
  'Risk assessment: ' ||
  LISTAGG(finding_text || ' in ' || room_type, ', ')
  AS inspection_summary
FROM ROOM_FINDINGS_TEXT
GROUP BY property_id;

CREATE OR REPLACE VIEW FINAL_PROPERTY_REPORT AS
SELECT
  prc.property_id,
  prc.risk_level || ': ' || pis.inspection_summary AS final_report
FROM PROPERTY_RISK_CATEGORY prc
JOIN PROPERTY_INSPECTION_SUMMARY pis
  ON prc.property_id = pis.property_id;
