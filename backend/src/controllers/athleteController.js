/**
 * Athlete Controller
 * Gestion complète des fonctionnalités du rôle athlète
 * Features: Dashboard, Profil, Licences, Compétitions, Santé, Médias, Notifications
 */

const db = require('../config/db');
const { validationResult } = require('express-validator');

/**
 * @desc    Get athlete dashboard statistics
 * @route   GET /api/athlete/dashboard
 * @access  Private (Athlete only)
 */
const getDashboardStats = async (req, res) => {
    try {
        const athleteId = req.user.id;

        // Get license status
        const licenseQuery = `
            SELECT l.*, f.name as federation_name, f.acronym
            FROM licenses l
            JOIN federations f ON l.federation_id = f.id
            WHERE l.athlete_id = $1
            AND l.status = 'APPROVED'
            AND l.expiry_date >= CURRENT_DATE
            ORDER BY l.expiry_date DESC
            LIMIT 1
        `;
        const licenseResult = await db.query(licenseQuery, [athleteId]);
        const currentLicense = licenseResult.rows[0] || null;

        // Get competition count
        const competitionCountQuery = `
            SELECT COUNT(*) as count
            FROM competition_participants cp
            JOIN competitions c ON cp.competition_id = c.id
            WHERE cp.athlete_id = $1
            AND c.season = '2024-2025'
        `;
        const competitionCount = await db.query(competitionCountQuery, [athleteId]);

        // Get medals count
        const medalsQuery = `
            SELECT COUNT(*) as count
            FROM performances p
            JOIN matches m ON p.match_id = m.id
            WHERE p.athlete_id = $1
            AND p.metrics->>'medal' IS NOT NULL
        `;
        const medalsResult = await db.query(medalsQuery, [athleteId]);

        // Get talent score from latest evaluation
        const talentQuery = `
            SELECT overall_score, potential
            FROM talent_evaluations
            WHERE athlete_id = $1
            ORDER BY evaluation_date DESC
            LIMIT 1
        `;
        const talentResult = await db.query(talentQuery, [athleteId]);
        const talentScore = talentResult.rows[0] || { overall_score: 0, potential: 'STANDARD' };

        // Get latest biometric data
        const biometricQuery = `
            SELECT vo2_max, heart_rate_resting, recovery_score
            FROM biometric_data
            WHERE athlete_id = $1
            ORDER BY recorded_at DESC
            LIMIT 1
        `;
        const biometricResult = await db.query(biometricQuery, [athleteId]);
        const fitness = biometricResult.rows[0] || null;

        // Get upcoming competitions
        const upcomingQuery = `
            SELECT c.*, f.name as federation_name, f.acronym,
                   cp.status as registration_status
            FROM competitions c
            JOIN federations f ON c.federation_id = f.id
            LEFT JOIN competition_participants cp ON cp.competition_id = c.id AND cp.athlete_id = $1
            WHERE c.start_date >= CURRENT_DATE
            AND c.status IN ('PLANNED', 'ONGOING')
            ORDER BY c.start_date ASC
            LIMIT 5
        `;
        const upcomingCompetitions = await db.query(upcomingQuery, [athleteId]);

        // Get recent notifications
        const notificationsQuery = `
            SELECT * FROM notifications
            WHERE user_id = $1
            AND is_read = FALSE
            ORDER BY created_at DESC
            LIMIT 5
        `;
        const notifications = await db.query(notificationsQuery, [athleteId]);

        res.json({
            success: true,
            data: {
                license: currentLicense ? {
                    status: currentLicense.status,
                    season: currentLicense.season,
                    licenseNumber: currentLicense.license_number,
                    expiryDate: currentLicense.expiry_date,
                    federation: currentLicense.federation_name,
                    qrCode: currentLicense.qr_code_data
                } : null,
                stats: {
                    competitions: parseInt(competitionCount.rows[0].count),
                    medals: parseInt(medalsResult.rows[0].count),
                    talentScore: talentScore.overall_score,
                    talentCategory: talentScore.potential,
                    fitness: fitness ? {
                        vo2Max: fitness.vo2_max,
                        restingHeartRate: fitness.heart_rate_resting,
                        recoveryScore: fitness.recovery_score
                    } : null
                },
                upcomingCompetitions: upcomingCompetitions.rows,
                notifications: notifications.rows
            }
        });
    } catch (error) {
        console.error('Get dashboard stats error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des statistiques du tableau de bord',
            error: error.message
        });
    }
};

