# SPORT CONNECT - Documentation UML en ASCII Art
## Écosystème Numérique du Sport Malgache
### Version 1.0 - Numérique de Madagascar 2035

---

## TABLE DES MATIÈRES

1. [Diagrammes de Cas d'Utilisation](#1-diagrammes-de-cas-dutilisation)
2. [Diagrammes de Classes](#2-diagrammes-de-classes)
3. [Diagrammes de Séquence](#3-diagrammes-de-séquence)
4. [Diagrammes d'Activité](#4-diagrammes-dactivité)
5. [Diagrammes de Déploiement](#5-diagrammes-de-déploiement)
6. [Modèle Entité-Relation](#6-modèle-entité-relation)

---

## 1. Diagrammes de Cas d'Utilisation

### 1.1 Vue d'Ensemble du Système SPORT CONNECT

```
                               +------------------+
                               |   SPORT CONNECT  |
                               |    PLATFORM      |
                               +--------+---------+
                                        |
           +------------+---------------+---------------+------------+
           |            |               |               |            |
           v            v               v               v            v
    +-------------+ +--------+ +--------------+ +-------------+ +--------+
    |   Gestion   | |  Compé-| |   Scouting   | |   Santé &   | |  Média |
    |  Identités  | |titions | |    & Talent  | | Performance | |E-Sport |
    +------+------+ +----+---+ +------+-------+ +------+------+ +----+---+
           |             |            |                 |            |
           |             |            |                 |            |
    +------v------+ +-----v----+ +-----v------+ +-------v-----+ +----v---+
    |• S'inscrire | |• Créer   | |• Évaluer   | |• Saisir     | |• Stream|
    |• Licence    | | compét.  | |  athlète   | |  données    | |• Abonn.|
    |• Auth       | |• Résultats| |• Suivi     | |  biométriq. | |• Partag|
    |• QR Code    | |• Calendr. | |  progress. | |• Télémédecin| |• E-sport
    +-------------+ +----------+ +------------+ +-------------+ +--------+
           ^             ^            ^                 ^            ^
           |             |            |                 |            |
    +------+------+ +----+-----+ +----+-------+ +-------+-----+ +----+---+
    |   ATHLÈTE   | |ENTRAÎNEUR| |   SCOUT    | |   MÉDECIN   | |   FAN  |
    +-------------+ +----------+ +------------+ +-------------+ +--------+
           ^
           |
    +------+------+
    |    ADMIN    |
    |  FÉDÉRATION |
    +-------------+
           ^
           |
    +------+------+      +-------------+      +-------------+
    |   OFFICIEL  |      | SÉLECTIONNEUR|      |   ADMIN     |
    |  (Arbitre)  |      |    NATIONAL   |      |   SYSTÈME   |
    +-------------+      +-------------+      +-------------+
           ^                      ^                    ^
           |                      |                    |
           +----------------------+--------------------+
                                 |
                         +-------+-------+
                         |     CNOM      |
                         |   MINISTÈRE   |
                         +---------------+
```

### 1.2 Cas d'Utilisation - Module SMART SQUAD

```
                         +-------------------------+
                         |    MODULE SMART SQUAD   |
                         |  Sélection par Poste IA |
                         +------------+------------+
                                      |
           +--------------------------+--------------------------+
           |                          |                          |
           v                          v                          v
    +-------------+           +----------------+           +------------+
    |  Configurer |           |   Exécuter     |           | Visualiser |
    |  Formation  |           |   Algorithmes  |           |   Équipe   |
    +------+------+           +--------+-------+           +------+-----+
           |                           |                           |
           |                           |                           |
    +------v------+           +-------v--------+          +-------v------+
    |• 4-3-3      |           |• PBSA          |          |• Vue terrain |
    |• 4-4-2      |           |• NTBA          |          |• Fiches      |
    |• 5-3-2      |           |• Scoring       |          |• Comparaisons|
    |• 3-5-2      |           |• Synergies     |          |• Radar       |
    +-------------+           +----------------+          +--------------+
                                       |
                                       v
                              +----------------+
                              |    Valider     |
                              |  Sélection IA  |
                              +--------+-------+
                                       |
                    +------------------+------------------+
                    |                  |                  |
                    v                  v                  v
            +-------v------+   +-------v-------+   +-------v-------+
            | Accepter     |   |   Modifier    |   |   Exporter    |
            | sélection    |   | manuellement  |   |   PDF Officiel|
            +--------------+   +---------------+   +---------------+
                    ^                  ^                  ^
                    |                  |                  |
            +-------+------+   +-------+-------+   +-------+-------+
            | SÉLECTIONNEUR|   |  ENTRAÎNEUR   |   |   ANALYSTE   |
            |   NATIONAL   |   |   de CLUB     |   |      IA      |
            +--------------+   +---------------+   +--------------+
```

### 1.3 Cas d'Utilisation - Gestion des Licences

```j
                         +---------------------------+
                         |    GESTION DES LICENCES   |
                         |      & Paiement Mobile    |
                         +-------------+-------------+
                                       |
         +-----------------------------+-----------------------------+
         |                             |                             |
         v                             v                             v
  +-------------+               +-------------+               +-------------+
  |   Athlète   |               |    Fédération|              |  Opérateurs |
  |   /Parent   |               |    Admin     |              |  Mobile     |
  +------+------+               +------+------+               |  Money      |
         |                             |                       +------+------+
         |                             |                              |
         |                             |                              |
    +----v----+                  +-----v-----+                  +-------v-------+
    | Soumettre|                 | Vérifier  |                  |• Mvola       |
    | demande  |---------------->| identité  |<---------------->|• Airtel      |
    |          |                 | médicale  |                  |• Orange      |
    +----+-----+                 +-----+-----+                  +---------------+
         |                             |
         |                             |
    +----v-----+                +-----v------+
    | Payer    |                | Générer    |
    |Mobile    |--------------->| licence    |
    |Money     |                | digitale   |
    +----+-----+                +-----+------+
         |                            |
         |                            |
    +----v------+               +-----v-------+      +------------------+
    |Confirmer  |               | Créer QR    |      |  Journaliser     |
    |paiement   |-------------->| Code        |---->|  Blockchain      |
    +----------+               +-------------+      +------------------+
```

---

## 2. Diagrammes de Classes

### 2.1 Modèle de Données Principal

```
+----------------+       +----------------+       +----------------+
|     User       |<------|    Athlete     |       |    Coach       |
+----------------+       +----------------+       +----------------+
| - id: UUID     |       | - user_id: FK  |       | - user_id: FK  |
| - email: String|       | - firstName    |       | - firstName    |
| - passwordHash |       | - lastName     |       | - lastName     |
| - nin: String  |       | - birthDate    |       | - specializ.   |
| - phone: String|       | - height       |       | - experience   |
| - role: Enum   |       | - weight       |       +--------+-------+
| - isActive     |       | - currentClub  |                |
+----------------+       +--------+-------+                |
         |                        |                        |
         |                        |                        |
         v                        v                        v
+--------+-------+       +--------+-------+       +--------+-------+
|  Federation    |<------|     Club       |       |   Scout        |
+----------------+       +----------------+       +----------------+
| - id: UUID     |       | - id: UUID     |       | - user_id: FK  |
| - name: String |       | - federationId |       | - regions      |
| - sportType    |       | - name: String |       | - employer     |
| - acronym      |       | - foundedDate  |       +--------+-------+
| - president    |       | - isPro        |                |
+----------------+       +--------+-------+                |
                                  |                        |
                                  v                        v
                         +--------+-------+       +--------+-------+
                         |    License     |<------| TalentEval.    |
                         +----------------+       +----------------+
                         | - id: UUID     |       | - athleteId    |
                         | - athleteId: FK|       | - scoutId      |
                         | - federationId |       | - scores: JSON |
                         | - clubId: FK   |       | - overallScore |
                         | - season       |       | - potential    |
                         | - status: Enum |       +----------------+
                         | - qrCodeData   |
                         | - expiryDate   |
                         +--------+-------+
                                  |
                                  |
                                  v
                         +--------+-------+
                         |    Payment     |
                         +----------------+
                         | - id: UUID     |
                         | - licenseId: FK|
                         | - amount       |
                         | - provider     |
                         | - status: Enum |
                         | - receiptUrl   |
                         +----------------+
```

### 2.2 Classes - Compétitions et Matchs

```
+----------------+       +----------------+       +----------------+
|  Competition   |<------|     Match      |<------|  Participant   |
+----------------+       +----------------+       +----------------+
| - id: UUID     |       | - id: UUID     |       | - id: UUID     |
| - federationId |       | - competitionId|       | - matchId: FK  |
| - name: String |       | - round: Int   |       | - athleteId    |
| - season       |       | - scheduledDate|       | - teamId       |
| - startDate    |       | - venue        |       | - seed: Int    |
| - endDate      |       | - status: Enum |       | - isBye        |
| - format       |       | - officialId   |       +--------+-------+
| - status       |       | - results      |                |
+----------------+       +--------+-------+                |
                                  |                        |
                                  |                        |
                                  v                        v
                         +--------+-------+       +--------+-------+
                         |  Performance   |       |    Standing    |
                         +----------------+       +----------------+
                         | - id: UUID     |       | - competitionId|
                         | - athleteId: FK|       | - participantId|
                         | - matchId: FK  |       | - position     |
                         | - metrics: JSON|       | - played       |
                         | - overallScore |       | - won          |
                         | - date         |       | - points       |
                         +----------------+       +----------------+
```

### 2.3 Classes - Module SMART SQUAD

```
+----------------+       +----------------+       +----------------+
| SmartSquadSel. |<>-----|  SelectedPlayer|<>-----|   AIReport     |
+----------------+       +----------------+       +----------------+
| - id: UUID     |       | - selectionId  |       | - selectionId  |
| - type: Enum   |       | - athleteId    |       | - generatedAt  |
| - sportType    |       | - position     |       | - algorithmVer |
| - formation    |       | - isStarter    |       | - explanations |
| - season       |       | - score: Float |       | - synergies    |
| - cohesionScore|       | - confidence   |       | - recommend.   |
| - generatedAt  |       | - manualOverride|      +--------+-------+
| - status: Enum |       +--------+-------+                |
+--------+-------+                |                        |
         |                        |                        |
         |                        v                        v
         |               +--------+-------+       +--------+-------+
         +-------------->|     Athlete    |       | SynergyAnalysis|
                         +----------------+       +----------------+
                         | - id: UUID     |       | - player1Id    |
                         | - firstName    |       | - player2Id    |
                         | - lastName     |       | - synergyScore |
                         | - position     |       | - factors: JSON|
                         | - clubId       |       +----------------+
                         | - birthDate    |
                         +----------------+
```

### 2.4 Classes - Santé et Biométrie

```
+----------------+       +----------------+       +----------------+
|  MedicalRecord |<------|    Biometric   |<------|     Injury     |
+----------------+       +----------------+       +----------------+
| - id: UUID     |       | - id: UUID     |       | - id: UUID     |
| - athleteId: FK|       | - athleteId: FK|       | - medicalRecId |
| - doctorId: FK |       | - recordedAt   |       | - type: String |
| - diagnosis    |       | - vo2Max: Float|       | - bodyPart     |
| - treatment    |       | - heartRate    |       | - severity     |
| - clearance    |       | - sleepQuality |       | - occurredDate |
| - isConfident. |       | - gpsData      |       | - recoveryDays |
+----------------+       | - altitude     |       | - isRecurring  |
                         +----------------+       +----------------+
```

---

## 3. Diagrammes de Séquence

### 3.1 Processus d'Inscription et Licence

```
Athlète         App Mobile      API Gateway    IdentitySvc    LicenseSvc    PaymentSvc    MobileMoney
   |                 |                 |              |              |              |              |
   | 1. Télécharger  |                 |              |              |              |              |
   |---------------->|                 |              |              |              |              |
   |                 |                 |              |              |              |              |
   | 2. Créer compte |                 |              |              |              |              |
   |---------------->|                 |              |              |              |              |
   |                 | 3. POST /register              |              |              |              |
   |                 |---------------->|              |              |              |              |
   |                 |                 | 4. validate()|              |              |              |
   |                 |                 |------------->|              |              |              |
   |                 |                 |              | 5. verifyNIN |              |              |
   |                 |                 |              |-------------NIN validé------->              |
   |                 |                 |              |<-------------|              |              |
   |                 |                 |              | 6. INSERT user              |              |
   |                 |                 |              |------DB OK----------------->              |
   |                 |                 |<-------------user_created--------------------|              |
   |                 |<----------------201 Created-------------------------------|              |              |
   |<----------------Compte créé      |              |              |              |              |
   |                 |                 |              |              |              |              |
   | 7. Se connecter |                 |              |              |              |              |
   |---------------->|                 |              |              |              |              |
   |                 | 8. POST /login  |              |              |              |              |
   |                 |---------------->|              |              |              |              |
   |                 |                 | authenticate()            |              |              |
   |                 |                 |-------------JWT token---------------------->|              |
   |                 |<----------------Token---------------------|              |              |
   |<----------------Connecté          |              |              |              |              |
   |                 |                 |              |              |              |              |
   | 9. Demander licence               |              |              |              |              |
   |---------------->|                 |              |              |              |              |
   |                 | POST /licenses/apply             |              |              |              |
   |                 |---------------->|              |              |              |              |
   |                 |                 | createLicenseRequest()    |              |              |
   |                 |                 |---------------------------->|              |              |
   |                 |                 |              |              | 10. calculateFee()          |
   |                 |                 |<---------------------------licence + amount------------|
   |                 |<----------------Demande créée, paiement requis            |              |
   |<----------------Confirmer paiement [Montant]                 |              |              |
   |                 |                 |              |              |              |              |
   | 11. Confirmer paiement            |              |              |              |              |
   |---------------->|                 |              |              |              |              |
   |                 | POST /payments/initiate       |              |              |              |
   |                 |---------------->|              |              |              |              |
   |                 |                 | initiatePayment()         |              |              |
   |                 |                 |-------------------------------------------->| 12. request |
   |                 |                 |              |              |              |------------>|
   |                 |                 |<-------------------------------------------pending----|
   |                 |<----------------En attente confirmation-----------------------|              |
   |<----------------Confirmez sur votre téléphone                  |              |              |
   |.....................Confirmer sur téléphone.....................................|              |
   |                 |                 |              |              |              | 13. webhook |
   |                 |                 |              |              |              |<------------|
   |                 |                 |              |              | 14. confirmPayment()       |
   |                 |                 |              |              |<-----------|              |
   |                 |                 |              |              | 15. generateLicense()      |
   |                 |                 |              |              | 16. createQRCode()         |
   |                 |                 |              |              |------DB OK--------------->  |
   |                 |                 |              |              |------blockchain---------->|
   |                 |                 |              |              |<--------tx_hash----------|
   |                 |                 |              |              | 17. notifyUser()          |
   |                 |<---------------PUSH notification: Licence approuvée!-----------------------|
   |<----------------Licence générée  |              |              |              |              |
   |                 |                 |              |              |              |              |
   | 18. Voir licence|                 |              |              |              |              |
   |---------------->|                 |              |              |              |              |
   |                 | GET /licenses/me|              |              |              |              |
   |                 |---------------->|              |              |              |              |
   |                 |                 | getLicense() |              |              |              |
   |                 |                 |---------------------------->|              |              |
   |                 |                 |<---------------------------license_data-----------------|
   |                 |<---------------licence + QR------------------|              |              |
   |<----------------Affichage QR Code|              |              |              |              |
   |                 |                 |              |              |              |              |
```

### 3.2 Processus SMART SQUAD - Sélection Nationale

```
Sélectionneur     Dashboard      SMART SQUAD      PBSA Engine     NTBA Engine     AthleteSvc
      |               |            API              |               |               |
      | 1. Accéder    |              |               |               |               |
      |-------------->|              |               |               |               |
      |               | GET /config|               |               |               |
      |               |------------>|               |               |               |
      |               |<------------|               |               |               |
      |<--------------| Configs dispo|               |               |               |
      |               |              |               |               |               |
      | 2. Sélectionner|             |               |               |               |
      | paramètres    |              |               |               |               |
      |-------------->|              |               |               |               |
      |               |              |               |               |               |
      | 3. Lancer     |              |               |               |               |
      | analyse       |              |               |               |               |
      |-------------->| POST /analyze|               |               |               |
      |               |------------>|               |               |               |
      |               |              |               |               |               |
      |               |      POUR CHAQUE POSTE:     |               |               |
      |               |              |               |               |               |
      |               |      selectBestForPosition()|               |               |
      |               |------------>|               |               |               |
      |               |              | getAthletesByPosition()      |               |
      |               |              |------------------------------>|               |
      |               |              |<-----------------------------athletes[]-------|
      |               |              |               |               |               |
      |               |              | POUR CHAQUE athlète:         |               |
      |               |              |  - getRecentPerformances()   |               |
      |               |              |  - calculateTechnicalScore()|               |
      |               |              |  - calculateFormScore()      |               |
      |               |              |  - calculateHealthScore()    |               |
      |               |              |  - calculateExperienceScore()|               |
      |               |              |               |               |               |
      |               |              |  predictPotential()          |               |
      |               |              |  applyWeightedFormula()       |               |
      |               |              |  rankAthletes()              |               |
      |               |              |<--------------rankedList-----------------------|
      |               |              |               |               |               |
      |               |              | buildNationalTeam()          |               |
      |               |              |------------------------------>|               |
      |               |              |               |  validateTeamConstraints()    |
      |               |              |               |  calculateSynergyMatrix()     |
      |               |              |               |  optimizeTeamComposition()    |
      |               |              |               |  selectSubstitutes()          |
      |               |              |               |  generateTeamReport()         |
      |               |              |<--------------completeTeam + cohesion---------|
      |               |<-------------selection + analytics---------------------------|
      |<--------------Visualiser équipe proposée  |               |               |
      |               |              |               |               |               |
      | 5. Explorer   |              |               |               |               |
      | détails       |              |               |               |               |
      |-------------->|              |               |               |               |
      |<--------------| Stats, radar, historique    |               |               |
      |               |              |               |               |               |
      | 6. Valider    |              |               |               |               |
      | sélection     |              |               |               |               |
      |-------------->| POST /validate               |               |               |
      |               |------------>|               |               |               |
      |               |              | generateOfficialDocument()   |               |
      |               |              | digitalSign()                 |               |
      |               |              | notifyFederation()            |               |
      |               |<-------------PDF + confirmation--------------------------------|
      |<--------------Document officiel généré     |               |               |
      |               |              |               |               |               |
```

### 3.3 Détection d'Anomalies et Alerte Dopage

```
Wearable      Biometric API       PAD Engine       AthleteSvc      Notification
  Device          |                 |                  |                |
    |             |                 |                  |                |
    | 1. Données  |                 |                  |                |
    |------------>|                 |                  |                |
    |             | INSERT metrics  |                  |                |
    |             |------DB OK---->|                  |                |
    |<------------| ACK             |                  |                |
    |             |                 |                  |                |
    |             | 2. scheduledAnalysis()            |                |
    |             |<----------------|                  |                |
    |             |                 |                  |                |
    |             | SELECT recent_data                |                |
    |             |------data[]---->|                  |                |
    |             |                 |                  |                |
    |             |      POUR CHAQUE athlète:          |                |
    |             |                 |                  |                |
    |             |                 | getHistoricalPerformance(24mois)
    |             |                 |----------------->|                |
    |             |                 |<----------------performances[]-----|
    |             |                 |                  |                |
    |             |                 | calculateMean()  |                |
    |             |                 | calculateStdDev()|                |
    |             |                 | calculateZScore()|                |
    |             |                 |                  |                |
    |             |                 |  SI |Z-Score| > 3.0:             |
    |             |                 |    ALERTE CRITIQUE               |
    |             |                 |    INSERT alert                 |
    |             |                 |    sendImmediateAlert()---------->|--Email/SMS Fed
    |             |                 |    |                            |  |-->Notif Médecin
    |             |                 |  SINON SI |Z-Score| > 2.0:       |
    |             |                 |    ALERTE ATTENTION             |
    |             |                 |    INSERT alert                 |
    |             |                 |    sendAlert()------------------->|-->Notif Médecin
    |             |                 |                  |                |
    |             |                 | Analysis complete|                |
    |             |<----------------|                  |                |
    |             |                 |                  |                |
    |             | 3. Consulter    |                  |                |
    |             | alertes         |                  |                |
    |<------------|                 |                  |                |
    |------------>|                 |                  |                |
    |             | SELECT pending  |                  |                |
    |             |------alerts[]-->|                  |                |
    |<------------|                 |                  |                |
    |             |                 |                  |                |
    | 4. Examiner |                 |                  |                |
    |------------>|                 |                  |                |
    |             | SELECT detailed_data               |                |
    |             |------full_timeline--------------->|                |
    |<------------| Graphique + données              |                |
    |             |                 |                  |                |
    | 5. Évaluation|                |                  |                |
    | médicale    |                 |                  |                |
    |             |                 |                  |                |
    | 6a. Marquer |                 |                  |                |
    | normal      |                 |                  |                |
    |------------>| 6b. Escalader  |                  |                |
    |             | investigation   |                  |                |
    |             |---------------->|                  |                |
    |             |                 | UPDATE status    |                |
    |             |                 | escalateToFed()---------------->|
    |             |                 |                  |                |-->Investigation requise
    |             |                 |                  |                |
```

### 3.4 Streaming d'un Match en Direct

```
Admin/Officiel    Dashboard      Encoder       StreamingSvc        CDN         Viewer
      |              |              |              |                 |           |
      | 1. Configurer|              |              |                 |           |
      | streaming    |              |              |                 |           |
      |------------->|              |              |                 |           |
      |              | POST /create |              |                 |           |
      |              |------------->|              |                 |           |
      |              |              | generateKey()|                 |           |
      |              |              | prepareBucket()              |           |
      |              |<-------------config ready---|                 |           |
      |<-------------Configuration prête           |                 |           |
      |              |              |              |                 |           |
      | 2. Démarrer  |              |              |                 |           |
      | diffusion    |              |              |                 |           |
      |------------->|------------>|              |                 |           |
      |              |              | RTMP ingest  |                 |           |
      |              |              |------------->|                 |           |
      |              |              |              | transcodeToHLS()|           |
      |              |              |              | pushSegments()-->|           |
      |              |              |<-------------Connected         |           |
      |              |<-------------Démarré         |                 |           |
      |<-------------Diffusion live |              |                 |           |
      |              |              |              |                 |           |
      |              |              |              |                 | 3. Ouvrir |
      |              |              |              |                 |<---------|
      |              |              |              | GET /streams/live           |
      |              |              |              |<-----------------------------|
      |              |              |              | list_streams[]  |           |
      |              |              |              |---------------------------->|
      |              |              |              |                 | Afficher  |
      |              |              |              |                 | matches   |
      |              |              |              |                 |---------->|
      |              |              |              |                 |           |
      |              |              |              |                 | 4. Sélect. |
      |              |              |              |                 |<---------|
      |              |              |              |                 | request   |
      |              |              |              |                 | Manifest()|
      |              |              |              |                 |<---------|
      |              |              |              |                 | m3u8      |
      |              |              |              |                 | playlist  |
      |              |              |              |                 |          |
      |              |              |              |                 | request  |
      |              |              |              |                 | Segment(n)|
      |              |              |              |                 |<---------|
      |              |              |              |                 | video_seg |
      |              |              |              |                 |--------->|
      |              |              |              |                 | (lecture |
      |              |              |              |                 | continue) |
      |              |              |              |                 |           |
      | 6. Terminer  |              |              |                 |           |
      | streaming    |              |              |                 |           |
      |------------->| POST /stop   |              |                 |           |
      |              |------------->|              |                 |           |
      |              |              |              | finalizeRecording()          |
      |              |              |              | moveToArchive()              |
      |              |              |              | purgeCache()---------------->|
      |              |<-------------stopped+archive_url             |           |
      |<-------------Terminé        |              |                 |           |
      |              |              |              |                 |           |
      |              |              |              |                 | 7. Replay |
      |              |              |              |                 |<---------|
      |              |              |              |                 | request   |
      |              |              |              |                 | Archive() |
      |              |              |              |                 |<---------|
      |              |              |              |                 | video_url |
      |              |              |              |                 |---------->|
      |              |              |              |                 | Lecture   |
      |              |              |              |                 | replay    |
      |              |              |              |                 |          |
```

---

## 4. Diagrammes d'Activité

### 4.1 Flux d'Inscription (Mode Online/Offline)

```
                          +-------------+
                          |   DÉBUT     |
                          +------+------+
                                 |
                                 v
                    +------------------------+
                    | Athlète ouvre app      |
                    +-----------+------------+
                                |
                                v
                    +------------------------+
                    | Connexion internet ?   |
                    +-----------+------------+
                    |                        |
                 OUI|                        |NON
                    |                        |
                    v                        v
          +-------------------+    +-------------------+
          |   MODE ONLINE     |    |   MODE OFFLINE    |
          +---------+---------+    +---------+---------+
                    |                          |
                    v                          v
          +-------------------+    +-------------------+
          | Saisir informations|    | Saisir informations|
          +---------+---------+    +---------+---------+
                    |                          |
                    v                          v
          +-------------------+    +-------------------+
          | Vérifier NIN temps|    | Stocker local     |
          | réel              |    | (SQLite chiffré)  |
          +---------+---------+    +---------+---------+
                    |                          |
                    v                          v
          +-------------------+    +-------------------+
          | Upload documents  |    | Sauvegarde        |
          | médicaux          |    | brouillon         |
          +---------+---------+    +---------+---------+
                    |                          |
                    |                          v
                    |                +-------------------+
                    |                | "Sync en attente" |
                    |                +---------+---------+
                    |                          |
                    |                          v
                    |                +-------------------+
                    |                | VÉRIFIER CONNEXION |
                    |                +---------+---------+
                    |                          |
                    |                +---------+--------+
                    |                | Connexion dispo ? |
                    |                +---------+---------+
                    |                |                   |
                    |             OUI|                   |NON (boucle)
                    |                |                   |
                    |                v                   |
                    |       +-------------------+       |
                    |       | Synchroniser      |       |
                    |       | données           |       |
                    |       +---------+---------+       |
                    |                 |                 |
                    +-----------------+-----------------+
                                      |
                                      v
                         +------------------------+
                         | Soumettre demande      |
                         | licence                |
                         +-----------+------------+
                                     |
                                     v
                         +------------------------+
                         | Générer QR Code        |
                         +-----------+------------+
                                     |
                                     v
                         +------------------------+
                         | Archivage blockchain   |
                         +-----------+------------+
                                     |
                                     v
                         +------------------------+
                         | Notification confirm.  |
                         +-----------+------------+
                                     |
                                     v
                               +---------+
                               |   FIN   |
                               +---------+
```

### 4.2 Processus de Détection de Talent

```
                          +-------------+
                          |   DÉBUT     |
                          +------+------+
                                 |
                                 v
                    +------------------------+
                    | Scout sur terrain      |
                    +-----------+------------+
                                |
                                v
                    +------------------------+
                    | Observation athlète      |
                    +-----------+------------+
                                |
                                v
                    +------------------------+
                    | App mobile ?           |
                    +-----------+------------+
                    |                        |
                 OUI|                        |NON
                    |                        |
                    v                        v
          +-------------------+    +-------------------+
          | Ouvrir formulaire |    | Formulaire papier |
          | évaluation        |    +---------+---------+
          +---------+---------+              |
                    |                        v
                    |              +-------------------+
                    |              | Saisie ultérieure |
                    |              +---------+---------+
                    |                        |
                    +------------+-----------+
                                 |
                                 v
                    +------------------------+
                    | Connexion ?            |
                    +-----------+------------+
                    |                        |
                 OUI|                        |NON
                    |                        |
                    v                        v
          +-------------------+    +-------------------+
          | Envoi immédiat    |    | Stockage local    |
          +---------+---------+    | Sync différée     |
                    |              +---------+---------+
                    |                        |
                    +------------+-----------+
                                 |
                                 v
                    +------------------------+
                    | Agrégation données     |
                    +-----------+------------+
                                |
                                v
                    +------------------------+
                    | Algorithme TSS         |
                    | exécuté                |
                    +-----------+------------+
                                |
                                v
                    +------------------------+
                    | Score > 85 ?           |
                    +-----------+------------+
                    |                        |
                 OUI|                        |NON
                    |                        |
                    v                        v
          +-------------------+    +-------------------+
          | TALENT ELITE      |    | Score > 70 ?      |
          | #LightGreen       |    +---------+---------+
          |                   |              |          |
          | • Alerte immédi.  |           OUI|          |NON
          | • Notif CNOM      |              |          |
          | • Notif Fédér.  |              v          v
          | • Fiche priori. |    +----------------+  +----------------+
          +---------+---------+    | TALENT PROMET. |  | Score > 55 ?   |
                    |              | #LightBlue     |  +--------+-------+
                    |              | • Alerte std   |           |
                    |              | • Suivi activé |        OUI|    |NON
                    |              +--------+-------+           |    |
                    |                       |                    |    |
                    |                       v                    |    v
                    |            +----------------+   +----------------+
                    |            |   À SUIVRE       |   |    STANDARD    |
                    |            |   #LightYellow   |   |    #LightGray  |
                    |            | • Archivage      |   | • Données OK   |
                    |            +--------+---------+   +--------+-------+
                    |                     |                      |
                    |                     |                      |
                    +----------+----------+----------------------+
                               |
                               v
                    +------------------------+
                    | Mise à jour tableau    |
                    | de bord                |
                    +-----------+------------+
                                |
                                v
                    +------------------------+
                    | Suivi longitudinal     |
                    | activé               |
                    +-----------+------------+
                                |
                                v
                          +---------+
                          |   FIN   |
                          +---------+
```

### 4.3 Algorithme PBSA - Calcul Score Joueur

```
                          +----------------+
                          |    DÉBUT       |
                          | PBSA Algorithm |
                          +-------+--------+
                                  |
                                  v
                    +---------------------------+
                    | ENTRÉES:                  |
                    | sport_id, poste, saison   |
                    +------------+--------------+
                                 |
                                 v
                    +---------------------------+
                    | Charger config poids poste|
                    +------------+--------------+
                                 |
                                 v
                    +---------------------------+
                    | Filtrer athlètes actifs   |
                    +------------+--------------+
                                 |
                                 v
                    +---------------------------+
                    | Initialiser liste scores |
                    +------------+--------------+
                                 |
                                 v
                    +---------------------------+
                    | POUR CHAQUE joueur        |
                    +------------+--------------+
                                 |
            +--------------------+--------------------+
            |                    |                    |
            v                    v                    v
    +----------------+   +----------------+   +----------------+
    | Calculer       |   | Récupérer      |   | Compter        |
    | SCORE_TECHNIQUE|   | performances   |   | blessures      |
    |                |   | 30 jours       |   | saison         |
    | SOMME(stat[k]  |   +--------+-------+   +--------+-------+
    | * poids[k])    |            |                    |
    +--------+-------+            v                    v
             |            +----------------+   +----------------+
             |            | Calculer       |   | Calculer       |
             |            | SCORE_FORME    |   | SCORE_SANTÉ    |
             |            |                |   |                |
             |            | MOYENNE(perf)  |   | 1 - (nb * 0.05)|
             |            +--------+-------+   +--------+-------+
             |                     |                    |
             |                     v                    v
             |            +----------------+   +----------------+
             |            | Compter matchs |   | Calculer       |
             |            | joués          |   | SCORE_EXP      |
             |            +--------+-------+   | LOG(nb+1)*0.10|
             |                     |           +--------+-------+
             |                     |                    |
             |                     +---------+----------+
             |                               |
             |                               v
             |                    +------------------------+
             |                    | Calculer SCORE_FINAL   |
             |                    |                        |
             |                    | (tech*0.50)+(form*0.25)|
             |                    | +(santé*0.15)+(exp*0.10)
             |                    +--------+---------------+
             |                             |
             +-------------+---------------+
                           |
                           v
              +---------------------------+
              | Ajouter à liste résultats|
              +------------+--------------+
                           |
                           v
                +--------------------+
                | Tous traités ?     |
                +---------+----------+
                |         |
             NON|         |OUI
                |         |
                +---------+
                          |
                          v
              +---------------------------+
              | Trier par score DESC      |
              +------------+--------------+
                           |
                           v
              +---------------------------+
              | Identifier joueur         |
              | exemplaire                |
              +------------+--------------+
                           |
                           v
              +---------------------------+
              | Générer rapport détaillé  |
              +------------+--------------+
                           |
                           v
              +---------------------------+
              | RETOURNER:                |
              | • classement              |
              | • sélection               |
              +------------+--------------+
                           |
                           v
                     +-----------+
                     |    FIN    |
                     +-----------+
```

---

## 5. Diagrammes de Déploiement

### 5.1 Architecture Cloud AWS

```
                              +------------------+
                              |    INTERNET      |
                              +--------+---------+
                                       |
                              +--------v---------+
                              |   Route 53 DNS   |
                              +--------+---------+
                                       |
                    +------------------+------------------+
                    |                  |                  |
                    v                  v                  v
           +--------+-------+ +--------+-------+ +--------+-------+
           |  AWS WAF       | |  AWS Shield    | |  AWS ACM       |
           |  Firewall      | |  DDoS Protect  | |  SSL/TLS       |
           +--------+-------+ +--------+-------+ +--------+-------+
                    |                  |                  |
                    +------------------+------------------+
                                       |
                    +------------------v------------------+
                    |         CloudFront CDN              |
                    |     (Edge Locations Afrique)      |
                    +------------------+------------------+
                                       |
                                       v
                    +--------------------------------------+
                    |      VPC SPORT-CONNECT               |
                    |  +--------------------------------+  |
                    |  |     Public Subnet (ALB)        |  |
                    |  |  +--------------------------+    |  |
                    |  |  | Application Load Balancer|    |  |
                    |  |  +------------+-------------+    |  |
                    |  |               |                 |  |
                    |  +---------------|----------------+  |
                    |                  |                    |
                    |  +---------------v----------------+  |
                    |  |  Private Subnet - App Tier    |  |
                    |  |  +------------------------+    |  |
                    |  |  |   EKS / ECS Cluster    |    |  |
                    |  |  |  +------------------+  |    |  |
                    |  |  |  | API Gateway Pod  |  |    |  |
                    |  |  |  | Identity Pod     |  |    |  |
                    |  |  |  | Athlete Pod      |  |    |  |
                    |  |  |  | License Pod      |  |    |  |
                    |  |  |  | Competition Pod  |  |    |  |
                    |  |  |  | SMART SQUAD Pod  |  |    |  |
                    |  |  |  | Media Pod        |  |    |  |
                    |  |  |  +------------------+  |    |  |
                    |  |  +------------------------+    |  |
                    |  +---------------|----------------+  |
                    |                  |                    |
                    |  +---------------v----------------+  |
                    |  |  Private Subnet - Data Tier   |  |
                    |  |  +------------------------+    |  |
                    |  |  | RDS PostgreSQL Multi-AZ|    |  |
                    |  |  | ElastiCache Redis      |    |  |
                    |  |  | DocumentDB (MongoDB)   |    |  |
                    |  |  | Timestream IoT         |    |  |
                    |  |  | OpenSearch             |    |  |
                    |  |  +------------------------+    |  |
                    |  +--------------------------------+  |
                    |                                      |
                    |  +--------------------------------+  |
                    |  |  Private Subnet - AI/ML Tier   |  |
                    |  |  +------------------------+    |  |
                    |  |  | SageMaker Endpoints    |    |  |
                    |  |  | EC2 GPU Instances      |    |  |
                    |  |  +------------------------+    |  |
                    |  +--------------------------------+  |
                    |                                      |
                    |  +--------------------------------+  |
                    |  |  Private Subnet - Storage     |  |
                    |  |  +------------------------+    |  |
                    |  |  | S3 Bucket Vidéos       |    |  |
                    |  |  | S3 Glacier Archives    |    |  |
                    |  |  | EFS Fichiers partagés  |    |  |
                    |  |  +------------------------+    |  |
                    |  +--------------------------------+  |
                    +--------------------------------------+
                                       |
                    +------------------+-------------------+
                    |                  |                   |
                    v                  v                   v
           +--------+-------+ +--------+-------+ +--------+-------+
           |    AWS KMS     | | Secrets Manager| | CloudTrail     |
           |  (Chiffrement) | | (Credentials)  | | (Audit Logs)   |
           +----------------+ +----------------+ +----------------+

           +------------------------------------------------------+
           |           PARTENAIRES EXTERNES                       |
           |  +---------------+ +---------------+ +--------------+|
           |  | Mobile Money  | | Fédérations   | |    CNOM      ||
           |  | Mvola/Airtel  | | Internationales| |              ||
           |  | Orange        | |               | |              ||
           |  +---------------+ +---------------+ +--------------+|
           +------------------------------------------------------+
```

### 5.2 Architecture Microservices

```
    +----------------+      +----------------+      +----------------+
    |   APP MOBILE   |      |  DASHBOARD WEB |      | STREAMING PORTAL|
    |  React Native  |      |   React.js     |      |   Next.js       |
    +-------+--------+      +--------+-------+      +--------+--------+
            |                        |                       |
            +------------------------+-----------------------+
                                     |
                         +-----------v-----------+
                         |    API GATEWAY        |
                         |    (Kong/AWS API GW)  |
                         +-----------+-----------+
                                     |
            +------------------------v------------------------+
            |                                                   |
    +-------v-------+ +-------v-------+ +-------v-------+ +-----v-----+
    |  CORE SERVICES| | ADVANCED SVC  | |  AI/ML SVC    | | INFRA SVC |
    +---------------+ +---------------+ +---------------+ +-----------+
    |• Identity Svc | |• Scouting Svc | |• ML Inference | |• Auth Svc |
    |• Athlete Svc   | |• SMART SQUAD  | |• Anomaly Det. | |• Notify   |
    |• License Svc   | |• Health Svc   | |• Recommend.   | |• Search   |
    |• Competition   | |• Media Svc    | |               | |• Blockchain|
    |• Payment Svc   | |• Streaming Svc| |               | |• File Sto.|
    +-------+-------+ +-------+-------+ +-------+-------+ +-----+-----+
            |                |                |                |
            +----------------+----------------+----------------+
                                     |
                         +-----------v-----------+
                         |    DATA LAYER           |
                         +-----------------------+
                         |  • PostgreSQL (RDS)   |
                         |  • MongoDB (DocDB)    |
                         |  • Redis (ElastiCache)|
                         |  • InfluxDB (Time)    |
                         |  • S3 (Files)         |
                         +-----------------------+
                                     |
            +------------------------v------------------------+
            |                                                   |
    +-------v-------+ +-------v-------+ +-------v-------+ +-----v-----+
    |  MOBILE MONEY | |  SMS GATEWAY  | |  EMAIL SVC    | |  MAPS/GPS |
    +---------------+ +---------------+ +---------------+ +-----------+
    |• Mvola API    | |• Twilio       | |• SendGrid     | |• Google   |
    |• Airtel Money | |               | |               | |  Maps     |
    |• Orange Money | |               | |               | |          |
    +---------------+ +---------------+ +---------------+ +-----------+
```

---

## 6. Modèle Entité-Relation

### 6.1 Schéma Simplifié des Tables Principales

```
+----------------+         +----------------+         +----------------+
|     user       |         |    athlete     |         |    coach       |
+================+         +================+         +================+
| PK id          |<|-------| PK user_id     |         | PK user_id     |
|    email       |         |    first_name  |         |    first_name  |
|    password_   |         |    last_name   |         |    last_name   |
|    hash        |         |    birth_date  |         |    specializ.  |
|    nin (UQ)    |         |    height      |         |    experience  |
|    phone       |         |    weight      |         +----------------+
|    role        |         | FK current_club|
|    is_active   |         +----------------+
|    created_at  |                |
+----------------+                |
                                  |
                                  v
+----------------+         +----------------+         +----------------+
|   federation   |         |     club       |         |    license     |
+================+         +================+         +================+
| PK id          |<|------| PK id          |<|------| PK id          |
|    name        |         | FK federation_ |         | FK athlete_id  |
|    sport_type  |         |    id          |         | FK federation_|
|    acronym     |         |    name        |         |    id          |
|    president   |         |    founded_date|         | FK club_id     |
+----------------+         |    is_profess. |         |    season      |
                           +----------------+         |    status      |
                                                        |    qr_code     |
                                                        |    issue_date  |
                                                        |    expiry_date |
                                                        +----------------+
                                                                  |
                                                                  |
                                                                  v
+----------------+         +----------------+         +----------------+
|   competition  |         |     match      |         |   performance  |
+================+         +================+         +================+
| PK id          |<|------| PK id          |<|------| PK id          |
| FK federation_ |         | FK competition |         | FK athlete_id  |
|    id          |         |    _id         |         | FK match_id    |
|    name        |         |    round       |         |    date        |
|    season      |         |    scheduled_  |         |    metrics     |
|    start_date  |         |    date        |         |    overall_    |
|    end_date    |         |    venue       |         |    score       |
|    status      |         |    status      |         +----------------+
+----------------+         +----------------+

+----------------+         +----------------+         +----------------+
| talent_eval.   |         | smart_squad_   |         | selected_      |
|                |         | selection      |         | player         |
+================+         +================+         +================+
| PK id          |         | PK id          |<|------| PK selection_id|
| FK athlete_id  |         |    type        |         | PK athlete_id  |
| FK scout_id    |         |    sport_type  |         |    position    |
|    eval_date   |         |    formation   |         |    is_starter  |
|    scores      |         |    season      |         |    score       |
|    overall_    |         |    generated_at|         +----------------+
|    score       |         |    status      |
|    potential   |         +----------------+
+----------------+

+----------------+         +----------------+         +----------------+
| medical_record |         |  biometric_    |         |    injury      |
|                |         |  data          |         |                |
+================+         +================+         +================+
| PK id          |         | PK id          |         | PK id          |
| FK athlete_id  |         | FK athlete_id  |         | FK medical_    |
| FK doctor_id   |         |    recorded_at |         |    record_id   |
|    diagnosis   |         |    vo2_max     |         |    type        |
|    treatment   |         |    heart_rate  |         |    body_part   |
|    clearance   |         |    gps_data    |         |    severity    |
|    is_confid.  |         |    sleep_qual. |         |    occurred_dt |
+----------------+         +----------------+         |    is_recurring|
                                                      +----------------+

+----------------+         +----------------+         +----------------+
|    payment     |         |    stream      |         |  subscription  |
|                |         |                |         |                |
+================+         +================+         +================+
| PK id          |         | PK id          |         | PK id          |
| FK license_id  |         | FK competition |         | FK user_id     |
|    amount      |         |    _id         |         |    type        |
|    provider    |         | FK match_id    |         |    start_date  |
|    status      |         |    title       |         |    end_date    |
|    receipt_url |         |    stream_url  |         |    amount      |
+----------------+         |    start_time  |         |    is_active   |
                           |    end_time    |         +----------------+
                           |    status      |
                           +----------------+

LÉGENDE:
--------
PK  = Primary Key
FK  = Foreign Key
UQ  = Unique
<|--| = One-to-Many relationship
```

### 6.2 Relations et Cardinalités

```
    +--------------+                +--------------+
    |     USER     |                |   FEDERATION |
    |   (1..1)     |                |   (1..*)     |
    +------+-------+                +-------+------+
           |                                |
           | 1..1                           | 1..*
           |                                |
           v                                v
    +--------------+                +--------------+
    |    ATHLETE   |<---------------|     CLUB     |
    |   (0..*)     |     0..1       |   (0..*)     |
    +------+-------+                +--------------+
           |
           | 0..*
           |
           |     +-------------------+   +------------------+
           |     |      LICENSE      |   |  SMART_SQUAD_SEL |
           +---->|      (0..*)       |   |     (0..*)       |
                 +-------------------+   +---------+--------+
                 |  - athlete_id FK  |             |
                 |  - federation_id  |             | 1..*
                 |  - club_id FK     |             |
                 +-------------------+             v
                                                 +------------------+
                                                 |  SELECTED_PLAYER |
                                                 |     (0..*)       |
                                                 +------------------+
                                                 | - selection_id FK
                                                 | - athlete_id FK  |
                                                 +------------------+

    +--------------+                +--------------+
    |  COMPETITION |<---------------|     MATCH    |
    |   (1..*)     |     1..*       |   (0..*)     |
    +--------------+                +--------------+
                                           |
                                           | 1..*
                                           |
                                           v
                                    +--------------+
                                    |  PERFORMANCE |
                                    |   (0..*)     |
                                    +--------------+
                                    | - match_id FK|
                                    | - athlete_id |
                                    +--------------+

    CARDINALITÉS PRINCIPALES:
    -------------------------
    • 1 User ---------- 0..1 Athlete      (Un user peut être un athlète)
    • 1 Federation ---- 0..* Clubs        (Une fédération a plusieurs clubs)
    • 1 Club ---------- 0..* Athletes     (Un club emploie plusieurs athlètes)
    • 1 Athlete ------- 0..* Licenses     (Un athlète a plusieurs licences/saisons)
    • 1 Federation ---- 0..* Competitions (Une fédération organise des compétitions)
    • 1 Competition --- 0..* Matches      (Une compétition a plusieurs matchs)
    • 1 Match --------- 0..* Performances (Un match génère plusieurs performances)
    • 1 Athlete ------- 0..* Evaluations  (Un athlète est évalué plusieurs fois)
    • 1 Athlete ------- 0..* BiometricData (Données biométriques multiples)
```

---

## Références

- **Cahier des Charges**: SPORT CONNECT - L'Écosystème Numérique du Sport Malgache (Mars 2025)
- **Module SMART SQUAD**: Sélection nationale par poste avec IA (PBSA/NTBA)
- **Budget**: 8.04 Md MGA (~1.8M USD)
- **Volume**: 153 KLOC, 742 Person-Months
- **Horizon**: 2025-2035

---

*Document ASCII Art généré pour le projet SPORT CONNECT*
*Auteur: RANDRIANIRINA Harena Eric Miaritsoa - SE20240079*
