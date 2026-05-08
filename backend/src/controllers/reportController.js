const pool = require('../config/db');

// ==================== REPORTS & ANALYTICS ====================

// Generate user activity report
exports.generateUserActivityReport = async (req, res) => {
  try {
    const { startDate, endDate, role, federationId } = req.query;

    let dateFilter = '';
    const params = [];
    let paramIndex = 1;

    if (startDate && endDate) {
      dateFilter = `AND u.created_at BETWEEN $${paramIndex} AND $${paramIndex + 1}`;
      params.push(startDate, endDate);
      paramIndex += 2;
    } else if (startDate) {
      dateFilter = `AND u.created_at >= $${paramIndex}`;
      params.push(startDate);
      paramIndex++;
    } else if (endDate) {
      dateFilter = `AND u.created_at <= $${paramIndex}`;
      params.push(endDate);
      paramIndex++;
    }

    let roleFilter = '';
    if (role) {
      roleFilter = `AND r.name = $${paramIndex}`;
      params.push(role.toUpperCase());
      paramIndex++;
    }

    let federationFilter = '';
    if (federationId) {
      federationFilter = `AND (a.federation_id = $${paramIndex} OR l.federation_id = $${paramIndex})`;
      params.push(federationId);
      paramIndex++;
    }

    // Federation admin restriction
    if (req.user.role === 'ADMIN_FEDERATION') {
      federationFilter = `AND (a.federation_id = $${paramIndex} OR l.federation_id = $${paramIndex})`;
      params.push(req.user.federationId);
      paramIndex++;
    }

    const query = `
      SELECT
        r.name as role,
        COUNT(*) as total_users,
        COUNT(*) FILTER (WHERE u.is_active = true) as active_users,
        COUNT(*) FILTER (WHERE u.is_active = false) as inactive_users,
        COUNT(*) FILTER (WHERE u.email_verified = true) as verified_users,
        COUNT(*) FILTER (WHERE u.last_login >= CURRENT_DATE - INTERVAL '30 days') as recently_active,
        DATE_TRUNC('month', u.created_at) as registration_month
      FROM users u
      JOIN roles r ON u.role_id = r.id
      LEFT JOIN athletes a ON u.id = a.user_id
      LEFT JOIN licenses l ON a.user_id = l.athlete_id
      WHERE 1=1 ${dateFilter} ${roleFilter} ${federationFilter}
      GROUP BY r.name, DATE_TRUNC('month', u.created_at)
      ORDER BY registration_month DESC, r.name
    `;

    const result = await pool.query(query, params);

    res.status(200).json({
      success: true,
      data: {
        reportType: 'user_activity',
        period: { startDate, endDate },
        results: result.rows
      }
    });
  } catch (error) {
    console.error('Generate user activity report error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la génération du rapport'
    });
  }
};

// Generate license report
exports.generateLicenseReport = async (req, res) => {
  try {
    const { season, federationId, status, startDate, endDate } = req.query;

    const params = [];
    let paramIndex = 1;
    const conditions = ['1=1'];

    if (season) {
      conditions.push(`l.season = $${paramIndex}`);
      params.push(season);
      paramIndex++;
    }

    if (status) {
      conditions.push(`l.status = $${paramIndex}`);
      params.push(status.toUpperCase());
      paramIndex++;
    }

    if (federationId) {
      conditions.push(`l.federation_id = $${paramIndex}`);
      params.push(federationId);
      paramIndex++;
    }

    // Federation admin restriction
    if (req.user.role === 'ADMIN_FEDERATION') {
      conditions.push(`l.federation_id = $${paramIndex}`);
      params.push(req.user.federationId);
      paramIndex++;
    }

    if (startDate) {
      conditions.push(`l.created_at >= $${paramIndex}`);
      params.push(startDate);
      paramIndex++;
    }

    if (endDate) {
      conditions.push(`l.created_at <= $${paramIndex}`);
      params.push(endDate);
      paramIndex++;
    }

    const whereClause = conditions.join(' AND ');

    // Summary stats
    const summaryQuery = `
      SELECT
        COUNT(*) as total_licenses,
        COUNT(*) FILTER (WHERE l.status = 'APPROVED') as approved,
        COUNT(*) FILTER (WHERE l.status = 'PENDING') as pending,
        COUNT(*) FILTER (WHERE l.status = 'REJECTED') as rejected,
        COUNT(*) FILTER (WHERE l.status = 'SUSPENDED') as suspended,
        COUNT(*) FILTER (WHERE l.status = 'EXPIRED') as expired,
        COUNT(DISTINCT l.federation_id) as federations_count,
        COUNT(DISTINCT l.club_id) as clubs_count,
        COALESCE(SUM(p.amount) FILTER (WHERE p.status = 'COMPLETED'), 0) as total_revenue
      FROM licenses l
      LEFT JOIN payments p ON l.id = p.license_id
      WHERE ${whereClause}
    `;

    const summaryResult = await pool.query(summaryQuery, params);

    // By federation
    const byFederationQuery = `
      SELECT
        f.name as federation_name,
        f.acronym,
        COUNT(*) as license_count,
        COUNT(*) FILTER (WHERE l.status = 'APPROVED') as approved_count,
        COALESCE(SUM(p.amount) FILTER (WHERE p.status = 'COMPLETED'), 0) as revenue
      FROM licenses l
      JOIN federations f ON l.federation_id = f.id
      LEFT JOIN payments p ON l.id = p.license_id
      WHERE ${whereClause}
      GROUP BY f.id, f.name, f.acronym
      ORDER BY license_count DESC
    `;

    const byFederationResult = await pool.query(byFederationQuery, params);

    // By month
    const byMonthQuery = `
      SELECT
        DATE_TRUNC('month', l.created_at) as month,
        COUNT(*) as license_count,
        COUNT(*) FILTER (WHERE l.status = 'APPROVED') as approved_count
      FROM licenses l
      WHERE ${whereClause}
      GROUP BY DATE_TRUNC('month', l.created_at)
      ORDER BY month DESC
    `;

    const byMonthResult = await pool.query(byMonthQuery, params);

    res.status(200).json({
      success: true,
      data: {
        reportType: 'license_summary',
        period: { startDate, endDate, season },
        summary: summaryResult.rows[0],
        byFederation: byFederationResult.rows,
        byMonth: byMonthResult.rows
      }
    });
  } catch (error) {
    console.error('Generate license report error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la génération du rapport'
    });
  }
};

