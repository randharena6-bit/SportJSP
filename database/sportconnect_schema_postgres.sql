-- =============================================================================
-- SPORT CONNECT - Schéma de Base de Données PostgreSQL
-- Écosystème Numérique du Sport Malgache
-- Version 1.0 - PostgreSQL 13+
-- Auteur: RANDRIANIRINA Harena Eric Miaritsoa - SE20240079
-- =============================================================================

-- Création de la base de données (à exécuter en psql ou en tant que superuser)
-- CREATE DATABASE sportconnect WITH ENCODING = 'UTF8' LC_COLLATE = 'fr_FR.UTF-8' LC_CTYPE = 'fr_FR.UTF-8';

\connect sportconnect;

-- Activer l'extension UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Activer l'extension pour recherche texte (optionnel)
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- =============================================================================
-- 1. TYPES ENUMÉRÉS
-- =============================================================================

-- Types pour les rôles
CREATE TYPE user_role AS ENUM ('ATHLETE', 'COACH', 'SCOUT', 'DOCTOR', 'ADMIN', 'ADMIN_FEDERATION', 'OFFICIAL', 'SELECTIONNEUR', 'FAN');

-- Types pour les genres
CREATE TYPE gender_type AS ENUM ('M', 'F', 'OTHER');

-- Types pour les statuts de licence
CREATE TYPE license_status AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'SUSPENDED', 'EXPIRED');

-- Types pour les statuts de paiement
CREATE TYPE payment_status AS ENUM ('INITIATED', 'PENDING', 'COMPLETED', 'FAILED', 'REFUNDED', 'ACTIVE', 'EXPIRED', 'CANCELLED');

-- Types pour les types de compétition
CREATE TYPE competition_type AS ENUM ('LEAGUE', 'CUP', 'TOURNAMENT', 'FRIENDLY');

-- Types pour les statuts de match
CREATE TYPE match_status AS ENUM ('SCHEDULED', 'ONGOING', 'COMPLETED', 'POSTPONED', 'CANCELLED');

-- Types pour les résultats de match
CREATE TYPE match_result AS ENUM ('HOME_WIN', 'AWAY_WIN', 'DRAW', 'NO_RESULT');

-- Types pour les statuts de participant
CREATE TYPE participant_status AS ENUM ('REGISTERED', 'CONFIRMED', 'DISQUALIFIED', 'WITHDRAWN');

-- Types pour les types de sélection SMART SQUAD
CREATE TYPE selection_type AS ENUM ('NATIONAL', 'CLUB', 'TRAINING');

-- Types pour les statuts de sélection
CREATE TYPE selection_status AS ENUM ('DRAFT', 'VALIDATED', 'APPROVED', 'REJECTED');

-- Types pour le potentiel des talents
CREATE TYPE potential_type AS ENUM ('ELITE', 'PROMISING', 'FOLLOW', 'STANDARD');

-- Types pour la sévérité des blessures
CREATE TYPE injury_severity AS ENUM ('MINOR', 'MODERATE', 'SEVERE', 'CRITICAL');

-- Types pour les statuts de blessure
CREATE TYPE injury_status AS ENUM ('ACTIVE', 'RECOVERING', 'RECOVERED', 'CHRONIC');

-- Types pour les alertes
CREATE TYPE alert_type AS ENUM ('CRITICAL', 'WARNING', 'INFO');

-- Types pour les statuts d'alerte
CREATE TYPE alert_status AS ENUM ('PENDING', 'REVIEWED', 'DISMISSED', 'ESCALATED');

-- Types pour les statuts de stream
CREATE TYPE stream_status AS ENUM ('SCHEDULED', 'LIVE', 'ENDED', 'ARCHIVED');

-- Types pour les types d'abonnement
CREATE TYPE subscription_type AS ENUM ('BASIC', 'PREMIUM', 'FAMILY', 'ORGANIZATION');

-- Types pour les notifications
CREATE TYPE notification_type AS ENUM ('LICENSE', 'PAYMENT', 'MATCH', 'SELECTION', 'HEALTH', 'SYSTEM');

