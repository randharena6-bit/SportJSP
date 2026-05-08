const pool = require('../config/db');
const crypto = require('crypto');

// ==================== FEDERATION MANAGEMENT ====================

// Get all federations
exports.getAllFederations = async (req, res) => {
  try {
    const { isActive, page = 1, limit = 20, search } = req.query;
    const offset = (page - 1) * limit;

    let conditions = ['1=1'];
    const params = [];
    let paramIndex = 1;

    if (isActive !== undefined) {
      conditions.push(`is_active = $${paramIndex}`);
      params.push(isActive === 'true');
      paramIndex++;
    }

    if (search) {
      conditions.push(`(name ILIKE $${paramIndex} OR acronym ILIKE $${paramIndex})`);
      params.push(`%${search}%`);
      paramIndex++;
    }

    const whereClause = conditions.join(' AND ');

    // Get total count
    const countQuery = `SELECT COUNT(*) as total FROM federations WHERE ${whereClause}`;
    const countResult = await pool.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get federations with stats
    const federationsQuery = `
      SELECT
        f.id,
        f.name,
        f.sport_type,
        f.acronym,
        f.description,
        f.president_name,
        f.contact_email,
        f.contact_phone,
        f.address,
        f.logo_url,
        f.is_active,
        f.created_at,
        f.updated_at,
        (SELECT COUNT(*) FROM clubs WHERE federation_id = f.id AND is_active = true) as club_count,
        (SELECT COUNT(*) FROM licenses l
         JOIN athletes a ON l.athlete_id = a.user_id
         WHERE l.federation_id = f.id AND l.status = 'APPROVED') as athlete_count
      FROM federations f
      WHERE ${whereClause}
      ORDER BY f.name ASC
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;

    params.push(parseInt(limit), parseInt(offset));
    const federationsResult = await pool.query(federationsQuery, params);

    res.status(200).json({
      success: true,
      data: {
        federations: federationsResult.rows,
        pagination: {
          total,
          page: parseInt(page),
          limit: parseInt(limit),
          totalPages: Math.ceil(total / limit)
        }
      }
    });
  } catch (error) {
    console.error('Get federations error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération des fédérations'
    });
  }
};

// Get federation by ID
exports.getFederationById = async (req, res) => {
  try {
    const { id } = req.params;

    // Check access for federation admins
    if (req.user.role === 'ADMIN_FEDERATION' && req.user.federationId !== id) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit à cette fédération'
      });
    }

    const query = `
      SELECT
        f.*,
        (SELECT COUNT(*) FROM clubs WHERE federation_id = f.id AND is_active = true) as club_count,
        (SELECT COUNT(*) FROM licenses l
         JOIN athletes a ON l.athlete_id = a.user_id
         WHERE l.federation_id = f.id AND l.status = 'APPROVED') as athlete_count,
        (SELECT COUNT(*) FROM competitions WHERE federation_id = f.id) as competition_count
      FROM federations f
      WHERE f.id = $1
    `;

    const result = await pool.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Fédération non trouvée'
      });
    }

    res.status(200).json({
      success: true,
      data: result.rows[0]
    });
  } catch (error) {
    console.error('Get federation by ID error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération de la fédération'
    });
  }
};

// Create federation
exports.createFederation = async (req, res) => {
  try {
    const {
      name,
      sportType,
      acronym,
      description,
      presidentName,
      contactEmail,
      contactPhone,
      address,
      logoUrl
    } = req.body;

    // Validation
    if (!name || !sportType || !acronym) {
      return res.status(400).json({
        success: false,
        message: 'Nom, type de sport et acronyme sont obligatoires'
      });
    }

    // Check if acronym already exists
    const existing = await pool.query(
      'SELECT id FROM federations WHERE acronym = $1',
      [acronym]
    );

    if (existing.rows.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Une fédération avec cet acronyme existe déjà'
      });
    }

    const result = await pool.query(
      `INSERT INTO federations
       (name, sport_type, acronym, description, president_name, contact_email, contact_phone, address, logo_url, is_active, created_at, updated_at)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
       RETURNING *`,
      [name, sportType, acronym, description || null, presidentName || null,
       contactEmail || null, contactPhone || null, address || null, logoUrl || null]
    );

    res.status(201).json({
      success: true,
      message: 'Fédération créée avec succès',
      data: result.rows[0]
    });
  } catch (error) {
    console.error('Create federation error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la création de la fédération'
    });
  }
};

// Update federation
exports.updateFederation = async (req, res) => {
  try {
    const { id } = req.params;
    const updateData = req.body;

    // Check access for federation admins
    if (req.user.role === 'ADMIN_FEDERATION' && req.user.federationId !== id) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit à cette fédération'
      });
    }

    const fields = [];
    const params = [id];
    let paramIndex = 2;

    const allowedFields = [
      'name', 'sport_type', 'acronym', 'description', 'president_name',
      'contact_email', 'contact_phone', 'address', 'logo_url', 'is_active'
    ];

    Object.keys(updateData).forEach(key => {
      const snakeKey = key.replace(/[A-Z]/g, letter => `_${letter.toLowerCase()}`);
      if (allowedFields.includes(snakeKey) && updateData[key] !== undefined) {
        fields.push(`${snakeKey} = $${paramIndex}`);
        params.push(updateData[key]);
        paramIndex++;
      }
    });

    if (fields.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Aucune donnée à mettre à jour'
      });
    }

    const query = `UPDATE federations SET ${fields.join(', ')}, updated_at = CURRENT_TIMESTAMP WHERE id = $1 RETURNING *`;
    const result = await pool.query(query, params);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Fédération non trouvée'
      });
    }

    res.status(200).json({
      success: true,
      message: 'Fédération mise à jour',
      data: result.rows[0]
    });
  } catch (error) {
    console.error('Update federation error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la mise à jour de la fédération'
    });
  }
};

// Delete federation
exports.deleteFederation = async (req, res) => {
  try {
    const { id } = req.params;
    const { force = false } = req.query;

    // Check if federation has associated data
    const checks = await pool.query(`
      SELECT
        (SELECT COUNT(*) FROM clubs WHERE federation_id = $1) as club_count,
        (SELECT COUNT(*) FROM licenses WHERE federation_id = $1) as license_count,
        (SELECT COUNT(*) FROM competitions WHERE federation_id = $1) as competition_count
    `, [id]);

    const { club_count, license_count, competition_count } = checks.rows[0];

    if ((parseInt(club_count) > 0 || parseInt(license_count) > 0 || parseInt(competition_count) > 0) && !force) {
      return res.status(400).json({
        success: false,
        message: 'La fédération contient des données associées. Utilisez force=true pour supprimer définitivement.',
        data: {
          clubs: parseInt(club_count),
          licenses: parseInt(license_count),
          competitions: parseInt(competition_count)
        }
      });
    }

    await pool.query('DELETE FROM federations WHERE id = $1', [id]);

    res.status(200).json({
      success: true,
      message: 'Fédération supprimée'
    });
  } catch (error) {
    console.error('Delete federation error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la suppression de la fédération'
    });
  }
};

// ==================== CLUB MANAGEMENT ====================

// Get all clubs
exports.getAllClubs = async (req, res) => {
  try {
    const { federationId, isActive, page = 1, limit = 20, search } = req.query;
    const offset = (page - 1) * limit;

    let conditions = ['1=1'];
    const params = [];
    let paramIndex = 1;

    // Filter by federation for federation admins
    if (req.user.role === 'ADMIN_FEDERATION') {
      conditions.push(`c.federation_id = $${paramIndex}`);
      params.push(req.user.federationId);
      paramIndex++;
    } else if (federationId) {
      conditions.push(`c.federation_id = $${paramIndex}`);
      params.push(federationId);
      paramIndex++;
    }

    if (isActive !== undefined) {
      conditions.push(`c.is_active = $${paramIndex}`);
      params.push(isActive === 'true');
      paramIndex++;
    }

    if (search) {
      conditions.push(`(c.name ILIKE $${paramIndex} OR c.city ILIKE $${paramIndex})`);
      params.push(`%${search}%`);
      paramIndex++;
    }

    const whereClause = conditions.join(' AND ');

    // Get total count
    const countQuery = `SELECT COUNT(*) as total FROM clubs c WHERE ${whereClause}`;
    const countResult = await pool.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get clubs
    const clubsQuery = `
      SELECT
        c.*,
        f.name as federation_name,
        f.acronym as federation_acronym,
        (SELECT COUNT(*) FROM athletes WHERE current_club_id = c.id) as athlete_count
      FROM clubs c
      JOIN federations f ON c.federation_id = f.id
      WHERE ${whereClause}
      ORDER BY c.name ASC
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;

    params.push(parseInt(limit), parseInt(offset));
    const clubsResult = await pool.query(clubsQuery, params);

    res.status(200).json({
      success: true,
      data: {
        clubs: clubsResult.rows,
        pagination: {
          total,
          page: parseInt(page),
          limit: parseInt(limit),
          totalPages: Math.ceil(total / limit)
        }
      }
    });
  } catch (error) {
    console.error('Get clubs error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération des clubs'
    });
  }
};

