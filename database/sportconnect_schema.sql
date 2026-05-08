-- =============================================================================
-- SPORT CONNECT - Schéma de Base de Données
-- Écosystème Numérique du Sport Malgache
-- Version 1.0 - MySQL 8.0+
-- Auteur: RANDRIANIRINA Harena Eric Miaritsoa - SE20240079
-- =============================================================================

-- Création de la base de données
CREATE DATABASE IF NOT EXISTS sportconnect 
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci;

USE sportconnect;

-- =============================================================================
-- 1. TABLES UTILISATEURS ET IDENTITÉ
-- =============================================================================

-- Table des rôles utilisateur
CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table principale des utilisateurs
CREATE TABLE users (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    nin VARCHAR(20) UNIQUE COMMENT 'Numéro d\'Identité National',
    phone VARCHAR(20),
    role_id INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    email_verified BOOLEAN DEFAULT FALSE,
    phone_verified BOOLEAN DEFAULT FALSE,
    last_login TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE RESTRICT
);

-- Table des athlètes
CREATE TABLE athletes (
    user_id VARCHAR(36) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    gender ENUM('M', 'F', 'OTHER') DEFAULT 'M',
    height DECIMAL(5,2) COMMENT 'en cm',
    weight DECIMAL(5,2) COMMENT 'en kg',
    current_club_id VARCHAR(36),
    sport_type VARCHAR(50),
    position VARCHAR(50) COMMENT 'Poste spécifique au sport',
    national_team_eligible BOOLEAN DEFAULT FALSE,
    biography TEXT,
    photo_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (current_club_id) REFERENCES clubs(id) ON DELETE SET NULL
);

-- Table des entraîneurs
CREATE TABLE coaches (
    user_id VARCHAR(36) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) COMMENT 'Spécialité (football, basket, etc.)',
    experience_years INT DEFAULT 0,
    current_club_id VARCHAR(36),
    certifications JSON COMMENT 'Liste des certifications',
    biography TEXT,
    photo_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (current_club_id) REFERENCES clubs(id) ON DELETE SET NULL
);