-- Types pour les canaux de notification
CREATE TYPE notification_channel AS ENUM ('APP', 'EMAIL', 'SMS', 'PUSH');

-- Types pour les actions d'audit
CREATE TYPE audit_action AS ENUM ('CREATE', 'UPDATE', 'DELETE');

-- Types pour les types d'officiels
CREATE TYPE official_type AS ENUM ('REFEREE', 'JUDGE', 'COMMISSIONER');

-- Types pour les niveaux d'admin
CREATE TYPE admin_level AS ENUM ('SUPER', 'FEDERATION', 'SYSTEM');

-- =============================================================================
-- 2. TABLES UTILISATEURS ET IDENTITÉ
-- =============================================================================

-- Table des rôles utilisateur
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table principale des utilisateurs
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    nin VARCHAR(20) UNIQUE,
    phone VARCHAR(20),
    role_id INTEGER NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    email_verified BOOLEAN DEFAULT FALSE,
    phone_verified BOOLEAN DEFAULT FALSE,
    last_login TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE RESTRICT
);

-- Trigger pour updated_at sur users
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Table des athlètes
CREATE TABLE athletes (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    gender gender_type DEFAULT 'M',
    height DECIMAL(5,2),
    weight DECIMAL(5,2),
    current_club_id UUID,
    sport_type VARCHAR(50),
    position VARCHAR(50),
    national_team_eligible BOOLEAN DEFAULT FALSE,
    biography TEXT,
    photo_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_athletes_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_athletes_club FOREIGN KEY (current_club_id) REFERENCES clubs(id) ON DELETE SET NULL
);

CREATE TRIGGER update_athletes_updated_at BEFORE UPDATE ON athletes
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =============================================================================
-- 3. TABLES ORGANISATIONS
-- =============================================================================

-- Table des fédérations
CREATE TABLE federations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(150) NOT NULL,
    sport_type VARCHAR(50) NOT NULL,
    acronym VARCHAR(10) NOT NULL UNIQUE,
    description TEXT,
    president_name VARCHAR(150),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(20),
    address TEXT,
    logo_url VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER update_federations_updated_at BEFORE UPDATE ON federations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Table des clubs
CREATE TABLE clubs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    federation_id UUID NOT NULL,
    name VARCHAR(150) NOT NULL,
    short_name VARCHAR(50),
    founded_date DATE,
    is_professional BOOLEAN DEFAULT FALSE,
    stadium_name VARCHAR(150),
    city VARCHAR(100),
    region VARCHAR(100),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(20),
    logo_url VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_clubs_federation FOREIGN KEY (federation_id) REFERENCES federations(id) ON DELETE RESTRICT
);

CREATE TRIGGER update_clubs_updated_at BEFORE UPDATE ON clubs
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Maintenant on peut créer les références vers clubs

-- Table des entraîneurs
CREATE TABLE coaches (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    experience_years INTEGER DEFAULT 0,
    current_club_id UUID,
    certifications JSONB,
    biography TEXT,
    photo_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_coaches_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_coaches_club FOREIGN KEY (current_club_id) REFERENCES clubs(id) ON DELETE SET NULL
);