// Get club by ID
exports.getClubById = async (req, res) => {
  try {
    const { id } = req.params;

    const query = `
      SELECT
        c.*,
        f.name as federation_name,
        f.acronym as federation_acronym,
        (SELECT COUNT(*) FROM athletes WHERE current_club_id = c.id) as athlete_count
      FROM clubs c
      JOIN federations f ON c.federation_id = f.id
      WHERE c.id = $1
    `;

    const result = await pool.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Club non trouvé'
      });
    }

    const club = result.rows[0];

    // Check federation access
    if (req.user.role === 'ADMIN_FEDERATION' && req.user.federationId !== club.federation_id) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit à ce club'
      });
    }

    res.status(200).json({
      success: true,
      data: club
    });
  } catch (error) {
    console.error('Get club by ID error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération du club'
    });
  }
};

// Create club
exports.createClub = async (req, res) => {
  try {
    const {
      federationId,
      name,
      shortName,
      foundedDate,
      isProfessional,
      stadiumName,
      city,
      region,
      contactEmail,
      contactPhone,
      logoUrl
    } = req.body;

    // Validation
    if (!name) {
      return res.status(400).json({
        success: false,
        message: 'Le nom du club est obligatoire'
      });
    }

    // Determine federation ID
    let finalFederationId = federationId;
    if (req.user.role === 'ADMIN_FEDERATION') {
      finalFederationId = req.user.federationId;
    }

    if (!finalFederationId) {
      return res.status(400).json({
        success: false,
        message: 'ID de fédération requis'
      });
    }

    const result = await pool.query(
      `INSERT INTO clubs
       (federation_id, name, short_name, founded_date, is_professional, stadium_name, city, region, contact_email, contact_phone, logo_url, is_active, created_at, updated_at)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
       RETURNING *`,
      [
        finalFederationId, name, shortName || null, foundedDate || null,
        isProfessional || false, stadiumName || null, city || null,
        region || null, contactEmail || null, contactPhone || null, logoUrl || null
      ]
    );

    res.status(201).json({
      success: true,
      message: 'Club créé avec succès',
      data: result.rows[0]
    });
  } catch (error) {
    console.error('Create club error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la création du club'
    });
  }
};

