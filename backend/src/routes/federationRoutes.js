const express = require('express');
const { body, param, query, validationResult } = require('express-validator');
const {
  getAllFederations,
  getFederationById,
  createFederation,
  updateFederation,
  deleteFederation,
  getAllClubs,
  getClubById,
  createClub,
  updateClub,
  deleteClub,
  getAllLicenses,
  getLicenseById,
  createLicense,
  approveLicense,
  rejectLicense,
  suspendLicense,
  verifyLicenseQR,
  getFederationStats,
  getFederationDashboard,
  getFederationAthletes,
  getFederationFinances
} = require('../controllers/federationController');
const { auth, checkRole, checkAdminLevel, checkFederationAccess, auditLog } = require('../middleware/auth');

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

// ==================== FEDERATION MANAGEMENT ====================

// Get all federations
router.get('/',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    query('page').optional().isInt({ min: 1 }),
    query('limit').optional().isInt({ min: 1, max: 100 }),
    query('isActive').optional().isBoolean(),
    query('search').optional().trim(),
    handleValidationErrors
  ],
  getAllFederations
);

// Get federation by ID
router.get('/:id',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    param('id').isUUID().withMessage('ID fédération invalide'),
    handleValidationErrors
  ],
  getFederationById
);

// Create federation (Super/System admin only)
router.post('/',
  checkRole('ADMIN', 'SYS_ADMIN'),
  checkAdminLevel('SUPER', 'SYSTEM'),
  [
    body('name').trim().notEmpty().withMessage('Le nom est requis'),
    body('sportType').trim().notEmpty().withMessage('Le type de sport est requis'),
    body('acronym').trim().notEmpty().withMessage('L\'acronyme est requis'),
    body('description').optional().trim(),
    body('presidentName').optional().trim(),
    body('contactEmail').optional().isEmail().normalizeEmail(),
    body('contactPhone').optional().trim(),
    body('address').optional().trim(),
    body('logoUrl').optional().trim().isURL(),
    handleValidationErrors
  ],
  auditLog('CREATE', 'FEDERATION'),
  createFederation
);

// Update federation
router.put('/:id',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  checkAdminLevel('SUPER', 'SYSTEM', 'FEDERATION'),
  [
    param('id').isUUID().withMessage('ID fédération invalide'),
    body('name').optional().trim(),
    body('sportType').optional().trim(),
    body('acronym').optional().trim(),
    body('description').optional().trim(),
    body('presidentName').optional().trim(),
    body('contactEmail').optional().isEmail().normalizeEmail(),
    body('contactPhone').optional().trim(),
    body('address').optional().trim(),
    body('logoUrl').optional().trim().isURL(),
    body('isActive').optional().isBoolean(),
    handleValidationErrors
  ],
  auditLog('UPDATE', 'FEDERATION'),
  updateFederation
);

// Delete federation (Super admin only)
router.delete('/:id',
  checkRole('ADMIN', 'SYS_ADMIN'),
  checkAdminLevel('SUPER'),
  [
    param('id').isUUID().withMessage('ID fédération invalide'),
    query('force').optional().isBoolean(),
    handleValidationErrors
  ],
  auditLog('DELETE', 'FEDERATION'),
  deleteFederation
);

// Get federation statistics
router.get('/:id/stats',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    param('id').isUUID().withMessage('ID fédération invalide'),
    handleValidationErrors
  ],
  getFederationStats
);

// Get federation dashboard
router.get('/:id/dashboard',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    param('id').isUUID().withMessage('ID fédération invalide'),
    handleValidationErrors
  ],
  getFederationDashboard
);

// Get federation athletes
router.get('/:id/athletes',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    param('id').isUUID().withMessage('ID fédération invalide'),
    query('status').optional().isIn(['PENDING', 'APPROVED', 'REJECTED', 'SUSPENDED']),
    query('clubId').optional().isUUID(),
    query('search').optional().trim(),
    query('page').optional().isInt({ min: 1 }),
    query('limit').optional().isInt({ min: 1, max: 100 }),
    handleValidationErrors
  ],
  getFederationAthletes
);

// Get federation finances
router.get('/:id/finances',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    param('id').isUUID().withMessage('ID fédération invalide'),
    query('year').optional().isInt({ min: 2020, max: 2030 }),
    handleValidationErrors
  ],
  getFederationFinances
);

// ==================== CLUB MANAGEMENT ====================

