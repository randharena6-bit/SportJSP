/**
 * Coach Controller
 * Gestion complète des fonctionnalités du rôle entraîneur
 * Features: Dashboard, Athletes, Training Sessions, Analysis, Competitions, Scouting, Communication
 */

const db = require('../config/db');
const { validationResult } = require('express-validator');

/**
 * @desc    Get coach dashboard statistics
 * @route   GET /api/coach/dashboard
 * @access  Private (Coach only)
 */
const getDashboardStats = async (req, res) => {
    try {
        const coachId = req.user.id;

        // Get coach profile
        const coachQuery = `
            SELECT c.*, cl.name as club_name, cl.id as club_id
            FROM coaches c
            LEFT JOIN clubs cl ON c.current_club_id = cl.id
            WHERE c.user_id = $1
        `;
        const coachResult = await db.query(coachQuery, [coachId]);
        const coach = coachResult.rows[0];

        if (!coach) {
            return res.status(404).json({
                success: false,
                message: 'Profil entraîneur non trouvé'
            });
        }

        // Get athlete counts
        const athleteCountsQuery = `
            SELECT 
                COUNT(*) as total,
                COUNT(CASE WHEN EXISTS (
                    SELECT 1 FROM licenses l 
                    WHERE l.athlete_id = a.user_id 
                    AND l.status = 'APPROVED' 
                    AND l.expiry_date >= CURRENT_DATE
                ) THEN 1 END) as active,
                COUNT(CASE WHEN EXISTS (
                    SELECT 1 FROM injuries i 
                    WHERE i.athlete_id = a.user_id 
                    AND i.status IN ('ACTIVE', 'RECOVERING')
                ) THEN 1 END) as injured
            FROM athletes a
            WHERE a.current_club_id = $1
        `;
        const athleteCounts = await db.query(athleteCountsQuery, [coach.current_club_id]);

        // Get average talent score
        const talentQuery = `
            SELECT AVG(te.overall_score) as avg_score
            FROM talent_evaluations te
            JOIN athletes a ON te.athlete_id = a.user_id
            WHERE a.current_club_id = $1
        `;
        const talentResult = await db.query(talentQuery, [coach.current_club_id]);

        // Get upcoming training sessions
        const sessionsQuery = `
            SELECT ts.*,
                   COUNT(tsa.athlete_id) as athlete_count
            FROM training_sessions ts
            LEFT JOIN training_session_athletes tsa ON ts.id = tsa.session_id
            WHERE ts.coach_id = $1
            AND ts.session_date >= CURRENT_DATE
            AND ts.session_date <= CURRENT_DATE + INTERVAL '7 days'
            GROUP BY ts.id
            ORDER BY ts.session_date ASC, ts.start_time ASC
            LIMIT 5
        `;
        const sessionsResult = await db.query(sessionsQuery, [coachId]);

        // Get performance alerts
        const alertsQuery = `
            SELECT 
                a.first_name || ' ' || a.last_name as athlete_name,
                a.user_id as athlete_id,
                i.injury_type,
                i.status as injury_status,
                p.metrics->>'regression' as regression,
                p.metrics->>'improvement' as improvement
            FROM athletes a
            LEFT JOIN injuries i ON i.athlete_id = a.user_id AND i.status IN ('ACTIVE', 'RECOVERING')
            LEFT JOIN performances p ON p.athlete_id = a.user_id AND p.match_date >= CURRENT_DATE - INTERVAL '30 days'
            WHERE a.current_club_id = $1
            AND (i.id IS NOT NULL OR p.metrics->>'regression' IS NOT NULL OR p.metrics->>'improvement' IS NOT NULL)
            LIMIT 10
        `;
        const alertsResult = await db.query(alertsQuery, [coach.current_club_id]);

        // Format alerts
        const alerts = [];
        alertsResult.rows.forEach(row => {
            if (row.injury_type) {
                alerts.push({
                    type: 'injury',
                    athleteName: row.athlete_name,
                    athleteId: row.athlete_id,
                    message: row.injury_type,
                    severity: row.injury_status === 'ACTIVE' ? 'high' : 'medium'
                });
            }
            if (row.regression) {
                alerts.push({
                    type: 'regression',
                    athleteName: row.athlete_name,
                    athleteId: row.athlete_id,
                    message: row.regression,
                    severity: 'medium'
                });
            }
            if (row.improvement) {
                alerts.push({
                    type: 'improvement',
                    athleteName: row.athlete_name,
                    athleteId: row.athlete_id,
                    message: row.improvement,
                    severity: 'low'
                });
            }
        });

        res.json({
            success: true,
            data: {
                coach: {
                    id: coachId,
                    name: coach.first_name + ' ' + coach.last_name,
                    club: coach.club_name,
                    clubId: coach.club_id
                },
                stats: {
                    totalAthletes: parseInt(athleteCounts.rows[0].total),
                    activeAthletes: parseInt(athleteCounts.rows[0].active),
                    injuredAthletes: parseInt(athleteCounts.rows[0].injured),
                    avgTalentScore: parseFloat(talentResult.rows[0]?.avg_score || 0).toFixed(1)
                },
                upcomingSessions: sessionsResult.rows,
                alerts: alerts
            }
        });
    } catch (error) {
        console.error('Get coach dashboard error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des statistiques',
            error: error.message
        });
    }
};

