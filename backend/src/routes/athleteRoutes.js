/**
 * Athlete Routes
 * Routes pour les fonctionnalités du rôle athlète
 */

const express = require('express');
const router = express.Router();
const { body, param, query } = require('express-validator');
const athleteController = require('../controllers/athleteController');
const { authenticate, requireRole } = require('../middleware/auth');

// Toutes les routes nécessitent une authentification et le rôle ATHLETE
router.use(authenticate);
router.use(requireRole('ATHLETE'));

/**
 * @route   GET /api/athlete/dashboard
 * @desc    Get athlete dashboard statistics
 * @access  Private (Athlete only)
 */
router.get('/dashboard', athleteController.getDashboardStats);

/**
 * @route   GET /api/athlete/performance-chart
 * @desc    Get performance chart data
 * @access  Private (Athlete only)
 */
router.get('/performance-chart', athleteController.getPerformanceChart);

/**
 * @route   GET /api/athlete/profile
 * @desc    Get athlete profile
 * @access  Private (Athlete only)
 */
router.get('/profile', athleteController.getProfile);

/**
 * @route   PUT /api/athlete/profile
 * @desc    Update athlete profile
 * @access  Private (Athlete only)
 */
router.put('/profile', [
    body('email').optional().isEmail().withMessage('Email invalide'),
    body('phone').optional().isString().trim(),
    body('height').optional().isFloat({ min: 50, max: 250 }).withMessage('Taille invalide (50-250 cm)'),
    body('weight').optional().isFloat({ min: 20, max: 300 }).withMessage('Poids invalide (20-300 kg)'),
    body('biography').optional().isString().trim()
], athleteController.updateProfile);

/**
 * @route   GET /api/athlete/palmares
 * @desc    Get athlete palmares/achievements
 * @access  Private (Athlete only)
 */
router.get('/palmares', athleteController.getPalmares);

/**
 * @route   GET /api/athlete/documents
 * @desc    Get athlete documents
 * @access  Private (Athlete only)
 */
router.get('/documents', athleteController.getDocuments);

/**
 * @route   GET /api/athlete/licenses
 * @desc    Get all athlete licenses
 * @access  Private (Athlete only)
 */
router.get('/licenses', athleteController.getLicenses);

/**
 * @route   POST /api/athlete/licenses
 * @desc    Request new license
 * @access  Private (Athlete only)
 */
router.post('/licenses', [
    body('federationId').isUUID().withMessage('ID de fédération invalide'),
    body('clubId').optional().isUUID().withMessage('ID de club invalide'),
    body('season').isString().notEmpty().withMessage('Saison requise'),
    body('category').optional().isString().trim()
], athleteController.requestLicense);

/**
 * @route   POST /api/athlete/licenses/:id/payment
 * @desc    Process license payment
 * @access  Private (Athlete only)
 */
router.post('/licenses/:id/payment', [
    param('id').isUUID().withMessage('ID de licence invalide'),
    body('amount').isFloat({ min: 0 }).withMessage('Montant invalide'),
    body('provider').isIn(['MVOLA', 'ORANGE_MONEY', 'AIRTEL_MONEY']).withMessage('Provider invalide'),
    body('phoneNumber').matches(/^\+?[0-9]{10,15}$/).withMessage('Numéro de téléphone invalide')
], athleteController.processLicensePayment);

/**
 * @route   GET /api/athlete/competitions
 * @desc    Get competitions with filtering
 * @access  Private (Athlete only)
 */
router.get('/competitions', [
    query('discipline').optional().isString().trim(),
    query('category').optional().isString().trim(),
    query('month').optional().isISO8601().withMessage('Format de date invalide'),
    query('status').optional().isIn(['upcoming', 'ongoing', 'past']).withMessage('Statut invalide'),
    query('page').optional().isInt({ min: 1 }).withMessage('Page invalide'),
    query('limit').optional().isInt({ min: 1, max: 100 }).withMessage('Limit invalide')
], athleteController.getCompetitions);

/**
 * @route   POST /api/athlete/competitions/:id/register
 * @desc    Register for competition
 * @access  Private (Athlete only)
 */
router.post('/competitions/:id/register', [
    param('id').isUUID().withMessage('ID de compétition invalide'),
    body('events').optional().isArray().withMessage('Épreuves doivent être un tableau'),
    body('clubId').optional().isUUID().withMessage('ID de club invalide')
], athleteController.registerForCompetition);

