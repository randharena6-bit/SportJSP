const pool = require('../config/db');
const jwt = require('jsonwebtoken');
const { comparePassword, hashPassword } = require('../utils/passwordUtils');
require('dotenv').config();

// Generate JWT Token
const generateToken = (userId, role) => {
  return jwt.sign(
    { userId, role },
    process.env.JWT_SECRET,
    { expiresIn: process.env.JWT_EXPIRE }
  );
};

// Register a new user
exports.register = async (req, res) => {
  try {
    const { firstname, lastname, email, nin, phone, password, confirmPassword, role } = req.body;

    // Validation
    if (!firstname || !lastname || !email || !nin || !phone || !password) {
      return res.status(400).json({
        success: false,
        message: 'Tous les champs sont obligatoires'
      });
    }

    if (password !== confirmPassword) {
      return res.status(400).json({
        success: false,
        message: 'Les mots de passe ne correspondent pas'
      });
    }

    if (password.length < 8) {
      return res.status(400).json({
        success: false,
        message: 'Le mot de passe doit contenir au moins 8 caractères'
      });
    }

    // Check if user already exists by email or NIN
    const existingUser = await pool.query(
      'SELECT id FROM users WHERE email = $1 OR nin = $2',
      [email, nin]
    );

    if (existingUser.rows.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Un utilisateur avec cet email ou NIN existe déjà'
      });
    }

    // Hash password
    const hashedPassword = await hashPassword(password);

    // Start transaction
    const client = await pool.connect();
    try {
      await client.query('BEGIN');

      // Insert user
      const userResult = await client.query(
        `INSERT INTO users (email, nin, password, role, is_active, created_at, updated_at)
         VALUES ($1, $2, $3, $4, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
         RETURNING id, email, role`,
        [email, nin, hashedPassword, role]
      );

      const userId = userResult.rows[0].id;

      // Insert role-specific profile based on role
      if (role === 'athlete') {
        await client.query(
          `INSERT INTO athletes (user_id, first_name, last_name, birth_date, gender, created_at, updated_at)
           VALUES ($1, $2, $3, NULL, 'M', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`,
          [userId, firstname, lastname]
        );
      } else if (role === 'coach') {
        await client.query(
          `INSERT INTO coaches (user_id, first_name, last_name, specialization, created_at, updated_at)
           VALUES ($1, $2, $3, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`,
          [userId, firstname, lastname]
        );
      } else if (role === 'federation') {
        await client.query(
          `INSERT INTO federation_admins (user_id, first_name, last_name, created_at, updated_at)
           VALUES ($1, $2, $3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`,
          [userId, firstname, lastname]
        );
      } else if (role === 'admin') {
        await client.query(
          `INSERT INTO admins (user_id, first_name, last_name, created_at, updated_at)
           VALUES ($1, $2, $3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`,
          [userId, firstname, lastname]
        );
      }

      await client.query('COMMIT');

      // Generate token
      const token = generateToken(userId, role);

      res.status(201).json({
        success: true,
        message: 'Compte créé avec succès',
        token,
        user: {
          id: userId,
          email: email,
          role: role,
          firstname: firstname,
          lastname: lastname
        }
      });

    } catch (error) {
      await client.query('ROLLBACK');
      throw error;
    } finally {
      client.release();
    }

  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la création du compte'
    });
  }
};

// Login user
exports.login = async (req, res) => {
  try {
    const { username, password, role } = req.body;

    // Validation
    if (!username || !password) {
      return res.status(400).json({
        success: false,
        message: 'Email/NIN et mot de passe sont obligatoires'
      });
    }

    // Find user by email or NIN
    const userResult = await pool.query(
      `SELECT u.id, u.email, u.nin, u.password, u.role, u.is_active,
              CASE 
                WHEN u.role = 'athlete' THEN a.first_name
                WHEN u.role = 'coach' THEN c.first_name
                WHEN u.role = 'federation' THEN f.first_name
                WHEN u.role = 'admin' THEN ad.first_name
              END as firstname,
              CASE 
                WHEN u.role = 'athlete' THEN a.last_name
                WHEN u.role = 'coach' THEN c.last_name
                WHEN u.role = 'federation' THEN f.last_name
                WHEN u.role = 'admin' THEN ad.last_name
              END as lastname
       FROM users u
       LEFT JOIN athletes a ON u.id = a.user_id AND u.role = 'athlete'
       LEFT JOIN coaches c ON u.id = c.user_id AND u.role = 'coach'
       LEFT JOIN federation_admins f ON u.id = f.user_id AND u.role = 'federation'
       LEFT JOIN admins ad ON u.id = ad.user_id AND u.role = 'admin'
       WHERE (u.email = $1 OR u.nin = $1) AND u.role = $2`,
      [username, role]
    );

    if (userResult.rows.length === 0) {
      return res.status(401).json({
        success: false,
        message: 'Identifiants invalides'
      });
    }

    const user = userResult.rows[0];

    // Check if user is active
    if (!user.is_active) {
      return res.status(401).json({
        success: false,
        message: 'Compte désactivé. Contactez l\'administrateur.'
      });
    }

    // Verify password
    const isValidPassword = await comparePassword(password, user.password);

    if (!isValidPassword) {
      return res.status(401).json({
        success: false,
        message: 'Identifiants invalides'
      });
    }

    // Generate token
    const token = generateToken(user.id, user.role);

    res.status(200).json({
      success: true,
      message: 'Connexion réussie',
      token,
      user: {
        id: user.id,
        email: user.email,
        role: user.role,
        firstname: user.firstname,
        lastname: user.lastname
      }
    });

  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la connexion'
    });
  }
};

// Get current user profile
exports.getProfile = async (req, res) => {
  try {
    const userId = req.user.userId;
    const role = req.user.role;

    let profileQuery;
    let queryParams = [userId];

    if (role === 'athlete') {
      profileQuery = `
        SELECT u.id, u.email, u.role, u.nin, u.created_at,
               a.first_name, a.last_name, a.birth_date, a.gender, a.height, a.weight,
               a.sport_type, a.position, a.photo_url
        FROM users u
        JOIN athletes a ON u.id = a.user_id
        WHERE u.id = $1
      `;
    } else if (role === 'coach') {
      profileQuery = `
        SELECT u.id, u.email, u.role, u.nin, u.created_at,
               c.first_name, c.last_name, c.specialization, c.phone, c.photo_url
        FROM users u
        JOIN coaches c ON u.id = c.user_id
        WHERE u.id = $1
      `;
    } else if (role === 'federation') {
      profileQuery = `
        SELECT u.id, u.email, u.role, u.nin, u.created_at,
               f.first_name, f.last_name, f.phone, f.photo_url
        FROM users u
        JOIN federation_admins f ON u.id = f.user_id
        WHERE u.id = $1
      `;
    } else if (role === 'admin') {
      profileQuery = `
        SELECT u.id, u.email, u.role, u.nin, u.created_at,
               a.first_name, a.last_name, a.phone, a.photo_url
        FROM users u
        JOIN admins a ON u.id = a.user_id
        WHERE u.id = $1
      `;
    }

    const result = await pool.query(profileQuery, queryParams);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Profil non trouvé'
      });
    }

    res.status(200).json({
      success: true,
      user: result.rows[0]
    });

  } catch (error) {
    console.error('Get profile error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération du profil'
    });
  }
};