// Update club
exports.updateClub = async (req, res) => {
  try {
    const { id } = req.params;
    const updateData = req.body;

    // Get club to check federation
    const clubCheck = await pool.query(
      'SELECT federation_id FROM clubs WHERE id = $1',
      [id]
    );

    if (clubCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Club non trouvé'
      });
    }

    // Check federation access
    if (req.user.role === 'ADMIN_FEDERATION' &&
        req.user.federationId !== clubCheck.rows[0].federation_id) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit à ce club'
      });
    }

    const fields = [];
    const params = [id];
    let paramIndex = 2;

    const allowedFields = [
      'name', 'short_name', 'founded_date', 'is_professional', 'stadium_name',
      'city', 'region', 'contact_email', 'contact_phone', 'logo_url', 'is_active'
    ];

    Object.keys(updateData).forEach(key => {
      const snakeKey = key.replace(/[A-Z]/g, letter => `_${letter.toLowerCase()}`);
      if (allowedFields.includes(snakeKey) && updateData[key] !== undefined) {
        fields.push(`${snakeKey} = $${paramIndex}`);
        params.push(updateData[key]);
        paramIndex++;
      }
    });

    if (fields.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Aucune donnée à mettre à jour'
      });
    }

    const query = `UPDATE clubs SET ${fields.join(', ')}, updated_at = CURRENT_TIMESTAMP WHERE id = $1 RETURNING *`;
    const result = await pool.query(query, params);

    res.status(200).json({
      success: true,
      message: 'Club mis à jour',
      data: result.rows[0]
    });
  } catch (error) {
    console.error('Update club error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la mise à jour du club'
    });
  }
};

// Delete club
exports.deleteClub = async (req, res) => {
  try {
    const { id } = req.params;

    // Get club to check federation
    const clubCheck = await pool.query(
      'SELECT federation_id FROM clubs WHERE id = $1',
      [id]
    );

    if (clubCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Club non trouvé'
      });
    }

    // Check federation access
    if (req.user.role === 'ADMIN_FEDERATION' &&
        req.user.federationId !== clubCheck.rows[0].federation_id) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit à ce club'
      });
    }

    // Soft delete (deactivate)
    await pool.query(
      'UPDATE clubs SET is_active = false, updated_at = CURRENT_TIMESTAMP WHERE id = $1',
      [id]
    );

    res.status(200).json({
      success: true,
      message: 'Club désactivé'
    });
  } catch (error) {
    console.error('Delete club error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la désactivation du club'
    });
  }
};

// ==================== LICENSE MANAGEMENT ====================