/**
 * @desc    Get performance chart data
 * @route   GET /api/athlete/performance-chart
 * @access  Private (Athlete only)
 */
const getPerformanceChart = async (req, res) => {
    try {
        const athleteId = req.user.id;
        const { months = 6 } = req.query;

        const query = `
            SELECT 
                DATE_TRUNC('month', m.scheduled_date) as month,
                AVG(p.overall_score) as avg_score,
                MAX(p.overall_score) as max_score
            FROM performances p
            JOIN matches m ON p.match_id = m.id
            WHERE p.athlete_id = $1
            AND m.scheduled_date >= CURRENT_DATE - INTERVAL '${months} months'
            GROUP BY DATE_TRUNC('month', m.scheduled_date)
            ORDER BY month ASC
        `;
        const result = await db.query(query, [athleteId]);

        // Format data for Chart.js
        const labels = result.rows.map(row => {
            const date = new Date(row.month);
            return date.toLocaleDateString('fr-FR', { month: 'short' });
        });
        const data = result.rows.map(row => parseFloat(row.avg_score).toFixed(1));

        res.json({
            success: true,
            data: { labels, datasets: [{ data }] }
        });
    } catch (error) {
        console.error('Get performance chart error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des données de performance'
        });
    }
};

/**
 * @desc    Get athlete profile
 * @route   GET /api/athlete/profile
 * @access  Private (Athlete only)
 */
const getProfile = async (req, res) => {
    try {
        const athleteId = req.user.id;

        const query = `
            SELECT 
                a.*,
                u.email,
                u.phone,
                u.nin,
                c.name as club_name,
                c.short_name as club_short_name,
                f.name as federation_name,
                f.acronym as federation_acronym
            FROM athletes a
            JOIN users u ON a.user_id = u.id
            LEFT JOIN clubs c ON a.current_club_id = c.id
            LEFT JOIN federations f ON c.federation_id = f.id
            WHERE a.user_id = $1
        `;
        const result = await db.query(query, [athleteId]);

        if (result.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Profil athlète non trouvé'
            });
        }

        res.json({
            success: true,
            data: result.rows[0]
        });
    } catch (error) {
        console.error('Get profile error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération du profil'
        });
    }
};

/**
 * @desc    Update athlete profile
 * @route   PUT /api/athlete/profile
 * @access  Private (Athlete only)
 */
const updateProfile = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                success: false,
                message: 'Données invalides',
                errors: errors.array()
            });
        }

        const athleteId = req.user.id;
        const { email, phone, height, weight, biography } = req.body;

        // Update athlete table
        const athleteQuery = `
            UPDATE athletes
            SET height = COALESCE($1, height),
                weight = COALESCE($2, weight),
                biography = COALESCE($3, biography),
                updated_at = CURRENT_TIMESTAMP
            WHERE user_id = $4
            RETURNING *
        `;
        await db.query(athleteQuery, [height, weight, biography, athleteId]);

        // Update users table for email and phone
        if (email || phone) {
            const userQuery = `
                UPDATE users
                SET email = COALESCE($1, email),
                    phone = COALESCE($2, phone),
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = $3
            `;
            await db.query(userQuery, [email, phone, athleteId]);
        }

        res.json({
            success: true,
            message: 'Profil mis à jour avec succès'
        });
    } catch (error) {
        console.error('Update profile error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la mise à jour du profil'
        });
    }
};

/**
 * @desc    Get athlete palmares/achievements
 * @route   GET /api/athlete/palmares
 * @access  Private (Athlete only)
 */
const getPalmares = async (req, res) => {
    try {
        const athleteId = req.user.id;

        const query = `
            SELECT 
                p.*,
                m.match_date,
                c.name as competition_name,
                c.season,
                c.competition_type
            FROM performances p
            JOIN matches m ON p.match_id = m.id
            JOIN competitions c ON m.competition_id = c.id
            WHERE p.athlete_id = $1
            AND (p.metrics->>'medal' IS NOT NULL OR p.metrics->>'position' IS NOT NULL)
            ORDER BY m.match_date DESC
        `;
        const result = await db.query(query, [athleteId]);

        // Group by medal type
        const palmares = result.rows.map(row => ({
            id: row.id,
            competition: row.competition_name,
            season: row.season,
            date: row.match_date,
            medal: row.metrics?.medal || null,
            position: row.metrics?.position || null,
            discipline: row.metrics?.discipline || null,
            performance: row.metrics?.performance || null,
            notes: row.metrics?.notes || null
        }));

        res.json({
            success: true,
            data: palmares
        });
    } catch (error) {
        console.error('Get palmares error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération du palmarès'
        });
    }
};