-- Table des scouts (recruteurs)
CREATE TABLE scouts (
    user_id VARCHAR(36) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    regions JSON COMMENT 'Régions de couverture',
    employer VARCHAR(100) COMMENT 'Employeur (club, fédération, etc.)',
    specializations JSON COMMENT 'Sports spécialisés',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table des médecins
CREATE TABLE doctors (
    user_id VARCHAR(36) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    license_number VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    institution VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table des administrateurs système
CREATE TABLE admins (
    user_id VARCHAR(36) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    admin_level ENUM('SUPER', 'FEDERATION', 'SYSTEM') DEFAULT 'SYSTEM',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table des officiels (arbitres, etc.)
CREATE TABLE officials (
    user_id VARCHAR(36) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    official_type ENUM('REFEREE', 'JUDGE', 'COMMISSIONER') DEFAULT 'REFEREE',
    certifications JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =============================================================================
-- 2. TABLES ORGANISATIONS
-- =============================================================================

-- Table des fédérations
CREATE TABLE federations (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
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
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table des clubs
CREATE TABLE clubs (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    federation_id VARCHAR(36) NOT NULL,
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
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (federation_id) REFERENCES federations(id) ON DELETE RESTRICT
);

-- =============================================================================
-- 3. TABLES GESTION DES LICENCES
-- =============================================================================

-- Table des licences
CREATE TABLE licenses (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    athlete_id VARCHAR(36) NOT NULL,
    federation_id VARCHAR(36) NOT NULL,
    club_id VARCHAR(36),
    season VARCHAR(10) NOT NULL COMMENT 'Ex: 2024-2025',
    license_number VARCHAR(50) UNIQUE,
    status ENUM('PENDING', 'APPROVED', 'REJECTED', 'SUSPENDED', 'EXPIRED') DEFAULT 'PENDING',
    qr_code_data TEXT COMMENT 'Données du QR code',
    qr_code_image_url VARCHAR(500),
    issue_date DATE,
    expiry_date DATE,
    medical_clearance BOOLEAN DEFAULT FALSE,
    medical_exam_date DATE,
    payment_status ENUM('PENDING', 'PAID', 'FAILED', 'REFUNDED') DEFAULT 'PENDING',
    documents JSON COMMENT 'URLs des documents uploadés',
    notes TEXT,
    blockchain_tx_hash VARCHAR(100) COMMENT 'Hash transaction blockchain',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    FOREIGN KEY (federation_id) REFERENCES federations(id) ON DELETE RESTRICT,
    FOREIGN KEY (club_id) REFERENCES clubs(id) ON DELETE SET NULL
);

-- Table des paiements (Mobile Money)
CREATE TABLE payments (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    license_id VARCHAR(36),
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'MGA',
    provider ENUM('MVOLA', 'AIRTEL_MONEY', 'ORANGE_MONEY', 'BANK') NOT NULL,
    provider_transaction_id VARCHAR(100),
    status ENUM('INITIATED', 'PENDING', 'COMPLETED', 'FAILED', 'REFUNDED') DEFAULT 'INITIATED',
    receipt_url VARCHAR(500),
    phone_number VARCHAR(20),
    paid_at TIMESTAMP NULL,
    failure_reason VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (license_id) REFERENCES licenses(id) ON DELETE SET NULL
);

-- =============================================================================
-- 4. TABLES COMPÉTITIONS ET MATCHS
-- =============================================================================

-- Table des compétitions
CREATE TABLE competitions (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    federation_id VARCHAR(36) NOT NULL,
    name VARCHAR(150) NOT NULL,
    season VARCHAR(10) NOT NULL,
    competition_type ENUM('LEAGUE', 'CUP', 'TOURNAMENT', 'FRIENDLY') DEFAULT 'LEAGUE',
    format VARCHAR(50) COMMENT 'Format de la compétition',
    start_date DATE,
    end_date DATE,
    registration_deadline DATE,
    venue VARCHAR(255),
    status ENUM('PLANNED', 'ONGOING', 'COMPLETED', 'CANCELLED') DEFAULT 'PLANNED',
    rules_document_url VARCHAR(500),
    created_by VARCHAR(36),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (federation_id) REFERENCES federations(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Table des participants aux compétitions (clubs ou athlètes individuels)
CREATE TABLE competition_participants (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    competition_id VARCHAR(36) NOT NULL,
    club_id VARCHAR(36),
    athlete_id VARCHAR(36),
    seed INT COMMENT 'Tête de série',
    is_bye BOOLEAN DEFAULT FALSE,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('REGISTERED', 'CONFIRMED', 'DISQUALIFIED', 'WITHDRAWN') DEFAULT 'REGISTERED',
    FOREIGN KEY (competition_id) REFERENCES competitions(id) ON DELETE CASCADE,
    FOREIGN KEY (club_id) REFERENCES clubs(id) ON DELETE CASCADE,
    FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_participant (competition_id, club_id, athlete_id)
);

-- Table des matchs
CREATE TABLE matches (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    competition_id VARCHAR(36),
    round INT COMMENT 'Tour/Round',
    match_number VARCHAR(20),
    home_participant_id VARCHAR(36),
    away_participant_id VARCHAR(36),
    scheduled_date DATETIME,
    venue VARCHAR(255),
    stadium VARCHAR(100),
    official_id VARCHAR(36) COMMENT 'Arbitre/officiel principal',
    status ENUM('SCHEDULED', 'ONGOING', 'COMPLETED', 'POSTPONED', 'CANCELLED') DEFAULT 'SCHEDULED',
    home_score INT DEFAULT 0,
    away_score INT DEFAULT 0,
    result ENUM('HOME_WIN', 'AWAY_WIN', 'DRAW', 'NO_RESULT') DEFAULT 'NO_RESULT',
    duration_minutes INT DEFAULT 90,
    attendance INT,
    weather_conditions VARCHAR(100),
    video_url VARCHAR(500),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (competition_id) REFERENCES competitions(id) ON DELETE SET NULL,
    FOREIGN KEY (home_participant_id) REFERENCES competition_participants(id) ON DELETE SET NULL,
    FOREIGN KEY (away_participant_id) REFERENCES competition_participants(id) ON DELETE SET NULL,
    FOREIGN KEY (official_id) REFERENCES officials(user_id) ON DELETE SET NULL
);

-- Table des performances des athlètes par match
CREATE TABLE performances (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    athlete_id VARCHAR(36) NOT NULL,
    match_id VARCHAR(36) NOT NULL,
    club_id VARCHAR(36),
    date DATE,
    metrics JSON COMMENT 'Statistiques détaillées par sport',
    overall_score DECIMAL(4,2) COMMENT 'Note globale 0-100',
    minutes_played INT DEFAULT 0,
    is_starter BOOLEAN DEFAULT FALSE,
    rating DECIMAL(3,1) COMMENT 'Note du match 0-10',
    verified_by VARCHAR(36),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    FOREIGN KEY (match_id) REFERENCES matches(id) ON DELETE CASCADE,
    FOREIGN KEY (club_id) REFERENCES clubs(id) ON DELETE SET NULL,
    FOREIGN KEY (verified_by) REFERENCES officials(user_id) ON DELETE SET NULL,
    UNIQUE KEY unique_performance (athlete_id, match_id)
);

-- Table des classements
CREATE TABLE standings (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    competition_id VARCHAR(36) NOT NULL,
    participant_id VARCHAR(36) NOT NULL,
    position INT DEFAULT 0,
    played INT DEFAULT 0,
    won INT DEFAULT 0,
    drawn INT DEFAULT 0,
    lost INT DEFAULT 0,
    goals_for INT DEFAULT 0,
    goals_against INT DEFAULT 0,
    goal_difference INT DEFAULT 0,
    points INT DEFAULT 0,
    form JSON COMMENT 'Série de résultats récents',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (competition_id) REFERENCES competitions(id) ON DELETE CASCADE,
    FOREIGN KEY (participant_id) REFERENCES competition_participants(id) ON DELETE CASCADE,
    UNIQUE KEY unique_standing (competition_id, participant_id)
);

-- =============================================================================
-- 5. TABLES SMART SQUAD (SÉLECTION IA)
-- =============================================================================

-- Table des sélections SMART SQUAD
CREATE TABLE smart_squad_selections (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    type ENUM('NATIONAL', 'CLUB', 'TRAINING') DEFAULT 'NATIONAL',
    sport_type VARCHAR(50) NOT NULL,
    formation VARCHAR(10) COMMENT 'Formation tactique (4-3-3, 4-4-2, etc.)',
    season VARCHAR(10) NOT NULL,
    cohesion_score DECIMAL(4,2) COMMENT 'Score de cohésion équipe',
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    generated_by VARCHAR(36),
    status ENUM('DRAFT', 'VALIDATED', 'APPROVED', 'REJECTED') DEFAULT 'DRAFT',
    notes TEXT,
    FOREIGN KEY (generated_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Table des joueurs sélectionnés
CREATE TABLE selected_players (
    selection_id VARCHAR(36),
    athlete_id VARCHAR(36),
    position VARCHAR(50) NOT NULL,
    is_starter BOOLEAN DEFAULT TRUE,
    score DECIMAL(5,2) COMMENT 'Score de sélection',
    confidence DECIMAL(4,2) COMMENT 'Confiance IA 0-100',
    manual_override BOOLEAN DEFAULT FALSE,
    override_reason TEXT,
    rank_in_position INT,
    PRIMARY KEY (selection_id, athlete_id),
    FOREIGN KEY (selection_id) REFERENCES smart_squad_selections(id) ON DELETE CASCADE,
    FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE
);

-- Table des rapports IA
CREATE TABLE ai_reports (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    selection_id VARCHAR(36) NOT NULL,
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    algorithm_version VARCHAR(20),
    pbsa_config JSON COMMENT 'Configuration PBSA utilisée',
    explanations JSON COMMENT 'Explications des sélections',
    synergies JSON COMMENT 'Analyse des synergies',
    recommendations TEXT,
    pdf_url VARCHAR(500),
    FOREIGN KEY (selection_id) REFERENCES smart_squad_selections(id) ON DELETE CASCADE
);

-- Table d'analyse des synergies entre joueurs
CREATE TABLE synergy_analysis (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    selection_id VARCHAR(36) NOT NULL,
    player1_id VARCHAR(36) NOT NULL,
    player2_id VARCHAR(36) NOT NULL,
    synergy_score DECIMAL(5,2) COMMENT 'Score de synergie',
    factors JSON COMMENT 'Facteurs de synergie détaillés',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (selection_id) REFERENCES smart_squad_selections(id) ON DELETE CASCADE,
    FOREIGN KEY (player1_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    FOREIGN KEY (player2_id) REFERENCES athletes(user_id) ON DELETE CASCADE
);

-- =============================================================================
-- 6. TABLES SCOUTING ET ÉVALUATION
-- =============================================================================

-- Table des évaluations de talents (TSS - Talent Scouting System)
CREATE TABLE talent_evaluations (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    athlete_id VARCHAR(36) NOT NULL,
    scout_id VARCHAR(36) NOT NULL,
    evaluation_date DATE NOT NULL,
    location VARCHAR(150),
    scores JSON COMMENT 'Scores par critère',
    overall_score DECIMAL(5,2) COMMENT 'Score global 0-100',
    potential ENUM('ELITE', 'PROMISING', 'FOLLOW', 'STANDARD') DEFAULT 'STANDARD',
    technical_notes TEXT,
    physical_notes TEXT,
    mental_notes TEXT,
    recommendation TEXT,
    video_urls JSON,
    is_synced BOOLEAN DEFAULT TRUE COMMENT 'Synchronisation offline',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    FOREIGN KEY (scout_id) REFERENCES scouts(user_id) ON DELETE SET NULL
);

-- =============================================================================
-- 7. TABLES SANTÉ ET BIOMÉTRIE
-- =============================================================================

-- Table des dossiers médicaux
CREATE TABLE medical_records (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    athlete_id VARCHAR(36) NOT NULL,
    doctor_id VARCHAR(36),
    consultation_date DATE,
    diagnosis TEXT,
    treatment TEXT,
    medications JSON,
    medical_clearance BOOLEAN DEFAULT FALSE,
    clearance_valid_until DATE,
    is_confidential BOOLEAN DEFAULT TRUE,
    attachments JSON COMMENT 'URLs des pièces jointes',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(user_id) ON DELETE SET NULL
);

-- Table des données biométriques
CREATE TABLE biometric_data (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    athlete_id VARCHAR(36) NOT NULL,
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    device_id VARCHAR(50),
    vo2_max DECIMAL(5,2) COMMENT 'VO2 max (ml/kg/min)',
    heart_rate_avg INT,
    heart_rate_max INT,
    heart_rate_resting INT,
    sleep_quality DECIMAL(3,1) COMMENT 'Qualité du sommeil 0-10',
    sleep_duration DECIMAL(4,1) COMMENT 'Durée du sommeil en heures',
    gps_data JSON COMMENT 'Données GPS (distance, vitesse, etc.)',
    altitude DECIMAL(6,1),
    body_temperature DECIMAL(4,1),
    blood_pressure_systolic INT,
    blood_pressure_diastolic INT,
    recovery_score DECIMAL(5,2),
    anomaly_detected BOOLEAN DEFAULT FALSE,
    anomaly_score DECIMAL(4,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE
);

-- Table des blessures
CREATE TABLE injuries (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    medical_record_id VARCHAR(36),
    athlete_id VARCHAR(36) NOT NULL,
    injury_type VARCHAR(100) NOT NULL,
    body_part VARCHAR(50) NOT NULL,
    severity ENUM('MINOR', 'MODERATE', 'SEVERE', 'CRITICAL') DEFAULT 'MINOR',
    occurred_date DATE,
    recovery_days INT,
    expected_return_date DATE,
    actual_return_date DATE,
    is_recurring BOOLEAN DEFAULT FALSE,
    previous_injury_id VARCHAR(36),
    treatment_notes TEXT,
    status ENUM('ACTIVE', 'RECOVERING', 'RECOVERED', 'CHRONIC') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (medical_record_id) REFERENCES medical_records(id) ON DELETE SET NULL,
    FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    FOREIGN KEY (previous_injury_id) REFERENCES injuries(id) ON DELETE SET NULL
);

-- Table des alertes de détection d'anomalies (PAD - Performance Anomaly Detection)
CREATE TABLE anomaly_alerts (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    athlete_id VARCHAR(36) NOT NULL,
    biometric_data_id VARCHAR(36),
    alert_type ENUM('CRITICAL', 'WARNING', 'INFO') DEFAULT 'WARNING',
    z_score DECIMAL(5,2),
    metric_name VARCHAR(50),
    detected_value DECIMAL(10,2),
    expected_range_min DECIMAL(10,2),
    expected_range_max DECIMAL(10,2),
    description TEXT,
    status ENUM('PENDING', 'REVIEWED', 'DISMISSED', 'ESCALATED') DEFAULT 'PENDING',
    reviewed_by VARCHAR(36),
    reviewed_at TIMESTAMP,
    escalated_to VARCHAR(36),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (athlete_id) REFERENCES athletes(user_id) ON DELETE CASCADE,
    FOREIGN KEY (biometric_data_id) REFERENCES biometric_data(id) ON DELETE SET NULL,
    FOREIGN KEY (reviewed_by) REFERENCES doctors(user_id) ON DELETE SET NULL,
    FOREIGN KEY (escalated_to) REFERENCES federations(id) ON DELETE SET NULL
);

-- =============================================================================
-- 8. TABLES MÉDIA ET STREAMING
-- =============================================================================

-- Table des streams en direct
CREATE TABLE streams (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    match_id VARCHAR(36),
    competition_id VARCHAR(36),
    title VARCHAR(150),
    stream_key VARCHAR(100) UNIQUE,
    stream_url VARCHAR(500),
    playback_url VARCHAR(500),
    thumbnail_url VARCHAR(500),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    duration_seconds INT,
    viewer_count INT DEFAULT 0,
    max_viewers INT DEFAULT 0,
    status ENUM('SCHEDULED', 'LIVE', 'ENDED', 'ARCHIVED') DEFAULT 'SCHEDULED',
    quality_settings JSON,
    recording_url VARCHAR(500),
    archived BOOLEAN DEFAULT FALSE,
    created_by VARCHAR(36),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (match_id) REFERENCES matches(id) ON DELETE SET NULL,
    FOREIGN KEY (competition_id) REFERENCES competitions(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Table des abonnements streaming
CREATE TABLE subscriptions (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id VARCHAR(36) NOT NULL,
    type ENUM('BASIC', 'PREMIUM', 'FAMILY', 'ORGANIZATION') DEFAULT 'BASIC',
    start_date DATE,
    end_date DATE,
    amount DECIMAL(10,2),
    currency VARCHAR(3) DEFAULT 'MGA',
    payment_provider VARCHAR(50),
    payment_status ENUM('ACTIVE', 'EXPIRED', 'CANCELLED', 'PENDING') DEFAULT 'PENDING',
    features JSON COMMENT 'Fonctionnalités incluses',
    auto_renew BOOLEAN DEFAULT TRUE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =============================================================================
-- 9. TABLES UTILITAIRES
-- =============================================================================

-- Table des notifications
CREATE TABLE notifications (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id VARCHAR(36) NOT NULL,
    type ENUM('LICENSE', 'PAYMENT', 'MATCH', 'SELECTION', 'HEALTH', 'SYSTEM') DEFAULT 'SYSTEM',
    title VARCHAR(150) NOT NULL,
    message TEXT,
    action_url VARCHAR(500),
    is_read BOOLEAN DEFAULT FALSE,
    read_at TIMESTAMP,
    sent_via ENUM('APP', 'EMAIL', 'SMS', 'PUSH') DEFAULT 'APP',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table des logs d'audit (Blockchain interne)
CREATE TABLE audit_logs (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    table_name VARCHAR(50) NOT NULL,
    record_id VARCHAR(36) NOT NULL,
    action ENUM('CREATE', 'UPDATE', 'DELETE') NOT NULL,
    old_values JSON,
    new_values JSON,
    performed_by VARCHAR(36),
    performed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent VARCHAR(500),
    hash VARCHAR(64) COMMENT 'Hash pour chaîne de bloc interne',
    previous_hash VARCHAR(64)
);

-- Table des sessions utilisateur
CREATE TABLE user_sessions (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id VARCHAR(36) NOT NULL,
    session_token VARCHAR(255) NOT NULL UNIQUE,
    device_info VARCHAR(255),
    ip_address VARCHAR(45),
    is_active BOOLEAN DEFAULT TRUE,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_activity TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
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

-- =============================================================================
-- VUES POUR RAPPORTS
-- =============================================================================

-- Vue des athlètes avec informations complètes
CREATE VIEW v_athletes_full AS
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
CREATE VIEW v_active_licenses AS
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
WHERE l.status = 'APPROVED' AND l.expiry_date >= CURDATE();

-- Vue des classements par compétition
CREATE VIEW v_competition_standings AS
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
CREATE VIEW v_pending_anomalies AS
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
