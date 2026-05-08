const pool = require('../config/db');
const { hashPassword } = require('../utils/passwordUtils');

// ==================== USER MANAGEMENT ====================

// Get all users with filtering and pagination
exports.getAllUsers = async (req, res) => {
  try {
    const {
      role,
      status,
      search,
      page = 1,
      limit = 20,
      sortBy = 'created_at',
      sortOrder = 'DESC'
    } = req.query;

    const offset = (page - 1) * limit;
    const conditions = ['1=1'];
    const params = [];
    let paramIndex = 1;

    // Role filter
    if (role) {
      conditions.push(`r.name = $${paramIndex}`);
      params.push(role.toUpperCase());
      paramIndex++;
    }

    // Status filter
    if (status !== undefined) {
      conditions.push(`u.is_active = $${paramIndex}`);
      params.push(status === 'true');
      paramIndex++;
    }

    // Search filter (email, name, NIN)
    if (search) {
      conditions.push(`(
        u.email ILIKE $${paramIndex} OR
        u.nin ILIKE $${paramIndex} OR
        COALESCE(a.first_name, c.first_name, s.first_name, d.first_name, ad.first_name) ILIKE $${paramIndex} OR
        COALESCE(a.last_name, c.last_name, s.last_name, d.last_name, ad.last_name) ILIKE $${paramIndex}
      )`);
      params.push(`%${search}%`);
      paramIndex++;
    }

    // Super admins can see all, federation admins see users in their federation only
    if (req.user.role === 'ADMIN_FEDERATION' && req.user.federationId) {
      conditions.push(`(
        a.federation_id = $${paramIndex} OR
        c.current_club_id IN (SELECT id FROM clubs WHERE federation_id = $${paramIndex}) OR
        fa.federation_id = $${paramIndex}
      )`);
      params.push(req.user.federationId);
      paramIndex++;
    }

    const whereClause = conditions.join(' AND ');

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM users u
      JOIN roles r ON u.role_id = r.id
      LEFT JOIN athletes a ON u.id = a.user_id
      LEFT JOIN coaches c ON u.id = c.user_id
      LEFT JOIN scouts s ON u.id = s.user_id
      LEFT JOIN doctors d ON u.id = d.user_id
      LEFT JOIN admins ad ON u.id = ad.user_id
      LEFT JOIN federation_admins fa ON u.id = fa.user_id
      WHERE ${whereClause}
    `;
    const countResult = await pool.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get users
    const usersQuery = `
      SELECT
        u.id,
        u.email,
        u.nin,
        u.phone,
        u.is_active,
        u.email_verified,
        u.phone_verified,
        u.last_login,
        u.created_at,
        u.updated_at,
        r.name as role,
        CASE
          WHEN r.name = 'ATHLETE' THEN jsonb_build_object(
            'firstName', a.first_name,
            'lastName', a.last_name,
            'birthDate', a.birth_date,
            'gender', a.gender,
            'sportType', a.sport_type,
            'position', a.position,
            'clubId', a.current_club_id
          )
          WHEN r.name = 'COACH' THEN jsonb_build_object(
            'firstName', c.first_name,
            'lastName', c.last_name,
            'specialization', c.specialization,
            'experienceYears', c.experience_years,
            'clubId', c.current_club_id
          )
          WHEN r.name = 'SCOUT' THEN jsonb_build_object(
            'firstName', s.first_name,
            'lastName', s.last_name,
            'employer', s.employer
          )
          WHEN r.name = 'DOCTOR' THEN jsonb_build_object(
            'firstName', d.first_name,
            'lastName', d.last_name,
            'licenseNumber', d.license_number,
            'specialization', d.specialization
          )
          WHEN r.name = 'ADMIN' THEN jsonb_build_object(
            'firstName', ad.first_name,
            'lastName', ad.last_name,
            'adminLevel', ad.admin_level
          )
          WHEN r.name = 'ADMIN_FEDERATION' THEN jsonb_build_object(
            'federationId', fa.federation_id
          )
          ELSE '{}'::jsonb
        END as profile
      FROM users u
      JOIN roles r ON u.role_id = r.id
      LEFT JOIN athletes a ON u.id = a.user_id
      LEFT JOIN coaches c ON u.id = c.user_id
      LEFT JOIN scouts s ON u.id = s.user_id
      LEFT JOIN doctors d ON u.id = d.user_id
      LEFT JOIN admins ad ON u.id = ad.user_id
      LEFT JOIN federation_admins fa ON u.id = fa.user_id
      WHERE ${whereClause}
      ORDER BY u.${sortBy} ${sortOrder}
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;

    params.push(parseInt(limit), parseInt(offset));
    const usersResult = await pool.query(usersQuery, params);

    res.status(200).json({
      success: true,
      data: {
        users: usersResult.rows,
        pagination: {
          total,
          page: parseInt(page),
          limit: parseInt(limit),
          totalPages: Math.ceil(total / limit)
        }
      }
    });
  } catch (error) {
    console.error('Get all users error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération des utilisateurs'
    });
  }
};