// Get all clubs
router.get('/clubs/all',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    query('federationId').optional().isUUID(),
    query('isActive').optional().isBoolean(),
    query('page').optional().isInt({ min: 1 }),
    query('limit').optional().isInt({ min: 1, max: 100 }),
    query('search').optional().trim(),
    handleValidationErrors
  ],
  getAllClubs
);

// Get club by ID
router.get('/clubs/:id',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    param('id').isUUID().withMessage('ID club invalide'),
    handleValidationErrors
  ],
  getClubById
);

// Create club
router.post('/clubs',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  checkFederationAccess,
  [
    body('federationId').optional().isUUID(),
    body('name').trim().notEmpty().withMessage('Le nom du club est requis'),
    body('shortName').optional().trim(),
    body('foundedDate').optional().isISO8601(),
    body('isProfessional').optional().isBoolean(),
    body('stadiumName').optional().trim(),
    body('city').optional().trim(),
    body('region').optional().trim(),
    body('contactEmail').optional().isEmail().normalizeEmail(),
    body('contactPhone').optional().trim(),
    body('logoUrl').optional().trim().isURL(),
    handleValidationErrors
  ],
  auditLog('CREATE', 'CLUB'),
  createClub
);

// Update club
router.put('/clubs/:id',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    param('id').isUUID().withMessage('ID club invalide'),
    body('name').optional().trim(),
    body('shortName').optional().trim(),
    body('foundedDate').optional().isISO8601(),
    body('isProfessional').optional().isBoolean(),
    body('stadiumName').optional().trim(),
    body('city').optional().trim(),
    body('region').optional().trim(),
    body('contactEmail').optional().isEmail().normalizeEmail(),
    body('contactPhone').optional().trim(),
    body('logoUrl').optional().trim().isURL(),
    body('isActive').optional().isBoolean(),
    handleValidationErrors
  ],
  auditLog('UPDATE', 'CLUB'),
  updateClub
);

// Delete club (soft delete)
router.delete('/clubs/:id',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    param('id').isUUID().withMessage('ID club invalide'),
    handleValidationErrors
  ],
  auditLog('DELETE', 'CLUB'),
  deleteClub
);

// ==================== LICENSE MANAGEMENT ====================

// Get all licenses
router.get('/licenses/all',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  checkFederationAccess,
  [
    query('status').optional().isIn(['PENDING', 'APPROVED', 'REJECTED', 'SUSPENDED', 'EXPIRED']),
    query('federationId').optional().isUUID(),
    query('clubId').optional().isUUID(),
    query('season').optional().trim(),
    query('page').optional().isInt({ min: 1 }),
    query('limit').optional().isInt({ min: 1, max: 100 }),
    query('search').optional().trim(),
    handleValidationErrors
  ],
  getAllLicenses
);

// Get license by ID
router.get('/licenses/:id',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    param('id').isUUID().withMessage('ID licence invalide'),
    handleValidationErrors
  ],
  getLicenseById
);

// Create license
router.post('/licenses',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  checkFederationAccess,
  [
    body('athleteId').isUUID().withMessage('ID athlète requis'),
    body('federationId').optional().isUUID(),
    body('clubId').optional().isUUID(),
    body('season').trim().notEmpty().withMessage('La saison est requise'),
    body('amount').optional().isDecimal().withMessage('Montant invalide'),
    body('medicalClearance').optional().isBoolean(),
    handleValidationErrors
  ],
  auditLog('CREATE', 'LICENSE'),
  createLicense
);

// Approve license
router.post('/licenses/:id/approve',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  checkFederationAccess,
  [
    param('id').isUUID().withMessage('ID licence invalide'),
    body('notes').optional().trim(),
    handleValidationErrors
  ],
  auditLog('APPROVE', 'LICENSE'),
  approveLicense
);

// Reject license
router.post('/licenses/:id/reject',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  checkFederationAccess,
  [
    param('id').isUUID().withMessage('ID licence invalide'),
    body('reason').trim().notEmpty().withMessage('Un motif de rejet est requis'),
    handleValidationErrors
  ],
  auditLog('REJECT', 'LICENSE'),
  rejectLicense
);

// Suspend license
router.post('/licenses/:id/suspend',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  checkFederationAccess,
  [
    param('id').isUUID().withMessage('ID licence invalide'),
    body('reason').optional().trim(),
    handleValidationErrors
  ],
  auditLog('SUSPEND', 'LICENSE'),
  suspendLicense
);

// Verify license by QR code
router.post('/licenses/verify-qr',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN', 'OFFICIAL'),
  [
    body('qrData').trim().notEmpty().withMessage('Données QR requises'),
    handleValidationErrors
  ],
  verifyLicenseQR
);

module.exports = router;
