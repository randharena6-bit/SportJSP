const jwt = require('jsonwebtoken');
const pool = require('../config/db');
require('dotenv').config();

// JWT Authentication Middleware
const auth = (req, res, next) => {
  try {
    const token = req.header('Authorization')?.replace('Bearer ', '');

    if (!token) {
      return res.status(401).json({
        success: false,
        message: 'Accès non autorisé. Token manquant.'
      });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    res.status(401).json({
      success: false,
      message: 'Token invalide ou expiré.'
    });
  }
};

// Role-based authorization middleware
const checkRole = (...allowedRoles) => {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({
        success: false,
        message: 'Authentification requise'
      });
    }

    const userRole = req.user.role?.toUpperCase();
    const normalizedRoles = allowedRoles.map(r => r.toUpperCase());

    if (!normalizedRoles.includes(userRole)) {
      return res.status(403).json({
        success: false,
        message: 'Accès interdit. Rôle insuffisant.'
      });
    }

    next();
  };
};

// Admin level authorization middleware
const checkAdminLevel = (...allowedLevels) => {
  return async (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({
        success: false,
        message: 'Authentification requise'
      });
    }

    const userRole = req.user.role?.toUpperCase();

    // Super admin bypass all checks
    if (userRole === 'ADMIN' || userRole === 'SYS_ADMIN') {
      try {
        const result = await pool.query(
          'SELECT admin_level FROM admins WHERE user_id = $1',
          [req.user.userId]
        );

        if (result.rows.length > 0) {
          const adminLevel = result.rows[0].admin_level;
          req.user.adminLevel = adminLevel;

          if (adminLevel === 'SUPER') {
            return next();
          }

          if (allowedLevels.includes(adminLevel)) {
            return next();
          }
        }
      } catch (error) {
        console.error('Admin level check error:', error);
      }
    }

    return res.status(403).json({
      success: false,
      message: 'Accès interdit. Niveau administrateur insuffisant.'
    });
  };
};

// Federation admin authorization - checks if admin belongs to specific federation
const checkFederationAccess = async (req, res, next) => {
  if (!req.user) {
    return res.status(401).json({
      success: false,
      message: 'Authentification requise'
    });
  }

  const userRole = req.user.role?.toUpperCase();

  // Super admins bypass federation checks
  if (userRole === 'ADMIN' && req.user.adminLevel === 'SUPER') {
    return next();
  }

  // Check if user is a federation admin
  if (userRole === 'ADMIN_FEDERATION') {
    try {
      const result = await pool.query(
        'SELECT federation_id FROM federation_admins WHERE user_id = $1',
        [req.user.userId]
      );

      if (result.rows.length > 0) {
        req.user.federationId = result.rows[0].federation_id;
        return next();
      }
    } catch (error) {
      console.error('Federation access check error:', error);
    }
  }

  return res.status(403).json({
    success: false,
    message: 'Accès interdit. Droits de fédération requis.'
  });
};

// Permission-based authorization middleware
const checkPermission = (...requiredPermissions) => {
  return async (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({
        success: false,
        message: 'Authentification requise'
      });
    }

    try {
      // Get user permissions from database
      const result = await pool.query(
        `SELECT p.name FROM permissions p
         JOIN role_permissions rp ON p.id = rp.permission_id
         JOIN roles r ON rp.role_id = r.id
         WHERE r.name = $1`,
        [req.user.role.toUpperCase()]
      );

      const userPermissions = result.rows.map(row => row.name);

      const hasAllPermissions = requiredPermissions.every(
        perm => userPermissions.includes(perm)
      );

      if (!hasAllPermissions) {
        return res.status(403).json({
          success: false,
          message: 'Accès interdit. Permissions insuffisantes.'
        });
      }

      req.user.permissions = userPermissions;
      next();
    } catch (error) {
      console.error('Permission check error:', error);
      return res.status(500).json({
        success: false,
        message: 'Erreur lors de la vérification des permissions'
      });
    }
  };
};

// Audit logging middleware
const auditLog = (action, entityType) => {
  return async (req, res, next) => {
    // Store original json method
    const originalJson = res.json;

    // Override json method to capture response
    res.json = function(data) {
      // Restore original json method
      res.json = originalJson;

      // Log the action asynchronously (don't block response)
      if (req.user) {
        const entityId = req.params.id || req.params.userId || req.body.id || null;
        const details = {
          method: req.method,
          path: req.path,
          ip: req.ip,
          userAgent: req.get('user-agent'),
          requestBody: { ...req.body },
          responseStatus: res.statusCode
        };

        // Remove sensitive data
        delete details.requestBody.password;
        delete details.requestBody.password_hash;
        delete details.requestBody.confirmPassword;

        pool.query(
          `INSERT INTO audit_logs (user_id, action, entity_type, entity_id, details, ip_address, created_at)
           VALUES ($1, $2, $3, $4, $5, $6, CURRENT_TIMESTAMP)`,
          [req.user.userId, action, entityType, entityId, JSON.stringify(details), req.ip]
        ).catch(err => console.error('Audit log error:', err));
      }

      // Call original json method
      return res.json(data);
    };

    next();
  };
};

module.exports = {
  auth,
  checkRole,
  checkAdminLevel,
  checkFederationAccess,
  checkPermission,
  auditLog
};