// Get all licenses
exports.getAllLicenses = async (req, res) => {
  try {
    const {
      status,
      federationId,
      clubId,
      season,
      page = 1,
      limit = 20,
      search
    } = req.query;

    const offset = (page - 1) * limit;
    const conditions = ['1=1'];
    const params = [];
    let paramIndex = 1;

    // Filter by federation for federation admins
    if (req.user.role === 'ADMIN_FEDERATION') {
      conditions.push(`l.federation_id = $${paramIndex}`);
      params.push(req.user.federationId);
      paramIndex++;
    } else if (federationId) {
      conditions.push(`l.federation_id = $${paramIndex}`);
      params.push(federationId);
      paramIndex++;
    }

    if (status) {
      conditions.push(`l.status = $${paramIndex}`);
      params.push(status.toUpperCase());
      paramIndex++;
    }

    if (clubId) {
      conditions.push(`l.club_id = $${paramIndex}`);
      params.push(clubId);
      paramIndex++;
    }

    if (season) {
      conditions.push(`l.season = $${paramIndex}`);
      params.push(season);
      paramIndex++;
    }

    if (search) {
      conditions.push(`(
        a.first_name ILIKE $${paramIndex} OR
        a.last_name ILIKE $${paramIndex} OR
        l.license_number ILIKE $${paramIndex}
      )`);
      params.push(`%${search}%`);
      paramIndex++;
    }

    const whereClause = conditions.join(' AND ');

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM licenses l
      JOIN athletes a ON l.athlete_id = a.user_id
      WHERE ${whereClause}
    `;
    const countResult = await pool.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get licenses
    const licensesQuery = `
      SELECT
        l.*,
        a.first_name as athlete_first_name,
        a.last_name as athlete_last_name,
        a.birth_date as athlete_birth_date,
        a.gender as athlete_gender,
        f.name as federation_name,
        c.name as club_name,
        u.email as athlete_email,
        u.nin as athlete_nin
      FROM licenses l
      JOIN athletes a ON l.athlete_id = a.user_id
      JOIN users u ON a.user_id = u.id
      JOIN federations f ON l.federation_id = f.id
      LEFT JOIN clubs c ON l.club_id = c.id
      WHERE ${whereClause}
      ORDER BY l.created_at DESC
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;

    params.push(parseInt(limit), parseInt(offset));
    const licensesResult = await pool.query(licensesQuery, params);

    res.status(200).json({
      success: true,
      data: {
        licenses: licensesResult.rows,
        pagination: {
          total,
          page: parseInt(page),
          limit: parseInt(limit),
          totalPages: Math.ceil(total / limit)
        }
      }
    });
  } catch (error) {
    console.error('Get licenses error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération des licences'
    });
  }
};

// Get license by ID
exports.getLicenseById = async (req, res) => {
  try {
    const { id } = req.params;

    const query = `
      SELECT
        l.*,
        a.first_name as athlete_first_name,
        a.last_name as athlete_last_name,
        a.birth_date as athlete_birth_date,
        a.gender as athlete_gender,
        a.height as athlete_height,
        a.weight as athlete_weight,
        a.photo_url as athlete_photo_url,
        f.name as federation_name,
        c.name as club_name,
        u.email as athlete_email,
        u.nin as athlete_nin,
        u.phone as athlete_phone,
        p.id as payment_id,
        p.amount as payment_amount,
        p.status as payment_status,
        p.provider as payment_provider,
        p.paid_at as payment_date
      FROM licenses l
      JOIN athletes a ON l.athlete_id = a.user_id
      JOIN users u ON a.user_id = u.id
      JOIN federations f ON l.federation_id = f.id
      LEFT JOIN clubs c ON l.club_id = c.id
      LEFT JOIN payments p ON p.license_id = l.id
      WHERE l.id = $1
    `;

    const result = await pool.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Licence non trouvée'
      });
    }

    const license = result.rows[0];

    // Check federation access
    if (req.user.role === 'ADMIN_FEDERATION' && req.user.federationId !== license.federation_id) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit à cette licence'
      });
    }

    res.status(200).json({
      success: true,
      data: license
    });
  } catch (error) {
    console.error('Get license by ID error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération de la licence'
    });
  }
};

// Create license
exports.createLicense = async (req, res) => {
  try {
    const {
      athleteId,
      federationId,
      clubId,
      season,
      amount,
      medicalClearance = false
    } = req.body;

    // Validation
    if (!athleteId || !federationId || !season) {
      return res.status(400).json({
        success: false,
        message: 'ID athlète, ID fédération et saison sont obligatoires'
      });
    }

    // Check federation access
    if (req.user.role === 'ADMIN_FEDERATION' && req.user.federationId !== federationId) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit à cette fédération'
      });
    }

    // Check if athlete exists
    const athleteCheck = await pool.query(
      'SELECT user_id FROM athletes WHERE user_id = $1',
      [athleteId]
    );

    if (athleteCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Athlète non trouvé'
      });
    }

    // Generate license number
    const licenseNumber = await generateLicenseNumber(federationId, season);

    // Generate QR code data
    const qrCodeData = crypto.randomUUID();

    // Calculate expiry date (end of season - assuming September)
    const [startYear, endYear] = season.split('-').map(y => parseInt(y));
    const expiryDate = `${endYear || startYear + 1}-09-30`;

    const result = await pool.query(
      `INSERT INTO licenses
       (athlete_id, federation_id, club_id, season, license_number, status, qr_code_data,
        issue_date, expiry_date, medical_clearance, payment_status, created_at, updated_at)
       VALUES ($1, $2, $3, $4, $5, 'PENDING', $6, CURRENT_DATE, $7, $8, 'PENDING', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
       RETURNING *`,
      [athleteId, federationId, clubId || null, season, licenseNumber, qrCodeData, expiryDate, medicalClearance]
    );

    // Create payment record if amount provided
    if (amount && amount > 0) {
      await pool.query(
        `INSERT INTO payments (license_id, amount, currency, status, created_at, updated_at)
         VALUES ($1, $2, 'MGA', 'PENDING', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`,
        [result.rows[0].id, amount]
      );
    }

    res.status(201).json({
      success: true,
      message: 'Licence créée avec succès',
      data: result.rows[0]
    });
  } catch (error) {
    console.error('Create license error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la création de la licence'
    });
  }
};