// Get user by ID with full details
exports.getUserById = async (req, res) => {
  try {
    const { id } = req.params;

    const query = `
      SELECT
        u.id,
        u.email,
        u.nin,
        u.phone,
        u.is_active,
        u.email_verified,
        u.phone_verified,
        u.last_login,
        u.created_at,
        u.updated_at,
        r.name as role,
        CASE
          WHEN r.name = 'ATHLETE' THEN jsonb_build_object(
            'firstName', a.first_name,
            'lastName', a.last_name,
            'birthDate', a.birth_date,
            'gender', a.gender,
            'height', a.height,
            'weight', a.weight,
            'sportType', a.sport_type,
            'position', a.position,
            'nationalTeamEligible', a.national_team_eligible,
            'biography', a.biography,
            'photoUrl', a.photo_url,
            'clubId', a.current_club_id
          )
          WHEN r.name = 'COACH' THEN jsonb_build_object(
            'firstName', c.first_name,
            'lastName', c.last_name,
            'specialization', c.specialization,
            'experienceYears', c.experience_years,
            'certifications', c.certifications,
            'biography', c.biography,
            'photoUrl', c.photo_url,
            'clubId', c.current_club_id
          )
          WHEN r.name = 'SCOUT' THEN jsonb_build_object(
            'firstName', s.first_name,
            'lastName', s.last_name,
            'regions', s.regions,
            'employer', s.employer,
            'specializations', s.specializations
          )
          WHEN r.name = 'DOCTOR' THEN jsonb_build_object(
            'firstName', d.first_name,
            'lastName', d.last_name,
            'licenseNumber', d.license_number,
            'specialization', d.specialization,
            'institution', d.institution
          )
          WHEN r.name = 'ADMIN' THEN jsonb_build_object(
            'firstName', ad.first_name,
            'lastName', ad.last_name,
            'adminLevel', ad.admin_level
          )
          WHEN r.name = 'ADMIN_FEDERATION' THEN jsonb_build_object(
            'federationId', fa.federation_id,
            'permissions', fa.permissions
          )
          WHEN r.name = 'OFFICIAL' THEN jsonb_build_object(
            'firstName', o.first_name,
            'lastName', o.last_name,
            'officialType', o.official_type,
            'certifications', o.certifications
          )
          ELSE '{}'::jsonb
        END as profile
      FROM users u
      JOIN roles r ON u.role_id = r.id
      LEFT JOIN athletes a ON u.id = a.user_id
      LEFT JOIN coaches c ON u.id = c.user_id
      LEFT JOIN scouts s ON u.id = s.user_id
      LEFT JOIN doctors d ON u.id = d.user_id
      LEFT JOIN admins ad ON u.id = ad.user_id
      LEFT JOIN federation_admins fa ON u.id = fa.user_id
      LEFT JOIN officials o ON u.id = o.user_id
      WHERE u.id = $1
    `;

    const result = await pool.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Utilisateur non trouvé'
      });
    }

    // Check if federation admin can access this user
    if (req.user.role === 'ADMIN_FEDERATION' && req.user.federationId) {
      const user = result.rows[0];
      const profile = user.profile || {};

      const hasAccess =
        profile.clubId && (await pool.query(
          'SELECT 1 FROM clubs WHERE id = $1 AND federation_id = $2',
          [profile.clubId, req.user.federationId]
        )).rows.length > 0 ||
        profile.federationId === req.user.federationId;

      if (!hasAccess) {
        return res.status(403).json({
          success: false,
          message: 'Accès interdit à cet utilisateur'
        });
      }
    }

    res.status(200).json({
      success: true,
      data: result.rows[0]
    });
  } catch (error) {
    console.error('Get user by ID error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération de l\'utilisateur'
    });
  }
};