CREATE TRIGGER update_coaches_updated_at BEFORE UPDATE ON coaches
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Table des scouts (recruteurs)
CREATE TABLE scouts (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    regions JSONB,
    employer VARCHAR(100),
    specializations JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_scouts_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TRIGGER update_scouts_updated_at BEFORE UPDATE ON scouts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Table des médecins
CREATE TABLE doctors (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    license_number VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    institution VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_doctors_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TRIGGER update_doctors_updated_at BEFORE UPDATE ON doctors
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Table des administrateurs système
CREATE TABLE admins (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    admin_level admin_level DEFAULT 'SYSTEM',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_admins_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table des officiels (arbitres, etc.)
CREATE TABLE officials (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    official_type official_type DEFAULT 'REFEREE',
    certifications JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_officials_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =============================================================================
-- 4. TABLES GESTION DES LICENCES
-- =============================================================================

-- Table des licences
CREATE TABLE licenses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    athlete_id UUID NOT NULL,
    federation_id UUID NOT NULL,
    club_id UUID,
    season VARCHAR(10) NOT NULL,
    license_number VARCHAR(50) UNIQUE,
    status license_status DEFAULT 'PENDING',
    qr_code_data TEXT,
    qr_code_image_url VARCHAR(500),
    issue_date DATE,
    expiry_date DATE,
    medical_clearance BOOLEAN DEFAULT FALSE,
    medical_exam_date DATE,
    payment_status payment_status DEFAULT 'PENDING',
    documents JSONB,
    notes TEXT,
    blockchain_tx_hash VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_licenses_athlete FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_licenses_federation FOREIGN KEY (federation_id) REFERENCES federations(id) ON DELETE RESTRICT,
    CONSTRAINT fk_licenses_club FOREIGN KEY (club_id) REFERENCES clubs(id) ON DELETE SET NULL
);

CREATE TRIGGER update_licenses_updated_at BEFORE UPDATE ON licenses
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Table des paiements (Mobile Money)
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    license_id UUID,
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'MGA',
    provider VARCHAR(20) NOT NULL,
    provider_transaction_id VARCHAR(100),
    status payment_status DEFAULT 'INITIATED',
    receipt_url VARCHAR(500),
    phone_number VARCHAR(20),
    paid_at TIMESTAMP NULL,
    failure_reason VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_payments_license FOREIGN KEY (license_id) REFERENCES licenses(id) ON DELETE SET NULL,
    CONSTRAINT chk_provider CHECK (provider IN ('MVOLA', 'AIRTEL_MONEY', 'ORANGE_MONEY', 'BANK'))
);

CREATE TRIGGER update_payments_updated_at BEFORE UPDATE ON payments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =============================================================================
-- 5. TABLES COMPÉTITIONS ET MATCHS
-- =============================================================================

-- Table des compétitions
CREATE TABLE competitions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    federation_id UUID NOT NULL,
    name VARCHAR(150) NOT NULL,
    season VARCHAR(10) NOT NULL,
    competition_type competition_type DEFAULT 'LEAGUE',
    format VARCHAR(50),
    start_date DATE,
    end_date DATE,
    registration_deadline DATE,
    venue VARCHAR(255),
    status VARCHAR(20) DEFAULT 'PLANNED',
    rules_document_url VARCHAR(500),
    created_by UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_competitions_federation FOREIGN KEY (federation_id) REFERENCES federations(id) ON DELETE RESTRICT,
    CONSTRAINT fk_competitions_creator FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TRIGGER update_competitions_updated_at BEFORE UPDATE ON competitions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Table des participants aux compétitions
CREATE TABLE competition_participants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    competition_id UUID NOT NULL,
    club_id UUID,
    athlete_id UUID,
    seed INTEGER,
    is_bye BOOLEAN DEFAULT FALSE,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status participant_status DEFAULT 'REGISTERED',
    CONSTRAINT fk_participants_competition FOREIGN KEY (competition_id) REFERENCES competitions(id) ON DELETE CASCADE,
    CONSTRAINT fk_participants_club FOREIGN KEY (club_id) REFERENCES clubs(id) ON DELETE CASCADE,
    CONSTRAINT fk_participants_athlete FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    CONSTRAINT unique_participant UNIQUE (competition_id, club_id, athlete_id)
);

-- Table des matchs
CREATE TABLE matches (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    competition_id UUID,
    round INTEGER,
    match_number VARCHAR(20),
    home_participant_id UUID,
    away_participant_id UUID,
    scheduled_date TIMESTAMP,
    venue VARCHAR(255),
    stadium VARCHAR(100),
    official_id UUID,
    status match_status DEFAULT 'SCHEDULED',
    home_score INTEGER DEFAULT 0,
    away_score INTEGER DEFAULT 0,
    result match_result DEFAULT 'NO_RESULT',
    duration_minutes INTEGER DEFAULT 90,
    attendance INTEGER,
    weather_conditions VARCHAR(100),
    video_url VARCHAR(500),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_matches_competition FOREIGN KEY (competition_id) REFERENCES competitions(id) ON DELETE SET NULL,
    CONSTRAINT fk_matches_home FOREIGN KEY (home_participant_id) REFERENCES competition_participants(id) ON DELETE SET NULL,
    CONSTRAINT fk_matches_away FOREIGN KEY (away_participant_id) REFERENCES competition_participants(id) ON DELETE SET NULL,
    CONSTRAINT fk_matches_official FOREIGN KEY (official_id) REFERENCES officials(user_id) ON DELETE SET NULL
);

CREATE TRIGGER update_matches_updated_at BEFORE UPDATE ON matches
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Table des performances des athlètes par match
CREATE TABLE performances (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    athlete_id UUID NOT NULL,
    match_id UUID NOT NULL,
    club_id UUID,
    match_date DATE,
    metrics JSONB,
    overall_score DECIMAL(4,2),
    minutes_played INTEGER DEFAULT 0,
    is_starter BOOLEAN DEFAULT FALSE,
    rating DECIMAL(3,1),
    verified_by UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_performances_athlete FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_performances_match FOREIGN KEY (match_id) REFERENCES matches(id) ON DELETE CASCADE,
    CONSTRAINT fk_performances_club FOREIGN KEY (club_id) REFERENCES clubs(id) ON DELETE SET NULL,
    CONSTRAINT fk_performances_verifier FOREIGN KEY (verified_by) REFERENCES officials(user_id) ON DELETE SET NULL,
    CONSTRAINT unique_performance UNIQUE (athlete_id, match_id)
);

CREATE TRIGGER update_performances_updated_at BEFORE UPDATE ON performances
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Table des classements
CREATE TABLE standings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    competition_id UUID NOT NULL,
    participant_id UUID NOT NULL,
    position INTEGER DEFAULT 0,
    played INTEGER DEFAULT 0,
    won INTEGER DEFAULT 0,
    drawn INTEGER DEFAULT 0,
    lost INTEGER DEFAULT 0,
    goals_for INTEGER DEFAULT 0,
    goals_against INTEGER DEFAULT 0,
    goal_difference INTEGER DEFAULT 0,
    points INTEGER DEFAULT 0,
    form JSONB,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_standings_competition FOREIGN KEY (competition_id) REFERENCES competitions(id) ON DELETE CASCADE,
    CONSTRAINT fk_standings_participant FOREIGN KEY (participant_id) REFERENCES competition_participants(id) ON DELETE CASCADE,
    CONSTRAINT unique_standing UNIQUE (competition_id, participant_id)
);