// Generate financial report
exports.generateFinancialReport = async (req, res) => {
  try {
    const { startDate, endDate, federationId, provider } = req.query;

    const params = [];
    let paramIndex = 1;
    const conditions = ['p.status = \'COMPLETED\''];

    if (startDate) {
      conditions.push(`p.paid_at >= $${paramIndex}`);
      params.push(startDate);
      paramIndex++;
    }

    if (endDate) {
      conditions.push(`p.paid_at <= $${paramIndex}`);
      params.push(endDate);
      paramIndex++;
    }

    if (federationId) {
      conditions.push(`l.federation_id = $${paramIndex}`);
      params.push(federationId);
      paramIndex++;
    }

    // Federation admin restriction
    if (req.user.role === 'ADMIN_FEDERATION') {
      conditions.push(`l.federation_id = $${paramIndex}`);
      params.push(req.user.federationId);
      paramIndex++;
    }

    if (provider) {
      conditions.push(`p.provider = $${paramIndex}`);
      params.push(provider.toUpperCase());
      paramIndex++;
    }

    const whereClause = conditions.join(' AND ');

    // Overall summary
    const summaryQuery = `
      SELECT
        COALESCE(SUM(p.amount), 0) as total_revenue,
        COUNT(*) as total_transactions,
        AVG(p.amount) as avg_transaction,
        COUNT(DISTINCT l.federation_id) as federations_count
      FROM payments p
      JOIN licenses l ON p.license_id = l.id
      WHERE ${whereClause}
    `;

    const summaryResult = await pool.query(summaryQuery, params);

    // By federation
    const byFederationQuery = `
      SELECT
        f.name as federation_name,
        f.acronym,
        COALESCE(SUM(p.amount), 0) as revenue,
        COUNT(*) as transaction_count
      FROM payments p
      JOIN licenses l ON p.license_id = l.id
      JOIN federations f ON l.federation_id = f.id
      WHERE ${whereClause}
      GROUP BY f.id, f.name, f.acronym
      ORDER BY revenue DESC
    `;

    const byFederationResult = await pool.query(byFederationQuery, params);

    // By provider (Mobile Money)
    const byProviderQuery = `
      SELECT
        p.provider,
        COALESCE(SUM(p.amount), 0) as revenue,
        COUNT(*) as transaction_count
      FROM payments p
      JOIN licenses l ON p.license_id = l.id
      WHERE ${whereClause}
      GROUP BY p.provider
      ORDER BY revenue DESC
    `;

    const byProviderResult = await pool.query(byProviderQuery, params);

    // By month
    const byMonthQuery = `
      SELECT
        DATE_TRUNC('month', p.paid_at) as month,
        COALESCE(SUM(p.amount), 0) as revenue,
        COUNT(*) as transaction_count
      FROM payments p
      JOIN licenses l ON p.license_id = l.id
      WHERE ${whereClause}
      GROUP BY DATE_TRUNC('month', p.paid_at)
      ORDER BY month DESC
    `;

    const byMonthResult = await pool.query(byMonthQuery, params);

    res.status(200).json({
      success: true,
      data: {
        reportType: 'financial',
        period: { startDate, endDate },
        summary: summaryResult.rows[0],
        byFederation: byFederationResult.rows,
        byProvider: byProviderResult.rows,
        byMonth: byMonthResult.rows
      }
    });
  } catch (error) {
    console.error('Generate financial report error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la génération du rapport financier'
    });
  }
};