// Create user by admin
exports.createUser = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      email,
      nin,
      phone,
      password,
      role,
      firstName,
      lastName,
      ...profileData
    } = req.body;

    // Validation
    if (!email || !nin || !password || !role || !firstName || !lastName) {
      return res.status(400).json({
        success: false,
        message: 'Email, NIN, mot de passe, rôle, prénom et nom sont obligatoires'
      });
    }

    if (password.length < 8) {
      return res.status(400).json({
        success: false,
        message: 'Le mot de passe doit contenir au moins 8 caractères'
      });
    }

    await client.query('BEGIN');

    // Check if email or NIN already exists
    const existingUser = await client.query(
      'SELECT id FROM users WHERE email = $1 OR nin = $2',
      [email, nin]
    );

    if (existingUser.rows.length > 0) {
      await client.query('ROLLBACK');
      return res.status(400).json({
        success: false,
        message: 'Un utilisateur avec cet email ou NIN existe déjà'
      });
    }

    // Hash password
    const hashedPassword = await hashPassword(password);

    // Create user
    const roleUpper = role.toUpperCase();
    const userResult = await client.query(
      `INSERT INTO users (email, nin, phone, password_hash, role_id, is_active, created_at, updated_at)
       VALUES ($1, $2, $3, $4, (SELECT id FROM roles WHERE name = $5), true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
       RETURNING id, email, (SELECT name FROM roles WHERE id = role_id) as role`,
      [email, nin, phone || null, hashedPassword, roleUpper]
    );

    const userId = userResult.rows[0].id;

    // Create role-specific profile
    switch (roleUpper) {
      case 'ATHLETE':
        await client.query(
          `INSERT INTO athletes (user_id, first_name, last_name, birth_date, gender, height, weight,
            sport_type, position, current_club_id, national_team_eligible, biography, created_at, updated_at)
           VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`,
          [
            userId, firstName, lastName, profileData.birthDate || null,
            profileData.gender || 'M', profileData.height || null,
            profileData.weight || null, profileData.sportType || null,
            profileData.position || null, profileData.clubId || null,
            profileData.nationalTeamEligible || false, profileData.biography || null
          ]
        );
        break;

      case 'COACH':
        await client.query(
          `INSERT INTO coaches (user_id, first_name, last_name, specialization, experience_years,
            current_club_id, certifications, biography, created_at, updated_at)
           VALUES ($1, $2, $3, $4, $5, $6, $7, $8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`,
          [
            userId, firstName, lastName, profileData.specialization || null,
            profileData.experienceYears || 0, profileData.clubId || null,
            JSON.stringify(profileData.certifications || []), profileData.biography || null
          ]
        );
        break;

      case 'SCOUT':
        await client.query(
          `INSERT INTO scouts (user_id, first_name, last_name, regions, employer, specializations, created_at, updated_at)
           VALUES ($1, $2, $3, $4, $5, $6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`,
          [
            userId, firstName, lastName, JSON.stringify(profileData.regions || []),
            profileData.employer || null, JSON.stringify(profileData.specializations || [])
          ]
        );
        break;

      case 'DOCTOR':
        await client.query(
          `INSERT INTO doctors (user_id, first_name, last_name, license_number, specialization, institution, created_at, updated_at)
           VALUES ($1, $2, $3, $4, $5, $6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`,
          [
            userId, firstName, lastName, profileData.licenseNumber || null,
            profileData.specialization || null, profileData.institution || null
          ]
        );
        break;

      case 'ADMIN':
        await client.query(
          `INSERT INTO admins (user_id, first_name, last_name, admin_level, created_at)
           VALUES ($1, $2, $3, $4, CURRENT_TIMESTAMP)`,
          [userId, firstName, lastName, profileData.adminLevel || 'SYSTEM']
        );
        break;

      case 'ADMIN_FEDERATION':
        await client.query(
          `INSERT INTO federation_admins (user_id, federation_id, permissions, created_at, updated_at)
           VALUES ($1, $2, $3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)`,
          [
            userId, profileData.federationId || null,
            JSON.stringify(profileData.permissions || ['VIEW', 'EDIT_LICENSES', 'MANAGE_COMPETITIONS'])
          ]
        );
        break;

      case 'OFFICIAL':
        await client.query(
          `INSERT INTO officials (user_id, first_name, last_name, official_type, certifications, created_at)
           VALUES ($1, $2, $3, $4, $5, CURRENT_TIMESTAMP)`,
          [
            userId, firstName, lastName,
            profileData.officialType || 'REFEREE',
            JSON.stringify(profileData.certifications || [])
          ]
        );
        break;
    }

    await client.query('COMMIT');

    res.status(201).json({
      success: true,
      message: 'Utilisateur créé avec succès',
      data: {
        id: userId,
        email,
        role: roleUpper,
        firstName,
        lastName
      }
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Create user error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la création de l\'utilisateur'
    });
  } finally {
    client.release();
  }
};

