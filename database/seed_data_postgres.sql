-- =============================================================================
-- SPORT CONNECT - Données Initiales PostgreSQL (Seed Data)
-- Écosystème Numérique du Sport Malgache
-- Version 1.0
-- =============================================================================

\connect sportconnect;

-- =============================================================================
-- 1. RÔLES UTILISATEUR
-- =============================================================================
INSERT INTO roles (id, name, description) VALUES
(1, 'ATHLETE', 'Athlète inscrit sur la plateforme'),
(2, 'COACH', 'Entraîneur / Entraîneur adjoint'),
(3, 'SCOUT', 'Recruteur / Observateur de talents'),
(4, 'DOCTOR', 'Médecin du sport'),
(5, 'ADMIN', 'Administrateur système'),
(6, 'ADMIN_FEDERATION', 'Administrateur de fédération'),
(7, 'OFFICIAL', 'Arbitre / Officiel de match'),
(8, 'SELECTIONNEUR', 'Sélectionneur national'),
(9, 'FAN', 'Spectateur / Supporter');

-- =============================================================================
-- 2. FÉDÉRATIONS MALGACHES (avec UUIDs PostgreSQL)
-- =============================================================================
INSERT INTO federations (id, name, sport_type, acronym, description, president_name, contact_email, contact_phone, address, is_active) VALUES
('550e8400-e29b-41d4-a716-446655440001'::uuid, 'Fédération Malgache de Football', 'FOOTBALL', 'FMF', 
 'Fédération officielle de football de Madagascar', 'Raoul Raveloarimanga', 
 'contact@fmf.mg', '+261 20 22 123 45', 'Antananarivo, Madagascar', TRUE),
('550e8400-e29b-41d4-a716-446655440002'::uuid, 'Fédération Malgache de Basketball', 'BASKETBALL', 'FMBB', 
 'Fédération de basketball de Madagascar', 'Jean Rakotomalala', 
 'contact@fmbb.mg', '+261 20 22 234 56', 'Antananarivo, Madagascar', TRUE),
('550e8400-e29b-41d4-a716-446655440003'::uuid, 'Fédération Malgache de Rugby', 'RUGBY', 'FMR', 
 'Fédération de rugby de Madagascar', 'Pierre Andriamampianina', 
 'contact@fmr.mg', '+261 20 22 345 67', 'Antananarivo, Madagascar', TRUE),
('550e8400-e29b-41d4-a716-446655440004'::uuid, 'Fédération Malgache d''Athlétisme', 'ATHLETICS', 'FMA', 
 'Fédération d''athlétisme de Madagascar', 'Marie Razafindrakoto', 
 'contact@fma.mg', '+261 20 22 456 78', 'Antananarivo, Madagascar', TRUE),
('550e8400-e29b-41d4-a716-446655440005'::uuid, 'Fédération Malgache de Volleyball', 'VOLLEYBALL', 'FMV', 
 'Fédération de volleyball de Madagascar', 'Luc Rasoamanana', 
 'contact@fmv.mg', '+261 20 22 567 89', 'Antananarivo, Madagascar', TRUE),
('550e8400-e29b-41d4-a716-446655440006'::uuid, 'Fédération Malgache de Handball', 'HANDBALL', 'FMH', 
 'Fédération de handball de Madagascar', 'Sophie Ravelojaona', 
 'contact@fmh.mg', '+261 20 22 678 90', 'Antananarivo, Madagascar', TRUE);