/**
 * @desc    Get athlete documents
 * @route   GET /api/athlete/documents
 * @access  Private (Athlete only)
 */
const getDocuments = async (req, res) => {
    try {
        const athleteId = req.user.id;

        const query = `
            SELECT 
                l.id,
                l.documents,
                l.license_number,
                l.season,
                f.name as federation_name
            FROM licenses l
            JOIN federations f ON l.federation_id = f.id
            WHERE l.athlete_id = $1
            ORDER BY l.created_at DESC
        `;
        const result = await db.query(query, [athleteId]);

        // Extract documents from all licenses
        const documents = [];
        result.rows.forEach(license => {
            if (license.documents) {
                const docs = typeof license.documents === 'string' 
                    ? JSON.parse(license.documents) 
                    : license.documents;
                
                Object.entries(docs).forEach(([type, url]) => {
                    documents.push({
                        id: `${license.id}-${type}`,
                        type: type,
                        url: url,
                        licenseId: license.id,
                        licenseNumber: license.license_number,
                        season: license.season,
                        federation: license.federation_name,
                        uploadedAt: license.created_at
                    });
                });
            }
        });

        res.json({
            success: true,
            data: documents
        });
    } catch (error) {
        console.error('Get documents error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des documents'
        });
    }
};

/**
 * @desc    Get athlete licenses
 * @route   GET /api/athlete/licenses
 * @access  Private (Athlete only)
 */
const getLicenses = async (req, res) => {
    try {
        const athleteId = req.user.id;

        const query = `
            SELECT 
                l.*,
                f.name as federation_name,
                f.acronym as federation_acronym,
                c.name as club_name
            FROM licenses l
            JOIN federations f ON l.federation_id = f.id
            LEFT JOIN clubs c ON l.club_id = c.id
            WHERE l.athlete_id = $1
            ORDER BY l.created_at DESC
        `;
        const result = await db.query(query, [athleteId]);

        res.json({
            success: true,
            count: result.rows.length,
            data: result.rows
        });
    } catch (error) {
        console.error('Get licenses error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des licences'
        });
    }
};

/**
 * @desc    Request new license
 * @route   POST /api/athlete/licenses
 * @access  Private (Athlete only)
 */
const requestLicense = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                success: false,
                message: 'Données invalides',
                errors: errors.array()
            });
        }

        const athleteId = req.user.id;
        const { federationId, clubId, season, category } = req.body;

        // Get athlete profile for license number generation
        const athleteQuery = `SELECT * FROM athletes WHERE user_id = $1`;
        const athleteResult = await db.query(athleteQuery, [athleteId]);
        
        if (athleteResult.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Profil athlète non trouvé'
            });
        }

        const athlete = athleteResult.rows[0];
        const licenseNumber = `LIC-${season}-${Math.random().toString(36).substr(2, 6).toUpperCase()}`;

        // Create license
        const query = `
            INSERT INTO licenses (
                athlete_id, federation_id, club_id, season, license_number,
                status, issue_date, expiry_date, payment_status, created_at, updated_at
            ) VALUES ($1, $2, $3, $4, $5, 'PENDING', CURRENT_DATE, 
                     CURRENT_DATE + INTERVAL '1 year', 'PENDING', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
            RETURNING *
        `;
        const result = await db.query(query, [
            athleteId, federationId, clubId, season, licenseNumber
        ]);

        // Create notification
        await db.query(`
            INSERT INTO notifications (user_id, type, title, message, created_at)
            VALUES ($1, 'LICENSE', 'Nouvelle demande de licence', 
                    'Votre demande de licence a été soumise et est en cours de traitement.', CURRENT_TIMESTAMP)
        `, [athleteId]);

        res.status(201).json({
            success: true,
            message: 'Demande de licence soumise avec succès',
            data: result.rows[0]
        });
    } catch (error) {
        console.error('Request license error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la demande de licence'
        });
    }
};