// Update user
exports.updateUser = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const {
      email,
      phone,
      isActive,
      firstName,
      lastName,
      ...profileData
    } = req.body;

    await client.query('BEGIN');

    // Check if user exists
    const userCheck = await client.query(
      'SELECT u.id, r.name as role FROM users u JOIN roles r ON u.role_id = r.id WHERE u.id = $1',
      [id]
    );

    if (userCheck.rows.length === 0) {
      await client.query('ROLLBACK');
      return res.status(404).json({
        success: false,
        message: 'Utilisateur non trouvé'
      });
    }

    const userRole = userCheck.rows[0].role;

    // Update base user info
    const updateFields = [];
    const params = [id];
    let paramIndex = 2;

    if (email !== undefined) {
      updateFields.push(`email = $${paramIndex}`);
      params.push(email);
      paramIndex++;
    }

    if (phone !== undefined) {
      updateFields.push(`phone = $${paramIndex}`);
      params.push(phone);
      paramIndex++;
    }

    if (isActive !== undefined) {
      updateFields.push(`is_active = $${paramIndex}`);
      params.push(isActive);
      paramIndex++;
    }

    if (updateFields.length > 0) {
      await client.query(
        `UPDATE users SET ${updateFields.join(', ')}, updated_at = CURRENT_TIMESTAMP WHERE id = $1`,
        params
      );
    }

    // Update role-specific profile
    const profileFields = [];
    const profileParams = [id];
    let profileParamIndex = 2;

    if (firstName !== undefined) {
      profileFields.push(`first_name = $${profileParamIndex}`);
      profileParams.push(firstName);
      profileParamIndex++;
    }

    if (lastName !== undefined) {
      profileFields.push(`last_name = $${profileParamIndex}`);
      profileParams.push(lastName);
      profileParamIndex++;
    }

    // Add profile-specific fields based on role
    Object.keys(profileData).forEach(key => {
      const dbField = key.replace(/[A-Z]/g, letter => `_${letter.toLowerCase()}`);
      if (profileData[key] !== undefined) {
        profileFields.push(`${dbField} = $${profileParamIndex}`);
        profileParams.push(
          typeof profileData[key] === 'object' ? JSON.stringify(profileData[key]) : profileData[key]
        );
        profileParamIndex++;
      }
    });

    if (profileFields.length > 0) {
      let tableName;
      switch (userRole) {
        case 'ATHLETE': tableName = 'athletes'; break;
        case 'COACH': tableName = 'coaches'; break;
        case 'SCOUT': tableName = 'scouts'; break;
        case 'DOCTOR': tableName = 'doctors'; break;
        case 'ADMIN': tableName = 'admins'; break;
        case 'ADMIN_FEDERATION': tableName = 'federation_admins'; break;
        case 'OFFICIAL': tableName = 'officials'; break;
        default: tableName = null;
      }

      if (tableName) {
        await client.query(
          `UPDATE ${tableName} SET ${profileFields.join(', ')}, updated_at = CURRENT_TIMESTAMP WHERE user_id = $1`,
          profileParams
        );
      }
    }

    await client.query('COMMIT');

    res.status(200).json({
      success: true,
      message: 'Utilisateur mis à jour avec succès'
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Update user error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la mise à jour de l\'utilisateur'
    });
  } finally {
    client.release();
  }
};

