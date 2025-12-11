USE booking_db;

-- Clear existing seats for show 17
DELETE FROM seats WHERE show_id = 17;

-- Generate 300 seats (20 seats per row, 15 rows A-O)
-- Regular: A, B (40 seats)
INSERT INTO seats (show_id, seat_number, seat_type, price, is_booked, status) VALUES
(17, 'A1', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A2', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A3', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A4', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A5', 'Regular', 100, 0, 'AVAILABLE'),
(17, 'A6', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A7', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A8', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A9', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A10', 'Regular', 100, 0, 'AVAILABLE'),
(17, 'A11', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A12', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A13', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A14', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A15', 'Regular', 100, 0, 'AVAILABLE'),
(17, 'A16', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A17', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A18', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A19', 'Regular', 100, 0, 'AVAILABLE'), (17, 'A20', 'Regular', 100, 0, 'AVAILABLE'),
(17, 'B1', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B2', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B3', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B4', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B5', 'Regular', 100, 0, 'AVAILABLE'),
(17, 'B6', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B7', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B8', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B9', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B10', 'Regular', 100, 0, 'AVAILABLE'),
(17, 'B11', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B12', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B13', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B14', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B15', 'Regular', 100, 0, 'AVAILABLE'),
(17, 'B16', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B17', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B18', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B19', 'Regular', 100, 0, 'AVAILABLE'), (17, 'B20', 'Regular', 100, 0, 'AVAILABLE');

-- Silver: C, D, E, F, G, H (120 seats)
INSERT INTO seats (show_id, seat_number, seat_type, price, is_booked, status) VALUES
(17, 'C1', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C2', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C3', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C4', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C5', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'C6', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C7', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C8', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C9', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C10', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'C11', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C12', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C13', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C14', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C15', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'C16', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C17', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C18', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C19', 'Silver', 150, 0, 'AVAILABLE'), (17, 'C20', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'D1', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D2', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D3', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D4', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D5', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'D6', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D7', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D8', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D9', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D10', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'D11', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D12', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D13', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D14', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D15', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'D16', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D17', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D18', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D19', 'Silver', 150, 0, 'AVAILABLE'), (17, 'D20', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'E1', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E2', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E3', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E4', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E5', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'E6', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E7', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E8', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E9', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E10', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'E11', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E12', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E13', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E14', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E15', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'E16', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E17', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E18', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E19', 'Silver', 150, 0, 'AVAILABLE'), (17, 'E20', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'F1', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F2', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F3', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F4', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F5', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'F6', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F7', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F8', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F9', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F10', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'F11', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F12', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F13', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F14', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F15', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'F16', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F17', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F18', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F19', 'Silver', 150, 0, 'AVAILABLE'), (17, 'F20', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'G1', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G2', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G3', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G4', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G5', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'G6', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G7', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G8', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G9', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G10', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'G11', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G12', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G13', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G14', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G15', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'G16', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G17', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G18', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G19', 'Silver', 150, 0, 'AVAILABLE'), (17, 'G20', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'H1', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H2', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H3', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H4', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H5', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'H6', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H7', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H8', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H9', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H10', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'H11', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H12', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H13', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H14', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H15', 'Silver', 150, 0, 'AVAILABLE'),
(17, 'H16', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H17', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H18', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H19', 'Silver', 150, 0, 'AVAILABLE'), (17, 'H20', 'Silver', 150, 0, 'AVAILABLE');

-- Gold: I, J, K, L, M (100 seats)
INSERT INTO seats (show_id, seat_number, seat_type, price, is_booked, status) VALUES
(17, 'I1', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I2', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I3', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I4', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I5', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'I6', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I7', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I8', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I9', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I10', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'I11', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I12', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I13', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I14', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I15', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'I16', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I17', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I18', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I19', 'Gold', 200, 0, 'AVAILABLE'), (17, 'I20', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'J1', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J2', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J3', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J4', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J5', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'J6', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J7', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J8', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J9', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J10', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'J11', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J12', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J13', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J14', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J15', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'J16', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J17', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J18', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J19', 'Gold', 200, 0, 'AVAILABLE'), (17, 'J20', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'K1', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K2', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K3', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K4', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K5', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'K6', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K7', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K8', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K9', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K10', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'K11', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K12', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K13', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K14', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K15', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'K16', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K17', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K18', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K19', 'Gold', 200, 0, 'AVAILABLE'), (17, 'K20', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'L1', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L2', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L3', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L4', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L5', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'L6', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L7', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L8', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L9', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L10', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'L11', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L12', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L13', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L14', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L15', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'L16', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L17', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L18', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L19', 'Gold', 200, 0, 'AVAILABLE'), (17, 'L20', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'M1', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M2', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M3', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M4', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M5', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'M6', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M7', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M8', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M9', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M10', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'M11', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M12', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M13', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M14', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M15', 'Gold', 200, 0, 'AVAILABLE'),
(17, 'M16', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M17', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M18', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M19', 'Gold', 200, 0, 'AVAILABLE'), (17, 'M20', 'Gold', 200, 0, 'AVAILABLE');

-- Premium: N, O (40 seats)
INSERT INTO seats (show_id, seat_number, seat_type, price, is_booked, status) VALUES
(17, 'N1', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N2', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N3', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N4', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N5', 'Premium', 250, 0, 'AVAILABLE'),
(17, 'N6', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N7', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N8', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N9', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N10', 'Premium', 250, 0, 'AVAILABLE'),
(17, 'N11', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N12', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N13', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N14', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N15', 'Premium', 250, 0, 'AVAILABLE'),
(17, 'N16', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N17', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N18', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N19', 'Premium', 250, 0, 'AVAILABLE'), (17, 'N20', 'Premium', 250, 0, 'AVAILABLE'),
(17, 'O1', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O2', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O3', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O4', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O5', 'Premium', 250, 0, 'AVAILABLE'),
(17, 'O6', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O7', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O8', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O9', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O10', 'Premium', 250, 0, 'AVAILABLE'),
(17, 'O11', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O12', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O13', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O14', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O15', 'Premium', 250, 0, 'AVAILABLE'),
(17, 'O16', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O17', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O18', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O19', 'Premium', 250, 0, 'AVAILABLE'), (17, 'O20', 'Premium', 250, 0, 'AVAILABLE');

SELECT 'Seats generated successfully!' as message;
SELECT seat_type, COUNT(*) as count FROM seats WHERE show_id = 17 GROUP BY seat_type;