// Generate athletes performance report
exports.generateAthletePerformanceReport = async (req, res) => {
  try {
    const { federationId, clubId, sportType, season } = req.query;

    const params = [];
    let paramIndex = 1;
    const conditions = ['1=1'];

    if (federationId) {
      conditions.push(`a.federation_id = $${paramIndex}`);
      params.push(federationId);
      paramIndex++;
    }

    if (clubId) {
      conditions.push(`a.current_club_id = $${paramIndex}`);
      params.push(clubId);
      paramIndex++;
    }

    if (sportType) {
      conditions.push(`a.sport_type = $${paramIndex}`);
      params.push(sportType);
      paramIndex++;
    }

    // Federation admin restriction
    if (req.user.role === 'ADMIN_FEDERATION') {
      conditions.push(`a.federation_id = $${paramIndex}`);
      params.push(req.user.federationId);
      paramIndex++;
    }

    if (season) {
      conditions.push(`l.season = $${paramIndex}`);
      params.push(season);
      paramIndex++;
    }

    const whereClause = conditions.join(' AND ');

    // Athletes summary
    const summaryQuery = `
      SELECT
        COUNT(DISTINCT a.user_id) as total_athletes,
        COUNT(DISTINCT a.user_id) FILTER (WHERE a.national_team_eligible = true) as national_eligible,
        COUNT(DISTINCT l.id) FILTER (WHERE l.status = 'APPROVED') as active_licenses,
        AVG(a.height) as avg_height,
        AVG(a.weight) as avg_weight,
        COUNT(DISTINCT a.current_club_id) as clubs_count
      FROM athletes a
      LEFT JOIN licenses l ON a.user_id = l.athlete_id
      WHERE ${whereClause}
    `;

    const summaryResult = await pool.query(summaryQuery, params);

    // By sport type
    const bySportQuery = `
      SELECT
        a.sport_type,
        COUNT(DISTINCT a.user_id) as athlete_count,
        COUNT(DISTINCT l.id) FILTER (WHERE l.status = 'APPROVED') as licensed_count
      FROM athletes a
      LEFT JOIN licenses l ON a.user_id = l.athlete_id
      WHERE ${whereClause}
      GROUP BY a.sport_type
      ORDER BY athlete_count DESC
    `;

    const bySportResult = await pool.query(bySportQuery, params);

    // By age group
    const byAgeQuery = `
      SELECT
        CASE
          WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, a.birth_date)) < 18 THEN 'U18'
          WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, a.birth_date)) < 23 THEN 'U23'
          WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, a.birth_date)) < 30 THEN 'Senior'
          ELSE 'Veteran'
        END as age_group,
        COUNT(DISTINCT a.user_id) as athlete_count
      FROM athletes a
      LEFT JOIN licenses l ON a.user_id = l.athlete_id
      WHERE ${whereClause} AND a.birth_date IS NOT NULL
      GROUP BY 1
      ORDER BY 1
    `;

    const byAgeResult = await pool.query(byAgeQuery, params);

    res.status(200).json({
      success: true,
      data: {
        reportType: 'athlete_performance',
        season,
        summary: summaryResult.rows[0],
        bySport: bySportResult.rows,
        byAgeGroup: byAgeResult.rows
      }
    });
  } catch (error) {
    console.error('Generate athlete report error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la génération du rapport athlètes'
    });
  }
};