/**
 * @desc    Get coach's athletes
 * @route   GET /api/coach/athletes
 * @access  Private (Coach only)
 */
const getAthletes = async (req, res) => {
    try {
        const coachId = req.user.id;
        const { status, discipline, page = 1, limit = 20 } = req.query;

        // Get coach club
        const coachQuery = `SELECT current_club_id FROM coaches WHERE user_id = $1`;
        const coachResult = await db.query(coachQuery, [coachId]);
        
        if (coachResult.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Entraîneur non trouvé'
            });
        }

        const clubId = coachResult.rows[0].current_club_id;

        let query = `
            SELECT 
                a.*,
                u.email,
                u.phone,
                f.name as federation_name,
                CASE WHEN EXISTS (
                    SELECT 1 FROM licenses l 
                    WHERE l.athlete_id = a.user_id 
                    AND l.status = 'APPROVED' 
                    AND l.expiry_date >= CURRENT_DATE
                ) THEN 'Actif' ELSE 'Inactif' END as license_status,
                (SELECT te.overall_score 
                 FROM talent_evaluations te 
                 WHERE te.athlete_id = a.user_id 
                 ORDER BY te.evaluation_date DESC 
                 LIMIT 1) as talent_score
            FROM athletes a
            JOIN users u ON a.user_id = u.id
            LEFT JOIN federations f ON a.sport_type = f.sport_type
            WHERE a.current_club_id = $1
        `;
        
        const params = [clubId];
        let paramCount = 1;

        if (status) {
            if (status === 'active') {
                query += ` AND EXISTS (
                    SELECT 1 FROM licenses l 
                    WHERE l.athlete_id = a.user_id 
                    AND l.status = 'APPROVED' 
                    AND l.expiry_date >= CURRENT_DATE
                )`;
            } else if (status === 'injured') {
                query += ` AND EXISTS (
                    SELECT 1 FROM injuries i 
                    WHERE i.athlete_id = a.user_id 
                    AND i.status IN ('ACTIVE', 'RECOVERING')
                )`;
            }
        }

        if (discipline) {
            params.push(discipline);
            query += ` AND a.sport_type = $${++paramCount}`;
        }

        query += `
            ORDER BY a.last_name ASC, a.first_name ASC
            LIMIT $${++paramCount} OFFSET $${++paramCount}
        `;
        params.push(parseInt(limit), (parseInt(page) - 1) * parseInt(limit));

        const result = await db.query(query, params);

        // Get total count
        const countQuery = query.replace(/SELECT.*?FROM/s, 'SELECT COUNT(*) as total FROM').replace(/LIMIT.*$/s, '');
        const countResult = await db.query(countQuery, params.slice(0, -2));

        // Get personal bests for each athlete
        for (let athlete of result.rows) {
            const pbQuery = `
                SELECT 
                    discipline,
                    MIN(CAST(metrics->>'time' as DECIMAL)) as pb_time
                FROM performances
                WHERE athlete_id = $1 AND metrics->>'time' IS NOT NULL
                GROUP BY discipline
                ORDER BY discipline
                LIMIT 3
            `;
            const pbResult = await db.query(pbQuery, [athlete.user_id]);
            athlete.personalBests = pbResult.rows;
        }

        res.json({
            success: true,
            count: result.rows.length,
            total: parseInt(countResult.rows[0]?.total || 0),
            page: parseInt(page),
            data: result.rows
        });
    } catch (error) {
        console.error('Get athletes error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des athlètes'
        });
    }
};

/**
 * @desc    Get athlete details for coach
 * @route   GET /api/coach/athletes/:id
 * @access  Private (Coach only)
 */