/**
 * @desc    Process license payment
 * @route   POST /api/athlete/licenses/:id/payment
 * @access  Private (Athlete only)
 */
const processLicensePayment = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                success: false,
                message: 'Données invalides',
                errors: errors.array()
            });
        }

        const athleteId = req.user.id;
        const licenseId = req.params.id;
        const { amount, provider, phoneNumber } = req.body;

        // Verify license belongs to athlete
        const licenseCheck = await db.query(
            'SELECT * FROM licenses WHERE id = $1 AND athlete_id = $2',
            [licenseId, athleteId]
        );

        if (licenseCheck.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Licence non trouvée'
            });
        }

        // Create payment record
        const paymentQuery = `
            INSERT INTO payments (
                license_id, amount, currency, provider, 
                phone_number, status, created_at
            ) VALUES ($1, $2, 'MGA', $3, $4, 'INITIATED', CURRENT_TIMESTAMP)
            RETURNING *
        `;
        const paymentResult = await db.query(paymentQuery, [
            licenseId, amount, provider, phoneNumber
        ]);

        // Update license payment status
        await db.query(`
            UPDATE licenses 
            SET payment_status = 'PENDING', updated_at = CURRENT_TIMESTAMP
            WHERE id = $1
        `, [licenseId]);

        // Simulate Mobile Money payment (in production, integrate with MVola, Orange Money, Airtel Money APIs)
        // For demo, auto-approve after 2 seconds
        setTimeout(async () => {
            try {
                await db.query(`
                    UPDATE payments 
                    SET status = 'COMPLETED', paid_at = CURRENT_TIMESTAMP
                    WHERE id = $1
                `, [paymentResult.rows[0].id]);

                await db.query(`
                    UPDATE licenses 
                    SET payment_status = 'COMPLETED', status = 'APPROVED', updated_at = CURRENT_TIMESTAMP
                    WHERE id = $1
                `, [licenseId]);

                // Create notification
                await db.query(`
                    INSERT INTO notifications (user_id, type, title, message, created_at)
                    VALUES ($1, 'PAYMENT', 'Paiement confirmé', 
                            'Votre paiement de ${amount} Ar a été confirmé. Votre licence est maintenant active.', CURRENT_TIMESTAMP)
                `, [athleteId]);
            } catch (err) {
                console.error('Payment completion error:', err);
            }
        }, 2000);

        res.json({
            success: true,
            message: 'Paiement initié',
            data: {
                paymentId: paymentResult.rows[0].id,
                status: 'INITIATED',
                message: `Veuillez valider le paiement sur votre téléphone ${provider}`
            }
        });
    } catch (error) {
        console.error('Process payment error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors du traitement du paiement'
        });
    }
};

/**
 * @desc    Get competitions with filtering
 * @route   GET /api/athlete/competitions
 * @access  Private (Athlete only)
 */
const getCompetitions = async (req, res) => {
    try {
        const { 
            discipline, 
            category, 
            month, 
            status = 'upcoming',
            page = 1, 
            limit = 10 
        } = req.query;

        let query = `
            SELECT 
                c.*,
                f.name as federation_name,
                f.acronym as federation_acronym,
                COUNT(cp.id) as participant_count
            FROM competitions c
            JOIN federations f ON c.federation_id = f.id
            LEFT JOIN competition_participants cp ON cp.competition_id = c.id
            WHERE 1=1
        `;
        
        const params = [];
        let paramCount = 0;

        if (status === 'upcoming') {
            query += ` AND c.start_date >= CURRENT_DATE`;
        } else if (status === 'ongoing') {
            query += ` AND c.start_date <= CURRENT_DATE AND c.end_date >= CURRENT_DATE`;
        } else if (status === 'past') {
            query += ` AND c.end_date < CURRENT_DATE`;
        }

        if (discipline) {
            params.push(discipline);
            query += ` AND f.sport_type = $${++paramCount}`;
        }

        if (month) {
            params.push(month);
            query += ` AND DATE_TRUNC('month', c.start_date) = DATE_TRUNC('month', $${++paramCount}::date)`;
        }

        query += `
            GROUP BY c.id, f.name, f.acronym
            ORDER BY c.start_date ASC
            LIMIT $${++paramCount} OFFSET $${++paramCount}
        `;
        params.push(parseInt(limit), (parseInt(page) - 1) * parseInt(limit));

        const result = await db.query(query, params);

        // Get total count for pagination
        const countQuery = query.replace(/SELECT.*?FROM/s, 'SELECT COUNT(*) as total FROM').replace(/LIMIT.*$/s, '');
        const countResult = await db.query(countQuery, params.slice(0, -2));

        res.json({
            success: true,
            count: result.rows.length,
            total: parseInt(countResult.rows[0]?.total || 0),
            page: parseInt(page),
            data: result.rows
        });
    } catch (error) {
        console.error('Get competitions error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des compétitions'
        });
    }
};

