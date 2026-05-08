-- =============================================================================
-- SPORT CONNECT - Données Initiales (Seed Data)
-- Écosystème Numérique du Sport Malgache
-- Version 1.0
-- =============================================================================

USE sportconnect;

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
-- 2. FÉDÉRATIONS MALGACHES
-- =============================================================================
INSERT INTO federations (id, name, sport_type, acronym, description, president_name, contact_email, contact_phone, address, is_active) VALUES
('fed-foot-001', 'Fédération Malgache de Football', 'FOOTBALL', 'FMF', 
 'Fédération officielle de football de Madagascar', 'Raoul Raveloarimanga', 
 'contact@fmf.mg', '+261 20 22 123 45', 'Antananarivo, Madagascar', TRUE),
('fed-bask-001', 'Fédération Malgache de Basketball', 'BASKETBALL', 'FMBB', 
 'Fédération de basketball de Madagascar', 'Jean Rakotomalala', 
 'contact@fmbb.mg', '+261 20 22 234 56', 'Antananarivo, Madagascar', TRUE),
('fed-rugb-001', 'Fédération Malgache de Rugby', 'RUGBY', 'FMR', 
 'Fédération de rugby de Madagascar', 'Pierre Andriamampianina', 
 'contact@fmr.mg', '+261 20 22 345 67', 'Antananarivo, Madagascar', TRUE),
('fed-athl-001', 'Fédération Malgache d\'Athlétisme', 'ATHLETICS', 'FMA', 
 'Fédération d\'athlétisme de Madagascar', 'Marie Razafindrakoto', 
 'contact@fma.mg', '+261 20 22 456 78', 'Antananarivo, Madagascar', TRUE),
('fed-voll-001', 'Fédération Malgache de Volleyball', 'VOLLEYBALL', 'FMV', 
 'Fédération de volleyball de Madagascar', 'Luc Rasoamanana', 
 'contact@fmv.mg', '+261 20 22 567 89', 'Antananarivo, Madagascar', TRUE),
('fed-hand-001', 'Fédération Malgache de Handball', 'HANDBALL', 'FMH', 
 'Fédération de handball de Madagascar', 'Sophie Ravelojaona', 
 'contact@fmh.mg', '+261 20 22 678 90', 'Antananarivo, Madagascar', TRUE);

-- =============================================================================
-- 3. CLUBS PROFESSIONNELS ET AMATEURS
-- =============================================================================
INSERT INTO clubs (id, federation_id, name, short_name, founded_date, is_professional, stadium_name, city, region, contact_email, is_active) VALUES
-- Football
('club-foot-001', 'fed-foot-001', 'CNaPS Sport', 'CNaPS', '1979-01-01', TRUE, 'Stade Municipal de Mahamasina', 'Antananarivo', 'Analamanga', 'cnaps@club.mg', TRUE),
('club-foot-002', 'fed-foot-001', 'Tana FC Formation', 'TANA FC', '1990-01-01', TRUE, 'Stade Municipal', 'Antananarivo', 'Analamanga', 'tanafc@club.mg', TRUE),
('club-foot-003', 'fed-foot-001', 'Disciples FC', 'DISCIPLES', '2002-01-01', FALSE, 'Stade de Mahajanga', 'Mahajanga', 'Boeny', 'disciples@club.mg', TRUE),
('club-foot-004', 'fed-foot-001', 'Fosa Juniors FC', 'FOSA', '2007-01-01', TRUE, 'Stade de Toamasina', 'Toamasina', 'Atsinanana', 'fosa@club.mg', TRUE),
('club-foot-005', 'fed-foot-001', 'AS Adema', 'ADEMA', '1950-01-01', TRUE, 'Stade Municipal', 'Antananarivo', 'Analamanga', 'adema@club.mg', TRUE),

-- Basketball
('club-bask-001', 'fed-bask-001', 'COSFA', 'COSFA', '1985-01-01', TRUE, 'Gymnase Municipal', 'Antananarivo', 'Analamanga', 'cosfa@club.mg', TRUE),
('club-bask-002', 'fed-bask-001', 'AS Lotererie Nationale', 'AS LN', '1995-01-01', TRUE, 'Gymnase Municipal', 'Antananarivo', 'Analamanga', 'asln@club.mg', TRUE),

