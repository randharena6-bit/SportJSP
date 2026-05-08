const express = require('express');
const { query, validationResult } = require('express-validator');
const {
  generateUserActivityReport,
  generateLicenseReport,
  generateFinancialReport,
  generateAthletePerformanceReport,
  getDashboardAnalytics,
  exportReport
} = require('../controllers/reportController');
const { auth, checkRole, auditLog } = require('../middleware/auth');

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

// ==================== REPORTS ====================

// User activity report
router.get('/users',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    query('startDate').optional().isISO8601(),
    query('endDate').optional().isISO8601(),
    query('role').optional().isIn(['ATHLETE', 'COACH', 'SCOUT', 'DOCTOR', 'ADMIN', 'ADMIN_FEDERATION', 'OFFICIAL', 'SELECTIONNEUR', 'FAN']),
    query('federationId').optional().isUUID(),
    handleValidationErrors
  ],
  auditLog('GENERATE_REPORT', 'USER_ACTIVITY'),
  generateUserActivityReport
);

// License report
router.get('/licenses',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    query('season').optional().trim(),
    query('federationId').optional().isUUID(),
    query('status').optional().isIn(['PENDING', 'APPROVED', 'REJECTED', 'SUSPENDED', 'EXPIRED']),
    query('startDate').optional().isISO8601(),
    query('endDate').optional().isISO8601(),
    handleValidationErrors
  ],
  auditLog('GENERATE_REPORT', 'LICENSE'),
  generateLicenseReport
);

// Financial report
router.get('/financial',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    query('startDate').optional().isISO8601(),
    query('endDate').optional().isISO8601(),
    query('federationId').optional().isUUID(),
    query('provider').optional().isIn(['MVOLA', 'AIRTEL_MONEY', 'ORANGE_MONEY', 'BANK']),
    handleValidationErrors
  ],
  auditLog('GENERATE_REPORT', 'FINANCIAL'),
  generateFinancialReport
);

// Athlete performance report
router.get('/athletes',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN', 'COACH', 'SELECTIONNEUR'),
  [
    query('federationId').optional().isUUID(),
    query('clubId').optional().isUUID(),
    query('sportType').optional().trim(),
    query('season').optional().trim(),
    handleValidationErrors
  ],
  auditLog('GENERATE_REPORT', 'ATHLETE_PERFORMANCE'),
  generateAthletePerformanceReport
);

// ==================== ANALYTICS ====================

// Dashboard analytics
router.get('/dashboard',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  getDashboardAnalytics
);

// ==================== EXPORT ====================

// Export reports
router.get('/export',
  checkRole('ADMIN', 'ADMIN_FEDERATION', 'SYS_ADMIN'),
  [
    query('type').isIn(['users', 'licenses', 'payments']).withMessage('Type d\'export invalide'),
    query('format').optional().isIn(['json', 'csv']).withMessage('Format invalide'),
    query('startDate').optional().isISO8601(),
    query('endDate').optional().isISO8601(),
    query('federationId').optional().isUUID(),
    handleValidationErrors
  ],
  auditLog('EXPORT_REPORT', 'DATA'),
  exportReport
);

module.exports = router;
