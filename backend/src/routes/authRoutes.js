const express = require('express');
const { body, validationResult } = require('express-validator');
const { register, login, getProfile } = require('../controllers/authController');
const auth = require('../middleware/auth');

const router = express.Router();

// Validation middleware
const validateRegister = [
  body('firstname').trim().notEmpty().withMessage('Le prénom est requis'),
  body('lastname').trim().notEmpty().withMessage('Le nom est requis'),
  body('email').isEmail().normalizeEmail().withMessage('Email invalide'),
  body('nin').trim().notEmpty().withMessage('Le NIN est requis'),
  body('phone').trim().notEmpty().withMessage('Le téléphone est requis'),
  body('password').isLength({ min: 8 }).withMessage('Le mot de passe doit contenir au moins 8 caractères'),
  body('role').isIn(['athlete', 'coach', 'federation', 'admin', 'ATHLETE', 'COACH', 'ADMIN_FEDERATION', 'ADMIN']).withMessage('Rôle invalide'),
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        success: false,
        message: 'Erreur de validation',
        errors: errors.array().map(err => err.msg)
      });
    }
    next();
  }
];

// Validation middleware for login
const validateLogin = [
  body('username').trim().notEmpty().withMessage('Email/NIN est requis'),
  body('password').notEmpty().withMessage('Le mot de passe est requis'),
  body('role').isIn(['athlete', 'coach', 'federation', 'admin', 'ATHLETE', 'COACH', 'ADMIN_FEDERATION', 'ADMIN']).withMessage('Rôle invalide'),
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        success: false,
        message: 'Erreur de validation',
        errors: errors.array().map(err => err.msg)
      });
    }
    next();
  }
];

// Routes
router.post('/register', validateRegister, register);
router.post('/login', validateLogin, login);
router.get('/profile', auth, getProfile);

module.exports = router;