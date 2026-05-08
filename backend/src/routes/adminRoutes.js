const express = require('express');
const { body, param, query, validationResult } = require('express-validator');
const {
  getAllUsers,
  getUserById,
  createUser,
  updateUser,
  deleteUser,
  resetPassword,
  getSystemStats,
  getAuditLogs,
  getRoles,
  updateRolePermissions,
  bulkOperation
} = require('../controllers/adminController');
const { auth, checkRole, checkAdminLevel, checkPermission, auditLog } = require('../middleware/auth');

const router = express.Router();

// Validation middleware helper
const handleValidationErrors = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({
      success: false,
      message: 'Erreur de validation',
      errors: errors.array().map(err => ({
        field: err.path,
        message: err.msg
      }))
    });
  }
  next();
};

// All routes require authentication
router.use(auth);

// ==================== USER MANAGEMENT ====================

// Get all users with filtering
router.get('/users',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    query('page').optional().isInt({ min: 1 }).withMessage('Page doit être un entier positif'),
    query('limit').optional().isInt({ min: 1, max: 100 }).withMessage('Limit doit être entre 1 et 100'),
    query('role').optional().isIn(['ATHLETE', 'COACH', 'SCOUT', 'DOCTOR', 'ADMIN', 'ADMIN_FEDERATION', 'OFFICIAL', 'SELECTIONNEUR', 'FAN']),
    handleValidationErrors
  ],
  auditLog('VIEW', 'USERS'),
  getAllUsers
);

// Get user by ID
router.get('/users/:id',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    param('id').isUUID().withMessage('ID utilisateur invalide'),
    handleValidationErrors
  ],
  auditLog('VIEW', 'USER'),
  getUserById
);

// Create new user
router.post('/users',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  checkAdminLevel('SUPER', 'SYSTEM', 'FEDERATION'),
  [
    body('email').isEmail().normalizeEmail().withMessage('Email invalide'),
    body('nin').trim().notEmpty().withMessage('NIN est requis'),
    body('password').isLength({ min: 8 }).withMessage('Le mot de passe doit contenir au moins 8 caractères'),
    body('role').isIn(['ATHLETE', 'COACH', 'SCOUT', 'DOCTOR', 'ADMIN', 'ADMIN_FEDERATION', 'OFFICIAL']),
    body('firstName').trim().notEmpty().withMessage('Prénom est requis'),
    body('lastName').trim().notEmpty().withMessage('Nom est requis'),
    body('phone').optional().trim(),
    handleValidationErrors
  ],
  auditLog('CREATE', 'USER'),
  createUser
);

// Update user
router.put('/users/:id',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    param('id').isUUID().withMessage('ID utilisateur invalide'),
    body('email').optional().isEmail().normalizeEmail(),
    body('phone').optional().trim(),
    body('isActive').optional().isBoolean(),
    body('firstName').optional().trim(),
    body('lastName').optional().trim(),
    handleValidationErrors
  ],
  auditLog('UPDATE', 'USER'),
  updateUser
);

// Delete/deactivate user
router.delete('/users/:id',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    param('id').isUUID().withMessage('ID utilisateur invalide'),
    query('permanent').optional().isBoolean(),
    handleValidationErrors
  ],
  auditLog('DELETE', 'USER'),
  deleteUser
);

// Reset user password
router.post('/users/:id/reset-password',
  checkRole('ADMIN', 'SYS_ADMIN'),
  [
    param('id').isUUID().withMessage('ID utilisateur invalide'),
    body('newPassword').isLength({ min: 8 }).withMessage('Le mot de passe doit contenir au moins 8 caractères'),
    handleValidationErrors
  ],
  auditLog('RESET_PASSWORD', 'USER'),
  resetPassword
);

// Bulk user operations
router.post('/users/bulk',
  checkRole('ADMIN', 'SYS_ADMIN'),
  checkAdminLevel('SUPER', 'SYSTEM'),
  [
    body('operation').isIn(['activate', 'deactivate', 'delete']).withMessage('Opération invalide'),
    body('userIds').isArray({ min: 1 }).withMessage('Liste d\'utilisateurs requise'),
    body('userIds.*').isUUID().withMessage('ID utilisateur invalide'),
    handleValidationErrors
  ],
  auditLog('BULK_OPERATION', 'USERS'),
  bulkOperation
);

// ==================== SYSTEM ADMINISTRATION ====================

// Get system statistics
router.get('/stats',
  checkRole('ADMIN', 'SYS_ADMIN'),
  auditLog('VIEW', 'SYSTEM_STATS'),
  getSystemStats
);

// Get audit logs
router.get('/audit-logs',
  checkRole('ADMIN', 'SYS_ADMIN'),
  [
    query('page').optional().isInt({ min: 1 }),
    query('limit').optional().isInt({ min: 1, max: 100 }),
    query('userId').optional().isUUID(),
    query('action').optional().trim(),
    query('entityType').optional().trim(),
    query('startDate').optional().isISO8601(),
    query('endDate').optional().isISO8601(),
    handleValidationErrors
  ],
  auditLog('VIEW', 'AUDIT_LOGS'),
  getAuditLogs
);

// ==================== ROLE & PERMISSION MANAGEMENT ====================

// Get all roles with permissions
router.get('/roles',
  checkRole('ADMIN', 'SYS_ADMIN'),
  checkAdminLevel('SUPER', 'SYSTEM'),
  getRoles
);

// Update role permissions
router.put('/roles/:roleId/permissions',
  checkRole('ADMIN', 'SYS_ADMIN'),
  checkAdminLevel('SUPER', 'SYSTEM'),
  [
    param('roleId').isInt().withMessage('ID rôle invalide'),
    body('permissions').isArray().withMessage('Permissions doit être un tableau'),
    handleValidationErrors
  ],
  auditLog('UPDATE', 'ROLE_PERMISSIONS'),
  updateRolePermissions
);

module.exports = router;