/**
 * @route   GET /api/athlete/competition-results
 * @desc    Get athlete's competition results
 * @access  Private (Athlete only)
 */
router.get('/competition-results', athleteController.getCompetitionResults);

/**
 * @route   GET /api/athlete/health
 * @desc    Get health stats
 * @access  Private (Athlete only)
 */
router.get('/health', athleteController.getHealthStats);

/**
 * @route   GET /api/athlete/health/weight-chart
 * @desc    Get weight chart data
 * @access  Private (Athlete only)
 */
router.get('/health/weight-chart', [
    query('months').optional().isInt({ min: 1, max: 24 }).withMessage('Période invalide (1-24 mois)')
], athleteController.getWeightChart);

/**
 * @route   GET /api/athlete/health/heart-rate-chart
 * @desc    Get heart rate chart data
 * @access  Private (Athlete only)
 */
router.get('/health/heart-rate-chart', [
    query('months').optional().isInt({ min: 1, max: 24 }).withMessage('Période invalide (1-24 mois)')
], athleteController.getHeartRateChart);

/**
 * @route   POST /api/athlete/health/biometric
 * @desc    Add biometric entry
 * @access  Private (Athlete only)
 */
router.post('/health/biometric', [
    body('weight').optional().isFloat({ min: 20, max: 300 }).withMessage('Poids invalide'),
    body('heartRateResting').optional().isInt({ min: 30, max: 150 }).withMessage('FC invalide'),
    body('vo2Max').optional().isFloat({ min: 10, max: 100 }).withMessage('VO2 Max invalide'),
    body('notes').optional().isString().trim()
], athleteController.addBiometricEntry);

/**
 * @route   POST /api/athlete/health/injuries
 * @desc    Report injury
 * @access  Private (Athlete only)
 */
router.post('/health/injuries', [
    body('injuryType').isString().notEmpty().withMessage('Type de blessure requis'),
    body('bodyPart').isString().notEmpty().withMessage('Partie du corps requise'),
    body('severity').isIn(['MINOR', 'MODERATE', 'SEVERE', 'CRITICAL']).withMessage('Gravité invalide'),
    body('occurredDate').isISO8601().withMessage('Date invalide'),
    body('treatmentNotes').optional().isString().trim()
], athleteController.reportInjury);

/**
 * @route   GET /api/athlete/media/streams
 * @desc    Get live streams and replays
 * @access  Private (Athlete only)
 */
router.get('/media/streams', [
    query('status').optional().isIn(['SCHEDULED', 'LIVE', 'ENDED', 'ARCHIVED']),
    query('page').optional().isInt({ min: 1 }),
    query('limit').optional().isInt({ min: 1, max: 50 })
], athleteController.getStreams);

/**
 * @route   GET /api/athlete/media/esport
 * @desc    Get e-sport tournaments
 * @access  Private (Athlete only)
 */
router.get('/media/esport', athleteController.getEsportTournaments);

/**
 * @route   GET /api/athlete/notifications
 * @desc    Get notifications
 * @access  Private (Athlete only)
 */
router.get('/notifications', [
    query('type').optional().isIn(['LICENSE', 'PAYMENT', 'MATCH', 'SELECTION', 'HEALTH', 'SYSTEM']),
    query('isRead').optional().isBoolean(),
    query('page').optional().isInt({ min: 1 }),
    query('limit').optional().isInt({ min: 1, max: 50 })
], athleteController.getNotifications);

/**
 * @route   PUT /api/athlete/notifications/:id/read
 * @desc    Mark notification as read
 * @access  Private (Athlete only)
 */
router.put('/notifications/:id/read', [
    param('id').isUUID().withMessage('ID de notification invalide')
], athleteController.markNotificationAsRead);

/**
 * @route   PUT /api/athlete/notifications/read-all
 * @desc    Mark all notifications as read
 * @access  Private (Athlete only)
 */
router.put('/notifications/read-all', athleteController.markAllNotificationsAsRead);

/**
 * @route   DELETE /api/athlete/notifications/:id
 * @desc    Delete notification
 * @access  Private (Athlete only)
 */
router.delete('/notifications/:id', [
    param('id').isUUID().withMessage('ID de notification invalide')
], athleteController.deleteNotification);

module.exports = router;
