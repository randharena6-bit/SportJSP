# SPORT CONNECT - Base de Données PostgreSQL

## Configuration PostgreSQL

### Prérequis
- PostgreSQL 13 ou supérieur
- Extension `uuid-ossp` activée
- Driver JDBC PostgreSQL 42.7.2+

### Installation

#### 1. Créer la base de données
```bash
# Se connecter en tant que postgres
sudo -u postgres psql

# Créer la base de données
CREATE DATABASE sportconnect 
    WITH ENCODING = 'UTF8' 
    LC_COLLATE = 'fr_FR.UTF-8' 
    LC_CTYPE = 'fr_FR.UTF-8';

\q
```

#### 2. Exécuter le schéma
```bash
psql -U postgres -d sportconnect -f database/sportconnect_schema_postgres.sql
```

#### 3. Insérer les données initiales (optionnel)
```bash
psql -U postgres -d sportconnect -f database/seed_data_postgres.sql
```

#### En une seule commande
```bash
sudo -u postgres psql -c "CREATE DATABASE sportconnect;" && \
psql -U postgres -d sportconnect -f database/sportconnect_schema_postgres.sql && \
psql -U postgres -d sportconnect -f database/seed_data_postgres.sql
```

### Configuration de l'application

Le fichier `src/main/resources/db.properties` est déjà configuré pour PostgreSQL :

```properties
db.url=jdbc:postgresql://localhost:5432/sportconnect?serverTimezone=Africa/Nairobi&characterEncoding=UTF-8
db.username=postgres
db.password=postgres
db.driver=org.postgresql.Driver
```

### Fonctionnalités PostgreSQL utilisées

| Fonctionnalité | Description |
|---------------|-------------|
| **UUID** | Extension `uuid-ossp` pour génération d'IDs |
| **ENUM** | Types personnalisés pour statuts et rôles |
| **JSONB** | Stockage performant des données JSON |
| **GIN Indexes** | Index pour recherche rapide dans JSONB |
| **Triggers** | Mise à jour automatique de `updated_at` |
| **Views** | Vues matérialisées pour rapports |

### Schéma relationnel

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  federations    │────▶│     clubs       │◀────│    coaches      │
│     (UUID)      │     │    (UUID)       │     │    (UUID)       │
└────────┬────────┘     └────────┬────────┘     └─────────────────┘
         │                       │
         │              ┌────────┴────────┐
         │              │                 │
         │              ▼                 ▼
         │      ┌───────────────┐  ┌───────────────┐
         │      │   athletes    │  │  competitions │
         │      │    (UUID)     │  │    (UUID)     │
         │      └───────┬───────┘  └───────┬───────┘
         │              │                    │
         │              │           ┌────────┴────────┐
         │              │           │                 │
         │              │           ▼                 ▼
         │              │   ┌───────────────┐  ┌───────────────┐
         │              │   │    matches    │  │ participants  │
         │              │   │    (UUID)     │  │    (UUID)     │
         │              │   └───────┬───────┘  └───────────────┘
         │              │           │
         │              │           ▼
         │              │   ┌───────────────┐
         └──────────────┼──▶│   licenses    │
                        │   │    (UUID)     │
                        │   └───────────────┘
                        │
                        ▼
              ┌─────────────────┐
              │  smart_squad    │
              │  selections     │
              │    (UUID)       │
              └─────────────────┘
```

### Types ENUM personnalisés

```sql
-- Rôles utilisateur
user_role: ATHLETE, COACH, SCOUT, DOCTOR, ADMIN, ADMIN_FEDERATION, OFFICIAL, SELECTIONNEUR, FAN

-- Statuts de licence
license_status: PENDING, APPROVED, REJECTED, SUSPENDED, EXPIRED

-- Statuts de match
match_status: SCHEDULED, ONGOING, COMPLETED, POSTPONED, CANCELLED

-- Potentiel des talents
potential_type: ELITE, PROMISING, FOLLOW, STANDARD

-- Sévérité des blessures
injury_severity: MINOR, MODERATE, SEVERE, CRITICAL
```

### Vues disponibles

| Vue | Description |
|-----|-------------|
| `v_athletes_full` | Athlètes avec infos complètes (club, fédération) |
| `v_active_licenses` | Licences actuellement valides |
| `v_competition_standings` | Classements par compétition |
| `v_pending_anomalies` | Alertes anomalies en attente |
| `v_athletes_last_performance` | Dernière performance par athlète |
| `v_top_talents` | Leaderboard des meilleurs talents |
| `v_biometric_weekly_stats` | Stats biométriques (7 derniers jours) |

### Exemples de requêtes

```sql
-- Rechercher les meilleurs talents par sport
SELECT * FROM v_top_talents 
WHERE sport_type = 'FOOTBALL' 
AND avg_score > 80;

-- Vérifier les licences actives d'un athlète
SELECT * FROM v_active_licenses 
WHERE user_id = 'athlete-f-001';

-- Anomalies biométriques récentes
SELECT * FROM v_pending_anomalies 
WHERE alert_type = 'CRITICAL';

-- Stats hebdomadaires d'un athlète
SELECT * FROM v_biometric_weekly_stats 
WHERE athlete_id = 'athlete-f-001';
```

### Comptes de test

| Email | Mot de passe | Rôle |
|-------|--------------|------|
| `admin@sportconnect.mg` | `Admin123!` | Super Admin |
| `admin@fmf.mg` | `Admin123!` | Admin Fédération |
| `jean.rakoto@sportconnect.mg` | `Player123!` | Athlète |
| `coach.foot@sportconnect.mg` | `Coach123!` | Entraîneur |
| `scout.national@sportconnect.mg` | `Scout123!` | Scout |
| `dr.sport@sportconnect.mg` | `Doctor123!` | Médecin |
| `referee.foot@sportconnect.mg` | `Referee123!` | Arbitre |

### Maintenance

#### Backup
```bash
pg_dump -U postgres sportconnect > backup_$(date +%Y%m%d).sql
```

#### Restore
```bash
psql -U postgres sportconnect < backup_YYYYMMDD.sql
```

#### Vacuum (optimisation)
```sql
VACUUM ANALYZE;
```

### Migration depuis MySQL

Si vous avez déjà des données MySQL, utilisez `pgloader` :
```bash
pgloader mysql://root:root@localhost/sportconnect postgresql://postgres:postgres@localhost/sportconnect
```

### Contact
**Auteur**: RANDRIANIRINA Harena Eric Miaritsoa - SE20240079
**Projet**: SPORT CONNECT - Numérique de Madagascar 2035