/**
 * @desc    Register for competition
 * @route   POST /api/athlete/competitions/:id/register
 * @access  Private (Athlete only)
 */
const registerForCompetition = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                success: false,
                message: 'Données invalides',
                errors: errors.array()
            });
        }

        const athleteId = req.user.id;
        const competitionId = req.params.id;
        const { events, clubId } = req.body;

        // Check if already registered
        const checkQuery = `
            SELECT * FROM competition_participants 
            WHERE competition_id = $1 AND athlete_id = $2
        `;
        const checkResult = await db.query(checkQuery, [competitionId, athleteId]);

        if (checkResult.rows.length > 0) {
            return res.status(409).json({
                success: false,
                message: 'Vous êtes déjà inscrit à cette compétition'
            });
        }

        // Check if registration deadline has passed
        const compQuery = `SELECT * FROM competitions WHERE id = $1`;
        const compResult = await db.query(compQuery, [competitionId]);

        if (compResult.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Compétition non trouvée'
            });
        }

        const competition = compResult.rows[0];
        if (new Date(competition.registration_deadline) < new Date()) {
            return res.status(400).json({
                success: false,
                message: 'La date limite d\'inscription est passée'
            });
        }

        // Register athlete
        const query = `
            INSERT INTO competition_participants (
                competition_id, club_id, athlete_id, 
                registration_date, status
            ) VALUES ($1, $2, $3, CURRENT_TIMESTAMP, 'REGISTERED')
            RETURNING *
        `;
        const result = await db.query(query, [competitionId, clubId, athleteId]);

        // Create notification
        await db.query(`
            INSERT INTO notifications (user_id, type, title, message, created_at)
            VALUES ($1, 'MATCH', 'Inscription confirmée', 
                    'Votre inscription à ${competition.name} a été confirmée.', CURRENT_TIMESTAMP)
        `, [athleteId]);

        res.status(201).json({
            success: true,
            message: 'Inscription réussie',
            data: result.rows[0]
        });
    } catch (error) {
        console.error('Register for competition error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de l\'inscription'
        });
    }
};

/**
 * @desc    Get athlete's competition results
 * @route   GET /api/athlete/competition-results
 * @access  Private (Athlete only)
 */
const getCompetitionResults = async (req, res) => {
    try {
        const athleteId = req.user.id;

        const query = `
            SELECT 
                p.*,
                m.match_date,
                m.venue,
                c.name as competition_name,
                c.season,
                cp.seed,
                cp.status as participant_status
            FROM performances p
            JOIN matches m ON p.match_id = m.id
            JOIN competitions c ON m.competition_id = c.id
            JOIN competition_participants cp ON cp.competition_id = c.id AND cp.athlete_id = p.athlete_id
            WHERE p.athlete_id = $1
            ORDER BY m.match_date DESC
        `;
        const result = await db.query(query, [athleteId]);

        res.json({
            success: true,
            count: result.rows.length,
            data: result.rows
        });
    } catch (error) {
        console.error('Get competition results error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des résultats'
        });
    }
};

/**
 * @desc    Get health stats
 * @route   GET /api/athlete/health
 * @access  Private (Athlete only)
 */