const getAthleteDetails = async (req, res) => {
    try {
        const coachId = req.user.id;
        const athleteId = req.params.id;

        // Verify coach has access to this athlete
        const accessCheck = await db.query(`
            SELECT 1 FROM athletes a
            JOIN coaches c ON a.current_club_id = c.current_club_id
            WHERE a.user_id = $1 AND c.user_id = $2
        `, [athleteId, coachId]);

        if (accessCheck.rows.length === 0) {
            return res.status(403).json({
                success: false,
                message: 'Accès non autorisé à cet athlète'
            });
        }

        // Get athlete details
        const athleteQuery = `
            SELECT a.*, u.email, u.phone, u.nin, c.name as club_name
            FROM athletes a
            JOIN users u ON a.user_id = u.id
            LEFT JOIN clubs c ON a.current_club_id = c.id
            WHERE a.user_id = $1
        `;
        const athleteResult = await db.query(athleteQuery, [athleteId]);

        // Get performance history
        const performanceQuery = `
            SELECT p.*, m.match_date, c.name as competition_name
            FROM performances p
            JOIN matches m ON p.match_id = m.id
            JOIN competitions c ON m.competition_id = c.id
            WHERE p.athlete_id = $1
            ORDER BY m.match_date DESC
            LIMIT 20
        `;
        const performanceResult = await db.query(performanceQuery, [athleteId]);

        // Get injury history
        const injuryQuery = `
            SELECT * FROM injuries
            WHERE athlete_id = $1
            ORDER BY occurred_date DESC
        `;
        const injuryResult = await db.query(injuryQuery, [athleteId]);

        // Get latest biometric data
        const biometricQuery = `
            SELECT * FROM biometric_data
            WHERE athlete_id = $1
            ORDER BY recorded_at DESC
            LIMIT 1
        `;
        const biometricResult = await db.query(biometricQuery, [athleteId]);

        res.json({
            success: true,
            data: {
                athlete: athleteResult.rows[0],
                performances: performanceResult.rows,
                injuries: injuryResult.rows,
                latestBiometric: biometricResult.rows[0] || null
            }
        });
    } catch (error) {
        console.error('Get athlete details error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des détails'
        });
    }
};

/**
 * @desc    Add performance entry for athlete
 * @route   POST /api/coach/athletes/:id/performance
 * @access  Private (Coach only)
 */
const addPerformanceEntry = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                success: false,
                message: 'Données invalides',
                errors: errors.array()
            });
        }

        const coachId = req.user.id;
        const athleteId = req.params.id;
        const { competitionId, discipline, time, distance, score, notes, date } = req.body;

        // Verify coach access
        const accessCheck = await db.query(`
            SELECT 1 FROM athletes a
            JOIN coaches c ON a.current_club_id = c.current_club_id
            WHERE a.user_id = $1 AND c.user_id = $2
        `, [athleteId, coachId]);

        if (accessCheck.rows.length === 0) {
            return res.status(403).json({
                success: false,
                message: 'Accès non autorisé'
            });
        }

        // Create or get match
        let matchId;
        if (competitionId) {
            const matchQuery = `
                INSERT INTO matches (competition_id, scheduled_date, status, created_at)
                VALUES ($1, $2, 'COMPLETED', CURRENT_TIMESTAMP)
                RETURNING id
            `;
            const matchResult = await db.query(matchQuery, [competitionId, date || new Date()]);
            matchId = matchResult.rows[0].id;
        }

        // Add performance
        const metrics = {};
        if (time) metrics.time = time;
        if (distance) metrics.distance = distance;
        if (score) metrics.score = score;
        if (notes) metrics.notes = notes;
        if (discipline) metrics.discipline = discipline;

        const performanceQuery = `
            INSERT INTO performances (athlete_id, match_id, club_id, match_date, metrics, overall_score, created_at)
            VALUES ($1, $2, (SELECT current_club_id FROM coaches WHERE user_id = $3), $4, $5, $6, CURRENT_TIMESTAMP)
            RETURNING *
        `;
        const performanceResult = await db.query(performanceQuery, [
            athleteId, matchId, coachId, date || new Date(), 
            JSON.stringify(metrics), score || 0
        ]);

        res.status(201).json({
            success: true,
            message: 'Performance enregistrée avec succès',
            data: performanceResult.rows[0]
        });
    } catch (error) {
        console.error('Add performance entry error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de l\'enregistrement'
        });
    }
};

/**
 * @desc    Get training sessions
 * @route   GET /api/coach/training-sessions
 * @access  Private (Coach only)
 */
