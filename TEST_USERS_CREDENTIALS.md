# 🔑 SPORT CONNECT - Identifiants de Test

Ce document contient les identifiants de connexion pour tester tous les rôles de l'application SPORT CONNECT.

**Mot de passe universel pour tous les comptes :** `password123`

---

## 📋 Tableau Récapitulatif

| Rôle | Email | NIN | Mot de passe | Usage |
|------|-------|-----|--------------|-------|
| **Admin** | `admin@test.com` | 1010101010101 | `password123` | Super administrateur système |
| **Athlète** | `athlete@test.com` | 2020202020202 | `password123` | Espace athlète (licence, compétitions) |
| **Entraîneur** | `coach@test.com` | 3030303030303 | `password123` | Dashboard entraîneur, gestion athlètes |
| **Fédération** | `federation@test.com` | 4040404040404 | `password123` | Admin fédération (licences, clubs) |
| **Médecin** | `doctor@test.com` | 5050505050505 | `password123` | Suivi médical athlètes |
| **Scout** | `scout@test.com` | 6060606060606 | `password123` | Détection talents, évaluations |

---

## 🔗 Endpoints API

### Authentification
- **POST** `http://localhost:3003/api/auth/login` - Connexion
- **POST** `http://localhost:3003/api/auth/register` - Inscription
- **GET** `http://localhost:3003/api/auth/profile` - Profil (auth requis)

### Exemple de requête Login

```bash
curl -X POST http://localhost:3003/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "athlete@test.com",
    "password": "password123",
    "role": "ATHLETE"
  }'
```

### Réponse attendue

```json
{
  "success": true,
  "message": "Connexion réussie",
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "user": {
    "id": "a0000000-0000-0000-0000-000000000002",
    "email": "athlete@test.com",
    "role": "ATHLETE",
    "firstname": "Jean",
    "lastname": "Rakoto"
  }
}
```

---

## 🗄️ Installation dans la Base de Données

### Méthode 1 : Exécution du script SQL

```bash
# Se connecter à PostgreSQL
psql -U postgres -d sportconnect

# Exécuter le script
\i backend/seed_users.sql
```

### Méthode 2 : API REST (Registration)

```bash
# Créer un athlète via l'API
curl -X POST http://localhost:3003/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "firstname": "Jean",
    "lastname": "Rakoto",
    "email": "athlete@test.com",
    "nin": "2020202020202",
    "phone": "0341234567",
    "password": "password123",
    "confirmPassword": "password123",
    "role": "ATHLETE"
  }'
```

---

## 🎭 Détails par Rôle

### 1. 👤 Admin (`admin@test.com`)
- **Niveau d'accès :** Super administrateur
- **Fonctionnalités :**
  - Gestion de tous les utilisateurs
  - Configuration système
  - Audit logs
  - Rapports globaux

### 2. 🏃 Athlète (`athlete@test.com`)
- **Nom :** Jean Rakoto
- **Fonctionnalités :**
  - Dashboard athlète (stats, performances)
  - Gestion des licences
  - Inscription aux compétitions
  - Données de santé
  - Médias et e-sport

### 3. 👨‍🏫 Entraîneur (`coach@test.com`)
- **Nom :** Pierre Rabemananjara
- **Spécialisation :** 100m, 200m Sprint
- **Fonctionnalités :**
  - Dashboard entraîneur
  - Gestion des athlètes
  - Planification entraînements
  - Analyse de performances
  - Scouting terrain
  - Communication avec athlètes

### 4. 🏛️ Fédération (`federation@test.com`)
- **Nom :** M. Rabe
- **Fédération :** Fédération Malgache d'Athlétisme (FMA)
- **Fonctionnalités :**
  - Gestion des licences
  - Validation/Réjection des demandes
  - Gestion des clubs affiliés
  - Organisation des compétitions
  - Scouting & talents
  - Finances et rapports

### 5. 🩺 Médecin (`doctor@test.com`)
- **Nom :** Dr. Raso Ramanana
- **Spécialisation :** Médecine du Sport
- **Numéro de licence :** MED-001-MDG
- **Fonctionnalités :**
  - Suivi médical des athlètes
  - Gestion des blessures
  - Certificats médicaux
  - Alertes de santé

### 6. 🔍 Scout (`scout@test.com`)
- **Nom :** Luc Andriamampianina
- **Région :** Antananarivo
- **Fonctionnalités :**
  - Évaluation des talents
  - Rapports de scouting
  - Base de données des prospects
  - Recommandations IA

---

## 🚀 Démarrage Rapide pour Tests

### 1. Démarrer le Backend
```bash
cd backend
node server.js
```

### 2. Tester la Connexion (Athlète)
```bash
curl -X POST http://localhost:3003/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"athlete@test.com","password":"password123","role":"ATHLETE"}'
```

### 3. Tester avec d'autres rôles
```bash
# Coach
curl -X POST http://localhost:3003/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"coach@test.com","password":"password123","role":"COACH"}'

# Fédération
curl -X POST http://localhost:3003/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"federation@test.com","password":"password123","role":"ADMIN_FEDERATION"}'

# Admin
curl -X POST http://localhost:3003/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin@test.com","password":"password123","role":"ADMIN"}'
```

---

## 📁 Fichiers Associés

| Fichier | Description |
|---------|-------------|
| `backend/seed_users.sql` | Script SQL pour créer les utilisateurs |
| `backend/generate-hash.js` | Script pour générer le hash bcrypt |
| `TEST_USERS_CREDENTIALS.md` | Ce fichier |

---

## ⚠️ Notes Importantes

1. **Ces identifiants sont pour les tests uniquement**
2. **Ne pas utiliser en production**
3. **Tous les comptes utilisent le même mot de passe :** `password123`
4. **Les UUIDs sont fixes** pour faciliter les tests (format: `a0000000-0000-0000-0000-0000000000XX`)

---

## 🔧 En Cas de Problème

### Réinitialiser les utilisateurs
```sql
-- Supprimer les utilisateurs de test
DELETE FROM users WHERE email LIKE '%@test.com';

-- Recréer
\i backend/seed_users.sql
```

### Vérifier la connexion
```bash
curl http://localhost:3003/health
```

---

**Date de création :** 2025-01-08  
**Version :** 1.0