const getHealthStats = async (req, res) => {
    try {
        const athleteId = req.user.id;

        // Get latest biometric data
        const biometricQuery = `
            SELECT *
            FROM biometric_data
            WHERE athlete_id = $1
            ORDER BY recorded_at DESC
            LIMIT 1
        `;
        const biometricResult = await db.query(biometricQuery, [athleteId]);

        // Get athlete profile for weight/height
        const athleteQuery = `SELECT height, weight FROM athletes WHERE user_id = $1`;
        const athleteResult = await db.query(athleteQuery, [athleteId]);
        const athlete = athleteResult.rows[0] || {};

        // Calculate BMI
        let bmi = null;
        if (athlete.height && athlete.weight) {
            bmi = (athlete.weight / Math.pow(athlete.height / 100, 2)).toFixed(1);
        }

        // Get injury log
        const injuriesQuery = `
            SELECT *
            FROM injuries
            WHERE athlete_id = $1
            ORDER BY occurred_date DESC
        `;
        const injuriesResult = await db.query(injuriesQuery, [athleteId]);

        // Get medical team
        const doctorsQuery = `
            SELECT d.*, u.email, u.phone
            FROM doctors d
            JOIN users u ON d.user_id = u.id
            JOIN medical_records mr ON mr.doctor_id = d.user_id
            WHERE mr.athlete_id = $1
            GROUP BY d.user_id, u.email, u.phone
        `;
        const doctorsResult = await db.query(doctorsQuery, [athleteId]);

        res.json({
            success: true,
            data: {
                latest: biometricResult.rows[0] || null,
                weight: athlete.weight,
                height: athlete.height,
                bmi: bmi,
                injuries: injuriesResult.rows,
                medicalTeam: doctorsResult.rows
            }
        });
    } catch (error) {
        console.error('Get health stats error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des données de santé'
        });
    }
};

/**
 * @desc    Get weight chart data
 * @route   GET /api/athlete/health/weight-chart
 * @access  Private (Athlete only)
 */
const getWeightChart = async (req, res) => {
    try {
        const athleteId = req.user.id;
        const { months = 6 } = req.query;

        // Get athlete weight history from athletes table updates (simplified)
        // In production, you'd have a weight_history table
        const query = `
            SELECT 
                DATE_TRUNC('month', recorded_at) as month,
                AVG(weight) as avg_weight
            FROM (
                SELECT recorded_at, weight 
                FROM biometric_data 
                WHERE athlete_id = $1 
                AND recorded_at >= CURRENT_DATE - INTERVAL '${months} months'
                UNION ALL
                SELECT CURRENT_TIMESTAMP, weight FROM athletes WHERE user_id = $1
            ) combined
            WHERE weight IS NOT NULL
            GROUP BY DATE_TRUNC('month', recorded_at)
            ORDER BY month ASC
        `;
        const result = await db.query(query, [athleteId]);

        const labels = result.rows.map(row => {
            const date = new Date(row.month);
            return date.toLocaleDateString('fr-FR', { month: 'short' });
        });
        const data = result.rows.map(row => parseFloat(row.avg_weight).toFixed(1));

        res.json({
            success: true,
            data: { labels, datasets: [{ data }] }
        });
    } catch (error) {
        console.error('Get weight chart error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des données de poids'
        });
    }
};

/**
 * @desc    Get heart rate chart data
 * @route   GET /api/athlete/health/heart-rate-chart
 * @access  Private (Athlete only)
 */
const getHeartRateChart = async (req, res) => {
    try {
        const athleteId = req.user.id;
        const { months = 6 } = req.query;

        const query = `
            SELECT 
                DATE_TRUNC('month', recorded_at) as month,
                AVG(heart_rate_resting) as avg_hr
            FROM biometric_data
            WHERE athlete_id = $1
            AND heart_rate_resting IS NOT NULL
            AND recorded_at >= CURRENT_DATE - INTERVAL '${months} months'
            GROUP BY DATE_TRUNC('month', recorded_at)
            ORDER BY month ASC
        `;
        const result = await db.query(query, [athleteId]);

        const labels = result.rows.map(row => {
            const date = new Date(row.month);
            return date.toLocaleDateString('fr-FR', { month: 'short' });
        });
        const data = result.rows.map(row => parseInt(row.avg_hr));

        res.json({
            success: true,
            data: { labels, datasets: [{ data }] }
        });
    } catch (error) {
        console.error('Get heart rate chart error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des données de fréquence cardiaque'
        });
    }
};

/**
 * @desc    Add biometric entry
 * @route   POST /api/athlete/health/biometric
 * @access  Private (Athlete only)
 */