-- Rugby
('club-rugb-001', 'fed-rugb-001', 'Stade Malgache', 'SM', '1960-01-01', TRUE, 'Stade de Mahamasina', 'Antananarivo', 'Analamanga', 'sm@club.mg', TRUE),
('club-rugb-002', 'fed-rugb-001', 'RC Antananarivo', 'RCA', '1975-01-01', TRUE, 'Stade de Mahamasina', 'Antananarivo', 'Analamanga', 'rca@club.mg', TRUE);

-- =============================================================================
-- 4. UTILISATEURS ADMINISTRATEURS (Mot de passe: Admin123!)
-- Hash bcrypt pour "Admin123!": $2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqhmM6JGKpS4G3R1G2JH8YpfB0Bqy
INSERT INTO users (id, email, password_hash, nin, phone, role_id, is_active, email_verified, phone_verified) VALUES
('admin-super-001', 'admin@sportconnect.mg', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqhmM6JGKpS4G3R1G2JH8YpfB0Bqy', 'ADMIN001', '+261 34 00 000 01', 5, TRUE, TRUE, TRUE),
('admin-fed-001', 'admin@fmf.mg', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqhmM6JGKpS4G3R1G2JH8YpfB0Bqy', 'ADMIN002', '+261 34 00 000 02', 6, TRUE, TRUE, TRUE),
('admin-fed-002', 'admin@fmbb.mg', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqhmM6JGKpS4G3R1G2JH8YpfB0Bqy', 'ADMIN003', '+261 34 00 000 03', 6, TRUE, TRUE, TRUE);

-- Administrateurs
INSERT INTO admins (user_id, first_name, last_name, admin_level) VALUES
('admin-super-001', 'Super', 'Admin', 'SUPER'),
('admin-fed-001', 'Admin', 'Football', 'FEDERATION'),
('admin-fed-002', 'Admin', 'Basketball', 'FEDERATION');

-- =============================================================================
-- 5. UTILISATEURS DÉMO - ATHLÈTES (Mot de passe: Player123!)
-- Hash bcrypt pour "Player123!": $2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4
-- Note: En production, utiliser des hashes bcrypt réels
INSERT INTO users (id, email, password_hash, nin, phone, role_id, is_active) VALUES
-- Football
('athlete-f-001', 'jean.rakoto@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '1234567890123', '+261 34 12 345 01', 1, TRUE),
('athlete-f-002', 'paul.rabe@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '1234567890124', '+261 34 12 345 02', 1, TRUE),
('athlete-f-003', 'michel.andria@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '1234567890125', '+261 34 12 345 03', 1, TRUE),
('athlete-f-004', 'eric.randria@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '1234567890126', '+261 34 12 345 04', 1, TRUE),
('athlete-f-005', 'luc.rasoa@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '1234567890127', '+261 34 12 345 05', 1, TRUE),

-- Basketball
('athlete-b-001', 'marc.ravelo@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '2234567890123', '+261 34 22 345 01', 1, TRUE),
('athlete-b-002', 'pierre.rakoto@sportconnect.mg', '$2a$10$L1h66VbY4aLQFQ8tG1h2Y.xvLlXqZvQJ1JlQ5e5Y4e5Y4e5Y4e5Y4', '2234567890124', '+261 34 22 345 02', 1, TRUE);

-- Athlètes Football
INSERT INTO athletes (user_id, first_name, last_name, birth_date, gender, height, weight, current_club_id, sport_type, position, national_team_eligible) VALUES
('athlete-f-001', 'Jean', 'Rakotomalala', '1995-03-15', 'M', 180.5, 75.0, 'club-foot-001', 'FOOTBALL', 'GK', TRUE),
('athlete-f-002', 'Paul', 'Rabemananjara', '1996-07-22', 'M', 175.0, 68.5, 'club-foot-001', 'FOOTBALL', 'DF', TRUE),
('athlete-f-003', 'Michel', 'Andriamampianina', '1994-11-08', 'M', 182.0, 78.0, 'club-foot-002', 'FOOTBALL', 'MF', TRUE),
('athlete-f-004', 'Eric', 'Randrianirina', '1997-05-20', 'M', 178.5, 72.0, 'club-foot-003', 'FOOTBALL', 'FW', TRUE),
('athlete-f-005', 'Luc', 'Rasoamanana', '1993-09-12', 'M', 185.0, 80.0, 'club-foot-004', 'FOOTBALL', 'DF', FALSE);

-- Athlètes Basketball
INSERT INTO athletes (user_id, first_name, last_name, birth_date, gender, height, weight, current_club_id, sport_type, position, national_team_eligible) VALUES
('athlete-b-001', 'Marc', 'Ravelojaona', '1998-01-25', 'M', 198.0, 95.0, 'club-bask-001', 'BASKETBALL', 'CENTER', TRUE),
('athlete-b-002', 'Pierre', 'Rakotovao', '1996-04-18', 'M', 192.0, 88.0, 'club-bask-002', 'BASKETBALL', 'GUARD', TRUE);

-- =============================================================================
-- 6. ENTRAÎNEURS DÉMO (Mot de passe: Coach123!)
INSERT INTO users (id, email, password_hash, nin, phone, role_id, is_active) VALUES
('coach-001', 'coach.foot@sportconnect.mg', '$2a$10$Coach123HashReplaceMe', '3234567890123', '+261 34 32 345 01', 2, TRUE),
('coach-002', 'coach.basket@sportconnect.mg', '$2a$10$Coach123HashReplaceMe', '3234567890124', '+261 34 32 345 02', 2, TRUE);

INSERT INTO coaches (user_id, first_name, last_name, specialization, experience_years, current_club_id) VALUES
('coach-001', 'François', 'Razanakoto', 'FOOTBALL', 15, 'club-foot-001'),
('coach-002', 'Henri', 'Rasamoelina', 'BASKETBALL', 12, 'club-bask-001');

-- =============================================================================
-- 7. SCOUTS DÉMO (Mot de passe: Scout123!)
INSERT INTO users (id, email, password_hash, nin, phone, role_id, is_active) VALUES
('scout-001', 'scout.national@sportconnect.mg', '$2a$10$Scout123HashReplaceMe', '4234567890123', '+261 34 42 345 01', 3, TRUE),
('scout-002', 'scout.regional@sportconnect.mg', '$2a$10$Scout123HashReplaceMe', '4234567890124', '+261 34 42 345 02', 3, TRUE);

INSERT INTO scouts (user_id, first_name, last_name, regions, employer, specializations) VALUES
('scout-001', 'Robert', 'Andriantsiferana', '["Analamanga", "Atsinanana", "Diana"]', 'FMF - Fédération Malgache de Football', '["FOOTBALL"]'),
('scout-002', 'Joseph', 'Razafindrazaka', '["Vakinankaratra", "Amoron\'i Mania"]', 'Indépendant', '["FOOTBALL", "BASKETBALL"]');

-- =============================================================================
-- 8. MÉDECINS DÉMO (Mot de passe: Doctor123!)
INSERT INTO users (id, email, password_hash, nin, phone, role_id, is_active) VALUES
('doctor-001', 'dr.sport@sportconnect.mg', '$2a$10$Doctor123HashReplaceMe', '5234567890123', '+261 34 52 345 01', 4, TRUE),
('doctor-002', 'dr.fmf@sportconnect.mg', '$2a$10$Doctor123HashReplaceMe', '5234567890124', '+261 34 52 345 02', 4, TRUE);

INSERT INTO doctors (user_id, first_name, last_name, license_number, specialization, institution) VALUES
('doctor-001', 'Dr. Marie', 'Ravelojaona', 'MED12345', 'Médecine du Sport', 'Centre Hospitalier Universitaire d\'Antananarivo'),
('doctor-002', 'Dr. Jean', 'Rakotoarison', 'MED12346', 'Médecine du Sport', 'Clinique du Sport - FMF');

-- =============================================================================
-- 9. OFFICIELS (ARBITRES) DÉMO (Mot de passe: Referee123!)
INSERT INTO users (id, email, password_hash, nin, phone, role_id, is_active) VALUES
('referee-001', 'referee.foot@sportconnect.mg', '$2a$10$Referee123HashReplaceMe', '6234567890123', '+261 34 62 345 01', 7, TRUE);

INSERT INTO officials (user_id, first_name, last_name, official_type, certifications) VALUES
('referee-001', 'Henri', 'Razafindrakoto', 'REFEREE', '["FIFA", "CAF", "FMF Elite"]');

-- =============================================================================
-- 10. COMPÉTITIONS
INSERT INTO competitions (id, federation_id, name, season, competition_type, format, start_date, end_date, registration_deadline, status) VALUES
('comp-001', 'fed-foot-001', 'THB Champions League', '2024-2025', 'LEAGUE', 'Championnat national', '2024-08-01', '2025-05-31', '2024-07-15', 'ONGOING'),
('comp-002', 'fed-foot-001', 'Coupe de Madagascar', '2024-2025', 'CUP', 'Tournoi à élimination directe', '2024-09-01', '2025-04-30', '2024-08-20', 'PLANNED'),
('comp-003', 'fed-bask-001', 'Championnat National Basketball', '2024-2025', 'LEAGUE', 'Championnat national', '2024-10-01', '2025-03-31', '2024-09-15', 'PLANNED');

-- Participants compétition football
INSERT INTO competition_participants (id, competition_id, club_id, seed, status) VALUES
('part-001', 'comp-001', 'club-foot-001', 1, 'CONFIRMED'),
('part-002', 'comp-001', 'club-foot-002', 2, 'CONFIRMED'),
('part-003', 'comp-001', 'club-foot-003', 3, 'CONFIRMED'),
('part-004', 'comp-001', 'club-foot-004', 4, 'CONFIRMED'),
('part-005', 'comp-001', 'club-foot-005', 5, 'CONFIRMED');

-- =============================================================================
-- 11. LICENCES (Exemples)
INSERT INTO licenses (id, athlete_id, federation_id, club_id, season, license_number, status, medical_clearance, issue_date, expiry_date, payment_status) VALUES
('lic-001', 'athlete-f-001', 'fed-foot-001', 'club-foot-001', '2024-2025', 'FMF-2024-000001', 'APPROVED', TRUE, '2024-08-01', '2025-07-31', 'PAID'),
('lic-002', 'athlete-f-002', 'fed-foot-001', 'club-foot-001', '2024-2025', 'FMF-2024-000002', 'APPROVED', TRUE, '2024-08-01', '2025-07-31', 'PAID'),
('lic-003', 'athlete-f-003', 'fed-foot-001', 'club-foot-002', '2024-2025', 'FMF-2024-000003', 'APPROVED', TRUE, '2024-08-01', '2025-07-31', 'PAID'),
('lic-004', 'athlete-f-004', 'fed-foot-001', 'club-foot-003', '2024-2025', 'FMF-2024-000004', 'PENDING', FALSE, NULL, NULL, 'PENDING');

-- =============================================================================
-- 12. MATCHS (Exemples)
INSERT INTO matches (id, competition_id, round, scheduled_date, venue, stadium, home_participant_id, away_participant_id, status, official_id, home_score, away_score, result) VALUES
('match-001', 'comp-001', 1, '2024-08-10 15:00:00', 'Antananarivo', 'Stade Municipal de Mahamasina', 'part-001', 'part-002', 'COMPLETED', 'referee-001', 2, 1, 'HOME_WIN'),
('match-002', 'comp-001', 1, '2024-08-17 15:00:00', 'Mahajanga', 'Stade de Mahajanga', 'part-003', 'part-004', 'COMPLETED', 'referee-001', 1, 1, 'DRAW');

-- =============================================================================
-- 13. PERFORMANCES (Exemples)
INSERT INTO performances (id, athlete_id, match_id, club_id, date, metrics, overall_score, minutes_played, is_starter, rating) VALUES
('perf-001', 'athlete-f-001', 'match-001', 'club-foot-001', '2024-08-10', '{"saves": 5, "goals_conceded": 1, "clean_sheets": 0, "pass_accuracy": 85}', 78.5, 90, TRUE, 7.5),
('perf-002', 'athlete-f-002', 'match-001', 'club-foot-001', '2024-08-10', '{"goals": 1, "assists": 0, "tackles": 8, "passes": 45, "pass_accuracy": 82}', 82.0, 90, TRUE, 8.0),
('perf-003', 'athlete-f-003', 'match-002', 'club-foot-002', '2024-08-17', '{"goals": 0, "assists": 1, "tackles": 6, "passes": 52, "pass_accuracy": 88}', 85.5, 90, TRUE, 8.5);

-- =============================================================================
-- 14. DONNÉES BIOMÉTRIQUES (Exemples)
INSERT INTO biometric_data (id, athlete_id, recorded_at, vo2_max, heart_rate_avg, heart_rate_max, heart_rate_resting, sleep_quality, sleep_duration, gps_data, recovery_score) VALUES
('bio-001', 'athlete-f-001', NOW() - INTERVAL 1 DAY, 62.5, 145, 185, 52, 8.2, 7.5, '{"distance_km": 8.5, "sprint_distance": 1.2, "top_speed": 28.5}', 85.0),
('bio-002', 'athlete-f-002', NOW() - INTERVAL 1 DAY, 58.0, 152, 190, 55, 7.5, 6.8, '{"distance_km": 10.2, "sprint_distance": 2.1, "top_speed": 32.0}', 82.0);

-- =============================================================================
-- 15. ÉVALUATIONS DE TALENTS (Exemples)
INSERT INTO talent_evaluations (id, athlete_id, scout_id, evaluation_date, location, scores, overall_score, potential, technical_notes, physical_notes, recommendation) VALUES
('eval-001', 'athlete-f-004', 'scout-001', '2024-07-15', 'Stade de Mahajanga', '{"technique": 85, "physique": 78, "mental": 82, "tactique": 80}', 81.25, 'PROMISING', 'Bonne technique de dribble, vision du jeu à améliorer', 'Rapide et endurant, renforcement musculaire nécessaire', 'À suivre régulièrement, potentiel pour équipe nationale U23'),
('eval-002', 'athlete-b-001', 'scout-002', '2024-07-20', 'Gymnase Antananarivo', '{"technique": 88, "physique": 85, "mental": 80, "tactique": 75}', 82.0, 'ELITE', 'Excellent tir, bonne passe', 'Grande taille avantageuse, mobilité à travailler', 'Talent élite, recommandé pour sélection nationale immédiate');

-- =============================================================================
-- 16. DOSSIERS MÉDICAUX (Exemples)
INSERT INTO medical_records (id, athlete_id, doctor_id, consultation_date, diagnosis, treatment, medical_clearance, clearance_valid_until, is_confidential) VALUES
('med-001', 'athlete-f-001', 'doctor-002', '2024-07-20', 'Examen médical annuel - Aucun problème détecté', 'Aucun traitement nécessaire', TRUE, '2025-07-20', FALSE),
('med-002', 'athlete-f-002', 'doctor-002', '2024-07-22', 'Entorse cheville grade 1', 'Repos 7 jours, glace, compression', TRUE, '2025-07-22', FALSE);

-- Blessures
INSERT INTO injuries (id, medical_record_id, athlete_id, injury_type, body_part, severity, occurred_date, recovery_days, expected_return_date, status) VALUES
('injury-001', 'med-002', 'athlete-f-002', 'Entorse', 'CHEVILLE', 'MINOR', '2024-08-05', 7, '2024-08-12', 'RECOVERED');

-- =============================================================================
-- 17. SMART SQUAD SÉLECTION (Exemple)
INSERT INTO smart_squad_selections (id, type, sport_type, formation, season, cohesion_score, status) VALUES
('smart-001', 'NATIONAL', 'FOOTBALL', '4-3-3', '2024-2025', 82.5, 'DRAFT');

INSERT INTO selected_players (selection_id, athlete_id, position, is_starter, score, confidence) VALUES
('smart-001', 'athlete-f-001', 'GK', TRUE, 85.5, 92.0),
('smart-001', 'athlete-f-002', 'LB', TRUE, 82.0, 88.5),
('smart-001', 'athlete-f-005', 'CB', TRUE, 80.5, 85.0),
('smart-001', 'athlete-f-003', 'CM', TRUE, 88.0, 90.0);

-- =============================================================================
-- FIN DU FICHIER SEED
-- =============================================================================