// Delete/deactivate user
exports.deleteUser = async (req, res) => {
  try {
    const { id } = req.params;
    const { permanent = false } = req.query;

    // Prevent self-deletion
    if (id === req.user.userId) {
      return res.status(400).json({
        success: false,
        message: 'Vous ne pouvez pas supprimer votre propre compte'
      });
    }

    if (permanent === 'true') {
      // Permanent deletion - only super admins
      if (req.user.adminLevel !== 'SUPER') {
        return res.status(403).json({
          success: false,
          message: 'Seuls les super administrateurs peuvent supprimer définitivement un utilisateur'
        });
      }

      await pool.query('DELETE FROM users WHERE id = $1', [id]);
    } else {
      // Soft delete (deactivate)
      await pool.query(
        'UPDATE users SET is_active = false, updated_at = CURRENT_TIMESTAMP WHERE id = $1',
        [id]
      );
    }

    res.status(200).json({
      success: true,
      message: permanent === 'true' ? 'Utilisateur supprimé définitivement' : 'Utilisateur désactivé'
    });
  } catch (error) {
    console.error('Delete user error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la suppression de l\'utilisateur'
    });
  }
};

// Reset user password
exports.resetPassword = async (req, res) => {
  try {
    const { id } = req.params;
    const { newPassword } = req.body;

    if (!newPassword || newPassword.length < 8) {
      return res.status(400).json({
        success: false,
        message: 'Le nouveau mot de passe doit contenir au moins 8 caractères'
      });
    }

    const hashedPassword = await hashPassword(newPassword);

    await pool.query(
      'UPDATE users SET password_hash = $1, updated_at = CURRENT_TIMESTAMP WHERE id = $2',
      [hashedPassword, id]
    );

    res.status(200).json({
      success: true,
      message: 'Mot de passe réinitialisé avec succès'
    });
  } catch (error) {
    console.error('Reset password error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la réinitialisation du mot de passe'
    });
  }
};

// ==================== SYSTEM ADMINISTRATION ====================

// Get system statistics
exports.getSystemStats = async (req, res) => {
  try {
    const stats = {};

    // User counts by role
    const userStats = await pool.query(`
      SELECT r.name as role, COUNT(*) as count
      FROM users u
      JOIN roles r ON u.role_id = r.id
      WHERE u.is_active = true
      GROUP BY r.name
    `);
    stats.usersByRole = userStats.rows;

    // Total active users
    const totalUsers = await pool.query(
      'SELECT COUNT(*) as total FROM users WHERE is_active = true'
    );
    stats.totalActiveUsers = parseInt(totalUsers.rows[0].total);

    // License stats
    const licenseStats = await pool.query(`
      SELECT status, COUNT(*) as count
      FROM licenses
      GROUP BY status
    `);
    stats.licensesByStatus = licenseStats.rows;

    // Recent registrations (last 30 days)
    const recentUsers = await pool.query(`
      SELECT DATE(created_at) as date, COUNT(*) as count
      FROM users
      WHERE created_at >= CURRENT_DATE - INTERVAL '30 days'
      GROUP BY DATE(created_at)
      ORDER BY date DESC
    `);
    stats.recentRegistrations = recentUsers.rows;

    // Federation stats
    const federationStats = await pool.query(`
      SELECT f.name, COUNT(l.id) as license_count
      FROM federations f
      LEFT JOIN licenses l ON f.id = l.federation_id AND l.status = 'APPROVED'
      WHERE f.is_active = true
      GROUP BY f.id, f.name
    `);
    stats.federationStats = federationStats.rows;

    res.status(200).json({
      success: true,
      data: stats
    });
  } catch (error) {
    console.error('Get system stats error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération des statistiques système'
    });
  }
};