const addBiometricEntry = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                success: false,
                message: 'Données invalides',
                errors: errors.array()
            });
        }

        const athleteId = req.user.id;
        const { weight, heartRateResting, vo2Max, notes } = req.body;

        const query = `
            INSERT INTO biometric_data (
                athlete_id, recorded_at, vo2_max, heart_rate_resting, notes
            ) VALUES ($1, CURRENT_TIMESTAMP, $2, $3, $4)
            RETURNING *
        `;
        const result = await db.query(query, [athleteId, vo2Max, heartRateResting, notes]);

        // Update athlete weight if provided
        if (weight) {
            await db.query(`
                UPDATE athletes 
                SET weight = $1, updated_at = CURRENT_TIMESTAMP
                WHERE user_id = $2
            `, [weight, athleteId]);
        }

        res.status(201).json({
            success: true,
            message: 'Données biométriques enregistrées',
            data: result.rows[0]
        });
    } catch (error) {
        console.error('Add biometric entry error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de l\'enregistrement des données'
        });
    }
};

/**
 * @desc    Report injury
 * @route   POST /api/athlete/health/injuries
 * @access  Private (Athlete only)
 */
const reportInjury = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                success: false,
                message: 'Données invalides',
                errors: errors.array()
            });
        }

        const athleteId = req.user.id;
        const { injuryType, bodyPart, severity, occurredDate, treatmentNotes } = req.body;

        const query = `
            INSERT INTO injuries (
                athlete_id, injury_type, body_part, severity,
                occurred_date, treatment_notes, status, created_at, updated_at
            ) VALUES ($1, $2, $3, $4, $5, $6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
            RETURNING *
        `;
        const result = await db.query(query, [
            athleteId, injuryType, bodyPart, severity, occurredDate, treatmentNotes
        ]);

        // Create notification for medical team
        await db.query(`
            INSERT INTO notifications (user_id, type, title, message, created_at)
            VALUES ($1, 'HEALTH', 'Nouvelle blessure déclarée', 
                    'Une nouvelle blessure (${injuryType}) a été déclarée.', CURRENT_TIMESTAMP)
        `, [athleteId]);

        res.status(201).json({
            success: true,
            message: 'Blessure déclarée avec succès',
            data: result.rows[0]
        });
    } catch (error) {
        console.error('Report injury error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la déclaration de la blessure'
        });
    }
};

/**
 * @desc    Get live streams
 * @route   GET /api/athlete/media/streams
 * @access  Private (Athlete only)
 */
const getStreams = async (req, res) => {
    try {
        const { status, page = 1, limit = 10 } = req.query;

        let query = `
            SELECT 
                s.*,
                c.name as competition_name,
                m.scheduled_date as match_date,
                m.home_score,
                m.away_score
            FROM streams s
            LEFT JOIN competitions c ON s.competition_id = c.id
            LEFT JOIN matches m ON s.match_id = m.id
            WHERE 1=1
        `;
        
        const params = [];
        let paramCount = 0;

        if (status) {
            params.push(status);
            query += ` AND s.status = $${++paramCount}`;
        }

        query += `
            ORDER BY s.start_time DESC
            LIMIT $${++paramCount} OFFSET $${++paramCount}
        `;
        params.push(parseInt(limit), (parseInt(page) - 1) * parseInt(limit));

        const result = await db.query(query, params);

        res.json({
            success: true,
            count: result.rows.length,
            data: result.rows
        });
    } catch (error) {
        console.error('Get streams error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des streams'
        });
    }
};

/**
 * @desc    Get e-sport tournaments
 * @route   GET /api/athlete/media/esport
 * @access  Private (Athlete only)
 */
const getEsportTournaments = async (req, res) => {
    try {
        // For demo, return mock data as e-sport tournaments aren't in the main schema
        const tournaments = [
            {
                id: '1',
                name: 'FIFA 24 Championship',
                game: 'FIFA 24',
                status: 'REGISTERING',
                maxPlayers: 64,
                registeredPlayers: 45,
                prizePool: '500 000 Ar',
                startDate: '2025-06-15',
                registrationFee: 50000
            },
            {
                id: '2',
                name: 'eRacing Madagascar Cup',
                game: 'F1 24',
                status: 'ONGOING',
                maxPlayers: 32,
                registeredPlayers: 32,
                prizePool: '300 000 Ar',
                startDate: '2025-05-01',
                registrationFee: 25000
            },
            {
                id: '3',
                name: 'NBA 2K24 League',
                game: 'NBA 2K24',
                status: 'UPCOMING',
                maxPlayers: 128,
                registeredPlayers: 0,
                prizePool: '400 000 Ar',
                startDate: '2025-07-01',
                registrationFee: 25000
            }
        ];

        res.json({
            success: true,
            data: tournaments
        });
    } catch (error) {
        console.error('Get esport tournaments error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des tournois e-sport'
        });
    }
};

