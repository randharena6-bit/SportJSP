/**
 * Coach Routes
 * Routes pour les fonctionnalités du rôle entraîneur
 */

const express = require('express');
const router = express.Router();
const { body, param, query } = require('express-validator');
const coachController = require('../controllers/coachController');
const { authenticate, requireRole } = require('../middleware/auth');

// Toutes les routes nécessitent une authentification et le rôle COACH
router.use(authenticate);
router.use(requireRole('COACH'));

/**
 * @route   GET /api/coach/dashboard
 * @desc    Get coach dashboard statistics
 * @access  Private (Coach only)
 */
router.get('/dashboard', coachController.getDashboardStats);

/**
 * @route   GET /api/coach/athletes
 * @desc    Get coach's athletes
 * @access  Private (Coach only)
 */
router.get('/athletes', [
    query('status').optional().isIn(['active', 'injured', 'all']),
    query('discipline').optional().isString().trim(),
    query('page').optional().isInt({ min: 1 }),
    query('limit').optional().isInt({ min: 1, max: 50 })
], coachController.getAthletes);

/**
 * @route   GET /api/coach/athletes/:id
 * @desc    Get athlete details
 * @access  Private (Coach only)
 */
router.get('/athletes/:id', [
    param('id').isUUID().withMessage('ID athlète invalide')
], coachController.getAthleteDetails);

/**
 * @route   POST /api/coach/athletes/:id/performance
 * @desc    Add performance entry for athlete
 * @access  Private (Coach only)
 */
router.post('/athletes/:id/performance', [
    param('id').isUUID().withMessage('ID athlète invalide'),
    body('competitionId').optional().isUUID(),
    body('discipline').optional().isString().trim(),
    body('time').optional().isString(),
    body('distance').optional().isString(),
    body('score').optional().isFloat({ min: 0, max: 100 }),
    body('notes').optional().isString().trim(),
    body('date').optional().isISO8601()
], coachController.addPerformanceEntry);

/**
 * @route   GET /api/coach/training-sessions
 * @desc    Get training sessions
 * @access  Private (Coach only)
 */
router.get('/training-sessions', [
    query('startDate').optional().isISO8601(),
    query('endDate').optional().isISO8601(),
    query('page').optional().isInt({ min: 1 }),
    query('limit').optional().isInt({ min: 1, max: 50 })
], coachController.getTrainingSessions);

/**
 * @route   POST /api/coach/training-sessions
 * @desc    Create training session
 * @access  Private (Coach only)
 */
router.post('/training-sessions', [
    body('title').isString().notEmpty().withMessage('Titre requis'),
    body('description').optional().isString().trim(),
    body('sessionDate').isISO8601().withMessage('Date invalide'),
    body('startTime').isString().notEmpty().withMessage('Heure de début requise'),
    body('endTime').isString().notEmpty().withMessage('Heure de fin requise'),
    body('location').isString().notEmpty().withMessage('Lieu requis'),
    body('athleteIds').optional().isArray().withMessage('Liste d\'athlètes invalide')
], coachController.createTrainingSession);

/**
 * @route   PUT /api/coach/training-sessions/:id
 * @desc    Update training session
 * @access  Private (Coach only)
 */
router.put('/training-sessions/:id', [
    param('id').isUUID().withMessage('ID séance invalide'),
    body('title').optional().isString().trim(),
    body('description').optional().isString().trim(),
    body('sessionDate').optional().isISO8601(),
    body('startTime').optional().isString(),
    body('endTime').optional().isString(),
    body('location').optional().isString(),
    body('athleteIds').optional().isArray()
], coachController.updateTrainingSession);

/**
 * @route   DELETE /api/coach/training-sessions/:id
 * @desc    Delete training session
 * @access  Private (Coach only)
 */
router.delete('/training-sessions/:id', [
    param('id').isUUID().withMessage('ID séance invalide')
], coachController.deleteTrainingSession);

/**
 * @route   GET /api/coach/analysis/:athleteId
 * @desc    Get performance analysis for athlete
 * @access  Private (Coach only)
 */
router.get('/analysis/:athleteId', [
    param('athleteId').isUUID().withMessage('ID athlète invalide')
], coachController.getPerformanceAnalysis);

/**
 * @route   GET /api/coach/competitions
 * @desc    Get competitions for coach's team
 * @access  Private (Coach only)
 */
router.get('/competitions', [
    query('status').optional().isIn(['upcoming', 'ongoing', 'past', 'all']),
    query('page').optional().isInt({ min: 1 }),
    query('limit').optional().isInt({ min: 1, max: 50 })
], coachController.getCompetitions);

/**
 * @route   GET /api/coach/competitions/:id/match-sheet
 * @desc    Get match sheet for competition
 * @access  Private (Coach only)
 */
router.get('/competitions/:id/match-sheet', [
    param('id').isUUID().withMessage('ID compétition invalide')
], coachController.getMatchSheet);

/**
 * @route   POST /api/coach/competitions/:id/results
 * @desc    Submit match results
 * @access  Private (Coach only)
 */
router.post('/competitions/:id/results', [
    param('id').isUUID().withMessage('ID compétition invalide'),
    body('results').isArray().withMessage('Résultats requis')
], coachController.submitMatchResults);

/**
 * @route   POST /api/coach/scouting/evaluations
 * @desc    Create talent evaluation
 * @access  Private (Coach only)
 */
router.post('/scouting/evaluations', [
    body('athleteName').isString().notEmpty().withMessage('Nom requis'),
    body('age').isInt({ min: 10, max: 25 }).withMessage('Âge invalide'),
    body('club').isString().notEmpty().withMessage('Club requis'),
    body('discipline').isString().notEmpty().withMessage('Discipline requise'),
    body('techniqueScore').isFloat({ min: 0, max: 20 }).withMessage('Note technique 0-20'),
    body('speedScore').isFloat({ min: 0, max: 20 }).withMessage('Note vitesse 0-20'),
    body('enduranceScore').isFloat({ min: 0, max: 20 }).withMessage('Note endurance 0-20'),
    body('mentalScore').isFloat({ min: 0, max: 20 }).withMessage('Note mental 0-20'),
    body('location').optional().isString().trim(),
    body('notes').optional().isString().trim()
], coachController.createTalentEvaluation);

/**
 * @route   GET /api/coach/scouting/pending
 * @desc    Get pending scouting evaluations
 * @access  Private (Coach only)
 */
router.get('/scouting/pending', coachController.getPendingEvaluations);

/**
 * @route   POST /api/coach/scouting/sync
 * @desc    Sync pending evaluations
 * @access  Private (Coach only)
 */
router.post('/scouting/sync', coachController.syncEvaluations);

/**
 * @route   GET /api/coach/messages
 * @desc    Get coach messages/conversations
 * @access  Private (Coach only)
 */
router.get('/messages', coachController.getMessages);

/**
 * @route   GET /api/coach/messages/:userId
 * @desc    Get conversation with specific user
 * @access  Private (Coach only)
 */
router.get('/messages/:userId', [
    param('userId').isUUID().withMessage('ID utilisateur invalide'),
    query('page').optional().isInt({ min: 1 }),
    query('limit').optional().isInt({ min: 1, max: 100 })
], coachController.getConversation);

/**
 * @route   POST /api/coach/messages
 * @desc    Send message
 * @access  Private (Coach only)
 */
router.post('/messages', [
    body('receiverId').isUUID().withMessage('ID destinataire invalide'),
    body('content').isString().notEmpty().withMessage('Contenu requis')
], coachController.sendMessage);

module.exports = router;