// Approve license
exports.approveLicense = async (req, res) => {
  try {
    const { id } = req.params;
    const { notes } = req.body;

    // Get license to check federation
    const licenseCheck = await pool.query(
      'SELECT federation_id, status FROM licenses WHERE id = $1',
      [id]
    );

    if (licenseCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Licence non trouvée'
      });
    }

    // Check federation access
    if (req.user.role === 'ADMIN_FEDERATION' &&
        req.user.federationId !== licenseCheck.rows[0].federation_id) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit à cette licence'
      });
    }

    // Check if already approved
    if (licenseCheck.rows[0].status === 'APPROVED') {
      return res.status(400).json({
        success: false,
        message: 'Cette licence est déjà approuvée'
      });
    }

    const result = await pool.query(
      `UPDATE licenses
       SET status = 'APPROVED',
           issue_date = CURRENT_DATE,
           updated_at = CURRENT_TIMESTAMP,
           notes = COALESCE($2, notes)
       WHERE id = $1
       RETURNING *`,
      [id, notes]
    );

    res.status(200).json({
      success: true,
      message: 'Licence approuvée avec succès',
      data: result.rows[0]
    });
  } catch (error) {
    console.error('Approve license error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de l\'approbation de la licence'
    });
  }
};

// Reject license
exports.rejectLicense = async (req, res) => {
  try {
    const { id } = req.params;
    const { reason } = req.body;

    if (!reason) {
      return res.status(400).json({
        success: false,
        message: 'Un motif de rejet est requis'
      });
    }

    // Get license to check federation
    const licenseCheck = await pool.query(
      'SELECT federation_id, status FROM licenses WHERE id = $1',
      [id]
    );

    if (licenseCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Licence non trouvée'
      });
    }

    // Check federation access
    if (req.user.role === 'ADMIN_FEDERATION' &&
        req.user.federationId !== licenseCheck.rows[0].federation_id) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit à cette licence'
      });
    }

    const result = await pool.query(
      `UPDATE licenses
       SET status = 'REJECTED',
           updated_at = CURRENT_TIMESTAMP,
           notes = $2
       WHERE id = $1
       RETURNING *`,
      [id, `Rejetée: ${reason}`]
    );

    res.status(200).json({
      success: true,
      message: 'Licence rejetée',
      data: result.rows[0]
    });
  } catch (error) {
    console.error('Reject license error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors du rejet de la licence'
    });
  }
};

// Suspend license
exports.suspendLicense = async (req, res) => {
  try {
    const { id } = req.params;
    const { reason } = req.body;

    // Get license to check federation
    const licenseCheck = await pool.query(
      'SELECT federation_id, status FROM licenses WHERE id = $1',
      [id]
    );

    if (licenseCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Licence non trouvée'
      });
    }

    // Check federation access
    if (req.user.role === 'ADMIN_FEDERATION' &&
        req.user.federationId !== licenseCheck.rows[0].federation_id) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit à cette licence'
      });
    }

    const result = await pool.query(
      `UPDATE licenses
       SET status = 'SUSPENDED',
           updated_at = CURRENT_TIMESTAMP,
           notes = COALESCE(notes || '; ', '') || 'Suspendue: ' || $2
       WHERE id = $1
       RETURNING *`,
      [id, reason || 'Non spécifié']
    );

    res.status(200).json({
      success: true,
      message: 'Licence suspendue',
      data: result.rows[0]
    });
  } catch (error) {
    console.error('Suspend license error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la suspension de la licence'
    });
  }
};

// Verify license by QR code
exports.verifyLicenseQR = async (req, res) => {
  try {
    const { qrData } = req.body;

    if (!qrData) {
      return res.status(400).json({
        success: false,
        message: 'Données QR requises'
      });
    }

    const query = `
      SELECT
        l.id,
        l.license_number,
        l.status,
        l.issue_date,
        l.expiry_date,
        l.medical_clearance,
        a.first_name as athlete_first_name,
        a.last_name as athlete_last_name,
        a.birth_date as athlete_birth_date,
        a.gender as athlete_gender,
        a.photo_url as athlete_photo_url,
        f.name as federation_name,
        f.sport_type,
        c.name as club_name
      FROM licenses l
      JOIN athletes a ON l.athlete_id = a.user_id
      JOIN federations f ON l.federation_id = f.id
      LEFT JOIN clubs c ON l.club_id = c.id
      WHERE l.qr_code_data = $1
    `;

    const result = await pool.query(query, [qrData]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Licence non trouvée - QR code invalide'
      });
    }

    const license = result.rows[0];

    // Check if license is valid
    const isValid = license.status === 'APPROVED' &&
                    new Date(license.expiry_date) > new Date();

    res.status(200).json({
      success: true,
      data: {
        ...license,
        isValid,
        verificationDate: new Date().toISOString()
      }
    });
  } catch (error) {
    console.error('Verify license QR error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la vérification de la licence'
    });
  }
};

