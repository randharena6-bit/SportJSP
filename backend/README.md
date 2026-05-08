# SPORT CONNECT - Backend API

Backend Node.js/Express pour l'authentification et la gestion des utilisateurs de SPORT CONNECT.

## 📋 Prérequis

- Node.js (v14 ou supérieur)
- PostgreSQL (v12 ou supérieur)
- npm ou yarn

## 🚀 Installation

1. **Cloner ou naviguer vers le dossier backend**
   ```bash
   cd /home/eric-dev/Documents/SportJSP/backend
   ```

2. **Installer les dépendances**
   ```bash
   npm install
   ```

3. **Configurer les variables d'environnement**
   
   Le fichier `.env` est déjà configuré avec les valeurs par défaut pour le développement :
   ```
   PORT=3001
   NODE_ENV=development
   DB_HOST=localhost
   DB_PORT=5432
   DB_NAME=sportconnect
   DB_USER=postgres
   DB_PASSWORD=postgres
   JWT_SECRET=votre_cle_secrete_tres_longue_et_compliquee_pour_la_securite
   JWT_EXPIRE=7d
   CORS_ORIGIN=http://localhost:8080
   ```

   ⚠️ **Important** : En production, changez le `JWT_SECRET` par une clé sécurisée.

4. **S'assurer que la base de données PostgreSQL est en cours d'exécution**
   ```bash
   sudo systemctl status postgresql
   ```

   Si PostgreSQL n'est pas démarré :
   ```bash
   sudo systemctl start postgresql
   ```

## 🎯 Démarrage du serveur

### Mode développement (avec nodemon)
```bash
npm run dev
```

### Mode production
```bash
npm start
```

Le serveur démarrera sur `http://localhost:3001`

## 📡 Endpoints API

### Authentification

#### Inscription
```http
POST /api/auth/register
Content-Type: application/json

{
  "firstname": "Jean",
  "lastname": "Rakoto",
  "email": "jean.rakoto@example.com",
  "nin": "1234567890123",
  "phone": "+261 34 XX XXX XX",
  "password": "Password123!",
  "confirmPassword": "Password123!",
  "role": "athlete"
}
```

Réponse :
```json
{
  "success": true,
  "message": "Compte créé avec succès",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "uuid",
    "email": "jean.rakoto@example.com",
    "role": "athlete",
    "firstname": "Jean",
    "lastname": "Rakoto"
  }
}
```

#### Connexion
```http
POST /api/auth/login
Content-Type: application/json

{
  "username": "jean.rakoto@example.com",
  "password": "Password123!",
  "role": "athlete"
}
```

Réponse :
```json
{
  "success": true,
  "message": "Connexion réussie",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "uuid",
    "email": "jean.rakoto@example.com",
    "role": "athlete",
    "firstname": "Jean",
    "lastname": "Rakoto"
  }
}
```

#### Obtenir le profil utilisateur (authentifié)
```http
GET /api/auth/profile
Authorization: Bearer <token>
```

### Health Check

```http
GET /health
```

Réponse :
```json
{
  "status": "OK",
  "message": "SPORT CONNECT Backend API is running",
  "timestamp": "2025-01-01T00:00:00.000Z"
}
```

## 🔐 Rôles disponibles

- `athlete` - Athlète
- `coach` - Entraîneur
- `federation` - Administrateur de fédération
- `admin` - Administrateur système

## 🛡️ Sécurité

- Les mots de passe sont hashés avec bcrypt
- JWT tokens pour l'authentification
- Validation des entrées avec express-validator
- CORS configuré pour autoriser le frontend

## 📊 Structure du projet

```
backend/
├── src/
│   ├── config/
│   │   └── db.js          # Configuration PostgreSQL
│   ├── controllers/
│   │   └── authController.js  # Logique d'authentification
│   ├── middleware/
│   │   └── auth.js        # Middleware JWT
│   ├── routes/
│   │   └── authRoutes.js  # Routes API
│   └── utils/
│       └── passwordUtils.js  # Utilitaires mot de passe
├── .env                   # Variables d'environnement
├── package.json           # Dépendances
├── server.js              # Point d'entrée
└── README.md              # Ce fichier
```

## 🧪 Test avec curl

### Test inscription
```bash
curl -X POST http://localhost:3001/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "firstname": "Jean",
    "lastname": "Rakoto",
    "email": "jean.rakoto@example.com",
    "nin": "1234567890123",
    "phone": "+261 34 XX XXX XX",
    "password": "Password123!",
    "confirmPassword": "Password123!",
    "role": "athlete"
  }'
```

### Test connexion
```bash
curl -X POST http://localhost:3001/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "jean.rakoto@example.com",
    "password": "Password123!",
    "role": "athlete"
  }'
```

### Test profil (avec token)
```bash
curl -X GET http://localhost:3001/api/auth/profile \
  -H "Authorization: Bearer VOTRE_TOKEN_ICI"
```

## 🔧 Dépannage

### Erreur de connexion à la base de données
- Vérifiez que PostgreSQL est en cours d'exécution
- Vérifiez les identifiants dans `.env`
- Vérifiez que la base de données `sportconnect` existe

### Erreur de port déjà utilisé
- Changez le PORT dans `.env`
- Arrêtez tout autre processus utilisant le port 3001

## 📝 Notes

- Le backend utilise la base de données PostgreSQL existante créée pour le projet JSP
- Les tables `users`, `athletes`, `coaches`, `federation_admins`, `admins` doivent exister
- Le JWT token expire après 7 jours par défaut