const getTrainingSessions = async (req, res) => {
    try {
        const coachId = req.user.id;
        const { startDate, endDate, page = 1, limit = 20 } = req.query;

        let query = `
            SELECT ts.*,
                   COUNT(tsa.athlete_id) as athlete_count,
                   json_agg(
                       json_build_object(
                           'id', a.user_id,
                           'name', a.first_name || ' ' || a.last_name
                       ) ORDER BY a.last_name
                   ) FILTER (WHERE a.user_id IS NOT NULL) as athletes
            FROM training_sessions ts
            LEFT JOIN training_session_athletes tsa ON ts.id = tsa.session_id
            LEFT JOIN athletes a ON tsa.athlete_id = a.user_id
            WHERE ts.coach_id = $1
        `;
        
        const params = [coachId];
        let paramCount = 1;

        if (startDate) {
            params.push(startDate);
            query += ` AND ts.session_date >= $${++paramCount}`;
        }

        if (endDate) {
            params.push(endDate);
            query += ` AND ts.session_date <= $${++paramCount}`;
        }

        query += `
            GROUP BY ts.id
            ORDER BY ts.session_date DESC, ts.start_time DESC
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
        console.error('Get training sessions error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des séances'
        });
    }
};

/**
 * @desc    Create training session
 * @route   POST /api/coach/training-sessions
 * @access  Private (Coach only)
 */
const createTrainingSession = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                success: false,
                message: 'Données invalides',
                errors: errors.array()
            });
        }

        const coachId = req.user.id;
        const { title, description, sessionDate, startTime, endTime, location, athleteIds } = req.body;

        // Create session
        const sessionQuery = `
            INSERT INTO training_sessions (
                coach_id, title, description, session_date, start_time, end_time, location, created_at
            ) VALUES ($1, $2, $3, $4, $5, $6, $7, CURRENT_TIMESTAMP)
            RETURNING *
        `;
        const sessionResult = await db.query(sessionQuery, [
            coachId, title, description, sessionDate, startTime, endTime, location
        ]);

        const sessionId = sessionResult.rows[0].id;

        // Add athletes to session
        if (athleteIds && athleteIds.length > 0) {
            const athleteValues = athleteIds.map((_, i) => `($1, $${i + 2})`).join(', ');
            const athleteQuery = `
                INSERT INTO training_session_athletes (session_id, athlete_id)
                VALUES ${athleteValues}
            `;
            await db.query(athleteQuery, [sessionId, ...athleteIds]);
        }

        res.status(201).json({
            success: true,
            message: 'Séance créée avec succès',
            data: sessionResult.rows[0]
        });
    } catch (error) {
        console.error('Create training session error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la création de la séance'
        });
    }
};

/**
 * @desc    Update training session
 * @route   PUT /api/coach/training-sessions/:id
 * @access  Private (Coach only)
 */
const updateTrainingSession = async (req, res) => {
    try {
        const coachId = req.user.id;
        const sessionId = req.params.id;
        const { title, description, sessionDate, startTime, endTime, location, athleteIds } = req.body;

        // Verify ownership
        const checkQuery = `SELECT 1 FROM training_sessions WHERE id = $1 AND coach_id = $2`;
        const checkResult = await db.query(checkQuery, [sessionId, coachId]);

        if (checkResult.rows.length === 0) {
            return res.status(403).json({
                success: false,
                message: 'Accès non autorisé'
            });
        }

        // Update session
        const updateQuery = `
            UPDATE training_sessions
            SET title = COALESCE($1, title),
                description = COALESCE($2, description),
                session_date = COALESCE($3, session_date),
                start_time = COALESCE($4, start_time),
                end_time = COALESCE($5, end_time),
                location = COALESCE($6, location)
            WHERE id = $7
            RETURNING *
        `;
        const result = await db.query(updateQuery, [
            title, description, sessionDate, startTime, endTime, location, sessionId
        ]);

        // Update athletes if provided
        if (athleteIds) {
            await db.query(`DELETE FROM training_session_athletes WHERE session_id = $1`, [sessionId]);
            
            if (athleteIds.length > 0) {
                const athleteValues = athleteIds.map((_, i) => `($1, $${i + 2})`).join(', ');
                const athleteQuery = `
                    INSERT INTO training_session_athletes (session_id, athlete_id)
                    VALUES ${athleteValues}
                `;
                await db.query(athleteQuery, [sessionId, ...athleteIds]);
            }
        }

        res.json({
            success: true,
            message: 'Séance mise à jour',
            data: result.rows[0]
        });
    } catch (error) {
        console.error('Update training session error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la mise à jour'
        });
    }
};

/**
 * @desc    Delete training session
 * @route   DELETE /api/coach/training-sessions/:id
 * @access  Private (Coach only)
 */
const deleteTrainingSession = async (req, res) => {
    try {
        const coachId = req.user.id;
        const sessionId = req.params.id;

        const query = `
            DELETE FROM training_sessions
            WHERE id = $1 AND coach_id = $2
            RETURNING *
        `;
        const result = await db.query(query, [sessionId, coachId]);

        if (result.rows.length === 0) {
            return res.status(403).json({
                success: false,
                message: 'Accès non autorisé ou séance non trouvée'
            });
        }

        res.json({
            success: true,
            message: 'Séance supprimée'
        });
    } catch (error) {
        console.error('Delete training session error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la suppression'
        });
    }
};

/**
 * @desc    Get performance analysis for athlete
 * @route   GET /api/coach/analysis/:athleteId
 * @access  Private (Coach only)
 */
const getPerformanceAnalysis = async (req, res) => {
    try {
        const coachId = req.user.id;
        const athleteId = req.params.athleteId;

        // Verify access
        const accessCheck = await db.query(`
            SELECT 1 FROM athletes a
            JOIN coaches c ON a.current_club_id = c.current_club_id
            WHERE a.user_id = $1 AND c.user_id = $2
        `, [athleteId, coachId]);

        if (accessCheck.rows.length === 0) {
            return res.status(403).json({
                success: false,
                message: 'Accès non autorisé'
            });
        }

        // Get performance trend (last 6 months)
        const trendQuery = `
            SELECT 
                DATE_TRUNC('month', m.match_date) as month,
                AVG(p.overall_score) as avg_score,
                json_agg(
                    json_build_object(
                        'date', m.match_date,
                        'score', p.overall_score,
                        'metrics', p.metrics
                    ) ORDER BY m.match_date
                ) as performances
            FROM performances p
            JOIN matches m ON p.match_id = m.id
            WHERE p.athlete_id = $1
            AND m.match_date >= CURRENT_DATE - INTERVAL '6 months'
            GROUP BY DATE_TRUNC('month', m.match_date)
            ORDER BY month ASC
        `;
        const trendResult = await db.query(trendQuery, [athleteId]);

        // Get AI talent evaluation
        const talentQuery = `
            SELECT *
            FROM talent_evaluations
            WHERE athlete_id = $1
            ORDER BY evaluation_date DESC
            LIMIT 1
        `;
        const talentResult = await db.query(talentQuery, [athleteId]);

        // Get SMART SQUAD selections
        const selectionQuery = `
            SELECT ss.*, sp.position, sp.is_starter
            FROM smart_squad_selections ss
            JOIN selected_players sp ON ss.id = sp.selection_id
            WHERE sp.athlete_id = $1
            ORDER BY ss.generated_at DESC
            LIMIT 5
        `;
        const selectionResult = await db.query(selectionQuery, [athleteId]);

        // Calculate insights
        const insights = {
            potential: talentResult.rows[0]?.potential || 'STANDARD',
            overallScore: talentResult.rows[0]?.overall_score || 0,
            progression: calculateProgression(trendResult.rows),
            injuryRisk: calculateInjuryRisk(athleteId),
            recommendations: generateRecommendations(trendResult.rows, talentResult.rows[0])
        };

        res.json({
            success: true,
            data: {
                trend: trendResult.rows,
                talent: talentResult.rows[0] || null,
                selections: selectionResult.rows,
                insights
            }
        });
    } catch (error) {
        console.error('Get performance analysis error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de l\'analyse'
        });
    }
};

// Helper functions for analysis
const calculateProgression = (trendData) => {
    if (trendData.length < 2) return 'stable';
    const first = parseFloat(trendData[0].avg_score);
    const last = parseFloat(trendData[trendData.length - 1].avg_score);
    const change = ((last - first) / first) * 100;
    
    if (change > 5) return 'improving';
    if (change < -5) return 'declining';
    return 'stable';
};

const calculateInjuryRisk = async (athleteId) => {
    // Check recent injuries and training load
    const result = await db.query(`
        SELECT COUNT(*) as injury_count,
               AVG(recovery_days) as avg_recovery
        FROM injuries
        WHERE athlete_id = $1
        AND occurred_date >= CURRENT_DATE - INTERVAL '12 months'
    `, [athleteId]);
    
    const { injury_count, avg_recovery } = result.rows[0];
    
    if (injury_count >= 3) return 'high';
    if (injury_count >= 1 || avg_recovery > 30) return 'medium';
    return 'low';
};

const generateRecommendations = (trendData, talentData) => {
    const recommendations = [];
    
    if (trendData.length > 0) {
        const latest = trendData[trendData.length - 1];
        const avgScore = parseFloat(latest.avg_score);
        
        if (avgScore < 60) {
            recommendations.push('Focus sur les fondamentaux techniques');
        } else if (avgScore < 80) {
            recommendations.push('Intensifier l\'entraînement spécifique');
        } else {
            recommendations.push('Maintenir le niveau actuel, préparer la compétition');
        }
    }
    
    if (talentData) {
        if (talentData.potential === 'ELITE') {
            recommendations.push('Potentiel élevé détecté - envisager le haut niveau');
        }
    }
    
    return recommendations;
};

/**
 * @desc    Get competitions for coach's team
 * @route   GET /api/coach/competitions
 * @access  Private (Coach only)
 */
const getCompetitions = async (req, res) => {
    try {
        const coachId = req.user.id;
        const { status, page = 1, limit = 10 } = req.query;

        // Get coach's club
        const coachQuery = `SELECT current_club_id FROM coaches WHERE user_id = $1`;
        const coachResult = await db.query(coachQuery, [coachId]);
        
        if (coachResult.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Entraîneur non trouvé'
            });
        }

        const clubId = coachResult.rows[0].current_club_id;

        let query = `
            SELECT 
                c.*,
                f.name as federation_name,
                COUNT(DISTINCT cp.athlete_id) as registered_athletes
            FROM competitions c
            JOIN federations f ON c.federation_id = f.id
            LEFT JOIN competition_participants cp ON cp.competition_id = c.id 
                AND cp.club_id = $1
            WHERE 1=1
        `;
        
        const params = [clubId];
        let paramCount = 1;

        if (status === 'upcoming') {
            query += ` AND c.start_date >= CURRENT_DATE`;
        } else if (status === 'ongoing') {
            query += ` AND c.start_date <= CURRENT_DATE AND c.end_date >= CURRENT_DATE`;
        } else if (status === 'past') {
            query += ` AND c.end_date < CURRENT_DATE`;
        }

        query += `
            GROUP BY c.id, f.name
            ORDER BY c.start_date DESC
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
        console.error('Get competitions error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des compétitions'
        });
    }
};