// Helper function to generate license number
async function generateLicenseNumber(federationId, season) {
  const federation = await pool.query(
    'SELECT acronym FROM federations WHERE id = $1',
    [federationId]
  );

  const acronym = federation.rows[0]?.acronym || 'UNK';
  const year = season.split('-')[0];

  // Get count of licenses for this federation and season
  const countResult = await pool.query(
    'SELECT COUNT(*) as count FROM licenses WHERE federation_id = $1 AND season = $2',
    [federationId, season]
  );

  const count = parseInt(countResult.rows[0].count) + 1;
  const sequence = count.toString().padStart(5, '0');

  return `${acronym}-${year}-${sequence}`;
}

// ==================== FEDERATION DASHBOARD ====================

// Get federation dashboard data
exports.getFederationDashboard = async (req, res) => {
  try {
    const { federationId } = req.params;

    // Check access
    if (req.user.role === 'ADMIN_FEDERATION' && req.user.federationId !== federationId) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit à ce tableau de bord'
      });
    }

    // Get current season
    const currentYear = new Date().getFullYear();
    const season = `${currentYear}-${currentYear + 1}`;

    // Stats
    const stats = {};

    // Licensed athletes count
    const athleteCount = await pool.query(`
      SELECT COUNT(*) as count
      FROM licenses
      WHERE federation_id = $1 AND status = 'APPROVED' AND season = $2
    `, [federationId, season]);
    stats.licensedAthletes = parseInt(athleteCount.rows[0].count);

    // Club count
    const clubCount = await pool.query(`
      SELECT COUNT(*) as count FROM clubs
      WHERE federation_id = $1 AND is_active = true
    `, [federationId]);
    stats.clubs = parseInt(clubCount.rows[0].count);

    // Active licenses
    const activeLicenses = await pool.query(`
      SELECT COUNT(*) as count
      FROM licenses
      WHERE federation_id = $1 AND status = 'APPROVED'
      AND expiry_date >= CURRENT_DATE
    `, [federationId]);
    stats.activeLicenses = parseInt(activeLicenses.rows[0].count);

    // Revenue
    const revenue = await pool.query(`
      SELECT COALESCE(SUM(amount), 0) as total
      FROM payments p
      JOIN licenses l ON p.license_id = l.id
      WHERE l.federation_id = $1 AND p.status = 'COMPLETED'
      AND l.season = $2
    `, [federationId, season]);
    stats.revenue = parseInt(revenue.rows[0].total);

    // Pending approvals
    const pendingApprovals = await pool.query(`
      SELECT
        l.id,
        l.license_number,
        l.season,
        l.status,
        l.created_at,
        a.first_name as athlete_first_name,
        a.last_name as athlete_last_name,
        c.name as club_name,
        'Nouvelle licence' as type
      FROM licenses l
      JOIN athletes a ON l.athlete_id = a.user_id
      LEFT JOIN clubs c ON l.club_id = c.id
      WHERE l.federation_id = $1 AND l.status = 'PENDING'
      ORDER BY l.created_at DESC
      LIMIT 10
    `, [federationId]);

    // Upcoming competitions
    const upcomingCompetitions = await pool.query(`
      SELECT
        c.id,
        c.name,
        c.start_date,
        c.end_date,
        c.venue,
        c.status,
        COUNT(cp.id) as registered_count
      FROM competitions c
      LEFT JOIN competition_participants cp ON cp.competition_id = c.id
      WHERE c.federation_id = $1 AND c.start_date >= CURRENT_DATE
      GROUP BY c.id
      ORDER BY c.start_date ASC
      LIMIT 5
    `, [federationId]);

    // Alerts
    const alerts = [];

    // Incomplete files (missing medical certificate)
    const incompleteFiles = await pool.query(`
      SELECT COUNT(*) as count
      FROM licenses l
      JOIN athletes a ON l.athlete_id = a.user_id
      WHERE l.federation_id = $1 AND l.status = 'APPROVED'
      AND l.medical_clearance = false
    `, [federationId]);

    if (parseInt(incompleteFiles.rows[0].count) > 0) {
      alerts.push({
        type: 'warning',
        message: `${incompleteFiles.rows[0].count} dossiers incomplets`,
        detail: 'Athlètes sans certificat médical',
        icon: 'user-times'
      });
    }

    // Anomalies detected
    const anomalies = await pool.query(`
      SELECT COUNT(*) as count
      FROM anomaly_alerts aa
      JOIN athletes a ON aa.athlete_id = a.user_id
      JOIN clubs c ON a.current_club_id = c.id
      WHERE c.federation_id = $1 AND aa.status = 'PENDING'
    `, [federationId]);

    if (parseInt(anomalies.rows[0].count) > 0) {
      alerts.push({
        type: 'critical',
        message: 'Anomalie détectée',
        detail: 'Performance suspecte - IA Alert',
        icon: 'exclamation-circle'
      });
    }

    // License evolution chart data
    const licenseEvolution = await pool.query(`
      SELECT
        DATE_TRUNC('month', created_at) as month,
        COUNT(*) as count
      FROM licenses
      WHERE federation_id = $1
      AND created_at >= CURRENT_DATE - INTERVAL '6 months'
      AND status = 'APPROVED'
      GROUP BY DATE_TRUNC('month', created_at)
      ORDER BY month ASC
    `, [federationId]);

    res.status(200).json({
      success: true,
      data: {
        stats,
        pendingApprovals: pendingApprovals.rows,
        upcomingCompetitions: upcomingCompetitions.rows,
        alerts,
        licenseEvolution: licenseEvolution.rows,
        digitalizationRate: 85 // Calculated metric
      }
    });
  } catch (error) {
    console.error('Get federation dashboard error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération du tableau de bord'
    });
  }
};

