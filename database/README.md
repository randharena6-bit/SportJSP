# SPORT CONNECT - Base de Données

## Configuration de la Base de Données MySQL

### Prérequis
- MySQL 8.0 ou supérieur
- MySQL Connector/J (déjà inclus dans le pom.xml)

### Installation

#### 1. Créer la base de données
```bash
mysql -u root -p < sportconnect_schema.sql
```

#### 2. Insérer les données initiales (optionnel)
```bash
mysql -u root -p sportconnect < seed_data.sql
```

#### 3. En une seule commande
```bash
mysql -u root -p < sportconnect_schema.sql && mysql -u root -p sportconnect < seed_data.sql
```

### Configuration de l'application

Créez un fichier `src/main/resources/db.properties` avec :

```properties
db.url=jdbc:mysql://localhost:3306/sportconnect?useSSL=false&serverTimezone=Africa/Nairobi&characterEncoding=UTF-8
db.username=votre_username
db.password=votre_password
db.driver=com.mysql.cj.jdbc.Driver
```

### Structure du Schéma

#### Tables Principales
| Table | Description |
|-------|-------------|
| `roles` | Rôles utilisateur (ATHLETE, COACH, SCOUT, etc.) |
| `users` | Utilisateurs du système |
| `athletes` | Profils des athlètes |
| `coaches` | Profils des entraîneurs |
| `scouts` | Profils des recruteurs |
| `doctors` | Profils des médecins |
| `federations` | Fédérations sportives malgaches |
| `clubs` | Clubs sportifs |

#### Tables Fonctionnelles
| Table | Description |
|-------|-------------|
| `licenses` | Licences des athlètes |
| `payments` | Paiements Mobile Money |
| `competitions` | Compétitions organisées |
| `matches` | Matchs programmés |
| `performances` | Performances des athlètes |
| `standings` | Classements |

#### Tables SMART SQUAD (IA)
| Table | Description |
|-------|-------------|
| `smart_squad_selections` | Sélections d'équipe IA |
| `selected_players` | Joueurs sélectionnés |
| `ai_reports` | Rapports générés par IA |
| `synergy_analysis` | Analyse des synergies |

#### Tables Santé
| Table | Description |
|-------|-------------|
| `medical_records` | Dossiers médicaux |
| `biometric_data` | Données biométriques (IoT) |
| `injuries` | Blessures |
| `anomaly_alerts` | Alertes de détection d'anomalies |

#### Tables Média
| Table | Description |
|-------|-------------|
| `streams` | Streams en direct |
| `subscriptions` | Abonnements streaming |

### Diagramme Relationnel Simplifié

```
users (1) ---- (1) athletes
   |              |
   |              | (n)
   |              v
   |          licenses (n) ---- (1) federations
   |              |
   |              | (n)
   |              v
   |          clubs (n) ---- (1) federations
   |
   |---- (1) coaches
   |---- (1) scouts
   |---- (1) doctors
   |---- (1) admins

federations (1) ---- (n) competitions (1) ---- (n) matches
                                        |            |
                                        |            | (n)
                                        |            v
                                        |        performances (n) ---- (1) athletes
                                        |
                                        | (n)
                                        v
                              competition_participants (n) ---- (1) clubs

athletes (1) ---- (n) biometric_data
         (1) ---- (n) medical_records (1) ---- (n) injuries
         (1) ---- (n) talent_evaluations
         (1) ---- (n) selected_players (n) ---- (n) smart_squad_selections
```

### Comptes de Test

| Rôle | Email | Mot de passe |
|------|-------|--------------|
| Super Admin | admin@sportconnect.mg | Admin123! |
| Admin Fédération | admin@fmf.mg | Admin123! |
| Athlète | jean.rakoto@sportconnect.mg | Player123! |
| Coach | coach.foot@sportconnect.mg | Coach123! |
| Scout | scout.national@sportconnect.mg | Scout123! |
| Médecin | dr.sport@sportconnect.mg | Doctor123! |
| Arbitre | referee.foot@sportconnect.mg | Referee123! |

### Notes Importantes

1. **Sécurité**: Les mots de passe dans `seed_data.sql` utilisent des placeholders. En production, utilisez des hash bcrypt réels.

2. **JSON Fields**: Les champs JSON nécessitent MySQL 5.7+ ou 8.0+

3. **UUID**: Les IDs utilisent des UUID générés par MySQL 8.0+ via `UUID()`

4. **Blockchain**: Le champ `blockchain_tx_hash` dans `licenses` et `audit_logs` est préparé pour l'intégration blockchain future.

### Maintenance

#### Backup
```bash
mysqldump -u root -p sportconnect > backup_$(date +%Y%m%d).sql
```

#### Restore
```bash
mysql -u root -p sportconnect < backup_YYYYMMDD.sql
```

### Contact
**Auteur**: RANDRIANIRINA Harena Eric Miaritsoa - SE20240079
**Projet**: SPORT CONNECT - Numérique de Madagascar 2035