// Get dashboard analytics
exports.getDashboardAnalytics = async (req, res) => {
  try {
    const analytics = {};

    // Date ranges
    const today = new Date().toISOString().split('T')[0];
    const thirtyDaysAgo = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0];

    // User stats
    const userStats = await pool.query(`
      SELECT
        COUNT(*) FILTER (WHERE is_active = true) as total_active,
        COUNT(*) FILTER (WHERE created_at >= $1) as new_this_month,
        COUNT(*) FILTER (WHERE last_login >= $1) as active_this_month
      FROM users
    `, [thirtyDaysAgo]);
    analytics.users = userStats.rows[0];

    // License stats (current season)
    const currentYear = new Date().getFullYear();
    const season = `${currentYear}-${currentYear + 1}`;

    const licenseStats = await pool.query(`
      SELECT
        COUNT(*) FILTER (WHERE status = 'APPROVED') as approved,
        COUNT(*) FILTER (WHERE status = 'PENDING') as pending,
        COUNT(*) FILTER (WHERE status = 'REJECTED') as rejected,
        COUNT(*) FILTER (WHERE created_at >= $1) as created_this_month
      FROM licenses
      WHERE season = $2
    `, [thirtyDaysAgo, season]);
    analytics.licenses = licenseStats.rows[0];

    // Revenue stats (current month)
    const revenueStats = await pool.query(`
      SELECT
        COALESCE(SUM(amount), 0) as total,
        COUNT(*) as transaction_count
      FROM payments
      WHERE status = 'COMPLETED' AND paid_at >= DATE_TRUNC('month', CURRENT_DATE)
    `);
    analytics.revenue = revenueStats.rows[0];

    // Recent activity
    const recentActivity = await pool.query(`
      SELECT
        al.action,
        al.entity_type,
        al.created_at,
        u.email as user_email
      FROM audit_logs al
      JOIN users u ON al.user_id = u.id
      ORDER BY al.created_at DESC
      LIMIT 10
    `);
    analytics.recentActivity = recentActivity.rows;

    // Federation stats (if super admin)
    if (req.user.role === 'ADMIN' || req.user.adminLevel === 'SUPER') {
      const federationStats = await pool.query(`
        SELECT
          f.name,
          f.acronym,
          (SELECT COUNT(*) FROM licenses WHERE federation_id = f.id AND season = $1) as license_count
        FROM federations f
        WHERE f.is_active = true
        ORDER BY license_count DESC
        LIMIT 5
      `, [season]);
      analytics.topFederations = federationStats.rows;
    }

    res.status(200).json({
      success: true,
      data: analytics
    });
  } catch (error) {
    console.error('Get dashboard analytics error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération des analytics'
    });
  }
};

// Export report (CSV/JSON)
exports.exportReport = async (req, res) => {
  try {
    const { type, format = 'json', startDate, endDate, federationId } = req.query;

    let data;
    let filename;

    switch (type) {
      case 'users':
        const usersResult = await pool.query(`
          SELECT
            u.id,
            u.email,
            u.nin,
            u.phone,
            r.name as role,
            u.is_active,
            u.created_at,
            u.last_login,
            COALESCE(a.first_name, c.first_name, s.first_name, d.first_name) as first_name,
            COALESCE(a.last_name, c.last_name, s.last_name, d.last_name) as last_name
          FROM users u
          JOIN roles r ON u.role_id = r.id
          LEFT JOIN athletes a ON u.id = a.user_id
          LEFT JOIN coaches c ON u.id = c.user_id
          LEFT JOIN scouts s ON u.id = s.user_id
          LEFT JOIN doctors d ON u.id = d.user_id
          WHERE u.created_at BETWEEN $1 AND $2
        `, [startDate || '1970-01-01', endDate || '2099-12-31']);
        data = usersResult.rows;
        filename = `users_export_${new Date().toISOString().split('T')[0]}`;
        break;

      case 'licenses':
        let licenseConditions = 'l.created_at BETWEEN $1 AND $2';
        const licenseParams = [startDate || '1970-01-01', endDate || '2099-12-31'];

        if (federationId || req.user.federationId) {
          licenseConditions += ` AND l.federation_id = $3`;
          licenseParams.push(federationId || req.user.federationId);
        }

        const licensesResult = await pool.query(`
          SELECT
            l.license_number,
            l.season,
            l.status,
            l.issue_date,
            l.expiry_date,
            a.first_name as athlete_first_name,
            a.last_name as athlete_last_name,
            f.name as federation_name,
            c.name as club_name,
            p.amount,
            p.status as payment_status
          FROM licenses l
          JOIN athletes a ON l.athlete_id = a.user_id
          JOIN federations f ON l.federation_id = f.id
          LEFT JOIN clubs c ON l.club_id = c.id
          LEFT JOIN payments p ON p.license_id = l.id
          WHERE ${licenseConditions}
        `, licenseParams);
        data = licensesResult.rows;
        filename = `licenses_export_${new Date().toISOString().split('T')[0]}`;
        break;

      default:
        return res.status(400).json({
          success: false,
          message: 'Type de rapport non supporté'
        });
    }

    if (format === 'csv') {
      // Simple CSV conversion
      if (data.length === 0) {
        return res.status(200).send('');
      }

      const headers = Object.keys(data[0]).join(',');
      const rows = data.map(row =>
        Object.values(row).map(val =>
          typeof val === 'string' && val.includes(',') ? `"${val}"` : val
        ).join(',')
      ).join('\n');

      res.setHeader('Content-Type', 'text/csv');
      res.setHeader('Content-Disposition', `attachment; filename="${filename}.csv"`);
      return res.send(`${headers}\n${rows}`);
    }

    res.status(200).json({
      success: true,
      data,
      exportInfo: {
        type,
        format,
        recordCount: data.length,
        generatedAt: new Date().toISOString()
      }
    });
  } catch (error) {
    console.error('Export report error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de l\'export du rapport'
    });
  }
};