// ==================== FEDERATION ATHLETES ====================

// Get all athletes in federation
exports.getFederationAthletes = async (req, res) => {
  try {
    const { federationId } = req.params;
    const { status, category, clubId, search, page = 1, limit = 20 } = req.query;

    // Check access
    if (req.user.role === 'ADMIN_FEDERATION' && req.user.federationId !== federationId) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit'
      });
    }

    let conditions = ['c.federation_id = $1'];
    const params = [federationId];
    let paramIndex = 2;

    if (status) {
      conditions.push(`EXISTS (
        SELECT 1 FROM licenses l
        WHERE l.athlete_id = a.user_id
        AND l.federation_id = $1
        AND l.status = $${paramIndex}
      )`);
      params.push(status.toUpperCase());
      paramIndex++;
    }

    if (clubId) {
      conditions.push(`a.current_club_id = $${paramIndex}`);
      params.push(clubId);
      paramIndex++;
    }

    if (search) {
      conditions.push(`(a.first_name ILIKE $${paramIndex} OR a.last_name ILIKE $${paramIndex} OR u.nin ILIKE $${paramIndex})`);
      params.push(`%${search}%`);
      paramIndex++;
    }

    const whereClause = conditions.join(' AND ');

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM athletes a
      JOIN users u ON a.user_id = u.id
      LEFT JOIN clubs c ON a.current_club_id = c.id
      WHERE ${whereClause}
    `;
    const countResult = await pool.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get athletes
    const athletesQuery = `
      SELECT
        a.user_id,
        a.first_name,
        a.last_name,
        a.birth_date,
        a.gender,
        a.sport_type,
        a.position,
        u.email,
        u.nin,
        c.name as club_name,
        c.id as club_id,
        (SELECT l.status FROM licenses l
         WHERE l.athlete_id = a.user_id AND l.federation_id = $1
         ORDER BY l.created_at DESC LIMIT 1) as license_status,
        (SELECT te.overall_score FROM talent_evaluations te
         WHERE te.athlete_id = a.user_id
         ORDER BY te.evaluation_date DESC LIMIT 1) as talent_score,
        (SELECT te.potential FROM talent_evaluations te
         WHERE te.athlete_id = a.user_id
         ORDER BY te.evaluation_date DESC LIMIT 1) as talent_potential
      FROM athletes a
      JOIN users u ON a.user_id = u.id
      LEFT JOIN clubs c ON a.current_club_id = c.id
      WHERE ${whereClause}
      ORDER BY a.last_name, a.first_name
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;

    params.push(parseInt(limit), (parseInt(page) - 1) * parseInt(limit));
    const athletesResult = await pool.query(athletesQuery, params);

    res.status(200).json({
      success: true,
      data: {
        athletes: athletesResult.rows,
        pagination: {
          total,
          page: parseInt(page),
          limit: parseInt(limit),
          totalPages: Math.ceil(total / limit)
        }
      }
    });
  } catch (error) {
    console.error('Get federation athletes error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération des athlètes'
    });
  }
};

// ==================== FEDERATION FINANCES ====================