/**
 * @desc    Get match sheet for competition
 * @route   GET /api/coach/competitions/:id/match-sheet
 * @access  Private (Coach only)
 */
const getMatchSheet = async (req, res) => {
    try {
        const coachId = req.user.id;
        const competitionId = req.params.id;

        // Get coach's club
        const coachQuery = `SELECT current_club_id FROM coaches WHERE user_id = $1`;
        const coachResult = await db.query(coachQuery, [coachId]);
        const clubId = coachResult.rows[0]?.current_club_id;

        // Get competition details
        const competitionQuery = `
            SELECT c.*, f.name as federation_name
            FROM competitions c
            JOIN federations f ON c.federation_id = f.id
            WHERE c.id = $1
        `;
        const competitionResult = await db.query(competitionQuery, [competitionId]);

        // Get registered athletes
        const athletesQuery = `
            SELECT 
                a.user_id,
                a.first_name || ' ' || a.last_name as name,
                a.sport_type as discipline,
                cp.seed,
                cp.status
            FROM competition_participants cp
            JOIN athletes a ON cp.athlete_id = a.user_id
            WHERE cp.competition_id = $1 AND cp.club_id = $2
            ORDER BY a.last_name, a.first_name
        `;
        const athletesResult = await db.query(athletesQuery, [competitionId, clubId]);

        res.json({
            success: true,
            data: {
                competition: competitionResult.rows[0],
                athletes: athletesResult.rows
            }
        });
    } catch (error) {
        console.error('Get match sheet error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération de la feuille de match'
        });
    }
};