// Get audit logs
exports.getAuditLogs = async (req, res) => {
  try {
    const {
      userId,
      action,
      entityType,
      startDate,
      endDate,
      page = 1,
      limit = 50
    } = req.query;

    const offset = (page - 1) * limit;
    const conditions = ['1=1'];
    const params = [];
    let paramIndex = 1;

    if (userId) {
      conditions.push(`user_id = $${paramIndex}`);
      params.push(userId);
      paramIndex++;
    }

    if (action) {
      conditions.push(`action = $${paramIndex}`);
      params.push(action);
      paramIndex++;
    }

    if (entityType) {
      conditions.push(`entity_type = $${paramIndex}`);
      params.push(entityType);
      paramIndex++;
    }

    if (startDate) {
      conditions.push(`created_at >= $${paramIndex}`);
      params.push(startDate);
      paramIndex++;
    }

    if (endDate) {
      conditions.push(`created_at <= $${paramIndex}`);
      params.push(endDate);
      paramIndex++;
    }

    const whereClause = conditions.join(' AND ');

    const countQuery = `SELECT COUNT(*) as total FROM audit_logs WHERE ${whereClause}`;
    const countResult = await pool.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    const logsQuery = `
      SELECT
        al.id,
        al.user_id,
        u.email as user_email,
        al.action,
        al.entity_type,
        al.entity_id,
        al.details,
        al.ip_address,
        al.created_at
      FROM audit_logs al
      LEFT JOIN users u ON al.user_id = u.id
      WHERE ${whereClause}
      ORDER BY al.created_at DESC
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;

    params.push(parseInt(limit), parseInt(offset));
    const logsResult = await pool.query(logsQuery, params);

    res.status(200).json({
      success: true,
      data: {
        logs: logsResult.rows,
        pagination: {
          total,
          page: parseInt(page),
          limit: parseInt(limit),
          totalPages: Math.ceil(total / limit)
        }
      }
    });
  } catch (error) {
    console.error('Get audit logs error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération des logs d\'audit'
    });
  }
};

// Get roles and permissions
exports.getRoles = async (req, res) => {
  try {
    const rolesQuery = `
      SELECT
        r.id,
        r.name,
        r.description,
        r.created_at,
        COALESCE(
          jsonb_agg(
            DISTINCT jsonb_build_object(
              'id', p.id,
              'name', p.name,
              'description', p.description
            )
          ) FILTER (WHERE p.id IS NOT NULL),
          '[]'::jsonb
        ) as permissions
      FROM roles r
      LEFT JOIN role_permissions rp ON r.id = rp.role_id
      LEFT JOIN permissions p ON rp.permission_id = p.id
      GROUP BY r.id, r.name, r.description, r.created_at
      ORDER BY r.id
    `;

    const rolesResult = await pool.query(rolesQuery);

    res.status(200).json({
      success: true,
      data: rolesResult.rows
    });
  } catch (error) {
    console.error('Get roles error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la récupération des rôles'
    });
  }
};

// Update role permissions
exports.updateRolePermissions = async (req, res) => {
  const client = await pool.connect();

  try {
    const { roleId } = req.params;
    const { permissions } = req.body;

    await client.query('BEGIN');

    // Remove existing permissions
    await client.query(
      'DELETE FROM role_permissions WHERE role_id = $1',
      [roleId]
    );

    // Add new permissions
    if (permissions && permissions.length > 0) {
      const values = permissions.map((_, i) => `($1, $${i + 2})`).join(',');
      await client.query(
        `INSERT INTO role_permissions (role_id, permission_id) VALUES ${values}`,
        [roleId, ...permissions]
      );
    }

    await client.query('COMMIT');

    res.status(200).json({
      success: true,
      message: 'Permissions du rôle mises à jour'
    });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Update role permissions error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de la mise à jour des permissions'
    });
  } finally {
    client.release();
  }
};

// Bulk user operations
exports.bulkOperation = async (req, res) => {
  try {
    const { operation, userIds } = req.body;

    if (!Array.isArray(userIds) || userIds.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Liste d\'utilisateurs requise'
      });
    }

    let result;

    switch (operation) {
      case 'activate':
        result = await pool.query(
          `UPDATE users SET is_active = true, updated_at = CURRENT_TIMESTAMP
           WHERE id = ANY($1) RETURNING id`,
          [userIds]
        );
        break;

      case 'deactivate':
        // Prevent self-deactivation
        const filteredIds = userIds.filter(id => id !== req.user.userId);
        result = await pool.query(
          `UPDATE users SET is_active = false, updated_at = CURRENT_TIMESTAMP
           WHERE id = ANY($1) RETURNING id`,
          [filteredIds]
        );
        break;

      case 'delete':
        // Only super admins can bulk delete
        if (req.user.adminLevel !== 'SUPER') {
          return res.status(403).json({
            success: false,
            message: 'Seuls les super administrateurs peuvent effectuer des suppressions en masse'
          });
        }
        result = await pool.query(
          'DELETE FROM users WHERE id = ANY($1) RETURNING id',
          [userIds.filter(id => id !== req.user.userId)]
        );
        break;

      default:
        return res.status(400).json({
          success: false,
          message: 'Opération non reconnue'
        });
    }

    res.status(200).json({
      success: true,
      message: `Opération ${operation} effectuée sur ${result.rowCount} utilisateurs`,
      affectedCount: result.rowCount
    });
  } catch (error) {
    console.error('Bulk operation error:', error);
    res.status(500).json({
      success: false,
      message: 'Erreur lors de l\'opération en masse'
    });
  }
};