-- =============================================================================
-- 3. CLUBS PROFESSIONNELS ET AMATEURS
-- =============================================================================
INSERT INTO clubs (id, federation_id, name, short_name, founded_date, is_professional, stadium_name, city, region, contact_email, is_active) VALUES
-- Football
('660e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, 'CNaPS Sport', 'CNaPS', '1979-01-01', TRUE, 'Stade Municipal de Mahamasina', 'Antananarivo', 'Analamanga', 'cnaps@club.mg', TRUE),
('660e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, 'Tana FC Formation', 'TANA FC', '1990-01-01', TRUE, 'Stade Municipal', 'Antananarivo', 'Analamanga', 'tanafc@club.mg', TRUE),
('660e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, 'Disciples FC', 'DISCIPLES', '2002-01-01', FALSE, 'Stade de Mahajanga', 'Mahajanga', 'Boeny', 'disciples@club.mg', TRUE),
('660e8400-e29b-41d4-a716-446655440004'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, 'Fosa Juniors FC', 'FOSA', '2007-01-01', TRUE, 'Stade de Toamasina', 'Toamasina', 'Atsinanana', 'fosa@club.mg', TRUE),
('660e8400-e29b-41d4-a716-446655440005'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, 'AS Adema', 'ADEMA', '1950-01-01', TRUE, 'Stade Municipal', 'Antananarivo', 'Analamanga', 'adema@club.mg', TRUE),

-- Basketball
('660e8400-e29b-41d4-a716-446655440006'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, 'COSFA', 'COSFA', '1985-01-01', TRUE, 'Gymnase Municipal', 'Antananarivo', 'Analamanga', 'cosfa@club.mg', TRUE),
('660e8400-e29b-41d4-a716-446655440007'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, 'AS Lotererie Nationale', 'AS LN', '1995-01-01', TRUE, 'Gymnase Municipal', 'Antananarivo', 'Analamanga', 'asln@club.mg', TRUE),

-- Rugby
('660e8400-e29b-41d4-a716-446655440008'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid, 'Stade Malgache', 'SM', '1960-01-01', TRUE, 'Stade de Mahamasina', 'Antananarivo', 'Analamanga', 'sm@club.mg', TRUE),
('660e8400-e29b-41d4-a716-446655440009'::uuid, '550e8400-e29b-41d4-a716-446655440003'::uuid, 'RC Antananarivo', 'RCA', '1975-01-01', TRUE, 'Stade de Mahamasina', 'Antananarivo', 'Analamanga', 'rca@club.mg', TRUE);

-- =============================================================================
-- 4. UTILISATEURS ADMINISTRATEURS (UUIDs PostgreSQL)
-- Mot de passe hashé avec bcrypt (Admin123!)
INSERT INTO users (id, email, password_hash, nin, phone, role_id, is_active, email_verified, phone_verified) VALUES
('770e8400-e29b-41d4-a716-446655440001'::uuid, 'admin@sportconnect.mg', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqhmM6JGKpS4G3R1G2JH8YpfB0Bqy', 'ADMIN001', '+261 34 00 000 01', 5, TRUE, TRUE, TRUE),
('770e8400-e29b-41d4-a716-446655440002'::uuid, 'admin@fmf.mg', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqhmM6JGKpS4G3R1G2JH8YpfB0Bqy', 'ADMIN002', '+261 34 00 000 02', 6, TRUE, TRUE, TRUE),
('770e8400-e29b-41d4-a716-446655440003'::uuid, 'admin@fmbb.mg', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqhmM6JGKpS4G3R1G2JH8YpfB0Bqy', 'ADMIN003', '+261 34 00 000 03', 6, TRUE, TRUE, TRUE);

-- Administrateurs
INSERT INTO admins (user_id, first_name, last_name, admin_level) VALUES
('770e8400-e29b-41d4-a716-446655440001'::uuid, 'Super', 'Admin', 'SUPER'),
('770e8400-e29b-41d4-a716-446655440002'::uuid, 'Admin', 'Football', 'FEDERATION'),
('770e8400-e29b-41d4-a716-446655440003'::uuid, 'Admin', 'Basketball', 'FEDERATION');

-- =============================================================================
-- 5. UTILISATEURS DÉMO - ATHLÈTES (UUIDs PostgreSQL)
INSERT INTO users (id, email, password_hash, nin, phone, role_id, is_active) VALUES
-- Football
('880e8400-e29b-41d4-a716-446655440001'::uuid, 'jean.rakoto@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '1234567890123', '+261 34 12 345 01', 1, TRUE),
('880e8400-e29b-41d4-a716-446655440002'::uuid, 'paul.rabe@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '1234567890124', '+261 34 12 345 02', 1, TRUE),
('880e8400-e29b-41d4-a716-446655440003'::uuid, 'michel.andria@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '1234567890125', '+261 34 12 345 03', 1, TRUE),
('880e8400-e29b-41d4-a716-446655440004'::uuid, 'eric.randria@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '1234567890126', '+261 34 12 345 04', 1, TRUE),
('880e8400-e29b-41d4-a716-446655440005'::uuid, 'luc.rasoa@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '1234567890127', '+261 34 12 345 05', 1, TRUE),

-- Basketball
('880e8400-e29b-41d4-a716-446655440006'::uuid, 'marc.ravelo@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '2234567890123', '+261 34 22 345 01', 1, TRUE),
('880e8400-e29b-41d4-a716-446655440007'::uuid, 'pierre.rakoto@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '2234567890124', '+261 34 22 345 02', 1, TRUE);

-- Athlètes Football
INSERT INTO athletes (user_id, first_name, last_name, birth_date, gender, height, weight, current_club_id, sport_type, position, national_team_eligible) VALUES
('880e8400-e29b-41d4-a716-446655440001'::uuid, 'Jean', 'Rakotomalala', '1995-03-15', 'M', 180.5, 75.0, '660e8400-e29b-41d4-a716-446655440001'::uuid, 'FOOTBALL', 'GK', TRUE),
('880e8400-e29b-41d4-a716-446655440002'::uuid, 'Paul', 'Rabemananjara', '1996-07-22', 'M', 175.0, 68.5, '660e8400-e29b-41d4-a716-446655440001'::uuid, 'FOOTBALL', 'DF', TRUE),
('880e8400-e29b-41d4-a716-446655440003'::uuid, 'Michel', 'Andriamampianina', '1994-11-08', 'M', 182.0, 78.0, '660e8400-e29b-41d4-a716-446655440002'::uuid, 'FOOTBALL', 'MF', TRUE),
('880e8400-e29b-41d4-a716-446655440004'::uuid, 'Eric', 'Randrianirina', '1997-05-20', 'M', 178.5, 72.0, '660e8400-e29b-41d4-a716-446655440003'::uuid, 'FOOTBALL', 'FW', TRUE),
('880e8400-e29b-41d4-a716-446655440005'::uuid, 'Luc', 'Rasoamanana', '1993-09-12', 'M', 185.0, 80.0, '660e8400-e29b-41d4-a716-446655440004'::uuid, 'FOOTBALL', 'DF', FALSE);

-- Athlètes Basketball
INSERT INTO athletes (user_id, first_name, last_name, birth_date, gender, height, weight, current_club_id, sport_type, position, national_team_eligible) VALUES
('880e8400-e29b-41d4-a716-446655440006'::uuid, 'Marc', 'Ravelojaona', '1998-01-25', 'M', 198.0, 95.0, '660e8400-e29b-41d4-a716-446655440006'::uuid, 'BASKETBALL', 'CENTER', TRUE),
('880e8400-e29b-41d4-a716-446655440007'::uuid, 'Pierre', 'Rakotovao', '1996-04-18', 'M', 192.0, 88.0, '660e8400-e29b-41d4-a716-446655440007'::uuid, 'BASKETBALL', 'GUARD', TRUE);

-- =============================================================================
-- 6. ENTRAÎNEURS DÉMO (UUIDs PostgreSQL)
INSERT INTO users (id, email, password_hash, nin, phone, role_id, is_active) VALUES
('990e8400-e29b-41d4-a716-446655440001'::uuid, 'coach.foot@sportconnect.mg', '$2a$10$Coach123HashReplaceMe', '3234567890123', '+261 34 32 345 01', 2, TRUE),
('990e8400-e29b-41d4-a716-446655440002'::uuid, 'coach.basket@sportconnect.mg', '$2a$10$Coach123HashReplaceMe', '3234567890124', '+261 34 32 345 02', 2, TRUE);

INSERT INTO coaches (user_id, first_name, last_name, specialization, experience_years, current_club_id, certifications) VALUES
('990e8400-e29b-41d4-a716-446655440001'::uuid, 'François', 'Razanakoto', 'FOOTBALL', 15, '660e8400-e29b-41d4-a716-446655440001'::uuid, '["UEFA Pro", "CAF A License", "Premier Secours"]'::jsonb),
('990e8400-e29b-41d4-a716-446655440002'::uuid, 'Henri', 'Rasamoelina', 'BASKETBALL', 12, '660e8400-e29b-41d4-a716-446655440006'::uuid, '["FIBA Coach", "NCAA Certified"]'::jsonb);

-- =============================================================================
-- 7. SCOUTS DÉMO (UUIDs PostgreSQL)
INSERT INTO users (id, email, password_hash, nin, phone, role_id, is_active) VALUES
('aa0e8400-e29b-41d4-a716-446655440001'::uuid, 'scout.national@sportconnect.mg', '$2a$10$Scout123HashReplaceMe', '4234567890123', '+261 34 42 345 01', 3, TRUE),
('aa0e8400-e29b-41d4-a716-446655440002'::uuid, 'scout.regional@sportconnect.mg', '$2a$10$Scout123HashReplaceMe', '4234567890124', '+261 34 42 345 02', 3, TRUE);

INSERT INTO scouts (user_id, first_name, last_name, regions, employer, specializations) VALUES
('aa0e8400-e29b-41d4-a716-446655440001'::uuid, 'Robert', 'Andriantsiferana', '["Analamanga", "Atsinanana", "Diana"]'::jsonb, 'FMF - Fédération Malgache de Football', '["FOOTBALL"]'::jsonb),
('aa0e8400-e29b-41d4-a716-446655440002'::uuid, 'Joseph', 'Razafindrazaka', '["Vakinankaratra", "Amoron''i Mania"]'::jsonb, 'Indépendant', '["FOOTBALL", "BASKETBALL"]'::jsonb);

-- =============================================================================
-- 8. MÉDECINS DÉMO (UUIDs PostgreSQL)
INSERT INTO users (id, email, password_hash, nin, phone, role_id, is_active) VALUES
('bb0e8400-e29b-41d4-a716-446655440001'::uuid, 'dr.sport@sportconnect.mg', '$2a$10$Doctor123HashReplaceMe', '5234567890123', '+261 34 52 345 01', 4, TRUE),
('bb0e8400-e29b-41d4-a716-446655440002'::uuid, 'dr.fmf@sportconnect.mg', '$2a$10$Doctor123HashReplaceMe', '5234567890124', '+261 34 52 345 02', 4, TRUE);

INSERT INTO doctors (user_id, first_name, last_name, license_number, specialization, institution) VALUES
('bb0e8400-e29b-41d4-a716-446655440001'::uuid, 'Dr. Marie', 'Ravelojaona', 'MED12345', 'Médecine du Sport', 'Centre Hospitalier Universitaire d''Antananarivo'),
('bb0e8400-e29b-41d4-a716-446655440002'::uuid, 'Dr. Jean', 'Rakotoarison', 'MED12346', 'Médecine du Sport', 'Clinique du Sport - FMF');

-- =============================================================================
-- 9. OFFICIELS (ARBITRES) DÉMO (UUIDs PostgreSQL)
INSERT INTO users (id, email, password_hash, nin, phone, role_id, is_active) VALUES
('cc0e8400-e29b-41d4-a716-446655440001'::uuid, 'referee.foot@sportconnect.mg', '$2a$10$Referee123HashReplaceMe', '6234567890123', '+261 34 62 345 01', 7, TRUE);

INSERT INTO officials (user_id, first_name, last_name, official_type, certifications) VALUES
('cc0e8400-e29b-41d4-a716-446655440001'::uuid, 'Henri', 'Razafindrakoto', 'REFEREE', '["FIFA", "CAF", "FMF Elite"]'::jsonb);

-- =============================================================================
-- 10. COMPÉTITIONS (UUIDs PostgreSQL)
INSERT INTO competitions (id, federation_id, name, season, competition_type, format, start_date, end_date, registration_deadline, status) VALUES
('dd0e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, 'THB Champions League', '2024-2025', 'LEAGUE', 'Championnat national', '2024-08-01', '2025-05-31', '2024-07-15', 'ONGOING'),
('dd0e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, 'Coupe de Madagascar', '2024-2025', 'CUP', 'Tournoi à élimination directe', '2024-09-01', '2025-04-30', '2024-08-20', 'PLANNED'),
('dd0e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440002'::uuid, 'Championnat National Basketball', '2024-2025', 'LEAGUE', 'Championnat national', '2024-10-01', '2025-03-31', '2024-09-15', 'PLANNED');

-- Participants compétition football
INSERT INTO competition_participants (id, competition_id, club_id, seed, status) VALUES
('ee0e8400-e29b-41d4-a716-446655440001'::uuid, 'dd0e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440001'::uuid, 1, 'CONFIRMED'),
('ee0e8400-e29b-41d4-a716-446655440002'::uuid, 'dd0e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440002'::uuid, 2, 'CONFIRMED'),
('ee0e8400-e29b-41d4-a716-446655440003'::uuid, 'dd0e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440003'::uuid, 3, 'CONFIRMED'),
('ee0e8400-e29b-41d4-a716-446655440004'::uuid, 'dd0e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440004'::uuid, 4, 'CONFIRMED'),
('ee0e8400-e29b-41d4-a716-446655440005'::uuid, 'dd0e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440005'::uuid, 5, 'CONFIRMED');

-- =============================================================================
-- 11. LICENCES (Exemples - UUIDs PostgreSQL)
INSERT INTO licenses (id, athlete_id, federation_id, club_id, season, license_number, status, medical_clearance, issue_date, expiry_date, payment_status) VALUES
('ff0e8400-e29b-41d4-a716-446655440001'::uuid, '880e8400-e29b-41d4-a716-446655440001'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440001'::uuid, '2024-2025', 'FMF-2024-000001', 'APPROVED', TRUE, '2024-08-01', '2025-07-31', 'COMPLETED'),
('ff0e8400-e29b-41d4-a716-446655440002'::uuid, '880e8400-e29b-41d4-a716-446655440002'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440001'::uuid, '2024-2025', 'FMF-2024-000002', 'APPROVED', TRUE, '2024-08-01', '2025-07-31', 'COMPLETED'),
('ff0e8400-e29b-41d4-a716-446655440003'::uuid, '880e8400-e29b-41d4-a716-446655440003'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440002'::uuid, '2024-2025', 'FMF-2024-000003', 'APPROVED', TRUE, '2024-08-01', '2025-07-31', 'COMPLETED'),
('ff0e8400-e29b-41d4-a716-446655440004'::uuid, '880e8400-e29b-41d4-a716-446655440004'::uuid, '550e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440003'::uuid, '2024-2025', 'FMF-2024-000004', 'PENDING', FALSE, NULL, NULL, 'PENDING');

-- =============================================================================
-- 12. MATCHS (Exemples - UUIDs PostgreSQL)
INSERT INTO matches (id, competition_id, round, scheduled_date, venue, stadium, home_participant_id, away_participant_id, status, official_id, home_score, away_score, result) VALUES
('110e8400-e29b-41d4-a716-446655440001'::uuid, 'dd0e8400-e29b-41d4-a716-446655440001'::uuid, 1, '2024-08-10 15:00:00', 'Antananarivo', 'Stade Municipal de Mahamasina', 'ee0e8400-e29b-41d4-a716-446655440001'::uuid, 'ee0e8400-e29b-41d4-a716-446655440002'::uuid, 'COMPLETED', 'cc0e8400-e29b-41d4-a716-446655440001'::uuid, 2, 1, 'HOME_WIN'),
('110e8400-e29b-41d4-a716-446655440002'::uuid, 'dd0e8400-e29b-41d4-a716-446655440001'::uuid, 1, '2024-08-17 15:00:00', 'Mahajanga', 'Stade de Mahajanga', 'ee0e8400-e29b-41d4-a716-446655440003'::uuid, 'ee0e8400-e29b-41d4-a716-446655440004'::uuid, 'COMPLETED', 'cc0e8400-e29b-41d4-a716-446655440001'::uuid, 1, 1, 'DRAW');

-- =============================================================================
-- 13. PERFORMANCES (Exemples - UUIDs PostgreSQL)
INSERT INTO performances (id, athlete_id, match_id, club_id, match_date, metrics, overall_score, minutes_played, is_starter, rating) VALUES
('220e8400-e29b-41d4-a716-446655440001'::uuid, '880e8400-e29b-41d4-a716-446655440001'::uuid, '110e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440001'::uuid, '2024-08-10', '{"saves": 5, "goals_conceded": 1, "clean_sheets": 0, "pass_accuracy": 85}'::jsonb, 78.5, 90, TRUE, 7.5),
('220e8400-e29b-41d4-a716-446655440002'::uuid, '880e8400-e29b-41d4-a716-446655440002'::uuid, '110e8400-e29b-41d4-a716-446655440001'::uuid, '660e8400-e29b-41d4-a716-446655440001'::uuid, '2024-08-10', '{"goals": 1, "assists": 0, "tackles": 8, "passes": 45, "pass_accuracy": 82}'::jsonb, 82.0, 90, TRUE, 8.0),
('220e8400-e29b-41d4-a716-446655440003'::uuid, '880e8400-e29b-41d4-a716-446655440003'::uuid, '110e8400-e29b-41d4-a716-446655440002'::uuid, '660e8400-e29b-41d4-a716-446655440002'::uuid, '2024-08-17', '{"goals": 0, "assists": 1, "tackles": 6, "passes": 52, "pass_accuracy": 88}'::jsonb, 85.5, 90, TRUE, 8.5);

-- =============================================================================
-- 14. DONNÉES BIOMÉTRIQUES (Exemples - UUIDs PostgreSQL)
INSERT INTO biometric_data (id, athlete_id, recorded_at, vo2_max, heart_rate_avg, heart_rate_max, heart_rate_resting, sleep_quality, sleep_duration, gps_data, recovery_score) VALUES
('330e8400-e29b-41d4-a716-446655440001'::uuid, '880e8400-e29b-41d4-a716-446655440001'::uuid, NOW() - INTERVAL '1 day', 62.5, 145, 185, 52, 8.2, 7.5, '{"distance_km": 8.5, "sprint_distance": 1.2, "top_speed": 28.5}'::jsonb, 85.0),
('330e8400-e29b-41d4-a716-446655440002'::uuid, '880e8400-e29b-41d4-a716-446655440002'::uuid, NOW() - INTERVAL '1 day', 58.0, 152, 190, 55, 7.5, 6.8, '{"distance_km": 10.2, "sprint_distance": 2.1, "top_speed": 32.0}'::jsonb, 82.0);

-- =============================================================================
-- 15. ÉVALUATIONS DE TALENTS (Exemples - UUIDs PostgreSQL)
INSERT INTO talent_evaluations (id, athlete_id, scout_id, evaluation_date, location, scores, overall_score, potential, technical_notes, physical_notes, recommendation) VALUES
('440e8400-e29b-41d4-a716-446655440001'::uuid, '880e8400-e29b-41d4-a716-446655440004'::uuid, 'aa0e8400-e29b-41d4-a716-446655440001'::uuid, '2024-07-15', 'Stade de Mahajanga', '{"technique": 85, "physique": 78, "mental": 82, "tactique": 80}'::jsonb, 81.25, 'PROMISING', 'Bonne technique de dribble, vision du jeu à améliorer', 'Rapide et endurant, renforcement musculaire nécessaire', 'À suivre régulièrement, potentiel pour équipe nationale U23'),
('440e8400-e29b-41d4-a716-446655440002'::uuid, '880e8400-e29b-41d4-a716-446655440006'::uuid, 'aa0e8400-e29b-41d4-a716-446655440002'::uuid, '2024-07-20', 'Gymnase Antananarivo', '{"technique": 88, "physique": 85, "mental": 80, "tactique": 75}'::jsonb, 82.0, 'ELITE', 'Excellent tir, bonne passe', 'Grande taille avantageuse, mobilité à travailler', 'Talent élite, recommandé pour sélection nationale immédiate');

-- =============================================================================
-- 16. DOSSIERS MÉDICAUX (Exemples - UUIDs PostgreSQL)
INSERT INTO medical_records (id, athlete_id, doctor_id, consultation_date, diagnosis, treatment, medical_clearance, clearance_valid_until, is_confidential) VALUES
('550e8400-e29b-41d4-a716-446655440010'::uuid, '880e8400-e29b-41d4-a716-446655440001'::uuid, 'bb0e8400-e29b-41d4-a716-446655440002'::uuid, '2024-07-20', 'Examen médical annuel - Aucun problème détecté', 'Aucun traitement nécessaire', TRUE, '2025-07-20', FALSE),
('550e8400-e29b-41d4-a716-446655440011'::uuid, '880e8400-e29b-41d4-a716-446655440002'::uuid, 'bb0e8400-e29b-41d4-a716-446655440002'::uuid, '2024-07-22', 'Entorse cheville grade 1', 'Repos 7 jours, glace, compression', TRUE, '2025-07-22', FALSE);

-- Blessures
INSERT INTO injuries (id, medical_record_id, athlete_id, injury_type, body_part, severity, occurred_date, recovery_days, expected_return_date, status) VALUES
('660e8400-e29b-41d4-a716-446655440020'::uuid, '550e8400-e29b-41d4-a716-446655440011'::uuid, '880e8400-e29b-41d4-a716-446655440002'::uuid, 'Entorse', 'CHEVILLE', 'MINOR', '2024-08-05', 7, '2024-08-12', 'RECOVERED');

-- =============================================================================
-- 17. SMART SQUAD SÉLECTION (Exemple - UUIDs PostgreSQL)
INSERT INTO smart_squad_selections (id, type, sport_type, formation, season, cohesion_score, status) VALUES
('770e8400-e29b-41d4-a716-446655440010'::uuid, 'NATIONAL', 'FOOTBALL', '4-3-3', '2024-2025', 82.5, 'DRAFT');

INSERT INTO selected_players (selection_id, athlete_id, position, is_starter, score, confidence) VALUES
('770e8400-e29b-41d4-a716-446655440010'::uuid, '880e8400-e29b-41d4-a716-446655440001'::uuid, 'GK', TRUE, 85.5, 92.0),
('770e8400-e29b-41d4-a716-446655440010'::uuid, '880e8400-e29b-41d4-a716-446655440002'::uuid, 'LB', TRUE, 82.0, 88.5),
('770e8400-e29b-41d4-a716-446655440010'::uuid, '880e8400-e29b-41d4-a716-446655440005'::uuid, 'CB', TRUE, 80.5, 85.0),
('770e8400-e29b-41d4-a716-446655440010'::uuid, '880e8400-e29b-41d4-a716-446655440003'::uuid, 'CM', TRUE, 88.0, 90.0);

-- =============================================================================
-- FIN DU FICHIER SEED
-- =============================================================================