/**
 * @desc    Submit match results
 * @route   POST /api/coach/competitions/:id/results
 * @access  Private (Coach only)
 */
const submitMatchResults = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                success: false,
                message: 'Données invalides',
                errors: errors.array()
            });
        }

        const coachId = req.user.id;
        const competitionId = req.params.id;
        const { results } = req.body; // Array of { athleteId, bibNumber, time/performance, position }

        // Create match if not exists
        const matchQuery = `
            INSERT INTO matches (competition_id, status, created_at)
            VALUES ($1, 'COMPLETED', CURRENT_TIMESTAMP)
            ON CONFLICT (competition_id) DO UPDATE SET status = 'COMPLETED'
            RETURNING id
        `;
        const matchResult = await db.query(matchQuery, [competitionId]);
        const matchId = matchResult.rows[0].id;

        // Add performances
        for (const result of results) {
            const metrics = {
                bibNumber: result.bibNumber,
                time: result.time,
                position: result.position,
                performance: result.performance
            };

            await db.query(`
                INSERT INTO performances (athlete_id, match_id, club_id, match_date, metrics, overall_score, created_at)
                VALUES ($1, $2, (SELECT current_club_id FROM coaches WHERE user_id = $3), CURRENT_DATE, $4, $5, CURRENT_TIMESTAMP)
                ON CONFLICT (athlete_id, match_id) DO UPDATE
                SET metrics = EXCLUDED.metrics, overall_score = EXCLUDED.overall_score
            `, [result.athleteId, matchId, coachId, JSON.stringify(metrics), calculateScore(metrics)]);
        }

        res.json({
            success: true,
            message: 'Résultats soumis avec succès'
        });
    } catch (error) {
        console.error('Submit match results error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la soumission'
        });
    }
};