/**
 * @desc    Get notifications
 * @route   GET /api/athlete/notifications
 * @access  Private (Athlete only)
 */
const getNotifications = async (req, res) => {
    try {
        const athleteId = req.user.id;
        const { type, isRead, page = 1, limit = 20 } = req.query;

        let query = `
            SELECT *
            FROM notifications
            WHERE user_id = $1
        `;
        
        const params = [athleteId];
        let paramCount = 1;

        if (type) {
            params.push(type);
            query += ` AND type = $${++paramCount}`;
        }

        if (isRead !== undefined) {
            params.push(isRead === 'true');
            query += ` AND is_read = $${++paramCount}`;
        }

        query += `
            ORDER BY created_at DESC
            LIMIT $${++paramCount} OFFSET $${++paramCount}
        `;
        params.push(parseInt(limit), (parseInt(page) - 1) * parseInt(limit));

        const result = await db.query(query, params);

        // Get unread count
        const unreadQuery = `
            SELECT COUNT(*) as count
            FROM notifications
            WHERE user_id = $1 AND is_read = FALSE
        `;
        const unreadResult = await db.query(unreadQuery, [athleteId]);

        res.json({
            success: true,
            count: result.rows.length,
            unreadCount: parseInt(unreadResult.rows[0].count),
            data: result.rows
        });
    } catch (error) {
        console.error('Get notifications error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des notifications'
        });
    }
};

/**
 * @desc    Mark notification as read
 * @route   PUT /api/athlete/notifications/:id/read
 * @access  Private (Athlete only)
 */
const markNotificationAsRead = async (req, res) => {
    try {
        const athleteId = req.user.id;
        const notificationId = req.params.id;

        const query = `
            UPDATE notifications
            SET is_read = TRUE, read_at = CURRENT_TIMESTAMP
            WHERE id = $1 AND user_id = $2
            RETURNING *
        `;
        const result = await db.query(query, [notificationId, athleteId]);

        if (result.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Notification non trouvée'
            });
        }

        res.json({
            success: true,
            message: 'Notification marquée comme lue',
            data: result.rows[0]
        });
    } catch (error) {
        console.error('Mark notification as read error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la mise à jour de la notification'
        });
    }
};

/**
 * @desc    Mark all notifications as read
 * @route   PUT /api/athlete/notifications/read-all
 * @access  Private (Athlete only)
 */
const markAllNotificationsAsRead = async (req, res) => {
    try {
        const athleteId = req.user.id;

        const query = `
            UPDATE notifications
            SET is_read = TRUE, read_at = CURRENT_TIMESTAMP
            WHERE user_id = $1 AND is_read = FALSE
        `;
        await db.query(query, [athleteId]);

        res.json({
            success: true,
            message: 'Toutes les notifications ont été marquées comme lues'
        });
    } catch (error) {
        console.error('Mark all notifications as read error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la mise à jour des notifications'
        });
    }
};

/**
 * @desc    Delete notification
 * @route   DELETE /api/athlete/notifications/:id
 * @access  Private (Athlete only)
 */
const deleteNotification = async (req, res) => {
    try {
        const athleteId = req.user.id;
        const notificationId = req.params.id;

        const query = `
            DELETE FROM notifications
            WHERE id = $1 AND user_id = $2
            RETURNING *
        `;
        const result = await db.query(query, [notificationId, athleteId]);

        if (result.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Notification non trouvée'
            });
        }

        res.json({
            success: true,
            message: 'Notification supprimée'
        });
    } catch (error) {
        console.error('Delete notification error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la suppression de la notification'
        });
    }
};

module.exports = {
    getDashboardStats,
    getPerformanceChart,
    getProfile,
    updateProfile,
    getPalmares,
    getDocuments,
    getLicenses,
    requestLicense,
    processLicensePayment,
    getCompetitions,
    registerForCompetition,
    getCompetitionResults,
    getHealthStats,
    getWeightChart,
    getHeartRateChart,
    addBiometricEntry,
    reportInjury,
    getStreams,
    getEsportTournaments,
    getNotifications,
    markNotificationAsRead,
    markAllNotificationsAsRead,
    deleteNotification
};