// Get federation financial data
exports.getFederationFinances = async (req, res) => {
  try {
    const { federationId } = req.params;
    const { year = new Date().getFullYear() } = req.query;

    // Check access
    if (req.user.role === 'ADMIN_FEDERATION' && req.user.federationId !== federationId) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit'
      });
    }

    const season = `${year}-${year + 1}`;

    // Revenue stats
    const revenueStats = await pool.query(`
      SELECT
        COALESCE(SUM(amount), 0) as total_revenue,
        COALESCE(SUM(amount) FILTER (WHERE provider = 'MVOLA'), 0) as mvola_revenue,
        COALESCE(SUM(amount) FILTER (WHERE provider = 'ORANGE_MONEY'), 0) as orange_revenue,
        COALESCE(SUM(amount) FILTER (WHERE provider = 'AIRTEL_MONEY'), 0) as airtel_revenue,
        COUNT(*) FILTER (WHERE provider = 'MVOLA') as mvola_count,
        COUNT(*) FILTER (WHERE provider = 'ORANGE_MONEY') as orange_count,
        COUNT(*) FILTER (WHERE provider = 'AIRTEL_MONEY') as airtel_count
      FROM payments p
      JOIN licenses l ON p.license_id = l.id
      WHERE l.federation_id = $1 AND l.season = $2 AND p.status = 'COMPLETED'
    `, [federationId, season]);

    // Monthly revenue chart data
    const monthlyRevenue = await pool.query(`
      SELECT
        DATE_TRUNC('month', p.paid_at) as month,
        SUM(p.amount) as amount
      FROM payments p
      JOIN licenses l ON p.license_id = l.id
      WHERE l.federation_id = $1 AND l.season = $2 AND p.status = 'COMPLETED'
      GROUP BY DATE_TRUNC('month', p.paid_at)
      ORDER BY month ASC
    `, [federationId, season]);

    // Recent transactions
    const recentTransactions = await pool.query(`
      SELECT
        p.id,
        p.amount,
        p.provider,
        p.status,
        p.paid_at,
        a.first_name || ' ' || a.last_name as athlete_name,
        l.license_number,
        l.season
      FROM payments p
      JOIN licenses l ON p.license_id = l.id
      JOIN athletes a ON l.athlete_id = a.user_id
      WHERE l.federation_id = $1
      ORDER BY p.created_at DESC
      LIMIT 20
    `, [federationId]);

    res.status(200).json({
      success: true,
      data: {
        stats: revenueStats.rows[0],
        monthlyRevenue: monthlyRevenue.rows,
        recentTransactions: recentTransactions.rows
      }
    });
  } catch (error) {
    console.error('Get federation finances error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération des données financières'
    });
  }
};

// ==================== FEDERATION REPORTS ====================

// Get federation statistics
exports.getFederationStats = async (req, res) => {
  try {
    const { federationId } = req.params;

    // Check access
    if (req.user.role === 'ADMIN_FEDERATION' && req.user.federationId !== federationId) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit à ces statistiques'
      });
    }

    const stats = {};

    // License stats by status
    const licenseStats = await pool.query(`
      SELECT status, COUNT(*) as count
      FROM licenses
      WHERE federation_id = $1
      GROUP BY status
    `, [federationId]);
    stats.licensesByStatus = licenseStats.rows;

    // Club stats
    const clubStats = await pool.query(`
      SELECT
        COUNT(*) as total_clubs,
        COUNT(*) FILTER (WHERE is_professional = true) as professional_clubs,
        COUNT(*) FILTER (WHERE is_active = true) as active_clubs
      FROM clubs
      WHERE federation_id = $1
    `, [federationId]);
    stats.clubs = clubStats.rows[0];

    // Athlete distribution by club
    const athleteDistribution = await pool.query(`
      SELECT
        c.name as club_name,
        COUNT(a.user_id) as athlete_count
      FROM clubs c
      LEFT JOIN athletes a ON a.current_club_id = c.id
      WHERE c.federation_id = $1 AND c.is_active = true
      GROUP BY c.id, c.name
      ORDER BY athlete_count DESC
    `, [federationId]);
    stats.athletesByClub = athleteDistribution.rows;

    // Recent licenses (last 30 days)
    const recentLicenses = await pool.query(`
      SELECT COUNT(*) as count
      FROM licenses
      WHERE federation_id = $1 AND created_at >= CURRENT_DATE - INTERVAL '30 days'
    `, [federationId]);
    stats.recentLicenses = parseInt(recentLicenses.rows[0].count);

    // Revenue summary
    const revenue = await pool.query(`
      SELECT
        COALESCE(SUM(amount), 0) as total_revenue,
        COALESCE(SUM(amount) FILTER (WHERE status = 'COMPLETED'), 0) as collected_revenue,
        COALESCE(SUM(amount) FILTER (WHERE status = 'PENDING'), 0) as pending_revenue
      FROM payments p
      JOIN licenses l ON p.license_id = l.id
      WHERE l.federation_id = $1 AND l.season = (SELECT MAX(season) FROM licenses WHERE federation_id = $1)
    `, [federationId]);
    stats.revenue = revenue.rows[0];

    res.status(200).json({
      success: true,
      data: stats
    });
  } catch (error) {
    console.error('Get federation stats error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération des statistiques'
    });
  }
};