const calculateScore = (metrics) => {
    // Simplified scoring logic
    let score = 50;
    if (metrics.position) {
        score += Math.max(0, 50 - (metrics.position * 10));
    }
    return score;
};

/**
 * @desc    Create talent evaluation (scouting)
 * @route   POST /api/coach/scouting/evaluations
 * @access  Private (Coach only)
 */
const createTalentEvaluation = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                success: false,
                message: 'Données invalides',
                errors: errors.array()
            });
        }

        const coachId = req.user.id;
        const { 
            athleteName, age, club, discipline,
            techniqueScore, speedScore, enduranceScore, mentalScore,
            location, notes
        } = req.body;

        // Calculate overall score
        const overallScore = (techniqueScore + speedScore + enduranceScore + mentalScore) / 4;

        // Determine potential
        let potential = 'STANDARD';
        if (overallScore >= 16) potential = 'ELITE';
        else if (overallScore >= 14) potential = 'PROMISING';
        else if (overallScore >= 12) potential = 'FOLLOW';

        // Create evaluation (stored temporarily if offline)
        const query = `
            INSERT INTO talent_evaluations (
                athlete_id, -- null for new talents
                scout_id,
                evaluation_date,
                location,
                scores,
                overall_score,
                potential,
                technical_notes,
                is_synced,
                created_at
            ) VALUES (
                NULL, $1, CURRENT_DATE, $2, $3, $4, $5, $6, FALSE, CURRENT_TIMESTAMP
            )
            RETURNING *
        `;
        
        const scores = {
            technique: techniqueScore,
            speed: speedScore,
            endurance: enduranceScore,
            mental: mentalScore
        };

        const result = await db.query(query, [
            coachId, location, JSON.stringify(scores), overallScore, potential, notes
        ]);

        res.status(201).json({
            success: true,
            message: 'Évaluation enregistrée',
            data: {
                evaluation: result.rows[0],
                athleteInfo: { name: athleteName, age, club, discipline },
                syncStatus: 'pending'
            }
        });
    } catch (error) {
        console.error('Create talent evaluation error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de l\'évaluation'
        });
    }
};

/**
 * @desc    Get pending scouting evaluations
 * @route   GET /api/coach/scouting/pending
 * @access  Private (Coach only)
 */
const getPendingEvaluations = async (req, res) => {
    try {
        const coachId = req.user.id;

        const query = `
            SELECT *
            FROM talent_evaluations
            WHERE scout_id = $1 AND is_synced = FALSE
            ORDER BY created_at DESC
        `;
        const result = await db.query(query, [coachId]);

        res.json({
            success: true,
            count: result.rows.length,
            data: result.rows
        });
    } catch (error) {
        console.error('Get pending evaluations error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération'
        });
    }
};

/**
 * @desc    Sync pending evaluations
 * @route   POST /api/coach/scouting/sync
 * @access  Private (Coach only)
 */
const syncEvaluations = async (req, res) => {
    try {
        const coachId = req.user.id;

        // Mark all pending as synced
        const query = `
            UPDATE talent_evaluations
            SET is_synced = TRUE
            WHERE scout_id = $1 AND is_synced = FALSE
            RETURNING *
        `;
        const result = await db.query(query, [coachId]);

        res.json({
            success: true,
            message: `${result.rows.length} évaluations synchronisées`,
            syncedCount: result.rows.length
        });
    } catch (error) {
        console.error('Sync evaluations error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la synchronisation'
        });
    }
};

/**
 * @desc    Get coach messages/conversations
 * @route   GET /api/coach/messages
 * @access  Private (Coach only)
 */
