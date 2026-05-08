-- Insérer un athlète de test dans la base de données

-- D'abord, insérer dans la table users
-- Mot de passe: Password123! (hashé avec bcrypt)
INSERT INTO users (email, nin, password, role, is_active, created_at, updated_at)
VALUES (
    'test.athlete@example.com',
    '1234567890123',
    '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
    'athlete',
    true,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
) RETURNING id;

-- Ensuite, insérer dans la table athletes avec l'ID de l'utilisateur
-- Remplacez 'USER_ID' par l'ID retourné par la commande précédente
INSERT INTO athletes (user_id, first_name, last_name, birth_date, gender, height, weight, sport_type, position, created_at, updated_at)
VALUES (
    (SELECT id FROM users WHERE email = 'test.athlete@example.com'),
    'Jean',
    'Rakoto',
    '1995-05-15',
    'M',
    175,
    70,
    'Athlétisme',
    'Sprint',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- Vérification
SELECT u.id, u.email, u.role, a.first_name, a.last_name
FROM users u
JOIN athletes a ON u.id = a.user_id
WHERE u.email = 'test.athlete@example.com';
