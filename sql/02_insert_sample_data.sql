-- 02_insert_sample_data.sql
-- Synthetic inspection dataset for prototype

INSERT INTO PROPERTIES VALUES
('P1','Bangalore','Under Construction');

INSERT INTO ROOMS VALUES
('R1','P1','Bedroom'),
('R2','P1','Kitchen'),
('R3','P1','Bathroom'),
('R4','P1','Living Room');

INSERT INTO INSPECTIONS VALUES
('I1','R1','Damp patches visible near window','leak','2025-01-05'),
('I2','R2','Exposed wiring near switchboard','exposed_wire','2025-01-05'),
('I3','R3','Hairline crack on ceiling beam','crack','2025-01-05'),
('I4','R4','No visible issues in living room','ok','2025-01-05');