const getMessages = async (req, res) => {
    try {
        const coachId = req.user.id;

        // Get conversations with athletes, doctors, federation
        const query = `
            SELECT 
                u.id as contact_id,
                u.email,
                a.first_name || ' ' || a.last_name as athlete_name,
                d.first_name || ' ' || d.last_name as doctor_name,
                f.name as federation_name,
                m.content as last_message,
                m.created_at as last_message_date,
                COUNT(CASE WHEN m2.is_read = FALSE AND m2.receiver_id = $1 THEN 1 END) as unread_count
            FROM users u
            LEFT JOIN athletes a ON a.user_id = u.id
            LEFT JOIN doctors d ON d.user_id = u.id
            LEFT JOIN federation_admins fa ON fa.user_id = u.id
            LEFT JOIN federations f ON fa.federation_id = f.id
            LEFT JOIN messages m ON (m.sender_id = u.id OR m.receiver_id = u.id)
                AND m.id = (
                    SELECT id FROM messages 
                    WHERE (sender_id = u.id AND receiver_id = $1) 
                       OR (sender_id = $1 AND receiver_id = u.id)
                    ORDER BY created_at DESC LIMIT 1
                )
            LEFT JOIN messages m2 ON (m2.sender_id = u.id OR m2.receiver_id = u.id)
            WHERE u.id != $1
            AND (a.current_club_id = (SELECT current_club_id FROM coaches WHERE user_id = $1)
                 OR d.id IS NOT NULL 
                 OR fa.id IS NOT NULL)
            GROUP BY u.id, u.email, a.first_name, a.last_name, d.first_name, d.last_name, f.name, m.content, m.created_at
            ORDER BY m.created_at DESC NULLS LAST
        `;
        const result = await db.query(query, [coachId]);

        res.json({
            success: true,
            data: result.rows
        });
    } catch (error) {
        console.error('Get messages error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération des messages'
        });
    }
};

/**
 * @desc    Get conversation with specific user
 * @route   GET /api/coach/messages/:userId
 * @access  Private (Coach only)
 */
const getConversation = async (req, res) => {
    try {
        const coachId = req.user.id;
        const otherUserId = req.params.userId;
        const { page = 1, limit = 50 } = req.query;

        const query = `
            SELECT *
            FROM messages
            WHERE (sender_id = $1 AND receiver_id = $2)
               OR (sender_id = $2 AND receiver_id = $1)
            ORDER BY created_at DESC
            LIMIT $3 OFFSET $4
        `;
        const result = await db.query(query, [
            coachId, otherUserId, parseInt(limit), (parseInt(page) - 1) * parseInt(limit)
        ]);

        // Mark messages as read
        await db.query(`
            UPDATE messages
            SET is_read = TRUE
            WHERE receiver_id = $1 AND sender_id = $2 AND is_read = FALSE
        `, [coachId, otherUserId]);

        res.json({
            success: true,
            data: result.rows.reverse() // Reverse to show oldest first
        });
    } catch (error) {
        console.error('Get conversation error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de la récupération'
        });
    }
};

/**
 * @desc    Send message
 * @route   POST /api/coach/messages
 * @access  Private (Coach only)
 */
const sendMessage = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                success: false,
                message: 'Données invalides',
                errors: errors.array()
            });
        }

        const coachId = req.user.id;
        const { receiverId, content } = req.body;

        const query = `
            INSERT INTO messages (sender_id, receiver_id, content, is_read, created_at)
            VALUES ($1, $2, $3, FALSE, CURRENT_TIMESTAMP)
            RETURNING *
        `;
        const result = await db.query(query, [coachId, receiverId, content]);

        // Create notification for receiver
        await db.query(`
            INSERT INTO notifications (user_id, type, title, message, created_at)
            VALUES ($1, 'SYSTEM', 'Nouveau message', 'Vous avez reçu un message de votre entraîneur', CURRENT_TIMESTAMP)
        `, [receiverId]);

        res.status(201).json({
            success: true,
            message: 'Message envoyé',
            data: result.rows[0]
        });
    } catch (error) {
        console.error('Send message error:', error);
        res.status(500).json({
            success: false,
            message: 'Erreur lors de l\'envoi'
        });
    }
};

module.exports = {
    getDashboardStats,
    getAthletes,
    getAthleteDetails,
    addPerformanceEntry,
    getTrainingSessions,
    createTrainingSession,
    updateTrainingSession,
    deleteTrainingSession,
    getPerformanceAnalysis,
    getCompetitions,
    getMatchSheet,
    submitMatchResults,
    createTalentEvaluation,
    getPendingEvaluations,
    syncEvaluations,
    getMessages,
    getConversation,
    sendMessage
};