-- =============================================================================
-- 6. TABLES SMART SQUAD (SÉLECTION IA)
-- =============================================================================

-- Table des sélections SMART SQUAD
CREATE TABLE smart_squad_selections (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    type selection_type DEFAULT 'NATIONAL',
    sport_type VARCHAR(50) NOT NULL,
    formation VARCHAR(10),
    season VARCHAR(10) NOT NULL,
    cohesion_score DECIMAL(4,2),
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    generated_by UUID,
    status selection_status DEFAULT 'DRAFT',
    notes TEXT,
    CONSTRAINT fk_selections_creator FOREIGN KEY (generated_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Table des joueurs sélectionnés
CREATE TABLE selected_players (
    selection_id UUID,
    athlete_id UUID,
    position VARCHAR(50) NOT NULL,
    is_starter BOOLEAN DEFAULT TRUE,
    score DECIMAL(5,2),
    confidence DECIMAL(4,2),
    manual_override BOOLEAN DEFAULT FALSE,
    override_reason TEXT,
    rank_in_position INTEGER,
    PRIMARY KEY (selection_id, athlete_id),
    CONSTRAINT fk_selected_selection FOREIGN KEY (selection_id) REFERENCES smart_squad_selections(id) ON DELETE CASCADE,
    CONSTRAINT fk_selected_athlete FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE
);

-- Table des rapports IA
CREATE TABLE ai_reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    selection_id UUID NOT NULL,
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    algorithm_version VARCHAR(20),
    pbsa_config JSONB,
    explanations JSONB,
    synergies JSONB,
    recommendations TEXT,
    pdf_url VARCHAR(500),
    CONSTRAINT fk_reports_selection FOREIGN KEY (selection_id) REFERENCES smart_squad_selections(id) ON DELETE CASCADE
);

-- Table d'analyse des synergies entre joueurs
CREATE TABLE synergy_analysis (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    selection_id UUID NOT NULL,
    player1_id UUID NOT NULL,
    player2_id UUID NOT NULL,
    synergy_score DECIMAL(5,2),
    factors JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_synergy_selection FOREIGN KEY (selection_id) REFERENCES smart_squad_selections(id) ON DELETE CASCADE,
    CONSTRAINT fk_synergy_player1 FOREIGN KEY (player1_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_synergy_player2 FOREIGN KEY (player2_id) REFERENCES athletes(user_id) ON DELETE CASCADE
);

-- =============================================================================
-- 7. TABLES SCOUTING ET ÉVALUATION
-- =============================================================================

-- Table des évaluations de talents (TSS - Talent Scouting System)
CREATE TABLE talent_evaluations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    athlete_id UUID NOT NULL,
    scout_id UUID NOT NULL,
    evaluation_date DATE NOT NULL,
    location VARCHAR(150),
    scores JSONB,
    overall_score DECIMAL(5,2),
    potential potential_type DEFAULT 'STANDARD',
    technical_notes TEXT,
    physical_notes TEXT,
    mental_notes TEXT,
    recommendation TEXT,
    video_urls JSONB,
    is_synced BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_evaluations_athlete FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_evaluations_scout FOREIGN KEY (scout_id) REFERENCES scouts(user_id) ON DELETE SET NULL
);

CREATE TRIGGER update_evaluations_updated_at BEFORE UPDATE ON talent_evaluations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =============================================================================
-- 8. TABLES SANTÉ ET BIOMÉTRIE
-- =============================================================================

-- Table des dossiers médicaux
CREATE TABLE medical_records (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    athlete_id UUID NOT NULL,
    doctor_id UUID,
    consultation_date DATE,
    diagnosis TEXT,
    treatment TEXT,
    medications JSONB,
    medical_clearance BOOLEAN DEFAULT FALSE,
    clearance_valid_until DATE,
    is_confidential BOOLEAN DEFAULT TRUE,
    attachments JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_medical_athlete FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_medical_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(user_id) ON DELETE SET NULL
);

CREATE TRIGGER update_medical_updated_at BEFORE UPDATE ON medical_records
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Table des données biométriques
CREATE TABLE biometric_data (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    athlete_id UUID NOT NULL,
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    device_id VARCHAR(50),
    vo2_max DECIMAL(5,2),
    heart_rate_avg INTEGER,
    heart_rate_max INTEGER,
    heart_rate_resting INTEGER,
    sleep_quality DECIMAL(3,1),
    sleep_duration DECIMAL(4,1),
    gps_data JSONB,
    altitude DECIMAL(6,1),
    body_temperature DECIMAL(4,1),
    blood_pressure_systolic INTEGER,
    blood_pressure_diastolic INTEGER,
    recovery_score DECIMAL(5,2),
    anomaly_detected BOOLEAN DEFAULT FALSE,
    anomaly_score DECIMAL(4,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_biometric_athlete FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE
);

-- Table des blessures
CREATE TABLE injuries (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    medical_record_id UUID,
    athlete_id UUID NOT NULL,
    injury_type VARCHAR(100) NOT NULL,
    body_part VARCHAR(50) NOT NULL,
    severity injury_severity DEFAULT 'MINOR',
    occurred_date DATE,
    recovery_days INTEGER,
    expected_return_date DATE,
    actual_return_date DATE,
    is_recurring BOOLEAN DEFAULT FALSE,
    previous_injury_id UUID,
    treatment_notes TEXT,
    status injury_status DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_injuries_medical FOREIGN KEY (medical_record_id) REFERENCES medical_records(id) ON DELETE SET NULL,
    CONSTRAINT fk_injuries_athlete FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_injuries_previous FOREIGN KEY (previous_injury_id) REFERENCES injuries(id) ON DELETE SET NULL
);

CREATE TRIGGER update_injuries_updated_at BEFORE UPDATE ON injuries
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Table des alertes de détection d'anomalies
CREATE TABLE anomaly_alerts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    athlete_id UUID NOT NULL,
    biometric_data_id UUID,
    alert_type alert_type DEFAULT 'WARNING',
    z_score DECIMAL(5,2),
    metric_name VARCHAR(50),
    detected_value DECIMAL(10,2),
    expected_range_min DECIMAL(10,2),
    expected_range_max DECIMAL(10,2),
    description TEXT,
    status alert_status DEFAULT 'PENDING',
    reviewed_by UUID,
    reviewed_at TIMESTAMP,
    escalated_to UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_alerts_athlete FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_alerts_biometric FOREIGN KEY (biometric_data_id) REFERENCES biometric_data(id) ON DELETE SET NULL,
    CONSTRAINT fk_alerts_reviewer FOREIGN KEY (reviewed_by) REFERENCES doctors(user_id) ON DELETE SET NULL,
    CONSTRAINT fk_alerts_escalated FOREIGN KEY (escalated_to) REFERENCES federations(id) ON DELETE SET NULL
);

-- =============================================================================
-- 9. TABLES MÉDIA ET STREAMING
-- =============================================================================

-- Table des streams en direct
CREATE TABLE streams (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    match_id UUID,
    competition_id UUID,
    title VARCHAR(150),
    stream_key VARCHAR(100) UNIQUE,
    stream_url VARCHAR(500),
    playback_url VARCHAR(500),
    thumbnail_url VARCHAR(500),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    duration_seconds INTEGER,
    viewer_count INTEGER DEFAULT 0,
    max_viewers INTEGER DEFAULT 0,
    status stream_status DEFAULT 'SCHEDULED',
    quality_settings JSONB,
    recording_url VARCHAR(500),
    archived BOOLEAN DEFAULT FALSE,
    created_by UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_streams_match FOREIGN KEY (match_id) REFERENCES matches(id) ON DELETE SET NULL,
    CONSTRAINT fk_streams_competition FOREIGN KEY (competition_id) REFERENCES competitions(id) ON DELETE SET NULL,
    CONSTRAINT fk_streams_creator FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Table des abonnements streaming
CREATE TABLE subscriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    type subscription_type DEFAULT 'BASIC',
    start_date DATE,
    end_date DATE,
    amount DECIMAL(10,2),
    currency VARCHAR(3) DEFAULT 'MGA',
    payment_provider VARCHAR(50),
    payment_status payment_status DEFAULT 'PENDING',
    features JSONB,
    auto_renew BOOLEAN DEFAULT TRUE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_subscriptions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TRIGGER update_subscriptions_updated_at BEFORE UPDATE ON subscriptions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =============================================================================
-- 10. TABLES UTILITAIRES
-- =============================================================================

-- Table des notifications
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    type notification_type DEFAULT 'SYSTEM',
    title VARCHAR(150) NOT NULL,
    message TEXT,
    action_url VARCHAR(500),
    is_read BOOLEAN DEFAULT FALSE,
    read_at TIMESTAMP,
    sent_via notification_channel DEFAULT 'APP',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table des logs d'audit (Blockchain interne)
CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    table_name VARCHAR(50) NOT NULL,
    record_id UUID NOT NULL,
    action audit_action NOT NULL,
    old_values JSONB,
    new_values JSONB,
    performed_by UUID,
    performed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent VARCHAR(500),
    hash VARCHAR(64),
    previous_hash VARCHAR(64)
);

-- Table des sessions utilisateur
CREATE TABLE user_sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    session_token VARCHAR(255) NOT NULL UNIQUE,
    device_info VARCHAR(255),
    ip_address VARCHAR(45),
    is_active BOOLEAN DEFAULT TRUE,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_activity TIMESTAMP,
    CONSTRAINT fk_sessions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =============================================================================
-- INDEXES POUR PERFORMANCE
-- =============================================================================

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_nin ON users(nin);
CREATE INDEX idx_users_role ON users(role_id);
CREATE INDEX idx_athletes_club ON athletes(current_club_id);
CREATE INDEX idx_athletes_sport ON athletes(sport_type);
CREATE INDEX idx_licenses_athlete ON licenses(athlete_id);
CREATE INDEX idx_licenses_status ON licenses(status);
CREATE INDEX idx_licenses_season ON licenses(season);
CREATE INDEX idx_competitions_federation ON competitions(federation_id);
CREATE INDEX idx_matches_competition ON matches(competition_id);
CREATE INDEX idx_matches_date ON matches(scheduled_date);
CREATE INDEX idx_performances_athlete ON performances(athlete_id);
CREATE INDEX idx_performances_match ON performances(match_id);
CREATE INDEX idx_biometric_athlete ON biometric_data(athlete_id);
CREATE INDEX idx_biometric_recorded ON biometric_data(recorded_at);
CREATE INDEX idx_anomaly_alerts_athlete ON anomaly_alerts(athlete_id);
CREATE INDEX idx_anomaly_alerts_status ON anomaly_alerts(status);
CREATE INDEX idx_talent_eval_athlete ON talent_evaluations(athlete_id);
CREATE INDEX idx_talent_eval_potential ON talent_evaluations(potential);
CREATE INDEX idx_payments_status ON payments(status);
CREATE INDEX idx_standings_competition ON standings(competition_id);

-- Index GIN pour JSONB (recherche rapide dans les documents JSON)
CREATE INDEX idx_athletes_jsonb ON athletes USING GIN (sport_type);
CREATE INDEX idx_biometric_gps ON biometric_data USING GIN (gps_data);
CREATE INDEX idx_evaluations_scores ON talent_evaluations USING GIN (scores);
CREATE INDEX idx_performances_metrics ON performances USING GIN (metrics);

-- =============================================================================
-- VUES POUR RAPPORTS
-- =============================================================================

-- Vue des athlètes avec informations complètes
CREATE OR REPLACE VIEW v_athletes_full AS
SELECT 
    a.user_id,
    a.first_name,
    a.last_name,
    a.birth_date,
    a.gender,
    a.height,
    a.weight,
    a.position,
    a.national_team_eligible,
    u.email,
    u.phone,
    u.nin,
    c.name AS club_name,
    f.name AS federation_name,
    f.sport_type
FROM athletes a
LEFT JOIN users u ON a.user_id = u.id
LEFT JOIN clubs c ON a.current_club_id = c.id
LEFT JOIN federations f ON c.federation_id = f.id;

-- Vue des licences actives
CREATE OR REPLACE VIEW v_active_licenses AS
SELECT 
    l.*,
    a.first_name,
    a.last_name,
    c.name AS club_name,
    f.name AS federation_name,
    f.sport_type
FROM licenses l
JOIN athletes a ON l.athlete_id = a.user_id
LEFT JOIN clubs c ON l.club_id = c.id
LEFT JOIN federations f ON l.federation_id = f.id
WHERE l.status = 'APPROVED' AND l.expiry_date >= CURRENT_DATE;

-- Vue des classements par compétition
CREATE OR REPLACE VIEW v_competition_standings AS
SELECT 
    s.*,
    c.name AS competition_name,
    cp.club_id,
    cl.name AS club_name,
    cl.logo_url AS club_logo
FROM standings s
JOIN competitions c ON s.competition_id = c.id
JOIN competition_participants cp ON s.participant_id = cp.id
LEFT JOIN clubs cl ON cp.club_id = cl.id
ORDER BY c.name, s.position;

-- Vue des alertes anomalies en attente
CREATE OR REPLACE VIEW v_pending_anomalies AS
SELECT 
    aa.*,
    a.first_name,
    a.last_name,
    a.sport_type,
    bd.vo2_max,
    bd.heart_rate_max
FROM anomaly_alerts aa
JOIN athletes a ON aa.athlete_id = a.user_id
LEFT JOIN biometric_data bd ON aa.biometric_data_id = bd.id
WHERE aa.status = 'PENDING'
ORDER BY aa.alert_type DESC, aa.created_at DESC;

-- Vue des athlètes avec dernière performance
CREATE OR REPLACE VIEW v_athletes_last_performance AS
SELECT 
    a.*,
    u.email,
    c.name AS club_name,
    p.match_date AS last_match_date,
    p.rating AS last_rating,
    p.overall_score AS last_overall_score,
    p.minutes_played AS last_minutes
FROM athletes a
LEFT JOIN users u ON a.user_id = u.id
LEFT JOIN clubs c ON a.current_club_id = c.id
LEFT JOIN LATERAL (
    SELECT * FROM performances 
    WHERE athlete_id = a.user_id 
    ORDER BY match_date DESC 
    LIMIT 1
) p ON true;

-- Vue du leaderboard des meilleurs talents
CREATE OR REPLACE VIEW v_top_talents AS
SELECT 
    a.user_id,
    a.first_name,
    a.last_name,
    a.position,
    c.name AS club_name,
    AVG(te.overall_score) AS avg_score,
    MAX(te.overall_score) AS max_score,
    COUNT(te.id) AS evaluation_count,
    CASE 
        WHEN AVG(te.overall_score) >= 85 THEN 'ELITE'
        WHEN AVG(te.overall_score) >= 70 THEN 'PROMISING'
        ELSE 'STANDARD'
    END AS talent_category
FROM athletes a
JOIN talent_evaluations te ON a.user_id = te.athlete_id
LEFT JOIN clubs c ON a.current_club_id = c.id
GROUP BY a.user_id, a.first_name, a.last_name, a.position, c.name
ORDER BY avg_score DESC;

-- Vue des statistiques biométriques par athlète (7 derniers jours)
CREATE OR REPLACE VIEW v_biometric_weekly_stats AS
SELECT 
    athlete_id,
    AVG(vo2_max) AS avg_vo2_max,
    AVG(heart_rate_avg) AS avg_heart_rate,
    AVG(sleep_quality) AS avg_sleep_quality,
    AVG(recovery_score) AS avg_recovery,
    COUNT(*) AS data_points,
    MAX(recorded_at) AS last_recorded
FROM biometric_data
WHERE recorded_at >= CURRENT_DATE - INTERVAL '7 days'
GROUP BY athlete_id;

-- =============================================================================
-- COMMENTAIRES SUR LES TABLES
-- =============================================================================

COMMENT ON TABLE users IS 'Utilisateurs principaux du système';
COMMENT ON TABLE athletes IS 'Profils des athlètes';
COMMENT ON TABLE coaches IS 'Profils des entraîneurs';
COMMENT ON TABLE scouts IS 'Profils des recruteurs / observateurs';
COMMENT ON TABLE federations IS 'Fédérations sportives malgaches';
COMMENT ON TABLE clubs IS 'Clubs sportifs';
COMMENT ON TABLE licenses IS 'Licences des athlètes avec QR code';
COMMENT ON TABLE payments IS 'Paiements Mobile Money (Mvola, Airtel, Orange)';
COMMENT ON TABLE competitions IS 'Compétitions organisées par fédérations';
COMMENT ON TABLE matches IS 'Matchs programmés';
COMMENT ON TABLE performances IS 'Statistiques de performance par match';
COMMENT ON TABLE smart_squad_selections IS 'Sélections d''équipe générées par IA';
COMMENT ON TABLE talent_evaluations IS 'Évaluations de talents par les scouts';
COMMENT ON TABLE biometric_data IS 'Données biométriques IoT des athlètes';
COMMENT ON TABLE anomaly_alerts IS 'Alertes de détection d''anomalies (dopage/santé)';
COMMENT ON TABLE streams IS 'Streams en direct des matchs';
COMMENT ON TABLE audit_logs IS 'Logs d''audit avec chaîne de hash (blockchain interne)';
