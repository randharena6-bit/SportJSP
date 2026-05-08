-- =============================================================================
-- SPORT CONNECT - Seed Users for Testing
-- Utilisateurs de test pour chaque rôle
-- =============================================================================

-- Password for all test users: password123
-- Hash generated with bcrypt (salt rounds: 10)
-- $2a$10$CWYhlmYr4MoyzKZKgvqsa.HQMzss.r9hNHhSuUzlBGUsbbtEGuiZO

-- First, ensure roles exist
INSERT INTO roles (name, description) VALUES
  ('ATHLETE', 'Athlète licencié'),
  ('COACH', 'Entraîneur'),
  ('ADMIN_FEDERATION', 'Administrateur de fédération'),
  ('ADMIN', 'Administrateur système'),
  ('DOCTOR', 'Médecin du sport'),
  ('SCOUT', 'Détecteur de talents')
ON CONFLICT (name) DO NOTHING;

-- =============================================================================
-- 1. ADMIN (Super Administrateur)
-- =============================================================================
INSERT INTO users (id, email, nin, password_hash, role_id, is_active, created_at, updated_at)
SELECT 
  'a0000000-0000-0000-0000-000000000001'::uuid,
  'admin@test.com',
  '1010101010101',
  '$2a$10$CWYhlmYr4MoyzKZKgvqsa.HQMzss.r9hNHhSuUzlBGUsbbtEGuiZO',
  id,
  true,
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
FROM roles WHERE name = 'ADMIN'
ON CONFLICT (email) DO UPDATE SET password_hash = EXCLUDED.password_hash;

INSERT INTO admins (user_id, first_name, last_name, admin_level, created_at)
VALUES 
  ('a0000000-0000-0000-0000-000000000001'::uuid, 'Super', 'Admin', 'SUPER', CURRENT_TIMESTAMP)
ON CONFLICT (user_id) DO NOTHING;

-- =============================================================================
-- 2. ATHLETE (Athlète)
-- =============================================================================
INSERT INTO users (id, email, nin, password_hash, role_id, is_active, created_at, updated_at)
SELECT 
  'a0000000-0000-0000-0000-000000000002'::uuid,
  'athlete@test.com',
  '2020202020202',
  '$2a$10$CWYhlmYr4MoyzKZKgvqsa.HQMzss.r9hNHhSuUzlBGUsbbtEGuiZO',
  id,
  true,
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
FROM roles WHERE name = 'ATHLETE'
ON CONFLICT (email) DO UPDATE SET password_hash = EXCLUDED.password_hash;

INSERT INTO athletes (user_id, first_name, last_name, birth_date, gender, sport_type, created_at, updated_at)
VALUES 
  ('a0000000-0000-0000-0000-000000000002'::uuid, 'Jean', 'Rakoto', '1998-05-15', 'M', 'ATHLETICS', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (user_id) DO NOTHING;

-- =============================================================================
-- 3. COACH (Entraîneur)
-- =============================================================================
INSERT INTO users (id, email, nin, password_hash, role_id, is_active, created_at, updated_at)
SELECT 
  'a0000000-0000-0000-0000-000000000003'::uuid,
  'coach@test.com',
  '3030303030303',
  '$2a$10$CWYhlmYr4MoyzKZKgvqsa.HQMzss.r9hNHhSuUzlBGUsbbtEGuiZO',
  id,
  true,
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
FROM roles WHERE name = 'COACH'
ON CONFLICT (email) DO UPDATE SET password_hash = EXCLUDED.password_hash;

INSERT INTO coaches (user_id, first_name, last_name, specialization, created_at, updated_at)
VALUES 
  ('a0000000-0000-0000-0000-000000000003'::uuid, 'Pierre', 'Rabemananjara', '100m, 200m Sprint', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (user_id) DO NOTHING;

-- =============================================================================
-- 4. ADMIN_FEDERATION (Admin Fédération Athlétisme)
-- =============================================================================
INSERT INTO users (id, email, nin, password_hash, role_id, is_active, created_at, updated_at)
SELECT 
  'a0000000-0000-0000-0000-000000000004'::uuid,
  'federation@test.com',
  '4040404040404',
  '$2a$10$CWYhlmYr4MoyzKZKgvqsa.HQMzss.r9hNHhSuUzlBGUsbbtEGuiZO',
  id,
  true,
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
FROM roles WHERE name = 'ADMIN_FEDERATION'
ON CONFLICT (email) DO UPDATE SET password_hash = EXCLUDED.password_hash;

-- Federation admin uses admins table with FEDERATION level
INSERT INTO admins (user_id, first_name, last_name, admin_level, created_at)
VALUES 
  ('a0000000-0000-0000-0000-000000000004'::uuid, 'M.', 'Rabe', 'FEDERATION', CURRENT_TIMESTAMP)
ON CONFLICT (user_id) DO NOTHING;

-- =============================================================================
-- 5. DOCTOR (Médecin du Sport)
-- =============================================================================
INSERT INTO users (id, email, nin, password_hash, role_id, is_active, created_at, updated_at)
SELECT 
  'a0000000-0000-0000-0000-000000000005'::uuid,
  'doctor@test.com',
  '5050505050505',
  '$2a$10$CWYhlmYr4MoyzKZKgvqsa.HQMzss.r9hNHhSuUzlBGUsbbtEGuiZO',
  id,
  true,
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
FROM roles WHERE name = 'DOCTOR'
ON CONFLICT (email) DO UPDATE SET password_hash = EXCLUDED.password_hash;

INSERT INTO doctors (user_id, first_name, last_name, specialization, license_number, created_at, updated_at)
VALUES 
  ('a0000000-0000-0000-0000-000000000005'::uuid, 'Dr. Raso', 'Ramanana', 'Médecine du Sport', 'MED-001-MDG', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (user_id) DO NOTHING;

-- =============================================================================
-- 6. SCOUT (Détecteur de Talents)
-- =============================================================================
INSERT INTO users (id, email, nin, password_hash, role_id, is_active, created_at, updated_at)
SELECT 
  'a0000000-0000-0000-0000-000000000006'::uuid,
  'scout@test.com',
  '6060606060606',
  '$2a$10$CWYhlmYr4MoyzKZKgvqsa.HQMzss.r9hNHhSuUzlBGUsbbtEGuiZO',
  id,
  true,
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
FROM roles WHERE name = 'SCOUT'
ON CONFLICT (email) DO UPDATE SET password_hash = EXCLUDED.password_hash;

INSERT INTO scouts (user_id, first_name, last_name, regions, created_at, updated_at)
VALUES 
  ('a0000000-0000-0000-0000-000000000006'::uuid, 'Luc', 'Andriamampianina', '["Antananarivo"]'::jsonb, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (user_id) DO NOTHING;

-- =============================================================================
-- Verify inserts
-- =============================================================================
SELECT 'Users created successfully' as status;
